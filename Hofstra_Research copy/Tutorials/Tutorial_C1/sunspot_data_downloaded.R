# requires data.table, lubridate library (includes functions for dealing with time)
library(data.table)
library(lubridate)

# save sunspot number data in sn
sn <- fread("http://www.sidc.be/silso/DATA/SN_d_tot_V2.0.csv", sep=";")

#data.frame() creates a new data table
sunspot_data <- data.frame(date_S=sn$V4,
                           sunspots=sn$V5)
#reformats data
sunspot_data$date_S <- as_date(date_decimal(sunspot_data$date_S, tz="UTC"), tz="UTC")

rm(sn)