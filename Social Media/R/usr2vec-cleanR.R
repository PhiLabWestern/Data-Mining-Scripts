###### usr2vec text cleaner #####
### by Brent Davis ###
## Input: Path to file to open in JSON format that is readable by jsonlite fromJSON command ##
## Output: Cleaned file for use with usr2vec.
# 1 : Remove all hyperlinks (original authors of usr2vec replaced with url. I think that will give a bad association with url).
# 2 : Remove all @ mentions of usernames to avoid vocabulary inflation. Replace with @user
# 3 : Add a space before and after all , . ! ?
require(jsonlite)
library(jsonlite)
require(dplyr)
library(dplyr)

#Take the filename as input from the commandline.
args = commandArgs(trailingOnly=TRUE)
y <- fromJSON(args[1])

#Twitter uses screen_name, Reddit uses author. This sorts them alphabetically.
y <- y[order(y$author),]

#Remove all posts that have less then 5 words.
z <- y[((sapply(gregexpr("\\W+",y$text),length))>5),]

#Get all posts from users that have made at least 5 seperate posts and no more then 1500. The 1500 is arbitrary - The 5 is for usr2vec.
x <- z %>% group_by(author) %>% filter(n() > 4 && n() < 1500)

#The file MUST have the text field labeled as x . You can use colnames(x) to find the number for the column, and then
# colnames(x)[spotNumber] <- "text"
#If this gets annoying, make args[2] into the name of the column.

#gsub("[^[:alnum:][:space:]']"," \\2 ", ABRC$text[1:100]) <- This is a stricter cleaner but may remove some words.

#Remove overdiverse words in corpus.
x$text<- gsub("@[^[:space:]]*","@user", x)
x$text<<- gsub("http[^[:space:]]*", "", x)

#Add spaces to punctuation
x$text<- gsub("!", " ! ", x)
x$text<- gsub(",", " , ", x)
x$text<- gsub("\\.", " . ", x)
x$text<- gsub("\\?", " \\? ", x)
x$text<- gsub("\""," \" ", x)
x$text<- gsub("\\("," ( ", x)
x$text<- gsub("\\)"," ) ", x)
x$text<- gsub("\\*"," * ",x)

#  x<- gsub("'", " ' ", x)
#The above will remove hyphens in words like it's
#This removes the case where 'quotes' happen.
x$text<- gsub("\\s'"," ' ",x)
x$text<- gsub("'\\s"," ' ",x)

#   #Remove newlines.
x$text<- gsub("[\n]"," ", x)
x$text<- gsub("[\r]"," ", x)
#Swap one or more spaces for one space.
x$text<- gsub("\\s+"," ", x)

#Remove all the non printable characters.
x$text<- gsub("[^[:print:]]","",x$text)

#There's methods to catch if this fails. This intermediary shouldn't be used in a case where it can. The above should make it safe, too.
x$text<- tolower(x)

#I am still unsure whether usr2vec truly wants space delimited or tab delimited.
#Documentation says space, code says tab.
write.table(x,paste(args[1],".usr2vec-clean"),sep="\t",quote=FALSE, col.names=FALSE,row.names=FALSE)


#-----------------------
# Function form:
#   clean.usr2vec.text <- function(x)
#   {
#     #Remove overdiverse words in corpus.
#     x<- gsub("@[^[:space:]]*","@user", x)
#     x<- gsub("http[^[:space:]]*", "", x)
#
#     #Add spaces to punctuation
#     x<- gsub("!", " ", x)
#     x<- gsub(",", " , ", x)
#     x<- gsub("\\.", " . ", x)
#     x<- gsub("\\?", " \\? ", x)
#     x<- gsub('"'," ", x)
#     x<- gsub("\\("," ", x)
#     x<- gsub("\\)"," ", x)
#     x<- gsub("\\*"," ",x)
#
#
#   # x<- gsub("'", " ' ", x)
# # #This removes the case where 'quotes' happen.
#     x<- gsub("\\s'"," ' ",x)
#     x<- gsub("'\\s"," ' ",x)
#
#  #   #Remove newlines.
#     x<- gsub("[\n]"," ", x)
#     x<- gsub("[\r]"," ", x)
#     #Swap one or more spaces for one space.
#     x<- gsub("\\s+"," ", x)
#
#    #Remove all the non printable characters.
#     x<- gsub("[^[:print:]]","",x)
#
#     x<- tolower(x)
#
#     return(x)
#
#   }
