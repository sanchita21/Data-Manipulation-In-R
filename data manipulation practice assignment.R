fd<-read.csv("H:\\FlightDelays.csv")
str(fd)
# The data has information on the flights over the year 2004 and if a particular flight was
# delayed or not.
# 1. Find out the number of delayed flights for all weekdays
# 2. Find the average distance, total distance and count for all delayed flights on Friday.
# 3. Find out how many flights were on time on Week days and Weekends (Consider Saturday
#                                                                      and Sunday as weekends)
# 4. Find out the number of flights for each destination across all weekdays
# 5. Find out the number of times weather was bad across all weekdays. (1 indicates bad
#                                                                       weather)
# Hints:
#   1. Make sure that you convert the column containing date information into date format
# 2. While converting the column with date information into date format, make sure that you
# are supplying the correct date specification. Eg: a string like 1/1/2001, can mean both 1st
# January 2001 and January 1 2001. Make sure you check the format of date column before
# proceeding with the assignment.

library(lubridate)
library(dplyr)

head(fd$date)
#date is in factor data type.WE have to convert it into date data type
fd$date<-mdy(fd$date)
str(fd$date)

#Q1. Find out the number of delayed flights for all weekdays
fd%>%filter(delay=="delayed"& weekdays(date)!="Saturday"& weekdays(date)!="Sunday")%>%nrow()
## [1] 336

#Q2 Find the average distance, total distance and count for all delayed flights on Friday


fd%>%
  filter(weekdays(date)=="Friday"& delay=="delayed")%>%
  summarize(mean(distance),sum(distance),length(distance))
## mean(distance) sum(distance) length(distance)
## 1 210.28 15771 75 

#Q3 Find out how many flights were on time on Week days and Weekends (Consider
              #Saturday and Sunday as weekends)
fd%>%
  filter(delay=="ontime",weekdays(date)!="Saturday"& weekdays(date)!="Sunday")%>%
  nrow()
# number of delayed flights on weekdays
## [1] 1362

fd%>%
filter(delay=="ontime",weekdays(date)=="Saturday"|weekdays(date)=="Sunday")%>%
  nrow()
# number of delayed flights on weekends
## [1] 411 



#Q4 Find out the number of flights for each destination across all weekdays
fd%>%
  filter(weekdays(date)!="Sunday"&weekdays(date)!="Saturday")%>%
  group_by(dest)%>%
  summarize(n())

## dest n()
## (fctr) (int)
## 1 EWR 507
## 2 JFK 272

#Q5 Find out the number of times weather was bad across all weekdays. (1 indicates bad weather)

fd%>%
  filter(weekdays(date)!="Sunday"&weekdays(date)!="Saturday"&weather==1)%>%nrow()
## [1] 30 




########### END ##############