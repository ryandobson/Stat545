
#CHAPTER 8: TIDY DATA 

fellow <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")

tower <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")

king <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")

getwd()

#Collect untidy LOTR data into a single data frame 
#dplyr::bind_rows()

lotr_untidy <- bind_rows(fellow, tower, king)
str(lotr_untidy)

#fitting together data like this is common and should be done early 
#sometimes more work needs to be done before you can bind things together

#Best practice is to glue pieces together as early as possible. 


#We have our "Word Count" variable split up over two variables, male and female 
#We need to gather these into a single variable, and create a new variable, gender 

lotr_tidy <- 
  gather(lotr_untidy, key = 'Gender', value = 'Words', Female, Male)
lotr_tidy
#took our untidy data 
#took the variables Female and Male and gathered their vlues into a single
#column named "words" 
#Key is the new variable of Gender that lists whether it comes from male or
#female 

write_csv(lotr_tidy, path = file.path("data", "lotr_tidy.csv")
          )
#checking to make sure it saved well 
read_csv("data/lotr_tidy.csv")

#Watch out for how untidy data forces you into working with it more than 
#you should 
#Data optimized for consumption by human eyeballs is suboptimal for computation 
#Tidy data often has lots of repetition, don't worry about it. 

#There are always work arounds with untidy data but they are a pain and 
#should be avoided 


#SPREAD 

#Get one variable per race 

lotr_tidy %>% 
  spread(key = Race, value = Words)


lotr_tidy %>% 
  spread(key = Gender, value = Words)



