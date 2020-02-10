
library(dplyr)
library(lubridate)
#Question 1 :
#Use the lakers data set in the package lubridate.
# How many rows correspond to a scenario, when opponent to POR was LAL?


lake<-lakers

lake<-lakers
lake$Date<-paste(as.character(lake$date),lake$time) 
lake$Date<-ymd_hm(lake$Date) 
lake%>%filter(opponent=="POR",team=="LAL")%>%nrow()
#852

#Question 2:
#Use the AdultUCI data set from the arules() package. How many 38 year olds are divorced?
install.packages("arules")
library(arules)

data(AdultUCI)

library(dplyr)

AdultUCI%>%filter(`marital-status`=="Divorced",age==38)%>%nrow()
#225

#Question 3 :

# Use the lakers data set in the package lubridate. How many times observations 
# corresponding to the months of October, December, January and April, appear?

str(lake)
lake$Date<-paste(as.character(lake$date),lake$time)
lake$Date<-ymd_hm(lake$Date) 

lake%>%
  group_by(Month=months(Date))%>%
  summarize(Number=n())%>%
  filter(Month=="October"|Month=="December"|Month=="January"|Month=="April")

# Month    Number
# <chr>     <int>
#   1 April      3618
# 2 December   6240
# 3 January    6515
# 4 October     871



#Question 4:
#see the lakers data set in the package lubridate.
# In this data set how many rows correspond to instances where the Player was Pau Gasol 
# and the opposition was POR?

lake$Date<-paste(as.character(lake$date),lake$time) 
lake$Date<-ymd_hm(lake$Date) 
lake%>%filter(player=="Pau Gasol",opponent=="POR")%>%nrow()
#94

#Question 5: 
#Why would there be an error if following command is used:
#   data%>%
#filter(column1=="abc",column2>25)%>%mean()

#assume that "data" is a dataframe and column1 and column2 are the two columns in the dataframe, 
#with column1 being a column containing string/character data and column2 being a column containing 
#numeric data. Also assume that both the logical conditions are valid in the context of the data. 
#(Assume that "dplyr" is loaded and installed in the system)
# 
# Answer: mean() will work if it is piped to summarise() and relevant context is provided as to which column's 
#mean is to be computed




#Question 6:
#Use the inbult iris dataset, what is mean Sepal.Length for species setosa?

iris%>%filter(Species=="setosa")%>%summarize(mean(Sepal.Length))

# mean(Sepal.Length)
#    5.006


#Question 7:
# Use the lakers data set in the package lubridate.
# In this data how many rows correspond to instances where the day was Monday and time 12?
lake$Date<-paste(as.character(lake$date),lake$time)
lake$Date<-ymd_hm(lake$Date)
lake%>%filter(hour(Date)==12,weekdays(Date)=="Monday")%>%nrow()
# 4



#Quesion 8:
# Use the lakers data set in the package lubridate. In this data how many rows correspond to instances where,
# the match was played on Home ground, the opponent wsa PHX and day was Wednesday?

 lake$Date<-paste(as.character(lake$date),lake$time)
 lake$Date<-ymd_hm(lake$Date)
lake%>%filter(weekdays(Date)=="Wednesday",opponent=="PHX",game_type=="home")%>%nrow()
#441

#Question 9:
# Load the inbuilt dataset AdultUCI from arules package.
# How many females are there in the data set whose age is less than 50 and who are black?

AdultUCI%>%filter(age<50, race=="Black",sex=="Female")%>%nrow()
#1870

#Question 10:
# Using the data set AdultUCI from the package arules() find out the mean age corresponding to all categories 
# in the column "income" for all white females who work less than 25 hours a week. 
# (Consider the missing values in the column "income" also as a separate group)

AdultUCI%>%
  filter(race=="White",sex=="Female",`hours-per-week`<25)%>%
  group_by(income)%>%summarize(mean(age))

# income `mean(age)`
# <ord>        <dbl>
#   1 small         34.4
# 2 large         45.4
# 3 NA            34.5