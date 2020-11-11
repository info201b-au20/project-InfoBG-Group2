#Histogram for race and gender involved in police shootings

library(tidyverse)
library(ggplot2)
shootings <- read.csv("https://media.githubusercontent.com/media/info201b-au20/project-InfoBG-Group2/gh-pages/data/USPoliceShootings.csv")

by_race <- shootings %>% 
  group_by(race) %>%
  summarise(race_count = n())

ggplot(data = by_race) +
  geom_col(mapping = aes(x = race, y = race_count)) +
  labs(x = "Race", y = "Number Killed", title = "US Police Shooting Victims by Race")

