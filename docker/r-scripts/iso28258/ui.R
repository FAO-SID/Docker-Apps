# Define UI ----
ui <- fluidPage(
  useShinyjs(),
  dashboardPage(
    skin = "red",
    dashboardHeader(
      title = "GLOSIS ISO-28258 Soil Domain Model",
      tags$li(
        class = "dropdown",
        tags$img(
          src = "fao_logo1.png",
          height = "40px",
          style = "position: absolute; right: 20px; top: 5px;"
        )
      ),
      titleWidth = 400
    ),
    dashboardSidebar(
      tags$head(
        tags$style(HTML(".main-sidebar, .left-side {background-color: #FFC527 !important;}"))
      ),
      tags$br(),
      uiOutput("db_dropdown"), # Dynamically generated dropdown menu
      actionButton("btnToggleConn", "Connect", icon = icon("plug"), width = '85%'),
      uiOutput("dynamicFileInput"), # Dynamic UI for fileInput
      uiOutput("renderButton"), # Dynamic UI for render dashboard
      # New line with the label
      tags$br(),
      tags$div(style = "padding: 10px 15px; font-weight: bold;", "CREATE A DATABASE"),
      actionButton("btn_create_db", "New Database", icon = icon("plus-circle"), width = '85%'),
      uiOutput("dbMessage"),
      uiOutput("password_modal"),  
      tags$br(),
      uiOutput("backupWarning"), # Add this line to display warnings
      #uiOutput("fileUploadWarning"), # Add this line to display warnings
      uiOutput("connectionWarning"), # Add this line to display warnings
      tags$p("DELETE SELECTED DATABASE", style = "width: 100%; padding: 10px 15px; color: white; font-weight: bold;"),
      actionButton("delete_button", "Delete", icon = icon("trash"), width = '85%', style = "color: red;"),  # Delete button with red text for emphasis
      tags$div(
        style = "position: absolute; bottom: 0; width: 100%; padding: 10px 15px; box-sizing: border-box;",
        tags$a(
          href = "http://localhost:3838/dataviewer", 
          target = "_blank", 
          class = "btn btn-primary", 
          style = "width: 100%; margin-left: auto; margin-right: auto; display: block;", 
          icon("external-link-alt"), " Go to Data Viewer"
        )
      )
    ),
    dashboardBody(
      tags$head(tags$style(
        HTML(
          "
          /* Change the dashboard body background color to green */
          .content-wrapper {background-color: #D3D3D3 !important;}
          /* Set the tabBox to occupy full width */
          .tab-content {width: 100% !important;}
          /* Optional: Adjust the height */
          .content-wrapper, .tab-content {
            height: 80vh !important; /* Adjust based on your needs */
            overflow-y: auto; /* Adds scroll to the content if it exceeds the viewport height */
          }
          "
        )
      )),
      tabBox(
        id = "tabs",
        width = 12,
        tabPanel("Project", DTOutput("viewProject") %>% withSpinner(color = "#0275D8", color.background = "#ffffff", size = .8, type = 2)),
        tabPanel("Site", DTOutput("viewSite") %>% withSpinner(color = "#0275D8", color.background = "#ffffff", size = .8, type = 2)),
        tabPanel("Site Project", DTOutput("viewSite_project") %>% withSpinner(color = "#0275D8", color.background = "#ffffff", size = .8, type = 2)),
        tabPanel("Plot", DTOutput("viewPlot") %>% withSpinner(color = "#0275D8", color.background = "#ffffff", size = .8, type = 2)),
        tabPanel("Profile", DTOutput("viewProfile") %>% withSpinner(color = "#0275D8", color.background = "#ffffff", size = .8, type = 2)),
        tabPanel("Element", DTOutput("viewElement") %>% withSpinner(color = "#0275D8", color.background = "#ffffff", size = .8, type = 2)),
        tabPanel("Specimen", DTOutput("viewSpecimen") %>% withSpinner(color = "#0275D8", color.background = "#ffffff", size = .8, type = 2)),
        tabPanel("Unit_of_measure", DTOutput("viewUnit_of_measure") %>% withSpinner(color = "#0275D8", color.background = "#ffffff", size = .8, type = 2)),
        tabPanel("Procedure_phys_chem", DTOutput("viewProcedure_phys_chem") %>% withSpinner(color = "#0275D8", color.background = "#ffffff", size = .8, type = 2)),
        tabPanel("Property_phys_chem", DTOutput("viewProperty_phys_chem") %>% withSpinner(color = "#0275D8", color.background = "#ffffff", size = .8, type = 2)),
        tabPanel("Observation_phys_chem", DTOutput("viewObservation_phys_chem") %>% withSpinner(color = "#0275D8", color.background = "#ffffff", size = .8, type = 2)),
        tabPanel("Result_phys_chem", DTOutput("viewResult_phys_chem") %>% withSpinner(color = "#0275D8", color.background = "#ffffff", size = .8, type = 2)),
        tabPanel("Glosis procedures", DTOutput("viewGlosis_procedures") %>% withSpinner(color = "#0275D8", color.background = "#ffffff", size = .8, type = 2)),
        tabPanel("Location", DTOutput("viewLocation") %>% withSpinner(color = "#0275D8", color.background = "#ffffff", size = .8, type = 2)),
        tabPanel("PSL", DTOutput("viewPSL") %>% withSpinner(color = "#0275D8", color.background = "#ffffff", size = .8, type = 2))
      )
    )
  )
)
