#Data manipulation Assignment 2:
The in built dataset is being used for this assignment
lakers dataset from lubridate() package
AdultUCI data set from the arules() package
iris dataset

Questions:
1.Use the lakers data set in the package lubridate. How many rows correspond to a scenario, 
when opponent to POR was LAL?

2.Use the AdultUCI data set from the arules() package. How many 38 year olds are divorced?

3.Use the lakers data set in the package lubridate. How many times observations corresponding to the months of
 October, December, January and April, appear?

4.Use the lakers data set in the package lubridate. In this data set how many rows correspond to instances
 where the Player was Pau Gasol and the opposition was POR?

5.Why would there be an error if following command is used:

 data%>%filter(column1==”abc”,column2>25)%>%mean()
 Assume that “data” is a dataframe and column1 and column2 are the two columns in the dataframe,
 with column1 being a column containingstring/character data and column2 being a column containing numeric data.
 Also assume that both the logical conditions are valid in the context of the data. 
 (Assume that “dplyr” is loaded and installed in the system)

6.Use the inbult iris dataset, what is mean Sepal.Length for species setosa?

7.Use the lakers data set in the package lubridate. In this data how many rows correspond to instances where the day was Monday and time 12?

8.Use the lakers data set in the package lubridate.
  In this data how many rows correspond to instances where, the match was played on Home ground,
  the opponent wsa PHX and day was Wednesday?

9.Load the inbuilt dataset AdultUCI from arules package.
  How many females are there in the data set whose age is less than 50 and who are black?

10.Using the data set AdultUCI from the package arules()
   find out the mean age corresponding to all categories in the column “income” for all white 
   females who work less than 25 hours a week. (Consider the missing values in the column “income”
   also as a separate group)