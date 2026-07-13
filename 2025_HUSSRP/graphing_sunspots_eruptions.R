library(BBmisc)
library(kza)

data <- merge(x=sunspot_data,
              y=eruptions_filled,
              by.x="year",
              by.y="YEAR",
              all=F) # false => keep only dates that overlap

data$norm_sunspots <- normalize(data$sunspots, method="range", range=c(0,1))
data$norm_eruptions <- normalize(data$count, method="range", range=c(0,1))

# data$ma_volc <- kz(x=data$count, m=3, k=1)
# data$ma_sunspots <- kz(x=data$sunspots, m=3, k=1)

ggplot() +
  geom_line(data=data, aes(x=year, y=norm_sunspots, color="yearly mean sunspots")) +
  geom_line(data=data, aes(x=year, y=norm_eruptions, color="annual eruptions")) +
  labs(title="Volcanic Eruptions and Sunspots (1700-2025)",
       x="Year",
       y="Normalized Value") +
  theme(text=element_text(family="Times New Roman"))