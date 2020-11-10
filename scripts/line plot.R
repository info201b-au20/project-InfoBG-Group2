library(tidyverse)

# DF1: US Gun Violence

gun_violence <- read.csv(url("https://media.githubusercontent.com/media/info201b-au20/project-InfoBG-Group2/gh-pages/data/USGunViolence.csv"))

# Incidents per day
gun_violence_date <- as.Date(gun_violence$date)
date_occurrence <- table(gun_violence_date)
date_occurrence_df <- as.data.frame(date_occurrence)
date_occurrence_df$gun_violence_date <- 
  as.Date(date_occurrence_df$gun_violence_date)

p_incidents_date <- 
  ggplot(data = date_occurrence_df, 
         aes(x = gun_violence_date, y = Freq, group = 1)) + 
  geom_line(color = "#77777D") +
  stat_smooth(color = "#3937D0", method = "loess") +
  scale_x_date(breaks = "6 months") +
  ggtitle("Number of Gun Violence Incidents per Day") +
  xlab("Date") + ylab("Number of Incidents")

p_incidents_date

# When looking at the plot "incidents_date", we can see the numbers in 2013
# are all extremely low (not even exceeding 10). I am assuming they probably 
# don't have the complete data for 2013, so I decide to drop those rows.
# Here I am having another version which has the data of 2013 dropped.

date_occurrence_df_trimmed<- date_occurrence_df[-c(1:177),]

p_incidents_date_trimmed <- 
  ggplot(data = date_occurrence_df_trimmed, 
         aes(x = gun_violence_date, y = Freq, group = 1)) + 
  geom_line(color = "#77777D") +
  stat_smooth(color = "#3937D0", method = "loess") +
  scale_x_date(breaks = "6 months") +
  ggtitle("Number of Gun Violence Incidents per Day") +
  xlab("Date") + ylab("Number of Incidents")

p_incidents_date_trimmed

p_dot <- 
  ggplot(data = date_occurrence_df_trimmed, 
         aes(x = gun_violence_date, y = Freq, group = 1)) + 
  geom_point(color = "#77777D") +
  stat_smooth(color = "#3937D0", method = "loess") +
  scale_x_date(breaks = "6 months") +
  ggtitle("Number of Gun Violence Incidents per Day") +
  xlab("Date") + ylab("Number of Incidents")

p_dot

###############################################################################

# killed & injured per day

killed_by_date <- gun_violence %>%
  group_by(date) %>%
  summarise(killed = sum(n_killed)) %>%
  select(date, killed)
killed_by_date$date <- as.Date(killed_by_date$date)

injured_by_date <- gun_violence %>%
  group_by(date) %>%
  summarise(injured = sum(n_injured)) %>%
  select(date, injured)
injured_by_date$date <- as.Date(injured_by_date$date)

p_killed_injured_date <- 
  ggplot() + 
  geom_point(data = killed_by_date, aes(x = date, y = killed), color = "#ff6600") +
  geom_point(data = injured_by_date, aes(x = date, y = injured), color = "#0099ff") +
  scale_x_date(breaks = "6 months") +
  ggtitle("Number of People Killed / Injured by Gun Violence per Day") +
  xlab("Date") + ylab("Number of People")

p_killed_injured_date

# STACKED BAR CHART

total_by_date <- full_join(killed_by_date, injured_by_date)
total_by_date <- total_by_date %>%
  gather("key", "value", -c(date))

p_stacked <- 
  ggplot(data = total_by_date, 
         aes(x = date, y = value, group = key, fill = key)) + 
  geom_col() +
  scale_x_date(breaks = "6 months") +
  ggtitle("Number of People Killed / Injured by Gun Violence per Day") +
  xlab("Date") + ylab("Number of People")

p_stacked


