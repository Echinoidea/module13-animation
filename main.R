library(ggplot2)
library(dplyr)
library(tidyr)
library(gganimate)
library(hrbrthemes)

covid_data <- read.csv("time-series-19-covid-combined.csv")

countries <- c("US", "China", "Brazil", "Italy", "India")

covid_data <- covid_data %>%
  filter(Country.Region %in% countries)

covid_data$Date <- as.Date(covid_data$Date)

covid_data_aggregate <- covid_data %>%
  group_by(Date, Country.Region) %>%
  summarise(Country.Total = sum(Confirmed)) %>%
  ungroup()

anim <- ggplot(data = covid_data_aggregate, aes(x = Date, y = Country.Total, color = Country.Region)) +
  geom_line(size = 1, alpha = 0.8, show.legend = TRUE) +
  geom_point() +
  labs(title = "COVID-19 Confirmed Cases",
       subtitle = "2020-01 through 2022-04",
       x = "Date",
       y = "Confirmed Cases",
       color = "Country") +
  theme_ipsum() +
  transition_reveal(Date)

anim

anim_save("covid.gif", anim)

