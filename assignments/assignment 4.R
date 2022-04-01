
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
