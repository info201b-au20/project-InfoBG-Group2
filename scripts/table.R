library(tidyverse)

police_shootings <- read.csv("data/USPoliceShootings.csv")
us_gun_violence <- read.csv("data/USGunViolence.csv")
state_abbr <- read.csv("data/state_abbrev.csv")

gun_violence_df <- left_join(us_gun_violence, state_abbr %>% 
                               rename(state = State))

gun_violence_df <- mutate(
  gun_violence_df,
  location = paste0(city_or_county, ", ", Abbreviation)
)

gun_violence_df <- gun_violence_df %>% 
  select(date, location, n_killed, n_injured, incident_characteristics)

police_shootings_df <- mutate(
  police_shootings,
  location = paste0(city, ", ", state)
)

police_shootings_df <- police_shootings_df %>% 
  rename(police_shooting_victims_race = race) %>% 
  select(date, location, police_shooting_victims_race)

explantory_analysis_df <- full_join(gun_violence_df, police_shootings_df)

explantory_analysis_df <- explantory_analysis_df %>% 
  filter(date >= "2015-01-02", date <= "2018-03-31") %>% 
  group_by(police_shooting_victims_race)
  
rate_police_shooting <- sum(
  !is.na(explantory_analysis_df$police_shooting_victims_race)) / 
  nrow(explantory_analysis_df) * 100
