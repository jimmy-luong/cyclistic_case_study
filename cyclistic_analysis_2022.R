# loading library
library(tidyverse)
library(lubridate)
library(data.table)

# upload the csv files from 2022 from the Cyclistic database
trip_01 <- read.csv("cyclistic_2022/202201-divvy-tripdata.csv")
trip_02 <- read.csv("cyclistic_2022/202202-divvy-tripdata.csv")
trip_03 <- read.csv("cyclistic_2022/202203-divvy-tripdata.csv")

# combines the row of each data frame to make one data frame
trip_q1_2022 <- rbind(trip_01, trip_02, trip_03)

# clean the data environment by removing excess data frames
remove(trip_01, trip_02, trip_03)

# create a duplicate of the data frame to use
trip_q1 <- trip_q1_2022

# verify the types of data of the data frame
str(trip_q1)

# says that started_at is a character type, so switch to date_type
trip_q1$started_at <- ymd_hms(trip_q1$started_at)

# add ride_length and day_of_week as per instructions
trip_q1$ride_length <- round(difftime(trip_q1$ended_at, trip_q1$started_at, units = "mins"), digits=2)
trip_q1$day_of_week <- weekdays(trip_q1$started_at)

# verify that these columns have been added to the data frame
colnames(trip_q1)

# cleaning the data, can verify by comparing obs. to original dataset
trip_q1 <- na.omit(trip_q1)  # omits the NA values
trip_q1 <- distinct(trip_q1) # removes duplicates
trip_q1 <- trip_q1[!(trip_q1$ride_length <= 0),] # removes rides with a length of 0 or less
trip_q1 <- trip_q1[,!names(trip_q1) %in% c("start_lat", "start_lng", "end_lat", "end_lng")]

# adding these columns will allow us to aggregate ride data for each month, day, or year
trip_q1$date <- as.Date(trip_q1$started_at) #The default format is yyyy-mm-dd
trip_q1$month <- format(as.Date(trip_q1$date), "%m")
trip_q1$day <- format(as.Date(trip_q1$date), "%d")
trip_q1$year <- format(as.Date(trip_q1$date), "%Y")
trip_q1$hour <- hour(trip_q1$started_at)

# verify that these columns have been added to the data frame
colnames(trip_q1)

# descriptive analysis on ride_length
mean(trip_q1$ride_length) 
median(trip_q1$ride_length) 
max(trip_q1$ride_length) 
min(trip_q1$ride_length)

# put the days in week in order
trip_q1$day_of_week <- ordered(trip_q1$day_of_week, levels=c("Sunday", 
                       "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))

# see the average ride time by each day for members vs casual users
aggregate(trip_q1$ride_length ~ trip_q1$member_casual + trip_q1$day_of_week, FUN = mean)

# analyze ridership data by type and day_of_week
trip_q1 %>% 
  group_by(member_casual, day_of_week) %>%  #groups by user type and day_of_week
  summarise(number_of_rides = n(), 		    	#calculates the number of rides and average duration 
            average_duration = mean(ride_length)) %>% 		# calculates the average duration
  arrange(member_casual, day_of_week)			  # sorts

# analyze and create a visualization of the number of rides by rider type
trip_q1 %>% 
  group_by(member_casual, day_of_week) %>% 
  summarise(number_of_rides = n(),
            average_duration = mean(ride_length)) %>% 
  arrange(member_casual, day_of_week)  %>% 
  ggplot(aes(x = day_of_week, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") + labs(title="Cyclistic: Casual vs Members", 
                                      subtitle = "Comparison of the number of rides between casual and members",
                                      x = "Day of Week", y = "Number of Rides")

# visualization for average duration
trip_q1 %>% 
  group_by(member_casual, day_of_week) %>% 
  summarise(number_of_rides = n(),
            average_duration = mean(ride_length)) %>% 
  arrange(member_casual, day_of_week)  %>% 
  ggplot(aes(x = day_of_week, y = average_duration, fill = member_casual)) +
  geom_col(position = "dodge") + labs(title="Cyclistic: Casual vs Members", 
                                      subtitle = "Comparison of the average ride length between casual and members",
                                      x = "Day of Week", y = "Average Duration")

# visualization for the number of rides during certain hours
trip_q1 %>% 
  group_by(member_casual, hour) %>% 
  summarise(number_of_rides = n(),
            average_duration = mean(ride_length)) %>% 
  arrange(member_casual, hour)  %>% 
  ggplot(aes(x = hour, y = number_of_rides, fill = member_casual)) +
  geom_col(position = "dodge") + labs(title="Cyclistic: Casual vs Members", 
                                      subtitle = "Comparison of the hours that the service is used",
                                      x = "Hour", y = "Number of Rides")
