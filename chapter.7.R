
#CHAPTER 7: SINGLE TABLE DPLYR FUNCTIONS 

#filter() for subsetting data with row logic 
#select() for subsetting data with variable - or column wise 

library(tidyverse)

library(gapminder)

#Creating a copy of the table to ensure we don't damage original data set 
(my_gap <- gapminder)
#Parenthesis around the function means it automatically prints it. 


#Pay attention to when we evaluate statements but let the output just print! 
#Versus when we store the output as an R object. (possibly overwriting an old object)

my_gap %>% filter(country == "Canada")


#Use mutate() to add new variables 

my_gap %>% mutate(gdp = pop * gdpPercap)

#Really large numbers are typically not that useful. 
#Maybe we do want to stick with our gdp per capita number. 
#Or we could do GDP per capita, relative to some benchmark country. 

#Create a new variable that is gdpPercap divided by Canadian gdpPercap 
#Taking care that I always divide two numbers that pertain to the same year. 

#Filter down to the rows for Canada 
#Create a new temporary variable in my_gap 
#extract the gdpPercap variable from the Candadian data 
#Replicate it once per country in the dataset, so it has the right length
#Divide raw gdpPercap by this Canadian figure 
#Discard the temporary variable of replicated Canadian gdpPercap 


ctib <- my_gap %>% 
  filter(country == "Canada")
#This is a semi-dangerous way to add this variable 
#He would prefer to join on year. (but we haven't covered that yet)

my_gap <- my_gap %>%  
  mutate(tmp = rep(ctib$gdpPercap, nlevels(country)),
         gdpPercapRel = gdpPercap / tmp, 
         tmp = NULL
         )
#mutate builds new variables sequentially so you can reference earlier
#variables in the same function. 
#You can also get rid of a variable that you temporarily needed by setting 
#the variable to NULL

#Sanity check to ensure it worked? 
#All the Canadian values for gdpPercapRel better be 1!

my_gap %>% 
  filter(country == "Canada") %>% 
  select(country, year, gdpPercapRel)

summary(my_gap$gdpPercapRel)


#Always find a way to check your work! 
#Trust no one, especially yourself. 


#Use arrange() to row-order data in a principled way 

my_gap %>% 
  arrange(year, country)

#Just want data from 2007 sorted on life expectancy? 

my_gap %>% 
  filter(year == 2007) %>% 
  arrange(lifeExp)


#sort by descending order?

my_gap %>% 
  filter(year == 2007) %>% 
  arrange(desc(lifeExp))


#Analyses should NEVER rely on rows or variables being in a specific order
#But you can reorder things to see whats happening and make things easier
#Also, when you are preparing data for human eyes ordering ecomes important

#Use rename() to rename variables 

my_gap %>% 
  rename(life_exp = lifeExp,
  gdp_percap = gdpPercap,
  gdp_percap_rel = gdpPercapRel)


#select() can rename and reposition variables 

#Two Tricks 
#select() can rename the variables you request to keep 
#select() can be used with everything() to hoist a variable up to the front 

my_gap %>% 
  filter(country == "Burundi", year > 1996) %>% 
  select(yr = year, lifeExp, gdpPercap) %>% 
  select(gdpPercap, everything())


#group_by() is a mighty weapon 

#group_by() adds extra structure to your data set - grouping information - 
# which lays the groundwork for computations within the groups 

#summarize() takes a dataset with n observations, computes requested 
#summaries and returns a dataset with 1 observation 

#mutate() and summarize() will honor groups 

#can also do general computations on your groups with do() 
#Recommended to use other approaches though 


#Counting things up 

my_gap %>% 
  group_by(continent) %>% 
  summarize(n = n())

#You could get the same output using table() from base R 
table(gapminder$continent)

#But if you look at the structure of this it makes downstream caclulations 
#more difficult. 
str(table(gapminder$continent))


#The tally() function is useful for counting rows 

my_gap %>% 
  group_by(continent) %>% 
  tally()
#tally() thankfully honors groups you specify 

#count() function does both grouping and counting!
my_gap %>% 
  count(continent)

#counting the number of distinct countries within each continent 

my_gap %>% 
  group_by(continent) %>% 
  summarize(n = n(),
            n_countries = n_distinct(country))


#functions within the summarize() function 
#mean()
#median()
#var() 
#sd() 
#mad()
#IQR()
#min() 
#max() 
#All these functions take n inputs and distill them down to 1 output 


#Average life expectancy by contintent 

my_gap %>% 
  group_by(continent) %>% 
  summarize(ave_lifeExp = mean(lifeExp))

#summarize_at() applies the same summary functions to multiple variables 

my_gap %>% 
  filter(year %in% c(1952, 2007)) %>% 
         group_by(continent, year) %>% 
           summarize_at(vars(lifeExp, gdpPercap), 
                       list(~mean(.), ~median(.)))


#Focus in on Asia 
my_gap %>% 
  filter(continent == "Asia") %>% 
  group_by(year) %>% 
  summarize(min_lifeExp = min(lifeExp),
               max_lifeExp = max(lifeExp))


#Grouped mutate
#Sometimes you don't want to collapse the n rows for each group into one row
#You want to keep your groups, but compute within them. 


my_gap %>% 
  group_by(country) %>% 
  select(country, year, lifeExp) %>% 
  mutate(lifeExp_gain = lifeExp - first(lifeExp)) %>% 
  filter(year < 1963) 
#first() is operating on the vector of life expectancies within each country group 



#Window Functions 

#Window functions take n inputs and give back n outputs. 
#Furthermore, the output depends on all the values 
#rank() is a window function but log() is not. 


#worst and best life expectancies in Asia over time, retaining
#information about which country contributes these extreme values 

my_gap %>% 
  filter(continent == "Asia") %>% 
  select(year, country, lifeExp) %>% 
  group_by(year) %>% 
  filter(min_rank(desc(lifeExp)) < 2 | min_rank(lifeExp < 2)) %>% 
           arrange(year) %>% 
           print(n = Inf)



#Which country experienced the sharpest 5-year drop in life expectancy? 
#This data set only has data every 5 years, so it is looking at data 
#between adjacent time points. 

my_gap %>% 
  select(country, year, continent, lifeExp) %>% 
  group_by(continent, country) %>% 
  #within country, take lifeExp in year i) - (lifeExp in year i - 1)
  #positive means lifeExp went up, negative means it went down 
  mutate(le_delta = lifeExp - lag(lifeExp)) %>% 
  #within country, retain the worst lifeExp change = smallest or most negative
  summarize(worst_le_delta = min(le_delta, na.rm = TRUE)) %>% 
  #within continent, retain the row witht he lowest worst_le_delta 
  top_n(-1, wt = worst_le_delta) %>% 
  arrange(worst_le_delta)
  








