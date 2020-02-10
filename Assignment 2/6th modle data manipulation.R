setwd("D:\\R practice")
getwd()

oj<-read.csv("oj dataset.csv")
str(oj)


library(dplyr)

ok<-rename(oj,"prices"=price)
names(ok)
class(oj)
om<-slice(oj,1:30)
view(om)

om
head(oj,10)

#dataframe[rows,columns]
oj[1,3]#if i want to check 1st row,3rd column value

oj[c(1,2,8,456),c(1,3,6)]#if i want to check 1,2,8 nd 456th rows of columns 1,3,nd 6

oj[c(2,5,10),c(2,5,6)]

oj[c(1:5),"brand"] #if i want to check "brand" for rows 1 to 5



#how to se;ect rows of data !

#logical Subsetting
#selectiong only those rows where brand bought is only "tropicana"
dat<-oj[oj$brand=="tropicana",]
head(dat,5)
class(dat)

#using or operator ,brand bought is tropicana  or dominicks
dat1<-oj[oj$brand =="tropicana"|oj$brand =="dominicks",]
head(dat1,10)

#using and operator,brand bought is tropicana and feat=0
dat2<-oj[oj$brand=="tropicana" & oj$feat==0, ]
head(dat2,15)
 
dat3<-oj[oj$brand=="dominicks" & oj$feat==0,]
head(dat3,15)

#subsetting using which operator
?which()
dat4<-which(oj$brand=="tropicana")
head(dat4) #this will give the positions where the ehere statement is true.which operator gives
#logical output.u wont be able to see the dataset
data5<-oj[dat4,]#we are assigning the values where the which operator was true in oj dataset to 
#the data5 dataset

head(data5,15)  

###selection of columns from a dataset

#selectiong only columns week and brand and all rows
data6<-oj[,c("week","brand")]
head(data6)

data7<-oj[,c("feat","brand")]

head(data7)


#selecting and subsetting data
data8<-oj[oj$brand=="tropicana",c("week","brand","feat")]
head(data8,10)

#adding new column in an existing dataset
dim(oj)
oj$logInc<-log(oj$INCOME)
dim(oj)
 
oj$revenue<-exp(oj$logmove)*oj$price
dim(oj)

#ordering data
#sorting Data
#order() returns the element that results in a sorted vector
students<-c("jim","alpana","kabir","aditya")
students
order(students)
students[order(students)]

#sorting numbers
data10<-c(5,15,7,89)
order(data10)
data10[order(data10)]

order(-data10)
data10[order(-data10)]

#sorting data frames
data11<-oj[order(oj$week),]
head(data11,15)
min(oj$week)

data12<-oj[order(oj$price),]
head(data12)
min(oj$price)

#group By summaries
#In the below set we are checking the means across  brands by grouping the brands and 
#finding the means of each of them
#Keep in mind we are  sumarizing the variable brand which is factor variable and we are trying
#to find mean ofeach of these groups

#mean price of juice across brands
#summarize price
#summarze by brand(factor)
#summarize how?- MEAN#we will use aggregate()
#aggregate(variable to be summarize,by=list(variable by which grouping is to be done,function))

?aggregate()
aggregate(oj$price,by=list(oj$brand),mean)

class(aggregate(oj$price,by=list(oj$brand),mean))
#we can use the tapply function to do the same task .the representation will be little different
#tapply(variable to be summarized,variable ,variable by which grouping is to be done,
#function to be used)
?tapply()

tapply(oj$price,oj$brand,mean)
class(tapply(oj$price,oj$brand,mean))
#the class is array here but in aggregate command the class is data.frame


#contingency Table
#contingency table is used when we have categorised variables in our data
#if we are interested in finding the number of units sold of different brands of juice based on 
#whether feature advertisement was run.
#we will use table() and supply it with column names of the two categorical variables .

#cross tabulations
#units of different brands sold based on if feature advertisement was run or not

#table syntax :-table(variable which u want in rows,variables u want in columns to see)
table(oj$brand,oj$feat)
class(table(oj$brand,oj$feat))

#we can use xtabs too
?xtabs()
xtabs(~oj$brand + oj$feat)
#here xtabs syntax:- xtabs(~ariable which u want in rows + variables u want in columns to see)
 ?dplyr()


#using dplyr package to manipulate data


install.packages("dplyr")

library(dplyr)


#subsetting data

#1...filter function:-it is used when we want to filter the data based on a particular or some elements
#filter syntax:-filter(dataset name,the column name which u want to filter=="the element name ")

#here we are taking out the observations where the brand is tropicana
data11<-filter(oj,brand=="tropicana")
dim(data11<-filter(oj,brand=="tropicana"))
head(data11,15)

data12<-filter(oj,brand=="tropicana" | brand=="dominicks")
dim(data12<-filter(oj,brand=="tropicana" | brand=="dominicks"))


#2....Selecting columns 
#use select function to select columns from the data
#select() function
# select function:- select function helps u to check the specific columns and display the data in it

#select(datset name,column names u want to check)
data13<-select(oj,brand,INCOME,feat)
head(data13,30)
#by using the a - (negative)operator inside the select statement ,we can drop the columns
data14<-select(oj,-brand,-INCOME,-feat)
head(data14,15)


#3....creating new columns in a existing dataset
#mutate()function to create new columns in a dataset
#mutate syntax:- mutate(dataset name,new variable name to be created=the variable that needs to be stored in new variable)
data14<-mutate(oj,logIncome=log(INCOME))
head(data14,20)
dim(oj)
dim(data14)


#4....Sorting/Ordering the data:-arrange()
#arrange() function is used to sort/arrange the data
#syntax:-arrange(dataset name,variable in which u want ur data to be arranged in ascending order)
data15<-arrange(oj,INCOME)
head(data15,20)
min(oj$INCOME)


#desc is used to arrange the data in descending order
# instead of using a desc keyword we can use-(negative) operator too to arrange in decending order
data16<-arrange(oj,desc(INCOME))
head(data16)
max(oj$INCOME)


#5....summarizing data :-summarize() and group_by()
#group_by command is used to create group based on grouping variables or a set of grouping variables
#and then summarize() command is used to apply to specific function on grouped data
gr_brand<-group_by(oj,brand)
summarize(gr_brand,mean(INCOME),sd(INCOME))
#suppose we want to find out mean and standard deviation of "INCOME" based on "brand" grouping
#first thing is to group the data by brand and store the object in gr_brand then next step is to use
#summrize function to compute the mean and standard deviation.
#we have the mean nd std of all the 3 brands available 

#6....Functional Pipieline %>%
#dplyr becomes a powerful tool when it is combined with %>% (pipe) operator
#example:- find the mean price for all the people whose Income>=10.5
#1st method-base R code
mean(oj[oj$INCOME>10.5,"price"])

# 2nd method:- dplyr code
summarize(filter(oj,INCOME>=10.5),mean(price))
#first we filter the data badsed on INCOME condition then the filter 
#function returns a subsetted data ,which becomes the input for summarize() function and then 
#summarize function finds the mean of the price column which belongs to the subsetted data



#3rd method:-using pipe operator
oj %>% filter(INCOME >= 10.5) %>% summarize(mean(price))
#the whole chunk of code can be written as first take the dataframe oj and filter it using the filter()
#then take the subsetted data and summarize it based on column price
#oj is the first functional argument to the function filter() and is written left of the %>%
#if we seee the 2nd %>% the subsetted data is to the left of it.
#it becomes the input of summarize


#Another example using pipe operator 
#let us assume we want to create a new column called logIncomw on the subset data of which price 
#is equal to or greater than 2.5 and we want to also summarize this newly created column logIncome
#and compute the mean ,median and std dev of this new column

#Steps:- subset the data based on price >=2,5,create a column logIncome,compute the mean,
#std dev of column logIncome
oj%>%filter(price>=2.5)%>%mutate(logIncome=log(INCOME)
                                 )%>%summarize(mean(logIncome),median(logIncome),sd(logIncome))
#first we need to take the dataframe oj,then we filter the dataset oj on the basis of price>=2.5 ,then we
# create a new column logIncome in which we store logarithmic of income values and then we find the mean,median and stdev of this new column logIncome
#B)LEFT OUTER JOIN
#C)RIGHT OUTER JOIN
#D)FULL OUTER JOIN


customer_id<-c(1,2,3,4,5,6)
product<-c("toaster","toaster","toaster","radio","radio","radio")
df1<-data.frame(customer_id,product)
df1

customer_id<-c(2,4,6)
state<-c("alabama","alabama","ohio")

df2<-data.frame(customer_id,state)
df2

#notice that customer_id is common in both the tables .this colu mn is called key column

# A)inner join:-Intersection on both tables merge(x=df1,y=df2,by="customer_id")
#if we join thses two tables based on the iner then 2,4,6 will be selected.
# which means the table which have both the same customer id's in both the tables


# B)Full outer join:- two tables arev joined irrespective of any match between the rows
merge(x=df1,y=df2,by="customer_id",all=TRUE)
#In full outer join both the tables are joined irrespective of any match betwween the rows,we use
#all=TRUE as an additional parameter to join

# C)left outer join:-all the rows of left table are retained 
#while matching rows of right table are displayed
#here i use a parameter of all.x=TRUE here x represents the left table
merge(x=df1,y=df2,by="customer_id",all.x=TRUE)

#  D)Right outer join :- all the rows of right table are retained 
#while matching rows of lefft table are displayed
#here i use a parameter of all.y=TRUe here y represents the right table
merge(x=df1,y=df2,by="customer_id",all.y=TRUE)


#video 5:- MISSING VALUE TREATMENT
#is.na() is a function which helps in finding out the missing values
a<-c(1,2,3,4,5,NA,NA,NA,7,8,9)
is.na(a)
 sum(is.na(a))
 
 #missing value treatment in a dataset
 data()
str(precip)
air<-airquality
head(air,15)


sum(is.na(air$Ozone))
sum(is.na(air$Solar.R))
class(air)

#imputing the missing values
air$Ozone[is.na(air$Ozone)]<-45
summary(air)
#sometimes it makes sense to compute missing values by means 

air$Solar.R[is.na(air$Solar.R)]<-mean(air$Solar.R,na.rm=TRUE)
summary(air)
#since solar.R has missing values inside it.if i want to compute mean,i have to ignore 
#those missing values.that is why i am supplying these parameters na.rm=TRUE.



#video 6....

#reshape2()package helps us in trransposing a data.this is reqired to run a annova model
#.when we run annova we want our data in particular format

library(reshape2)

person<-c("sankar","acharya","aiyar")

age<-c(26,24,25)
age
weight<-c(56,54,89)
weight

wide<-data.frame(person,age,weight)
wide

#converting the data wide into long format we will use melt function
long<-melt(wide,id.vars="person",value.name = "demo_value")
long
#the variable person creates natural grouping in the data.

#converting long format to wide format
#dcast function is used
dcast(long,person~variable,value.var="demo_value")



#video 7...manipulating strings in R
#1..using substr function to extract strings
a<-"Batman"
substr(a,start=2,stop=6)

#2..nchar():-to calculate the number of elements in a string we use nchar
nchar(a)

#3...tolower():-used to convert everything in small case letters
tolower(a)
 #4....toupper:-used to convert everything in upper case
toupper(a)
#5...strsplit:-used to split a given string based on some character
b<-"Bat-Man"
strsplit(b,split="-")
c<-"bat/man"
strsplit(c,split="/")
#6..paste():-used to concatenate two character objects
paste(b,split=c)
#7..grep():-used to check where a specific pattern occur in a particulalr string.
c(b,c)
grep("-",c(b,c))
#8..grepl() :-it does a logical comparison and returns a true/false value corresponding to the 
#index in which the particular pattern is found
grepl("/",c(b,c))
grepl("/")
c(c,b)
grepl("/",c(c.b))
#if i reverse the position of objects /  will ocur in frst place

#9..sub():-used to substitute a particular element in a string with another element
?sub()
sub("/",";",c)
#10..gsub():-used to replace pattern when a object has more than one pattern in it
d<-"bat-m-an"
sub("-","/",d)
gsub("-","/",d)


#video 8:sqldf package
library(sqldf)
oj_s<-sqldf("select brand,income,feat from oj")
#using where statement
#subsetting using where statement
oj_t<-sqldf("select brand,feat,income from oj where price <3.8 and income<10")
#using order by statement
oj_s<-sqldf("select store,brand,week,logmove,price,income from oj order by income asc")






















































































































 
























































