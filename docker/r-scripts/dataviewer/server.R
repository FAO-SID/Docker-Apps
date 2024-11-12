# GLOSIS DATABASE VIEWER

server <- function(input, output, session) {
  con <- reactiveVal(NULL)  # Track database connection
  data <- reactiveVal(NULL)  # Store and manage table data
  
  # Always display the dropdown menu for databases
  output$db_dropdown <- renderUI({
    # Establish a temporary connection just for fetching database names
    temp_con <- dbConnect(RPostgres::Postgres(), dbname = database_name, host = host_name, port = port_number, user = user_name, password = password_name)
    dbs <- dbGetQuery(temp_con, "SELECT datname FROM pg_database WHERE datistemplate = false;")
    dbDisconnect(temp_con)  # Disconnect the temporary connection
    selectInput("db_name_input", "Database Name", choices = dbs[dbs$datname != "postgres", "datname"], selected = dbs$datname[1])
  })
  
  # Observe button for connection management
  observeEvent(input$connect_button, {
    if (is.null(con())) {
      # Connect to database
      db <- dbConnect(RPostgres::Postgres(), 
                      dbname = isolate(input$db_name_input),
                      host = host_name, port = port_number, user = user_name, password = password_name)
      con(db)
      updateActionButton(session, "connect_button", label = "Disconnect from Database", icon = icon("ban"))
    } else {
      # Disconnect from database
      dbDisconnect(con())
      con(NULL)  # Clear the connection object
      data(NULL)  # Clear the data to empty the dashboard content
      updateActionButton(session, "connect_button", label = "Connect to Database", icon = icon("plug"))
    }
  })
  

  # Load data when connected
  observe({
    if (!is.null(con())) {
      # Execute query 1
      query1 <- "
      SELECT 
          sp.site_id, 
          s.site_code, 
          p.project_id, 
          p.name, 
          p.description, 
          ST_AsText(l.coordinates::geography) AS location,
          ST_X(l.coordinates::geometry) AS long, 
          ST_Y(l.coordinates::geometry) AS lat
      FROM 
          site_project sp
      JOIN 
          project p ON sp.project_id = p.project_id
      JOIN 
          site s ON s.site_id = sp.site_id
      JOIN 
          location l ON l.location_id = s.site_id;
      "
      sch <- dbGetQuery(con(), query1)
      
      # Execute query 2
      query2 <- sprintf("
      SELECT 
          pr.name AS project_name,
          s.site_code,
          rpc.result_phys_chem_id, 
          rpc.value,
          opc.observation_phys_chem_r_label,
          e.specimen_code
      FROM 
          result_phys_chem rpc
      JOIN 
          element e ON rpc.element_id = e.element_id
      JOIN 
          profile p ON e.profile_id = p.profile_id
      JOIN 
          plot pl ON p.plot_id = pl.plot_id
      JOIN 
          site s ON pl.site_id = s.site_id
      JOIN 
          site_project sp ON s.site_id = sp.site_id
      JOIN 
          project pr ON sp.project_id = pr.project_id
      JOIN 
          observation_phys_chem opc ON rpc.observation_phys_chem_id = opc.observation_phys_chem_id;")
      
      site_tibble <- dbGetQuery(con(), query2)
      
      # Data processing
      site_tibble <- site_tibble %>%
        select(-result_phys_chem_id) %>%
        group_by(project_name, site_code, specimen_code, observation_phys_chem_r_label) %>%
        summarise(value = mean(value, na.rm = TRUE), .groups = 'drop') %>%
        ungroup() %>%
        pivot_wider(names_from = observation_phys_chem_r_label, values_from = value,
                    names_glue = "{observation_phys_chem_r_label}") %>%
        arrange(project_name, site_code, specimen_code)
      
      # Join the transformed dataframe
      sch <- left_join(sch, site_tibble, by = "site_code")
      data(sch)  # Set the data
    }
  })
  
  # Render Leaflet map
  output$map <- renderLeaflet({
    req(con())  # Only proceed if there is an active connection
    req(data())  # Ensure data is available
    
    leaflet(data()) %>%
      addTiles() %>%
      addCircleMarkers(
        ~long, ~lat, color = "tomato", radius = 5, fillOpacity = 0.1,
        weight = 1,
        popup = ~as.character(site_code)
      )
  })
  
  # Output the data table using DT::renderDT
  output$data_table <- DT::renderDT({
    if (!is.null(data())) {
      datatable(
        data(),
        extensions = c('FixedHeader', 'Buttons', 'Scroller', 'Select'),
        filter = 'top', 
        selection = 'none',
        class = 'cell-border stripe',
        editable = 'cell',
        rownames = FALSE,
        options = list(
          dom = 'Bfrtip',
          buttons = c('selectAll', 'selectNone', 'copy', 'csv', 'pdf', 'print'),
          select = list(style = 'multi', items = 'row'),
          paging = TRUE,
          pageLength = 40,
          scrollX = TRUE, 
          scrollY = '900px',
          fixedHeader = TRUE,
          scrollCollapse = TRUE,
          keys = TRUE
        )
      )
    } else {
      # Return an empty table if data is NULL
      datatable(data.frame(), options = list(pageLength = 0))
    }
  })
  
  # Cleanup function to close database connection when session ends
  session$onSessionEnded(function() {
    if (!is.null(con())) {
      dbDisconnect(con())
    }
  })
}
