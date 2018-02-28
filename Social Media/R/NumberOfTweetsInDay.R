#This script takes a dataframe that is split into sections (assumed to be by day) of tweets and outputs the number of tweets in each day.

x <- 0
DateNames <- names(FPTwtsLdnByDay)
#Go through every date in the dataframe and add it to a list that is counting the frequency of tweets.
#Dates are implicit and not contained within the TweetCount list at all.
#Could make it a dataframe and append another row to it if desired.
for (i in DateNames){
  
  #Counter since i will be a date like 2016-02-01
  x <- x+1
  
  if (x == 1){
    
    TweetCountInitial <- length(FPTwtsLdnByDay[[i]]$text)
    
  }
  if (x ==2 ){
    
    TweetCountTemp <- length(FPTwtsLdnByDay[[i]]$text)
    FPTwtsLdnByDayCount <- rbind(TweetCountInitial,TweetCountTemp)
    
    
  }
  if(x > 2 ){
    TweetCountTemp <- length(FPTwtsLdnByDay[[i]]$text)
    FPTwtsLdnByDayCount <- rbind(FPTwtsLdnByDayCount,TweetCountTemp)
  }
  
  
}