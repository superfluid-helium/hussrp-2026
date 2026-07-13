# requires data.table, lubridate library (includes functions for dealing with time)
library(data.table)
library(lubridate)
library(tidyverse)
library(ggplot2)

# save yearly mean sunspot number data in sn
sn <- fread("https://www.sidc.be/SILSO/INFO/snytotcsv.php", sep=";")

# data.frame() creates a new data table
sunspot_data <- data.frame(year=sn$V1,
                           sunspots=sn$V2)
sunspot_data$year <- floor(sunspot_data$year)

# reformats data
# sunspot_data$date_S <- as_date(date_decimal(sunspot_data$date_S, tz="UTC"), tz="UTC")
# 
# sunspots_per_year <- sunspot_data |> 
#   group_by(year) |> 
#   summarise(total_sunspots=mean(sunspots))

ggplot(data=sunspot_data, aes(x=year, y=sunspots)) +
  geom_line() +
  labs(title="Average Sunspots Over Time",
       x="Year",
       y="Sunspots") +
  theme(text=element_text(family="Times New Roman"))
rm(sn)