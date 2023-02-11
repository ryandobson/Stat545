
#CHAPTER 9: WRITING AND READING FILES

#Tip: today's outputs are tomorrow's inputs 

#Aim for future proof and moron-proof (It should be able to be read by humans)

#q()

library(tidyverse)

library(fs)

(gap_tsv <- path_package("gapminder", "extdata", "gapminder.tsv")
    )

gapminder <- read_tsv(gap_tsv)
#tsv = tab-delimited data 

str(gapminder, give.attr = FALSE)

#for full flexibility you can also use: 
#readr::read_delim() 

#similar convenience wrapper for CSV 
#read_csv() 

#creating variables into factors 
gapminder <- gapminder %>% 
  mutate(country = factor(country),
         continent = factor(continent))

str(gapminder)
#can use this to look at how they got turned into a factor 

#Country level summary of maximum life expectancy 

gap_life_exp <- gapminder %>% 
  group_by(country, continent) %>% 
  summarize(life_exp = max(lifeExp)) %>% 
  ungroup() 
gap_life_exp

#the new variable gap_life_exp is an example of something we want to save
#for downstream analyses 

#workhose function for rectangular data in readr is 
#write_delim() 
#We will use write_csv() to get a comma delimited file 

write_csv(gap_life_exp, "gap_life_exp.csv")

read_csv("gap_life_exp.csv")




