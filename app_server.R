library(dplyr)
library(tidyr)
library(shiny)
library(plotly)
library(RColorBrewer)

################################################################################
# Read in data
source('./scripts/pie.R')
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
  hover_incidents = paste0("State: ", state, "\n# of Incidents: ", incidents),
  hover_num_killed = paste0("State: ", state, "\n# of deaths: ", num_killed))

state_gun_violence <- state_gun_violence %>% 
  select(year, state_abbr, num_killed, incidents, hover_incidents, hover_num_killed)

################################################################################
# Bar chart data
# Yearly shootings by race
year_by_race <- mutate(
  police_shootings,
  year = format(as.Date(police_shootings$date, format="%Y-%m-%d"),"%Y")
)

year_by_race <- year_by_race %>% 
  group_by(year, race) %>% 
  summarise(cases = n())

year_by_race <- year_by_race %>% 
  spread(year, cases)

names(year_by_race)[2] <- "year2015"
names(year_by_race)[3] <- "year2016"
names(year_by_race)[4] <- "year2017"
names(year_by_race)[5] <- "year2018"
names(year_by_race)[6] <- "year2019"
names(year_by_race)[7] <- "year2020"

################################################################################
#Pie
incident_type <- gun_violence$incident_characteristics
high_lev_incident_type <- str_replace(incident_type, "\\|.*", "")
high_lev_incident_type <- table(high_lev_incident_type)
gun_violence_type <- as.data.frame(high_lev_incident_type)

# Too many categories, need to group those with fewer numbers into one single
# category labeled as "other".
small <- gun_violence_type %>%
  filter(Freq < 1500) %>%
  summarise(other = sum(Freq)) %>%
  select(other)

other <- small %>%
  gather("high_lev_incident_type", "Freq", other)

keep <- subset(gun_violence_type, Freq > 1500)

grouped_incident_type <- full_join(other, keep)

# pie chart label location
grouped_incident_type <- grouped_incident_type %>% 
  arrange(desc(high_lev_incident_type)) %>%
  mutate(prop = Freq / sum(grouped_incident_type$Freq) *100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop ) %>%
  mutate(percent = paste(round(prop, digits = 2), "%"))

label_list <- c(t(grouped_incident_type$Freq), t(grouped_incident_type$percent))

################################################################################
#Summary


################################################################################
#Start shinyServer
server <- function(input, output) {
  
  output$map <- renderPlotly({ 
    return(build_map(state_gun_violence, input$mapvar))
  }) 
  
  output$bar <- renderPlotly ({
    race_plot <- ggplot(year_by_race, aes(x = race, fill = race)) +
      geom_col(aes_string(y = input$y_input)) +
      labs(x = "Race", y = "Number of Fatal Shootings")
    ggplotly(race_plot)
  })
  
  
  output$pie <- renderPlotly ({
    return(build_pie(grouped_incident_type))
  })
}

