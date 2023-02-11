
#CHAPTER 1 - Introduction 

#Recommended to update any packages and RStudio frequently 


update.packages(ask = FALSE, checkBuilt = TRUE)
#This only searches for packages on CRAN so you need to 
#do something different if the package is on Github 

install.packages("dplyr", dependencies = TRUE)
#by marking "dependencies = TRUE" we are being explicit that 
#that it should install any additional packages that dplyr depends upon 

library(tidyverse)

#CHAPTER 2 - R BASICS AND WORKFLOWS 


#alt shift k opens up a keyboard shortcut reference card 


#When you just make an assignment, it does not automatically print 
#If you want it to automatically print, surround the entire thing with 
#parenthesis 

(x <- 3*4)

y <- 12

date() #this gives you the current date and time 

objects()

ls()

rm(x, y)

#to remove everything from your environment 

rm(list = ls())

#Try to do as little as possible with your mouse! 
#When you do things with your mouse, it isn't recorded 

#It is best to consider your R script as your real work space  
#No need to save the environment. 

getwd()

#Encouraged to organize your analytical projects into directories 
#When working on project A, set R's working direction to the associated directory 



###RStudio Projects


#File > New Project... 
#Directory name chosen here will be the project name 

#Now when you open this project it will open the associated working directory 

#If you run some code in the console you can then go to the history pane
#(upper right tab next to the environment tab) 

#Click on the floppy disc to save the R script 
#By default it goes to the project directory! 

#Quit R (quit())

#When you reopen RStudio, it will reopen everything where it was. 

n <- 40

source('toy-line.r')
#clicking this reruns all of the code from that document! 

#Save figures and things with R code! 
#Doing this makes it easier to recreate things and edit figures 
#And simply helps you determine where it is from 

rm(list = ls())


#Many long time users never save the workspace (environment)
#never save RData files, and never save or consult the history. 


#It pays to think holistically about your workflow! 


###GIT, GITHUB, AND R STUDIO 

#Git is a version control system 
#Original purpose was to help groups work collobaratively on big projects 
#Manages the evolution of a set of files - called a repository 
#It is sort of like track changes of Microsoft on steroids 

#It has been repurposed by the data science community. 
#Used to manage the motley collection of files that make up a project 
#data, figures, reports, and source code 


#A solo data analyst, working on a single computer, will benefit from this 
#Although, the pain of installation and additional workflow pieces might 
#make it not worth it for a solo data analyst 

#However, for new users, the pros outweigh the cons when you consider collobarting 
#your life will be easier if this is baked into your workflow 


#Github provides a host for your projects on the internet 
#Allows others to sync up with you and even make changes 


#It sucks to setup. 
#You have to install Git, get local Git talking to GitHubt, 
#and make sure RStudio can talk to local Git (and, therefore, GitHub) 
#One time pain though! 

#Process for New Projects 

#Dedicate a directory (folder) to it 
#Make it an RStudio project 
#Make it a Git repository 
#Go about your usual business. But you make a commit, which takes a multi-file
#snapshot of the entire project. 
#Push commits to GitHub periodically. (like sharing your document with someone else)


#Payoff of GitHub 

#Exposure - other people can easily get your work and run your code 
# If they don't use Git, they can still browse your project 

#You can track the development of other's R packages and communicate 
#with other people easier 

#Collaboration - Individuals work independently, then send work back to GitHub 
#for reconciliation and transmission to the rest of the team. 

#Compared to other ways to collaborate 

#Edit, Save, Attach 
#Everyone has the document with different versions and there is no master 
#document. Everything gets combined in weird ways by painful communication 

#Google Doc 
#One copy of the document that lives in the cloud. Everyone can edit at one
#time and changes can be seen and previous versions can be explored 

#GitHub is much more similar to the Google Doc scenario and enjoys 
#similar advantages. More complicated than Google Docs though. 



#Checking if you have the most up to date version of R 
R.version.string

#Update your packages 
#update.packages(ask = FALSE, checkBuilt = TRUE)

#Try to never fall more than 1 minor version behind of RStudio
#Keep your RStudio up to date! 

#Expect to update RStudio more often than R 

#How to tell if you are in a Git Bash shell 
#type this: echo $SHELL
#you want this: /usr/bin/bash

quit()

#getting Git organized 
git config --global user.name 'Ryan Dobson'
git config --global user.email 'rdobson17@gmail.com'
git config --global --list

#the last command returns what you entered from the first two. 
#To ensure that Git understood what you tuped 

#If you fail to give Git what it wants it kicks you into an editor 
#This code makes sure it kicks you into a good editor 
git config --global core.editor "emacs"
#emacs should be fine (notepad and sublime are other options)

#Setting your default initial branch name 
git config --global init.defaultBranch main


#Git is just a collection of individual commands you execute in the shell 
#This is not appealing to everyone and some prefer a graphical interface 

#Your Git and Gitclient are not the same thing like R and RStudio are not the same

#For some tasks, you will need to use the command line. 
#But, the visual overview given by your Git client can be great to understand 
#the current state of things. And prepare to send things to the command line. 

#At minnimum, start with the Git client even if it has less functionality 
#It will get you proficient and willing to use Git 

#If you frequently login from a remote server, then Git skills at the command
#line will help you 

#To access things you need a personal access token (PAT)
usethis::create_github_token()
#this code takes you to the page and selects the scope you want. 

#name your PAT after the computer or project you are using it for. 
#not a bad plan to stick with the 30 day expiration on the PAT 



#Next time Git asks for your password, provide the PAT



#Storing Git PAT 
#install.packages("gitcreds")

#run this code to see if you have one set. 
#If you have one set, it will pop up. 
#If you don't have one set, it will prompt you to set it 
gitcreds::gitcreds_set()

#you can also replace the credentials using this code if needed

#To check if you've stored a credential 
gitcreds::get()

#When a token expires, go to GitHub and then you can regenerate the token 


#functions to help solve problems
usethis::gh_token_help()

usethis::git_sitrep()


#Cloning my GitHub repository to my computer 

getwd()

usethis::create_from_github("https://github.com/ryandobson/myrepo.git",
                            #destdir = "stat.545"
)
#I don't need to specify a folder because my working directory is already set 
#where I want it 
#Just use buttons to do this. Probably unnecessary to code this part
#It is a one time setup for each project. 


#New and Existing Projects Do This: 
#Dedicate a local directory or folder to it 
#Make it an RStudio Project. 
#Make it a Git repository 

#Your workflow doesn't change much with Git 
#Instead of just saving individual files, you commit's occasionally 
#A commit takes a snapshot of all the files in the entire project 
#Pushing your commits to GitHub is like sharing all of your files with 
#the team. It is effectively updating the team. 


#Consider Version A of a file and then modified Version B. 
#Version A was the first commit and Version B was the second commit 
#The set of differences between A and B is called a "Diff" 

#By looking at diffs, its easy to see how two snapshots differ. 

#Every time you make a commit you must write a short commite message
#The commit message should convey the motivation for the change 

#When you revisit a project after a break or need to digest changes made 
#by a colleague, looking at history, by reading commit messages and skimming 
#diffs is a great way to catch up. 

#Git Commands 
#https://happygitwithr.com/git-commands.html


#BRANCHES 

#You take a detour from the main stream of development and do work without 
#changing the main stream. 
#Allows people to work in parallel without overwriting each other's work! 

#Also allows someone working solo to work incrementally on an experimental 
#idea without jeopardizing the state of the main project. 

#To create a new branch use "Git Branch" 
#You do this on GitHub 
#After you create a new branch you can commit to it per usual 

#If you need to switch branches but the work is not complete? 
#Safeguard the current work with a temporary commit. 
#Use "WIP" Work in Progress - to note that the commit is primarily to save the
#document but is not a true update to the project. 
#If you do this when you come back you can set the commit back to the previous 
#state. 
#Having a git client can really help with this process. 


#After you have done your work in the branch and committed it there. 
#You can switch back to the main and merge the new branch. 

#Occasionally you will get merge conflicts. 
#These can usually be pretty easily resolved. You usually just have to go in 
#and edit a small bit of code to the version you want and then finish it. 

#More Info on Branching and Merges 
#https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging


#Remotes 
#Remote repositories of your project that are hosted on the internet or another
#network. You can pull and push changes from the remotes. 

#Strong convention to use "Origin" as the nickname of your main remote. 

#A common reason to add a second remote is when you have done a "fork and 
#clone." You will still want to pull from the original 
#Name the new one "upstream" 


#It is typical to use the first 7 characters of the 40 string of characters to 
#identify a specific commit. 


#Useful Git Patterns for a productive Workflow 
#https://happygitwithr.com/workflows-intro.html


#The Repeated Amend 
#Use a Git commit like a protective measure when in uncertain or dangerous 
#territory. 
#You don't want to commit too often because you will just make a mess of things. 
#But, if you are going to do something that might not work, make a commit. 


#When doing something tricky you usually proceed toward the goal in small 
#increments. Checking that each thing works along the way. 
#Yes, it works? Make a commit. 
#This can lead to a lot of tiny commits, which is fine at times. 


#The * on a commit means that exists only in your local repo and is not
#yet on GitHub. 
#If you are doing WIP commits, you don't need to push them to GitHub. 


#It is better for the health of a project to push and integrate more often 


#Disaster Recovery
#https://happygitwithr.com/burn.html













