library("shiny")
library("tidyverse")
library("plotly")

intro_panel <- tabPanel(
  "Introduction",
  tags$div(class = "main",
           tags$div(class = "row banner",
                    tags$style(".banner {
                               background-image: url('gun.jpg')}"), 
                    p(em("Image: The Atlantic"))
                    ),
           tags$div(class="row info",
                   tags$div(class = "intro",
                            tags$hr(class = "intro-hr"),
                            tags$h1("ABOUT THE PROJECT"),
                            tags$hr(class = "intro-hr"),
                            tags$p(class = "intro-para", "This project 
                            focused on how gun violence by police has changed 
                            over the years", tags$strong("how gun violence by 
                            police has changed over the years"), "at the US, ", 
                            tags$strong("whether police shootings targeted a 
                            racial group"), "more than the others, and the ", 
                            tags$strong("gun incident characteristics"), 
                            "(whether the suspects were armed, how badly they 
                            were injured etc.)"),
                            tags$hr()
                            ),
                   tags$div(class = "row data",
                            tags$div(class = "col-lg-5 data-left",
                                     tags$img(class = "code-img",
                                              src = "rcode-pic.jpg")),
                            tags$div(class = "col-lg-6 data-right",
                                     tags$h2("About the Data"),
                                     tags$p(class = "data-para",
                                     tags$em("We focused on gun violence 
                                     in the US. For the analysis we primarily 
                                     used 'US Police Shootings' data from 
                                     Kaggle.com which was collected by 
                                     AhsenNazir, a data analyst. The data is 
                                     about police shootings in the United States
                                     across different states. The data also 
                                     involves details about a race, whether the 
                                     person was armed, if the victim had a 
                                     mental illness, etc. It contains 5924 
                                     observations and 15 features.We focused on 
                                     gun violence in the US. For the analysis 
                                     we primarily used 'US Police Shootings' 
                                     data from Kaggle.com which was collected by
                                     AhsenNazir, a data analyst. The data is 
                                     about police shootings in the United States 
                                     across different states. The data also 
                                     involves details about a race, whether the 
                                     person was armed, if the victim had a 
                                     mental illness, etc. It contains 5924
                                     observations and 15 features."))
                                     )
                   ),
                   tags$footer(class = "footer", 
                               tags$p(class = "text-muted",
                               "Built by Jacob Fell, Doris Xu, Hatice Ece Oz, ", 
                               tags$a(href="https://www.linkedin.com/in/xiaoyu-zhu-2495b01a1/",
                               "Rita Zhu"), ", and Ellie Stegman")
                               )
                   )
           )
  )

map_panel <- tabPanel(
  title = "Map", 
  tags$h2(class = "title",
          "Gun Violence Trends in the United States"),
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
  includeCSS("styles.css"),
  
  navbarPage(
    "US Gun Violence & Police Shooting Report",
    
    # intro
    intro_panel,
    
    # interactive page 1 - map
    map_panel,
    
    # interactive page 2 - bar
    tabPanel(
      title = "Bar Chart of Fatal Shootings by Race", 
      tags$h2(class = "title bar-title", "Fatal Police Shootings by Race"),
      sidebarLayout(
        sidebarPanel(
          y_input
        ),
        mainPanel(
          plotlyOutput("bar"))
        )
    ),
    
    # interactive page 3 - pie
    tabPanel(
      title = "By Sector",
      tags$h2(class = "title", "High Level Gun Violence Incident Characteristics"),
      sidebarLayout(
        sidebarPanel(
          # inputs
          selectInput(
            inputId = "typeInput",
            label = "Select a gun incident type:",
            choices = gun_violence_type$high_lev_incident_type,
            selected = "Shot - Wounded/Injured",
            multiple = TRUE
          ),
          tableOutput("pie_table")
        ),
      
      mainPanel(
        plotlyOutput("pie")
      )
      )
    ),
    
    # page - conclusion
    tabPanel(
      title = "Takeaways",
      tags$h2(class = "title", "What We Have Learned"),
      tags$div(class = "conclu",
               tags$p(class = "conclu-para",
                      "Gun violence in the United States is an incredibly 
                      complex issue. Through this analysis, the surface of gun 
                      violence incidents has just been scratched, but a few key 
                      takeaways have been discovered."
                      ),
               uiOutput("List"),
               tags$hr(),
               p(class = "conclu-para",
                 "These takeaways lead to an important realisation, that areas 
                 with ", strong("greater "), "populations will generally have ",
                 strong("more "), "gun incidents. If this recognition is made, 
                 the conclusion is not that certain groups of people or certain 
                 places are responsible for more gun incidents, but that more 
                 people leads to more gun incidents. This is  important for 
                 legislation and gun reform in the US, because maybe there is a 
                 solution for gun reform that is based on population size, 
                 rather than other factors. These statistics come in a context 
                 and in no way tell a full story of gun incidents in America. 
                 But they do show that the issue is complex and that it is 
                 important to understand statistics in context, before making 
                 decisions on key issues."))
    )
  )
)
