
# 1) In retrospect, is DOMA a representative station? Why do you think its behaviour is so different than the other stations?
# In my opinion, it's can't be a representative station because every year data is so much different than the data on other stations. It could happen because of dam constarction near the station.

# 2) In our analysis, we have used only river runoff. Precipitation is a factor strongly linked with runoff. Can you perform a similar analysis (boxplots and regression) for precipitation? Precipitation data averaged over the whole Rhine region can be found in the file precipitation_day.rds in folder data. What do you observe?

library(data.table)
library(ggplot2)

precipitation_day <- readRDS('data/raw/precip_day.rds')
colset_4 <-  c("#D35C37", "#BF9A77", "#D6C6B9", "#97B8C2")

precipitation_day[, month := month(date)]
precipitation_day[month == 12 | month == 1 | month == 2, season := 'winter']
precipitation_day[month == 3 | month == 4 | month == 5, season := 'spring']
precipitation_day[month == 6 | month == 7 | month == 8, season := 'summer']
precipitation_day[month == 9 | month == 10 | month == 11, season := 'autumn']
precipitation_day[, season := factor(season, levels = c('winter', 'spring', 'summer', 'autumn'))]

precipitation_day[, year := year(date)]
precipitation_winter <- precipitation_day[season == 'winter', 
                            .(value = sum(value)), by = year]
precipitation_summer <- precipitation_day[season == 'summer', 
                            .(value = sum(value)), by = year]

year_thres <- 1987
to_plot <- rbind(cbind(precipitation_winter, season = factor('winter')), 
                 cbind(precipitation_summer, season = factor('summer'))) 

to_plot[year < year_thres, period := factor('pre_1987')]
to_plot[year >= year_thres, period := factor('aft_1987')]
to_plot[year < year_thres, period := factor('pre_1987')]
to_plot[year >= year_thres, period := factor('aft_1987')]

ggplot(to_plot[year >= 1957], aes(season, value, fill = period)) +
  geom_boxplot() +
  scale_fill_manual(values = colset_4[c(4, 1)]) +
  xlab(label = "Season") +
  ylab(label = "Precitation") +
  theme_bw()

ggplot(to_plot[season == 'summer' & year >= 1957], aes(x = year, y = value)) +
  geom_line(col = colset_4[3])+
  geom_point(col = colset_4[3])+
  geom_smooth(method = 'lm', formula = y~x, se = 0, col = colset_4[1]) +
  geom_smooth(method = 'loess', formula = y~x, se = 0, col = colset_4[4]) +
  scale_color_manual(values = colset_4[c(1, 2, 4)]) +
  xlab(label = "Year") +
  ylab(label = "Precipitation Summer") +
  theme_bw()

ggplot(to_plot[season == 'winter' & year >= 1957], aes(x = year, y = value)) +
  geom_line(col = colset_4[3])+
  geom_point(col = colset_4[3])+
  geom_smooth(method = 'lm', formula = y~x, se = 0, col = colset_4[1]) +
  geom_smooth(method = 'loess', formula = y~x, se = 0, col = colset_4[4]) +
  scale_color_manual(values = colset_4[c(1, 2, 4)]) +
  xlab(label = "Year") +
  ylab(label = "Precipitation Winter") +
  theme_bw()

# 3) What are your thoughts about the changes in Rhine runoff after completing EDA?
# My thoughts: We can see the changes in runoff and precipitation, but in my opinion there is not enougth data for being sure that the change in precipitation and runoff is the result of climate change.

# 4) Which are some future analyses or other factors that should be examined? Present some arguments related to the findings so far.
# Perhaps the air pollution, amount of fabrics by region, temperature and presence of dams could tell more about effects of climate change on runoffs and increase the quality of collected data.