library("shiny")
library("tidyverse")
library(plotly)

main_content <- mainPanel(
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
  includeCSS("styles.css"),
  tags$div(class = "main",
           tags$div(class = "background-img",
                    tags$style(".background-img {
                      background-image: url('gun.jpg')
                      }"), 
                    #img(src = "gun.jpg"),
                    p(em("Image: The Atlantic"))
                    ),
           tags$div(class = "intro",
                    tags$hr(),
                    tags$h1("ABOUT THE PROJECT"),
                    tags$hr(),
                    tags$p("For this project focused on how gun violence by
                    police has changed over the years", tags$strong("how gun 
                    violence by police has changed over the years"), "at the 
                    US, ", tags$strong("whether police shootings targeted a 
                    racial group"), "more than the others, and the ", 
                    tags$strong("gun incident characteristics"), "(whether the 
                    suspects were armed, how badly they were injured etc.)"),
                    tags$hr()
                    ),
           tags$div(class = "data-info",
                    tags$h2("About the Data"),
                    tags$p(tags$em("We focused on gun violence in the US. For the analysis 
                    we primarily used 'US Police Shootings' data from Kaggle.com
                    which was collected by AhsenNazir, a data analyst. The data
                    is about police shootings in the United States across
                    different states. The data also involves details about a
                    race, whether the person was armed, if the victim had a 
                    mental illness, etc. It contains 5924 observations and 15
                    features."))
                    ),
           tags$footer(class = "credit-to", 
                       tags$p("Built by Jacob Fell, Doris Xu, Hatice Ece Oz, ", 
                       tags$a(href="https://www.linkedin.com/in/xiaoyu-zhu-2495b01a1/",
                       "Rita Zhu"), "Ellie Stegman")
                       )
           )
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

################################################################################
#Start shinyUI
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
      p(
        "Gun violence in the United States is an incredibly complex issue. Through this analysis, the surface of gun violence incidents has just been scratched, but a few key takeaways have been discovered."
      ),
      uiOutput("List"),
      p(
        "These takeaways lead to an important realisation, that areas with ",
        strong("greater "),
        "populations will generally have ",
        strong("more "),
        "gun incidents. If this recognition is made, the conclusion is not that certain groups of people or certain places are responsible for more gun incidents, but that more people leads to more gun incidents. This is important for legislation and gun reform in the US, because maybe there is a solution for gun reform that is based on population size, rather than other factors. These statistics come in a context and in no way tell a full story of gun incidents in America. But they do show that the issue is complex and that it is important to understand statistics in context, before making decisions on key issues."
      )
    )
  )
)
