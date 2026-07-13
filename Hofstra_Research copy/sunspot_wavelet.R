library(kza)
library(WaveletComp)
library(scorepeak)

my.data2 <- data.frame(x = data$ma_sunspots)

my.w2 <- analyze.wavelet(my.data2, "x",
                        loess.span = 0,
                        dt = 1, 
                        dj = 1/10, 
                        lowerPeriod = 1,
                        upperPeriod = 730,
                        make.pval = TRUE,
                        n.sim = 1000)

wt.image(my.w2, color.key = "quantile", n.levels = 250,
         legend.params = list(lab = "wavelet power levels", mar = 4.7),
         show.date = TRUE,
         date.format = "%Y",
         periodlab = "Period (years)",
         timelab = "years",
         spec.period.axis = list(at = seq(10, 512, by = 30)),  # ADD EXTRA TICKS in y axis
         periodtck = 1, periodtcl = NULL # It adds horizontal lines (1 is for whole lines, 0.5 or less for shorter lines)
         
)

# Plot power and periods
plot(my.w2$Period, my.w2$Power.avg, type = "l")

# Find and plot peaks
local_peaks <- scorepeak::detect_localmaxima(my.w2$Power.avg)
plot(my.w2$Period, my.w2$Power.avg, type = "l")
points(my.w2$Period[local_peaks], my.w2$Power.avg[local_peaks], col = "red", pch = 19)
abline(v = my.w2$Period[local_peaks], col = "blue")
axis(1, round(my.w2$Period[local_peaks], digits = 0), col.ticks = "blue", lwd.ticks = 3)
text(round(my.w2$Period[local_peaks], digits = 1), round(my.w2$Power.avg[local_peaks], digits = 1),
     labels = round(my.w2$Period[local_peaks], digits = 1), adj = 1)

df.sunspots <-  data.frame(my.w2$Power.avg[local_peaks], my.w2$Period[local_peaks]) 