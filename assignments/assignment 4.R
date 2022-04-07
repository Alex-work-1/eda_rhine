library(data.table)
library(ggplot2)
library(moments)

runoff_stats <- readRDS('./data/runoff_stats.rds')



#transforming to tidy format
runoff_stations_tidy <- melt(runoff_stats, id.vars = "sname")



ggplot(data = runoff_stations_tidy, aes(x = sname, y = value, col = variable)) +
  geom_point() +
  geom_text(x = runoff_stations_tidy$sname, y = runoff_stations_tidy$value + 500, label = runoff_stations_tidy$sname) +
  scale_color_manual(values = colorRampPalette(c("red", "yellow", "blue", "green"))(4)) 


# -----------------

runoff_day <- readRDS('data/runoff_day.rds')
runoff_stats <- runoff_day[, .(mean_day = round(mean(value), 0),
                               sd_day = round(sd(value), 0),
                               min_day = round(min(value), 0),
                               max_day = round(max(value), 0),
                               skewness = round(skewness(value), 2)), by = sname]
runoff_stats[, variation_coefficient := (sd_day / mean_day), by = sname]
dt_skewness_and_variation_coefficient <- runoff_stats[, .(sname, skewness, variation_coefficient)]



# ----------------

colours <- c("red", "yellow", "blue", "green")


runoff_month <- runoff_day[, .(value = mean(value)), by = .(month, year, sname)]
runoff_month[, date := as.Date(paste0(year, '-', month, '-1'))]

ggplot(runoff_month, aes(x = factor(month), y = value)) +
  geom_boxplot(fill = colours[3]) +
  facet_wrap(~sname, scales = "free") 
  
# ---------------

# It loads for a long time
 
# ggplot(runoff_day, aes(x = factor(date), y = value)) +
#   geom_boxplot(fill = colours[3]) +
#   facet_wrap(~sname, scales = 'free') +
#   theme_bw()





# ---------------

runoff_stations <- readRDS('data/runoff_stations.rds')
runoff_stations[, area_class := factor('small')]
runoff_stations[area >= 10000 & area < 140000, area_class := factor('medium')]
runoff_stations[area >= 140000, area_class := factor('large')]

runoff_stations[, alt_class := factor('low')]
runoff_stations[altitude >= 40 & altitude < 450, alt_class := factor('medium')]
runoff_stations[altitude >= 450, alt_class := factor('high')]


dt <- runoff_stations[, .(sname, area, alt_class)]
to_plot <- runoff_stats[dt, on = 'sname']
stations_amount<- nrow(runoff_stats)
colours <-  c("#D35C37", "#BF9A77", "#D6C6B9", "#97B8C2")

ggplot(to_plot, aes(x = mean_day, y = area, col = sname,point_color = area_class, cex = alt_class)) +
  geom_point() +
  scale_color_manual(values = colorRampPalette(colours)(stations_amount)) +
  theme_bw()