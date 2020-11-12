library(tidyverse)
library(dplyr)
library(stringr)

shootings <- read.csv("USPoliceShootings.csv")
rows <- nrow(shootings)
cols <- ncol(shootings)

# Location
num_wa <- sum(str_detect(shootings$state, "WA"))
num_ca <- sum(str_detect(shootings$state, "CA"))
num_ms <- sum(str_detect(shootings$state, "MS"))
num_tx <- sum(str_detect(shootings$state, "TX"))

# Average Age
mean_age <- mean(shootings$age)

# Racial Groups
num_white <- sum(str_detect(shootings$race, "White"))
num_asian <- sum(str_detect(shootings$race, "Asian"))
num_black <- sum(str_detect(shootings$race, "Black"))
num_hispanic <- sum(str_detect(shootings$race, "Hispanic"))

# Date
dates <- as.Date(shootings[['date']])
latest <- max(dates)
earliest <- min(dates)
in_2020 <- length(dates[format(dates, "%Y") == "2020"])
in_2019 <- length(dates[format(dates, "%Y") == "2019"])
in_2018 <- length(dates[format(dates, "%Y") == "2018"])
in_2017 <- length(dates[format(dates, "%Y") == "2017"])
in_2016 <- length(dates[format(dates, "%Y") == "2016"])
in_2015 <- length(dates[format(dates, "%Y") == "2015"])

# Mental Illness
mentall_ill <- filter(shootings, signs_of_mental_illness == "True")
