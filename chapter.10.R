
#Chapter 10: Be the boss of your factors 

#factors are how we store truly categorical information in R 
#factors take on levels 

#In general, you can name your factors to "male/female" 
#remember, under the hood it is really "1,2, etc" 

#Be wary of when your data is in factor form versus character form! 

#The base R data import likes to translate charcter strings into factors 
#Thus, read.table() will turn things into factors at times. 
#You can avoid this by adding stringsAsFactors = FALSE 
#OR you can just use the tidyverse load in read_csv() 
#the tidyverse is designed to stop that from happening! 


#They tidyverse includes the package "forcats" 
#This is the main package that is used here, it loads in with the
#tidyverse so no use in loading it in separately! 

library(tidyverse) 

#loading in the data set for this lesson 
library(gapminder)

#get to know your factor before you start touching it! 
str(gapminder$continent)
levels(gapminder$continent)
nlevels(gapminder$continent)
class(gapminder$continent)

#looking at the frequencies of each factor! 
gapminder %>% count(continent)


#example 

nlevels(gapminder$country)

h_countries <- c("Egypt", "Haiti", "Romania", "Thailand", "Venezuela")

h_gap <- gapminder %>% 
  filter(country %in% h_countries)
nlevels(h_gap$country)
#here we dropped a ton of countries with the h_gap data frame 
#But, we we ask for country levels it still says we have 142 

#Here is how we drop those extra levels that were retained

h_gap_dropped <- h_gap %>% 
  droplevels() #I think this drops all of the empty factors 
nlevels(h_gap_dropped$country)

#If you want to specify a specific factor to drop from you can use 
h_gap$country %>% 
  fct_drop() %>% 
  levels() 

#By default, factors are ordered alphabetically. 
#It is best to order your factors by some principle 
#Frequency of results in a factor 
#Whatever makes sense for you 

#Frequency works well for when you are making figures! 

##default order is alphabetical 
gapminder$continent %>% 
  levels() 

##Changing order to frequency 
gapminder$continent %>% 
  fct_infreq() %>% 
  levels()

##Order by least frequent (backwarnds to the above)

gapminder$continent %>% 
  fct_infreq() %>% 
  fct_rev %>% 
  levels()


#Now we can order country by another variable that is quantitative. 

##order countries by median life expectancy 

fct_reorder(gapminder$country, gapminder$lifeExp) %>% 
  levels() %>% head()

##order according to minimum life expectancy instead of median 
fct_reorder(gapminder$country, gapminder$lifeExp, min) %>% 
  levels() %>% head() 

##backwards 
fct_reorder(gapminder$country, gapminder$lifeExp, .desc = TRUE) %>% 
  levels() %>% head() 

gap_asia_2007 <- gapminder %>% filter(year == 2007, continent == "Asia")
ggplot(gap_asia_2007, aes(x = lifeExp, y = country)) + geom_point()
ggplot(gap_asia_2007, aes(x = lifeExp, y = fct_reorder(country, lifeExp))) +
  geom_point()
#the only difference between the above plots is the order of the countries!
#notice how much easier it is to take things away with this organization. 



#When you have two quantitative variables use fct_reorder2() 
#to make the legend appear in the same way as the data
#Notice how in the organized graph the highest line is in accordance with the 
#legend. 

h_countries <- c("Egypt", "Haiti", "Romania", "Thailand", "Venezuela")
h_gap <- gapminder %>%
  filter(country %in% h_countries) %>% 
  droplevels()
ggplot(h_gap, aes(x = year, y = lifeExp, color = country)) +
  geom_line()
ggplot(h_gap, aes(x = year, y = lifeExp,
                  color = fct_reorder2(country, year, lifeExp))) +
  geom_line() +
  labs(color = "country")


#Change order of the levels, "Because I said so" 

h_gap$country %>% levels()

h_gap$country %>% fct_relevel("Romania", "Haiti") %>% levels()
#This simply moves romania and haiti to the top of the factors 
#If you want to completely respecify, just list all of them in the order you want 


#Recode the Levels 

i_gap <- gapminder %>% 
  filter(country %in% c("United States", "Sweden", "Australia")) %>% 
  droplevels()
i_gap$country %>% levels()
#> [1] "Australia"     "Sweden"        "United States"

#This is where the recoding happens 
i_gap$country %>% 
  fct_recode("USA" = "United States", "Oz" = "Australia") %>% levels()
#> [1] "Oz"     "Sweden" "USA"


#Grow a factor 

#Creating two data frames and dropping unused factor levels 
df1 <- gapminder %>%
  filter(country %in% c("United States", "Mexico"), year > 2000) %>%
  droplevels()
df2 <- gapminder %>%
  filter(country %in% c("France", "Germany"), year > 2000) %>%
  droplevels()

#Looking at the levels of the data frames 

levels(df1$country)
#> [1] "Mexico"        "United States"
levels(df2$country)
#> [1] "France"  "Germany"

#combine the factors using fct_c() 

fct_c(df1$country, df2$country)


#Exploring how different forms of row binding behave here 

bind_rows(df1, df2)

rbind(df1, df2)



