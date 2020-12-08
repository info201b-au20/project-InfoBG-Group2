library("shiny")
library("tidyverse")
library(plotly)

main_content <- mainPanel(
  img(src = "gun.jpg",  height = 250, width = 450),
  p(em("Image: The Atlantic")),
  p(
    "For this project focused on how gun violence by police has changed over the
    years",
    strong("how gun violence by police has changed over the
    years"),
    "at the US, ",
    strong("whether police shootings targeted a racial group"),
    "more than the others, and the ",
    strong("gun incident characteristics"),
    "(whether the suspects were armed, how badly they were injured etc.)"
  )
)

intro_panel <- tabPanel(
  "Introduction",
  
  titlePanel("Gun Violence in the US"),
  
  sidebarPanel(
    h4("About the Data"),
    p(em("On this project, we focused on gun violence in the US. For the analysis we
      primarily used 'US Police Shootings' data from Kaggle.com which was 
      collected by AhsenNazir, a data analyst. The data is about police shootings in the United 
      States across different states. The data also involves details about a 
      race, whether the person was armed, if the victim had a mental illness, etc. 
      It contains 5924 observations and 15 features.
      "))
  ),
  main_content
)

y_input <- selectInput(
  inputId = "y_input",
  label = "Choose a Year",
  choices = list(
    "2015" = "year2015",
    "2016" = "year2016",
    "2017" = "year2017",
    "2018" = "year2018",
    "2019" = "year2019",
    "2020" = "year2020"
  )
)

ui <- fluidPage(
  navbarPage(
    "US Gun Violence & Police Shooting Report",
    intro_panel,
    
    # interactive page 1 - map
    tabPanel(
      title = "Map", 
      titlePanel("Gun Violence Trends in the United States"),
      sidebarLayout(
        sidebarPanel(
          selectInput(
            inputId = "mapvar",
            label = "Variable to Map",
            choices = list(
              "Overall Incidents" = "incidents",
              "Overall Deaths" = "num_killed"
            )
          )
        ),
        
        mainPanel(
          plotlyOutput("map")
        )
      )
    ),
    
    # interactive page 2 - bar
    tabPanel(
      title = "Bar Chart of Fatal Shootings by Race", 
      titlePanel("Fatal Police Shootings by Race"),
      y_input,
      plotlyOutput("bar")
    ),
    
    # interactive page 3 - pie
    tabPanel(
      title = "By Sector",
      
      sidebarLayout(
        sidebarPanel(
          # inputs
          selectInput(
            inputId = "typeInput",
            label = "Select a gun incident type:",
            choices = gun_violence_type$high_lev_incident_type,
            selected = "Shot - Wounded/Injured",
            multiple = TRUE
          )
        ),
      
      mainPanel(
        h3("Pie Chart of High Level Gun Violence Incident Characteristics"),
        plotlyOutput("pie"),
        tableOutput("pie_table")
      )
      )
    ),
    
    # page - conclusion
    tabPanel(
      title = "Takeaways", 
    )
  )
)
