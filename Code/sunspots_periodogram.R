library(TSA)
library(scorepeak)

my.data.sunspots <- sunspot_data |>
  dplyr::filter(year>=1702)
sp.sunspots <- TSA::periodogram(my.data.sunspots$ma3, plot=F)

plot(1/sp.sunspots$freq,sp.sunspots$spec,type='l',
     xlab="Periods",
     ylab="Spec",
     main=paste0("Sunspots periodogram (data after 1702 inclusive)"),
     xlim=c(0,150))
local_peaks <- scorepeak::detect_localmaxima(sp.sunspots$spec)
df.sunspots.periodogram <-  data.frame(sp.sunspots$spec[local_peaks], 1/sp.sunspots$freq[local_peaks])

write.csv(df.sunspots.periodogram,
          file = "/Users/sofia/programming/hussrp-2026/Tables/sunspots_periodogram_local_peaks.csv")