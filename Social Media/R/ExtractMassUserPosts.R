#/usr/bin/env Rscript
#This script is designed to take a vector of author names (usernames)
#and find all posts in a directory of JSON files for Reddit.
library(foreach)
library(doParallel)
library(jsonlite)

cores=detectCores()
cl <- makeCluster(7)
registerDoParallel(cl)


files = list.files(path="./", pattern = "Nov*", full.names = T, recursive = FALSE)
i <- 1
numFiles = length(files)

finalUsrMat <- foreach (i=1:numFiles, .combine=rbind) %dopar% {
  tempMatrix = {}

  tempMatrix <- jsonlite::fromJSON(files[i])
  #tempMatrix$author_flair_css_class <- NULL
  #tempMatrix$author_flair_text <- NULL
  #tempMatrix$can_gild <- NULL
  #tempMatrix$controversiality <- NULL
  #tempMatrix$distinguished <- NULL
  #tempMatrix$gilded <- NULL
  #tempMatrix$edited <- NULL
  #tempMatrix$permalink <- NULL
  #tempMatrix$author_cakeday <- NULL
  #tempMatrix$subreddit_type <- NULL
  userMatrix <- tempMatrix[tempMatrix$author %in% LdnUsers,]
  rm(tempMatrix)
  userMatrix <- userMatrix[!userMatrix$author == "[deleted]",]
  userMatrix <- subset(userMatrix, select=c("author","body","score","subreddit"))
  return(userMatrix)

}

stopCluster(cl)
