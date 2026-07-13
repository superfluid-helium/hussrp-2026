ggplot(eop, aes(x = date)) +
  geom_line(aes(y = PM_X, color = "PM_X")) +
  geom_line(aes(y = PM_Y, color = "PM_Y")) +
  labs(title = "Polar Motion (PM_X and PM_Y) since 2000",
       x = "Date", y = "Arcseconds", color = "Axis") +
  theme_minimal()