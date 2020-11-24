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
  group_by(police_shooting_victims_race)


################################################################################
shooting_by_race <- police_shootings %>% 
  arrange(race)

shooting_by_gender <- police_shootings %>% 
  arrange(gender)

shooting_by_age <- police_shootings %>% 
  arrange(age)

shooting_by_state <- police_shootings %>% 
  arrange(state)

shooting_by_armed <- police_shootings %>% 
  arrange(armed)

shooting_by_death_type <- police_shootings %>% 
  arrange(manner_of_death)

shooting_by_mental_illness <- police_shootings %>% 
  arrange(signs_of_mental_illness)