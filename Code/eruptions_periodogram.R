library(TSA)
library(scorepeak)

my.data.eruptions <- eruptions_filled |>
  dplyr::filter(YEAR>=1702)
sp.eruptions <- TSA::periodogram(my.data.eruptions$ma3, plot=F)

plot(1/sp.eruptions$freq,sp.eruptions$spec,type='l',
     xlab="Periods",
     ylab="Spec",
     main=paste0("Eruptions periodogram (data after 1702 inclusive)"),
     xlim=c(0,150))
local_peaks <- scorepeak::detect_localmaxima(sp.eruptions$spec)
df.eruptions.periodogram <-  data.frame(sp.eruptions$spec[local_peaks], 1/sp.sunspots$freq[local_peaks])

write.csv(df.sunspots.periodogram,
          file = "/Users/sofia/programming/hussrp-2026/Tables/eruptions_periodogram_local_peaks.csv")