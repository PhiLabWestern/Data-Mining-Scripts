#/usr/bin/env Rscript
#Input: Files from a directory.
library(jsonlite)
#args = commandArgs(trailingOnly=TRUE)

files = list.files(path="./", pattern = "Nov*", full.names = T, recursive = FALSE)

for (x in files){

  tmpFrame <- fromJSON(x)

  #tmpFrame$author_flair_css_class <- NULL
  #tmpFrame$author_flair_text <- NULL
  #tmpFrame$can_gild <- NULL
  #tmpFrame$controversiality <- NULL
  #tmpFrame$distinguished <- NULL
  #tmpFrame$gilded <- NULL
  #tmpFrame$edited <- NULL
  #tmpFrame$permalink <- NULL
  #tmpFrame$author_cakeday <- NULL
  #tmpFrame$subreddit_type <- NULL
  print ("Extracting")
  print(x)
  LdnFrame <- tmpFrame[grep("londonontario",tmpFrame$subreddit),]
  rm(tmpFrame)
  LdnUsers <- unique(c(LdnUsers,LdnFrame$author))
  rm(LdnFrame)

}
