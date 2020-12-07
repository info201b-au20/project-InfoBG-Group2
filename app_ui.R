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
