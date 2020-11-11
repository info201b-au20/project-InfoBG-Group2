library(tidyverse)
Police_Shootings <- read.csv("https://media.githubusercontent.com/media/info201b-au20/project-InfoBG-Group2/gh-pages/data/USPoliceShootings.csv")

shooting_by_race <- Police_Shootings %>% 
  arrange(race)

shooting_by_gender <- Police_Shootings %>% 
  arrange(gender)

shooting_by_age <- Police_Shootings %>% 
  arrange(age)

shooting_by_state <- Police_Shootings %>% 
  arrange(state)

shooting_by_armed <- Police_Shootings %>% 
  arrange(armed)

shooting_by_death_type <- Police_Shootings %>% 
  arrange(manner_of_death)

shooting_by_mental_illness <- Police_Shootings %>% 
  arrange(signs_of_mental_illness)