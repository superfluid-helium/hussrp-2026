world_map <- map_data("world")

ggplot() +
  geom_polygon(data=world_map,
               aes(x=long, y=lat, group=group),
               fill="gray85", color="white") +
  geom_point(data=eruption_filt,
             aes(x=LONGITUDE, y=LATITUDE, size=VEI),
             alpha=0.7) +
  scale_size(range=c(1,5), name="VEI") +
  coord_fixed(1.3) +
  labs(title="Global Significant Volcanic Eruptions (2002-2026)",
       x="Longitude", y="Latitude") +
  theme(text=element_text(family="Times New Roman"))