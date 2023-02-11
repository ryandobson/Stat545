
#CHAPTER 5 - BASIC CARE AND FEEDING OF DATA IN R

getwd()

#delete the environment so we don't have any code depending on an old env.
#rm(list = ls())

#restart R so we don't have any previous packages loaded 
#q()

#You want to restart everything so you know your code is not dependent 
#on other things. 

#Use Data Frames (versus general arrays or matrices)


#install.packages("gapminder")

library(gapminder)


#"str" displays the strucutre of an object. 
#Use this to get a quick idea of what you are working with. 
str(gapminder)

library(tidyverse)

#with the tidyverse our data.frames turn into tibbles but are still data.frames 
class(gapminder)

#With TidyVerse you can print the data set and it will give you the first
#columns instead of printing the whole data set. 

#Printing the data
gapminder

#Dealing with plain data frames? 
#Use "head()" and "tail()" to explore your data frame. 
#or do "as_tibble()" to change your data frame. 


#Query Basic Info on a Data Frame 

names(gapminder) 

ncol(gapminder)

length(gapminder)

dim(gapminder)

nrow(gapminder)

#Statistical Overview 

summary(gapminder)


#R Graphics (built in R graphics are very basic)

plot(lifeExp ~ year, gapminder)


#Data Frames are a special case of a list because the length of each list (column)
#is the same. 
#Data Frames are superior to matrices because they can hold chr, numeric, 
#and categorical data. 


#Looking at Variables Inside a Data Frame 

#use the $ to look at specific varaibles 

head(gapminder$lifeExp)

summary(gapminder$lifeExp)

hist(gapminder$lifeExp)

#Year data is basically categorical 
summary(gapminder$year)
table(gapminder$year)


#Truly categorical data is stored as a factor in R 
class(gapminder$continent)

summary(gapminder$continent)

levels(gapminder$continent)

nlevels(gapminder$continent)

#The levels of a factor are named by a character string 
#such as male/female and control/treatment 
#Under the hood though, R is treating each one of these as a number 
str(gapminder$continent)

table(gapminder$continent)
barplot(table(gapminder$continent))

#Always understand the basic extent of your data frames! 
#Number of rows and columns 
#What flavor the variables are. 
#Use factors with intention and care. 

#Do basic statistical and visual sanity checking of each variable 

#Refer to variables by name (not by column number)
#Makes your code much more readable. 




#CHATPER 6 - INTRODUCTION TO DPLY (TIDYVERSE)


#Think before you create excerpts of your data! 
#Don't just store a ton of random snippets of your data. 


#Ask yourself: 
#Do I want to create mini data sets for each level of some factor in
#order to compute or graph something?
#If YES, use proper data aggregation techniques or faceting! 


#Copies and excerpts of your data clutter your workspace, invite mistakes, 
#and sow general confusion. Avoid whenever possible. 


#Use filter() to subset data row-wise 

filter(gapminder, lifeExp < 29)

filter(gapminder, country == "Rwanda", year > 1979)

filter(gapminder, country %in% c("Rwanda", "Afghanistan"))


#compared to sub setting data with base R code: 
gapminder[gapminder$lifeExp < 29, ] ## repeat `gapminder`, [i, j] indexing is distracting
subset(gapminder, country == "Rwanda") ## almost same as filter; quite nice actually


#When you filter data you don't need to create excerpts.
#In other words, don't assign new things to these and save them. 

#Use the pipe operator! 

#When using the assignment operator "<-" think "gets" 
#When using the pipe operator "%>%" think "then" 


#Use select() to subset the dat aon variables or columns 

gapminder %>% select(year, lifeExp)


#Revel in the convienence 

gapminder %>% 
  filter(country == "Cambodia") %>% 
  select(year, lifeExp)

#What the R Base Code for that looks like: 
#gapminder[gapminder$country == "Cambodia", c("year", "lifeExp")]


#Pure Functions 
#Always map the same input to the same output 
#and have no other impact on the workspace. 
#In other words, pure functions have no side effects. 
#They don't effect the data in any way apart from the value they return. 

#The data set is always the first thing you specify! 





