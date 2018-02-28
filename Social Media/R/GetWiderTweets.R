#Script to collect all the tweets from London and the wider area in a specified time and then save them to a file. Repeats a number of times based on how the loop is set.
#This script now looks at the Ottawa area as well.
#There might need to be some fine tuning of the bounding boxes in the 'location' section to stop getting Michigan.
library(streamR)

#Command line arguments -
# 1 - File name
# 2 - File containing keywords to be streamed.
# 3 - File containing geographic coordinates (location data for bounding box)
# 4 - Time out time (in seconds)
# 5 - Path to twitCred file.


#This is the previous OAuth data and would need to be redone if someone else was using this script. Your authentication data should go here.
load("twitCred.Rdata")
stringTrack <- c("ldnont","food poisoning")
 
#Total run time is based on the number in the for loop (currently 216 iterations) and the time in the method itself (currently 1800 seconds)
for (i in 1:216){
  
  filterStream(file="OttawaAndLondonAreaTweetsSept14th-Sept18+LDNONT+FoodPoisoning.json",track=stringTrack,location=c("-82.4194,42.5713,-80.6946,43.4629, -76.333,45.02,-75.0146,45.6179"),timeout=1800,oauth=twitCred)
  
}