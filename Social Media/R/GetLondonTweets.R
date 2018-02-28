#Script to collect all the tweets from London in an hour and then save them to a file. Repeats a number of times based on how the loop is set.
library(streamR)
load("twitCred.Rdata")

for (i in 1:6){
  
  filterStream(file="LondonAreaTweetsMay6th.json",language="en",location=c("-81.8344116211,42.5662301764, -80.5160522461,43.4080405599"),timeout=1800,oauth=twitCred)
  
  
  #tweets.df <- parseTweets("LondonAreaTweets.json",simplify=TRUE,verbose=FALSE)
  
  
}