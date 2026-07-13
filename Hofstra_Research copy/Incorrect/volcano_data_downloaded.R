library(tidyverse)
library(dplyr)

# use setwd() to set the working directory (or go to Session tab)
# make sure the working directory is programming

# define the filename of the downloaded data.
file_name1 <- "volcano-events.tsv"
file_name2 <- "eruption-list.tsv"

# download NCEI
vd <- read.delim(file_name1, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
volcano_data_ncei <- data.frame(year=vd$Year, month=vd$Mo, day=vd$Dy, VEI=vd$VEI)

# download GVP
vd2 <- read.delim(file_name2, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
volcano_data_gvp <- data.frame(year=vd2$X.5, month=vd2$X.7, day=vd2$X.9, VEI=vd2$Downloaded.on.15.May.2025.at.05.03.PM)
volcano_data_gvp <- volcano_data_gvp[-1, ]

# make summary data
min_time=0;
max_time=2024;
min_VEI=2;

volcano_data_gvp <- filter(volcano_data_gvp, VEI >= min_VEI)
volcano_data_gvp$year <- as.numeric(volcano_data_gvp$year)
eruptions_by_year_gvp <- volcano_data_gvp |> 
  count(year, name = "total_eruptions_gvp")
eruptions_by_year_gvp <- arrange(eruptions_by_year_gvp, year)
eruptions_by_year_gvp <- filter(eruptions_by_year_gvp, year >= min_time)
eruptions_by_year_gvp <- filter(eruptions_by_year_gvp, year <= max_time)

volcano_data_ncei <- filter(volcano_data_ncei, VEI >= min_VEI)
volcano_data_ncei$year <- as.numeric(volcano_data_ncei$year)
eruptions_by_year_ncei <- volcano_data_ncei |> 
  count(year, name = "total_eruptions_ncei")
eruptions_by_year_ncei <- arrange(eruptions_by_year_ncei, year)
eruptions_by_year_ncei <- filter(eruptions_by_year_ncei, year >= min_time)
eruptions_by_year_ncei <- filter(eruptions_by_year_ncei, year <= max_time)

merged_volc_data <- merge(x=eruptions_by_year_gvp,
                          y=eruptions_by_year_ncei,
                          by.x="year",
                          by.y="year",
                          all=F) # false => keep only dates that overlap

# plotting the data to compare the data sets
ggplot() +
  geom_line(data = eruptions_by_year_gvp, aes(x = year, y = total_eruptions_gvp, color = "Smithsonian")) +
  geom_line(data = eruptions_by_year_ncei, aes(x = year, y = total_eruptions_ncei, color = "NOAA")) +
  labs(
    title = "number of eruptions over time",
    x = "year", y = "total eruptions",
    color = "Data Source"
  )

rm(vd, vd2, file_name1, file_name2, min_time, min_VEI)