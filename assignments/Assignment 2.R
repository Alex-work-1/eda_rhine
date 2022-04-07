library(data.table)


multiply <- function(x, y){
  return(x*y)
}


temperatures= c(3,6,10,14)
weights = c(1,0.8,1.2,1)

results <- multiply(temperatures, weights)



# Creating a random runoff data frame
runoff_df <- data.frame(time = as.Date(1:90, origin = '2020/12/31'), 
                        value = sample(c(130, 135, 140), 
                                       size = 90, replace = T))

# Converting data frame into data table
runoff_dt <- data.table(runoff_df) 



runoff_dt[, month := month(time)] # Creating month number column


runoff_dt[, mon_mean := mean(value), by = month] # month mean column





runoff_month <- runoff_dt[months(runoff_dt$time) %in% month.name[1:3], .(month, mon_mean)] # creating new data table with January February and March months


runoff_month <- unique(runoff_month) # removing the repetitions

runoff_month[, pecentage_change := paste0(as.character(round( (mon_mean / shift(mon_mean)) * 100 - 100, digits = 2 )), '%')] # calculating and adding a precentage change colun

# Displaying table
runoff_month