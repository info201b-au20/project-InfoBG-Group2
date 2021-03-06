library(tidyverse)
library(plotly)

# DF1: US Gun Violence

gun_violence <- read.csv("data/USGunViolence.csv")
###############################################################################

# Pie Chart

# Group by high level characteristics
incident_type <- gun_violence$incident_characteristics
high_lev_incident_type <- str_replace(incident_type, "\\|.*", "")
high_lev_incident_type <- table(high_lev_incident_type)
gun_violence_type <- as.data.frame(high_lev_incident_type)

# Too many categories, need to group those with fewer numbers into one single
# category labeled as "other".
small <- gun_violence_type %>%
  filter(Freq < 1500) %>%
  summarise(other = sum(Freq)) %>%
  select(other)

other <- small %>%
  gather("high_lev_incident_type", "Freq", other)

keep <- subset(gun_violence_type, Freq > 1500)

grouped_incident_type <- full_join(other, keep)

# pie chart label location
grouped_incident_type <- grouped_incident_type %>% 
  arrange(desc(high_lev_incident_type)) %>%
  mutate(prop = Freq / sum(grouped_incident_type$Freq) *100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop ) %>%
  mutate(percent = paste(round(prop, digits = 2), "%"))

# generating a pie chart
p_pie <- 
  ggplot(data = grouped_incident_type, 
         aes(x = "", y = prop, fill = high_lev_incident_type)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void() +
  geom_text(aes(x = 1.6, y = ypos, label = percent), color = "black", size=3) +
  labs(title = "Pie Chart of High Level Gun Violence Incident Characteristics") +
  scale_fill_discrete(name = "Incident Characteristics")

p_pie

p1_pie <- plot_ly(grouped_incident_type, 
                  labels = ~high_lev_incident_type,
                  values = ~grouped_incident_type$prop,
                  type = 'pie')
p1_pie <- p1_pie %>% 
  layout(title = '1',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
p1_pie

##############################################################################
# Shiny build pie

build_pie <- function(data) {
  p1_pie <- plot_ly(data, 
                    labels = ~data$high_lev_incident_type,
                    values = ~data$Freq,
                    type = 'pie')
  p1_pie <- p1_pie %>% 
    layout(xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           legend = list(x = 100, y = 0.5))
  return(p1_pie)
}
