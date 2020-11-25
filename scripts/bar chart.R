#Histogram for race and gender involved in police shootings

library(tidyverse)
library(ggplot2)
shootings <- read.csv("data/USPoliceShootings.csv")

by_race <- shootings %>% 
  group_by(race) %>%
  summarise(race_count = n())

shooting_by_race <- ggplot(data = by_race) +
  geom_col(mapping = aes(x = race, y = race_count, fill = race)) +
  labs(x = "Race", y = "Number Killed", title =
        "US Police Shooting Victims by Race from 2015-2020")
