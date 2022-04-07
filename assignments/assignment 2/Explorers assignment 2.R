


# 1) Which are the units for area and runoff in our records?
#   area    =   km^2 
#   runoff  =   m^3/s

# 2)   Which is the average catchment area and runoff of Rhine, according to our data? Write a script that performs the calculation.
library(data.table)
library(ggplot2)

runoff_stations <- readRDS('data/runoff_stations.rds')
runoff_stations[, mean(area)]
runoff_day <- readRDS('data/runoff_day.rds')
runoff_day[, mean(value)]

# 3) Which is the average runoff in each station? Present them in a graph.

runoff_average <- runoff_day[, mean(value), by = sname]
runoff_average
# 4) Is there any relationship between station altitude and catchment area? Why?
# Usually the river width is smaller in higher altitudes and higher in lower altitudes, so the catchment area is also larger.
