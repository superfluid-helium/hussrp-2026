# Download temperature data (2 stations)
# Store data as temp1 and temp2, then merge and filter to temp_data
# Requires GSODR

# download data
temp1 <- GSODR::get_GSOD(1973:2024, "744860-94789")
temp2 <- GSODR::get_GSOD(1948:1972, "999999-94789")

# merge data
temp3 <- rbind(temp1, temp2)
# rbind() combines the two data sets
# by adding the rows of the second beneath the first

# filter data
temp_data <- data.frame(date_T=temp3$YEARMODA, temperature=temp3$TEMP)