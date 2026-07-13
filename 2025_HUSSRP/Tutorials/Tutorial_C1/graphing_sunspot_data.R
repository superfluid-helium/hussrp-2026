#requires sunspot data to be downloaded (as sunspot_data)

plot(sunspot_data$date_S, sunspot_data$sunspots, type="l", col="darkred",
     xlab="date", ylab="sunspots",
     main="sunspot data (daily)")

legend("topright", legend=c("sunspots"), col=c("darkred"), lty=1)