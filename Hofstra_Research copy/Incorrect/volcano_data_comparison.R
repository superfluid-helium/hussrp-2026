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
eruptions_by_year_gvp <- volcano_data_gvp |> 
  count(year, name = "total_eruptions")
eruptions_by_year_gvp$year <- as.numeric(eruptions_by_year_gvp$year)
eruptions_by_year_gvp <- arrange(eruptions_by_year_gvp, year)
eruptions_by_year_gvp <- filter(eruptions_by_year_gvp, year >= -100)

eruptions_by_year_ncei <- volcano_data_ncei |> 
  count(year, name = "total_eruptions")
eruptions_by_year_ncei$year <- as.numeric(eruptions_by_year_ncei$year)
eruptions_by_year_ncei <- arrange(eruptions_by_year_ncei, year)
eruptions_by_year_ncei <- filter(eruptions_by_year_ncei, year >= -100)

# plotting the data to compare the data sets
plot(eruptions_by_year_gvp$year, eruptions_by_year_gvp$total_eruptions, type="line", col="blue",
     xlab="year", ylab="total eruptions")
lines(eruptions_by_year_ncei$year, eruptions_by_year_ncei$total_eruptions, col="red")

legend("topright",
       legend=c("NOAA", "Smithsonian"),
       col=c("red", "blue"),
       lty=1)