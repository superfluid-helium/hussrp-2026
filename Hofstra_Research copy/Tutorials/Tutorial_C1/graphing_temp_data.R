#requires temp data to be downloaded (as temp_data)

# creates a dotted line graph of temp vs date
plot(temp_data$date_T, temp_data$temperature, type="l",lty=3, col="steelblue",
     xlab="date", ylab="temperature (deg F)", # adds labels for the x and y axes
     main="temperature data (daily)") # adds a main title

# adds a legend at the bottom right
legend("bottomright", legend=c("temperature"), col=c("steelblue"), lty=3)
# inside the c(), adding more values allows for more types of lines/labels in the legend