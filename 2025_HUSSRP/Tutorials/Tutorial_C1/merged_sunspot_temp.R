# requires downloaded sunspot and temp data
# requires data.table, BBmisc library

data <- merge(x=sunspot_data,
              y=temp_data,
              by.x="date_S",
              by.y="date_T",
              all=F) # false => keep only dates that overlap

# rename the date column
setnames(data, old = "date_S", new = "date")

# normalize the data
data$norm_sunspots <- normalize(data$sunspots, method="range", range=c(0,1))
data$norm_temperature <- normalize(data$temperature, method="range", range=c(0,1))


# plotting the normalized, merged data
plot(data$date, data$norm_sunspots, type="l", col="darkred",
     xlab="date", ylab="normalized value",
     main="normalized temp and sunspot data")
lines(data$date, data$norm_temperature, col="steelblue")
legend("topright", legend=c("sunspots", "temperature"), col=c("darkred", "steelblue"), lty=1)