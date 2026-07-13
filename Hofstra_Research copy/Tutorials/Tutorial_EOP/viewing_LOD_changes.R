ggplot(eop, aes(x = date, y=LOD)) +
  geom_line(color="steelblue3") +
  labs(title = "Length of Day since 2000",
       x = "Date", y = "Milliseconds") +
  theme_minimal()