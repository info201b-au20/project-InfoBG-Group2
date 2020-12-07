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
              "Gun Violence Incidents" = "incidents",
              "Gun Violence Deaths" = "num_killed",
              "Police Shootings" = "cases"
            )
          )
        ),
        
        mainPanel(
          plotlyOutput("map")
        )
      )
    ),
    
    tabPanel(
      title = "Bar Chart of Fatal Shootings by Race", 
      titlePanel("Fatal Police Shootings by Race"),
      y_input,
      plotlyOutput("bar")
    ),
    
    tabPanel(
      title = "By Sector", 
    ),
    
    tabPanel(
      title = "Takeaways", 
    )
  )
)
