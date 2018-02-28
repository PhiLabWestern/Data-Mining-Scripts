#/usr/bin/env Rscript
#Input: Dataframe of Reddit JSON compatible with jsonlite package.
library(jsonlite)


args = commandArgs(trailingOnly=TRUE)
tmpFrame <- fromJSON(args[1])
#print(args[1])
#customize this to be input eventually.
tmpFrame <- tmpFrame[grep("londonontario",tmpFrame$subreddit),]

#Custome this to decide which fields to keep.
#Assigns a filename based on the input file name.
assign(paste(args[1]),tmpFrame[,c("author","selftext","subreddit")])
rm("tmpFrame")
save.image(paste(args[1],".RData",sep=""))
