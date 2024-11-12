# GLOSIS DATABASE VIEWER
# load libraries
library(shiny)
library(DBI)
library(dplyr)
library(tidyr)
library(RPostgres)
library(shinythemes)
library(shinydashboard)
library(DT)
library(leaflet)

# Load credentials for the docker container
source("../iso28258/credentials.R")

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "GLOSIS Database Viewer"),
  dashboardSidebar(
    sidebarMenu(
      id = "inputdata",
      menuItem(
        "Database Connection",
        tabName = "connect-db",
        icon = icon("database"),
        startExpanded = TRUE, 
        uiOutput("db_dropdown"), # Dynamically generated dropdown menu
        actionButton("connect_button", "Connect to Database", icon = icon("plug"), width = '85%') # Set width to 85%
      )
    ),
    uiOutput("mysidebar"),
    uiOutput("credits"),
    tags$br(),
    # Positioning within sidebar
    tags$div(
      style = "position: absolute; bottom: 0; left: 0; right: 0; padding: 10px 15px; box-sizing: border-box;",
      tags$a(
        href = "http://localhost:3838/iso28258", 
        target = "_blank", 
        class = "btn btn-primary", 
        style = "width: 100%;", 
        icon("external-link-alt"), " Go to ISO-28258"
      )
    )
  ),
  dashboardBody(
    tags$head(
      tags$style(
        HTML(
          '.myClass { font-size: 15px; line-height: 50px; text-align: left; padding: 0 5px; overflow: hidden; color: white; }'
        )
      ),
      tags$style(
        HTML(
          ".box.box-solid.box-primary>.box-header { } .box.box-solid.box-primary{ background:#022226 } .box.box-solid.box-info>.box-header { } .box.box-solid.box-info{ background:#FFFFFF }"
        )
      ),
      tags$head(
        tags$style(
          HTML(
            '.info-box {min-height: 103px;} .info-box-icon {height: 103px; line-height: 103px;} .info-box-content {padding-top: 0px; padding-bottom: 0px;}'
          )
        )
      ),
      tags$head(
        tags$style(
          HTML('.shiny-output-error { visibility: hidden; }')
        )
      ),
      tags$head(
        tags$style(
          HTML('.shiny-output-error:before { visibility: hidden; }')
        )
      ),
      tag.map.title = tags$style(
        HTML(
          ".leaflet-control.map-title { transform: translate(-50%,20%); position: fixed !important; left: 50%; text-align: center; padding-left: 10px; padding-right: 10px; background: rgba(255,255,255,0.75); font-weight: bold; font-size: 18px; }"
        )
      ),
      tags$style(
        type = "text/css",
        ".leaflet {height: calc(90vh - 80px) !important;}"
      )
    ),
    fluidRow(
      column(width = 8,
             DTOutput("data_table") # Use 2/3 width for the table
      ),
      column(width = 4,
             leafletOutput("map") # Use 1/3 width for the map
      )
    )
  )
)
