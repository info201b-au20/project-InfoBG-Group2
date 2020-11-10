library(tidyverse)

gun_violence <- read.csv(url("https://media.githubusercontent.com/media/info201b-au20/project-InfoBG-Group2/gh-pages/data/USGunViolence.csv"))

gun_violence_date <- as.Date(gun_violence$date)
date_occurrence <- table(gun_violence_date)
date_occurrence_df <- as.data.frame(date_occurrence)
date_occurrence_df$gun_violence_date <- 
  as.Date(date_occurrence_df$gun_violence_date)

incidents_date <- 
  ggplot(data = date_occurrence_df, 
         aes(x = gun_violence_date, y = Freq, group = 1)) + 
  geom_line(color = "#77777D") +
  stat_smooth(color = "#3937D0", method = "loess") +
  scale_x_date(breaks = "6 months") +
  ggtitle("Number of Gun Violence Incidents per Day") +
  xlab("Date") + ylab("Number of Incidents")

incidents_date

date_occurrence_df_trimmed<- date_occurrence_df[-c(1:177),]

incidents_date_trimmed <- 
  ggplot(data = date_occurrence_df_trimmed, 
         aes(x = gun_violence_date, y = Freq, group = 1)) + 
  geom_line(color = "#77777D") +
  stat_smooth(color = "#3937D0", method = "loess") +
  scale_x_date(breaks = "6 months") +
  ggtitle("Number of Gun Violence Incidents per Day") +
  xlab("Date") + ylab("Number of Incidents")

incidents_date_trimmed
