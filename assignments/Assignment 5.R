
library(data.table)
library(ggplot2)

runoff_year_key <- readRDS('data/runoff_year_key.rds')
runoff_month_key <- readRDS('data/runoff_month_key.rds')
runoff_day <- readRDS('data/runoff_day.rds')
runoff_summer <- readRDS('data/runoff_summer.rds')
runoff_winter <- readRDS('data/runoff_winter.rds')
runoff_summary <- readRDS('data/runoff_summary.rds')
colset_4 <-  c("#D35C37", "#BF9A77", "#D6C6B9", "#97B8C2")
key_stations <- c('DOMA', 'BASR', 'KOEL')

# 1 In our boxplot comparison of DOMA, BASR and KOEL we have used summer and winter period. Can you repeat it for annual and monthly data? Is there is some useful new information presented?

# annual 
runoff_year_key[year <= 2000, age_range := factor('before 2000')]
runoff_year_key[year > 2000, age_range := factor('after 2000')]

ggplot(runoff_year_key, aes(age_range, value, fill = age_range)) +
  geom_boxplot() +
  facet_wrap(~sname, scales = 'free_y') +
  scale_fill_manual(values = colset_4[c(4, 1)]) +
  xlab(label = "Age Range") +
  ylab(label = "Runoff (m3/s)") +
  theme_bw()
# answer : range is changed

# monthly
runoff_month_key[year <= 2000, age_range := factor('before 2000')]
runoff_month_key[year > 2000, age_range := factor('after 2000')]

ggplot(runoff_month_key, aes(factor(month), value, fill = age_range)) +
  geom_boxplot() +
  facet_wrap(~sname, scales = 'free_y') +
  scale_fill_manual(values = colset_4[c(4, 1)]) +
  xlab(label = "Month") +
  ylab(label = "Runoff (m3/s)") +
  theme_bw()
# we can see which month has the most runoff , so it is more accurate then seasonal







#2 In their research, Middelkoop and colleagues also mentioned changes in the high/low runoff. Do our data agree with their results? We define high runoff as the daily runoff above the 0.9 quantile and low runoff as the daily runoff below the 0.1 quantile. Then we can estimate the mean high/low runoff per station. Finally, we also compare the number of days with values above/below 0.9 and 0.1 correspondingly (hint: .N function in data.table might help).
runoff_day_key <- runoff_day[sname %in% key_stations]
year_thres <- 2016 - 30
runoff_day_key[year <= year_thres, age_range := factor('before_1986')]
runoff_day_key[year > year_thres, age_range := factor('after_1986')]
runoff_day_key[, qu_01 := quantile(value, 0.1), by = .(sname, month)]
runoff_day_key[, qu_09 := quantile(value, 0.9), by = .(sname, month)]

runoff_day_key[, runoff_class := factor('medium')]
runoff_day_key[value <= qu_01, runoff_class := factor('low')]
runoff_day_key[value >= qu_09, runoff_class := factor('high')]
runoff_day_key[, days := .N, .(sname, year, runoff_class, season)]

runoff_day_key_class <- unique(
  runoff_day_key[, .(sname, days, year, age_range, season, runoff_class)])

ggplot(runoff_day_key_class[season == 'winter' | season == 'summer'], 
       aes(season, days, fill = age_range)) +
  geom_boxplot() +
  facet_wrap(runoff_class~sname, scales = 'free_y') +
  scale_fill_manual(values = colset_4[c(4, 1)]) +
  xlab(label = "Season") +
  ylab(label = "Days") +
  theme_bw()

#3 How sensitive are slopes to adding new data? Redo the 1950-today regression plots, but instead of 2016, use data till 2010. What do you observe? What if you used linear regression instead of loess?

#loess
runoff_winter[, value_norm := scale(value), sname]
runoff_summer[, value_norm := scale(value), sname]
n_stations <- nrow(runoff_summary)

ggplot(runoff_winter[year > 1950 & year <= 2010], aes(x = year, y = value_norm, col = sname)) +
  geom_smooth(method = 'loess', formula = y~x, se = 0) + 
  scale_color_manual(values = colorRampPalette(colset_4)(n_stations)) +
  ggtitle('Winter runoff') +
  xlab(label = "Year") +
  ylab(label = "Runoff (z-score)") +
  theme_bw()

# there is a decrease in runoff untill 2010 and since 2010 it starts increasing




ggplot(runoff_summer[year > 1950 & year <= 2010], aes(x = year, y = value_norm, col = sname)) +
  geom_smooth(method = 'loess', formula = y~x, se = 0) + 
  scale_color_manual(values = colorRampPalette(colset_4)(n_stations)) +
  ggtitle('Summer runoff') +
  xlab(label = "Year") +
  ylab(label = "Runoff (z-score)") +
  theme_bw()
#in this case it shows decrease only


# linear regression
ggplot(runoff_winter[year > 1950 & year <= 2010], aes(x = year, y = value_norm, col = sname)) +
  geom_smooth(method = 'lm', formula = y~x, se = 0) + 
  scale_color_manual(values = colorRampPalette(colset_4)(n_stations)) +
  ggtitle('Winter runoff') +
  xlab(label = "Year") +
  ylab(label = "Runoff (z-score)") +
  theme_bw()
#shows a steady increase

ggplot(runoff_summer[year > 1950 & year <= 2010], aes(x = year, y = value_norm, col = sname)) +
  geom_smooth(method = 'lm', formula = y~x, se = 0) + 
  scale_color_manual(values = colorRampPalette(colset_4)(n_stations)) +
  ggtitle('Summer runoff') +
  xlab(label = "Year") +
  ylab(label = "Runoff (z-score)") +
  theme_bw()
# again shows steady decrease, but without some information 
