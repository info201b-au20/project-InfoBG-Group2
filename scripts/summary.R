library(tidyverse)
library(dplyr)
library(stringr)

shootings <- read.csv("-data/USPoliceShootings.csv")

summary_info$rows <- nrow(shootings)
summary_info$cols <- ncol(shootings)

# Location
summary_info$num_wa <- sum(str_detect(shootings$state, "WA"))
summary_info$num_ca <- sum(str_detect(shootings$state, "CA"))
summary_info$num_ms <- sum(str_detect(shootings$state, "MS"))
summary_info$num_tx <- sum(str_detect(shootings$state, "TX"))

# Average Age
summary_info$mean_age <- mean(shootings$age)

# Racial Groups
summary_info$num_white <- sum(str_detect(shootings$race, "White"))
summary_info$num_asian <- sum(str_detect(shootings$race, "Asian"))
summary_info$num_black <- sum(str_detect(shootings$race, "Black"))
summary_info$num_hispanic <- sum(str_detect(shootings$race, "Hispanic"))

# Date
dates <- as.Date(shootings[['date']])
summary_info$latest <- max(dates)
summary_info$earliest <- min(dates)
summary_info$in_2020 <- length(dates[format(dates, "%Y") == "2020"])
summary_info$in_2019 <- length(dates[format(dates, "%Y") == "2019"])
summary_info$in_2018 <- length(dates[format(dates, "%Y") == "2018"])
summary_info$in_2017 <- length(dates[format(dates, "%Y") == "2017"])
summary_info$in_2016 <- length(dates[format(dates, "%Y") == "2016"])
summary_info$in_2015 <- length(dates[format(dates, "%Y") == "2015"])

# Mental Illness
summary_info$mentall_ill <- length(filter(shootings, signs_of_mental_illness == "True"))
