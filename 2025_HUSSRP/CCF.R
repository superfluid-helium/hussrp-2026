ccf_result <- ccf(my.data2, my.data, lag.max = 1000, main='Cross-Correlation (sunspots vs eruptions)',
                  xlab="Lag (relative to sunspot data)")
max_idx <- which.max(ccf_result$acf)
best_lag <- ccf_result$lag[max_idx]