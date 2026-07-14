library(TSA)

t <- seq(1,365,1)

period = 30

data <- cos(2*pi * t * (1/period))

#time domain
plot(t, data, type='l',
     main='Synthetic Time Series',
     xlab='Time',
     ylab='Value',
     xlim=c(0,100),
     col='cyan3')
abline(v=seq(1,365,period), col='darkgreen')

#frequency domain
sp.data <- TSA::periodogram(data,plot=F)
#plot separately because we want period, not frequencies
plot(1/sp.data$freq,sp.data$spec,type='l',
     xlab="Periods",
     ylab="Spec",
     main=paste0('Periodogram - frequency domain'),
     xlim=c(0,100))

#adding noise to the cosine function data
noise <- 4*runif(n=length(data),min=-1,max=1)
noisy_data <- data + noise

#plotting the signal
plot(t, data, type='l',
     main='signal',
     ylim=c(-4,4),
     col='blue',
     lwd=2)

#plotting the noise
plot(t, noise, type='l',
     main='noise',
     ylim=c(-4,4),
     col='limegreen')

#plotting the clean signal and the noisy signal together
plot(t, data, type='l',
     col='blue',
     lwd=2,
     ylim=range(c(data,noisy_data)),
     main='Signal and Noise',
     xlab='Time',
     ylab='Value')
lines(t,noisy_data,
      col='lightblue3',
      lwd=1)
legend('topright',
       legend=c('Clean Signal', 'Noisy Signal'),
       col=c('blue','lightblue3'),
       lwd=c(2,1))

#periodogram for the noisy data
sp.data.noisy <- TSA::periodogram(noisy_data,plot=F)
max_spec_idx <- which.max(sp.data.noisy$spec)
peak_period <- 1/sp.data.noisy$freq[max_spec_idx]
plot(1/sp.data.noisy$freq,sp.data.noisy$spec,type='l',
     xlab='Periods',
     ylab='Spec',
     main='Periodogram (Noisy Data)')
abline(v=peak_period, col='red', lwd=2, lty=2) #lty => linetype
text(peak_period,
     max(sp.data.noisy$spec),
     labels=paste("Peak at", round(peak_period, 2)),
     pos=4)
