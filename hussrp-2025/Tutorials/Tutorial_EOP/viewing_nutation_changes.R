ggplot(eop, aes(x = date)) +
  geom_line(aes(y = DX, color = "DX (dPsi)")) +
  geom_line(aes(y = DY, color = "DY (dEps)")) +
  labs(title = "Nutation Parameters (dPsi and dEps) since 2000",
       x = "Date", y = "Arcseconds", color = "Type") +
  theme_minimal()