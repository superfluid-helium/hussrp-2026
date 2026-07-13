library(kza)
library(WaveletComp)
library(scorepeak)

my.data <- data.frame(x = data$norm_eruptions)

my.w <- analyze.wavelet(my.data, "x",
                        loess.span = 0,
                        dt = 1, 
                        dj = 1/10, 
                        lowerPeriod = 1,
                        upperPeriod = 730,
                        make.pval = TRUE,
                        n.sim = 1000)

wt.image(my.w, color.key = "quantile", n.levels = 250,
         legend.params = list(lab = "wavelet power levels", mar = 4.7),
         show.date = TRUE,
         date.format = "%Y",
         periodlab = "Period (years)",
         timelab = "years",
         spec.period.axis = list(at = seq(10, 512, by = 30)),  # ADD EXTRA TICKS in y axis
         periodtck = 1, periodtcl = NULL # It adds horizontal lines (1 is for whole lines, 0.5 or less for shorter lines)
         
)

# Plot power and periods
plot(my.w$Period, my.w$Power.avg, type = "l")

# Find and plot peaks
local_peaks <- scorepeak::detect_localmaxima(my.w$Power.avg)
plot(my.w$Period, my.w$Power.avg, type = "l")
points(my.w$Period[local_peaks], my.w$Power.avg[local_peaks], col = "red", pch = 19)
abline(v = my.w$Period[local_peaks], col = "blue")
axis(1, round(my.w$Period[local_peaks], digits = 0), col.ticks = "blue", lwd.ticks = 3)
text(round(my.w$Period[local_peaks], digits = 1), round(my.w$Power.avg[local_peaks], digits = 1),
     labels = round(my.w$Period[local_peaks], digits = 1), adj = 1)

df.volc_ncei_filled <-  data.frame(my.w$Power.avg[local_peaks], my.w$Period[local_peaks]) 