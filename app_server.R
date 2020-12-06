library(dplyr)
library(shiny)
library(RColorBrewer)

################################################################################
# Read in data
source('./scripts/map.R')
gun_violence <- read.csv("data/USGunViolence.csv")
police_shootings <- read.csv("data/USPoliceShootings.csv")

################################################################################
#Intro


################################################################################
#map data cleanup
##Gun Violence data
year_gun_violence <- mutate(
  gun_violence,
  year = format(as.Date(gun_violence$date, format="%Y-%m-%d"),"%Y")
)

year_gun_violence <- year_gun_violence %>% 
  group_by(year, state) %>% 
  summarise(num_killed = sum(n_killed), 
            incidents= sum(n_killed) + sum(n_injured))

state_gun_violence <- left_join(
  year_gun_violence, state_abbr %>% 
    rename(state = State, state_abbr = Abbreviation))

state_gun_violence <- mutate(
  state_gun_violence,
  hover = paste0("State: ", state, "\n# of Incidents: ", num_killed))

state_gun_violence <- state_gun_violence %>% 
  select(year, state_abbr, num_killed, incidents, hover)

##Police Shooting data
year_police_shootings <- mutate(
  police_shootings,
  year = format(as.Date(police_shootings$date, format="%Y-%m-%d"),"%Y")
)

year_police_shootings <- year_police_shootings %>% 
  group_by(year, state) %>% 
  summarise(cases = n())

year_police_shootings <- mutate(
  year_police_shootings,
  hover = paste0("State: ", state, "\n# of Incidents: ", cases))

################################################################################
#Bar


################################################################################
#Pie


################################################################################
#Summary


################################################################################
#Start shinyServer
server <- function(input, output) {
  output$map <- renderPlotly({ 
    return(build_map(state_gun_violence, input$mapvar))
  }) 
}
