

library(data.table)
library(ggplot2)



runoff_stations <- readRDS('./data/runoff_stations.rds')

theme_set(theme_minimal())




#---------------------
ggplot(data = runoff_stations) +
  geom_point(aes(x = area, y = altitude, col = size)) +
  geom_text(aes(x = area, y = altitude + 35, label = runoff_stations$sname, col = size))




#---------------------

ggplot(data = runoff_stations) +
  geom_point(aes(x = lon, y = lat, col = altitude)) +
  geom_text(aes(x = lon, y = lat + 0.2, label = runoff_stations$sname, col = size)) +
  scale_colour_continuous(low = 'darkgreen', high = 'darkred')

#---------------------

ggplot(data=runoff_stations, aes(x = sname, y = size)) +
  geom_bar(stat="identity", fill="blue")
