setwd("~/Desktop/University system/EDA/EDA_GIT_code")


runoff <- 130 #m3/s 
runoff_ts <- data.frame(time = as.Date(1:90, origin = '2020/12/31'), 
                        value = sample(c(130, 135, 140), 
                                       size = 90, replace = T))

head(runoff_ts)


library(data.table)
runoff_dt <- data.table(runoff_ts) # the same
runoff_dt <- setDT(runoff_ts) # the same


runoff_dt[value > 130]



runoff_dt[value > 130]

runoff_dt[value > 130, mean(value)]

runoff_dt[value > 130, mean(value), by = month(time)] # time (column)
# umbers without all of the collumns because we said to show only values which are more than 130




runoff_dt[, month := month(time)]
runoff_dt

runoff_dt[, week := week(time)]
runoff_dt


runoff_dt[, mon_mean := mean(value), by = month]
runoff_dt


runoff_dt[, wk_mean := mean(value), by = week]

runoff_dt



runoff_month <- runoff_dt[, .(month, mon_mean)]  # getting the table only with this collumns
runoff_month
unique(runoff_month)  # ?????


saveRDS(runoff_dt, file = './data/dt_example.rds')