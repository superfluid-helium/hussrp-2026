library(zoo)
library(tidyverse)

eruptions_filled <- eruptions_filled |> 
  dplyr::mutate(ma3=zoo::rollmean(count, k=3, fill=NA, align="right"))

sunspot_data <- sunspot_data |> 
  dplyr::mutate(ma3=zoo::rollmean(sunspots, k=3, fill=NA, align="right"))

ggplot(eruptions_filled, aes(x=YEAR)) +
  geom_line(aes(y=count), alpha=0.5) +
  geom_line(aes(y=ma3), size=1.2) +
  labs(title="Annual Significant Volcanic Eruptions (1600-2025) with 10-Year Moving Average",
     x="Year", y="Eruptions",
     caption="Gray=annual count, Blue=10-year moving average") +
  theme_minimal() +
  theme(text=element_text(family="Times New Roman"))

ggplot(sunspot_data, aes(x=year)) +
  geom_line(aes(y=sunspots), alpha=0.5) +
  geom_line(aes(y=ma3), size=1.2) +
  labs(title="Yearly Mean Sunspot Number (1700-2025) with 10-Year Moving Average",
     x="Year", y="Sunspots",
     caption="Gray=annual count, Blue=10-year moving average") +
  theme_minimal() +
  theme(text=element_text(family="Times New Roman"))
  