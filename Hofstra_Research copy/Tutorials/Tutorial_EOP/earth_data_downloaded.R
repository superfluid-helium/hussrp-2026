# requires data.table, tidyverse

url <- "https://datacenter.iers.org/data/latestVersion/EOP_C01_IAU2000_1846-now.txt"

eop <- fread(url)

colnames(eop) <- c(
  "MJD", "PM_X", "PM_Y", "UT1_TAI", "DX", "DY",
  "X_ERR", "Y_ERR", "UT1_ERR", "DX_ERR", "DY_ERR",
  "RMS", "CORR_XY", "CORR_XU", "CORR_YU", "CORR_DXDY",
  "IND1", "IND2", "IND3", "XRT", "YRT", "LOD",
  "DXRT", "DYRT", "XRT_ERR", "YRT_ERR", "LOD_ERR",
  "DXRT_ERR", "DYRT_ERR")

eop$date <- as.Date(eop$MJD, origin = "1858-11-17")
eop <- filter(eop, year(date) >= 2000)