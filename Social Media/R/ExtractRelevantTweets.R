#R Script to filter out the collected tweets using a regular expression in the pattern.

options(echo=TRUE)
args <- commandArgs

library(twitteR)
library(streamR)
library(jsonlite)
library(dplyr)

#Take filename from command line to tell the script which file to open.
tweetsFilename <- args(1)

#Current pattern being used. Could update this to be taken from command line or from a file, etc.
pattern <- "(stomach|tummy|skin)(ache|pain|upset|<bug>)|<flu>|cramp|cramps|(throw up)|(threw up)|sick|fever|chills|barf|retch|spew|(not feeling well)|(feeling gross)|heave|diarrhea|poop|bathroom|toilet|doctor|nurse|hospital|sleepless|insomnia|<ER>|<E.R.>|<E.R>|clinic|pharmacy|<ill>|<illness>|tired|medicine|tylenol|advil|food poisoning|food poison|salmonella|e.coli|<coli>|(chicken pox)|varicella|chickenpox|<pox>|shingles|calamine|rash|<itch>|<itchy>"

invisible(tweetsFrame <- parseTweets(tweetsFilename));
#Filter out the ones from the US that are getting caught in border cases.
invisible(tweetsFrame<-tweetsFrame[!tweetsFrame$country == "United States",]);

#Now filter out based on the pattern provided.
# invisible(indexes <- grep(pattern,tweetsF, Orame$text));
# invisible(filteredTweetsFrame <- tweetsFrame[indexes,]);
#Newer implementation using dplyr package directly.
#invisible(testF <- filter(tweetsFrame,grepl(pattern,tweetsFrame$text))); Buggy in newer versions of R

#Direct indexing instead of filter seems to work well for retrieveing this level of deeper in hierarchy data from the dataframe.
testF <- tweetsFrame[grepl(pattern,tweetsFrame$text),] 


#When I tried this, it was deleting two of the rows from the dataframe. I am unsure which two rows it is right now but it does not appear to be any of the ones we are interested in.
#Future attempts may include trying to parse this down further before saving it.
invisible(jsonFile <- toJSON(filteredTweetsFrame));
write(jsonFile,paste(tweetsFilename,"-filteredTweets.json",sep=""))