ui <- fluidPage(
  navbarPage(
    "US Gun Violence & Police Shooting Report",
    tabPanel(
      title = "Introduction",
    ),
    
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
    
    tabPanel(
      title = "Bar", 
    ),
    
    tabPanel(
      title = "By Sector", 
    ),
    
    tabPanel(
      title = "Takeaways", 
    )
  )
)

