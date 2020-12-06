library("dplyr")
library("plotly") 

gun_violence <- read.csv("data/USGunViolence.csv")
state_abbr <- read.csv("data/state_abbrev.csv")
police_shootings <- read.csv("data/USPoliceShootings.csv")

################################################################################
#Gun Violence Maps(death && total incidents)
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

gun_deaths_map <- plot_geo(state_gun_violence,
                             locationmode = 'USA-states',
                             frame = ~year) %>% 
  add_trace(locations = ~state_abbr,
            z = ~num_killed,
            zmin = 0,
            zmax = max(state_gun_violence$num_killed),
            color = ~num_killed,
            colorscale = "Reds",
            text = ~hover,
            hoverinfo = "text") %>% 
  layout(geo = list(scope = "usa"),
         title = "Gun Deaths in the U.S.\n2013 - 2018") %>% 
  config(displayModeBar = FALSE) %>% 
  colorbar(title = "number of death")
gun_deaths_map

gun_incidents_map <- plot_geo(state_gun_violence,
                                    locationmode = 'USA-states',
                                    frame = ~year) %>% 
  add_trace(locations = ~state_abbr,
            z = ~incidents,
            zmin = 0,
            zmax = max(state_gun_violence$incidents),
            color = ~incidents,
            colorscale = "Reds",
            text = ~hover,
            hoverinfo = "text") %>% 
  layout(geo = list(scope = "usa"),
         title = "Gun Incidents in the U.S.\n2013 - 2018") %>% 
  config(displayModeBar = FALSE) %>% 
  colorbar(title = "number of incidents")
gun_incidents_map

################################################################################
#Police Gun Shootings
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

police_shooting_map <- plot_geo(year_police_shootings,
                              locationmode = 'USA-states',
                              frame = ~year) %>% 
  add_trace(locations = ~state,
            z = ~cases,
            zmin = 0,
            zmax = max(year_police_shootings$cases),
            color = ~cases,
            colorscale = "Reds",
            text = ~hover,
            hoverinfo = "text") %>% 
  layout(geo = list(scope = "usa"),
         title = "Police Gun Incidents in the U.S.\n2015 - 2020") %>% 
  config(displayModeBar = FALSE) %>% 
  colorbar(title = "number of incidents")
police_shooting_map

################################################################################
#Shiny Map
build_map <- function(data, var) {
  map <- plot_geo(data = data,
                  locationmode = 'USA-states',
                  frame = ~year) %>% 
    add_trace(locations = ~state_abbr,
              z = data[,var],
              zmin = 0,
              zmax = max(data[var]),
              color = data[,var],
              colorscale = "Reds",
              text = ~hover,
              hoverinfo = "text") %>% 
    layout(geo = list(scope = "usa")) %>% 
    config(displayModeBar = FALSE) %>% 
    colorbar(title = "number of incidents")
  return(map)
}
