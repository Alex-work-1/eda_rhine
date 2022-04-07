# Explorer’s Questions
 
# 1 How big is the Rhine catchment (km2)?
Rhine_catchment_area <- 185000 # km^2

#  2  If it rained for one full day over the whole catchment area at 0.5mm/hour and all the precipitated water ended up in the river, how much would be the increase in the average river runoff? Write a script that performs the calculation.

Rhine_catchment_area <- Rhine_catchment_area * (1000 ^ 2) # convert to m^2
precipitation_hour <- 0.5 # mm/h
precipitation_day <- (precipitation_hour * 24) / (1000) # m/day
catchment_water <- precipitation_day * Rhine_catchment_area #m3/day

average_runoff <- catchment_water / (24 * 60 * 60) # m^3/s

average_runoff # 25694.44 m^3/s



# 4 In the study of study of Middelkoop et al. (2001):
   
#a)   Which other hydroclimatic changes reported in the article and not discussed above?
# after increase in greenhouse gasses will be increased global average temperature. This will change precipitation and runoff. The snow precipitation will decrease, and the rain precipitation will increase. 


#b)   Can you detect three assumptions made by Middelkoop et al. (2001)?
# the CO2 emission may increase soon, the amount of precipitation day won't change. The climate model includes assumptions about change in temperature.


#c)   Why Middelkoop and his colleagues made this study? Why is it important? For example, the reason for searching for a way to the Orient was that Ottoman Empire monopolized the trade routes across Asia.
# There could be impacts on: winter sports in the alps, flood defense, inland navigation, floodplain development, water availability, hydropower generation. 

