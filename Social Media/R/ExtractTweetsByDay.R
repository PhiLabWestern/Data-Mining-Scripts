#Extract Pattern from Files by Day Frame
######NOT FUNCTIONAL DO NOT USE ############
x <- 0
pattern <- "(stomach|tummy|skin)(ache|pain|upset|<bug>)|<flu>|cramp|cramps|(throw up)|(threw up)|sick|fever|chills|barf|retch|spew|(not feeling well)|(feeling gross)|heave|diarrhea|poop|bathroom|toilet|doctor|nurse|hospital|sleepless|insomnia|<ER>|<E.R.>|<E.R>|clinic|pharmacy|<ill>|<illness>|tired|medicine|tylenol|advil|food poisoning|food poison|salmonella|e.coli|<coli>|(chicken pox)|varicella|chickenpox|<pox>|shingles|calamine|rash|<itch>|<itchy>"


#Go through every date in the dataframe and add it to a list that is counting the frequency of tweets.
#Dates are implicit and not contained within the TweetCount list at all.
#Could make it a dataframe and append another row to it if desired.
for (i in length(LdnExByDay)){
  
  x <- x+1
  #Start Case
  if(x==1){
    tempListInitial <- LdnExByDay[[i]][grepl(pattern,LdnExByDay$i$text),]
  }
  # Unique rbind
  if(x==2){
    tempList <- LdnExByDay$i[grepl(pattern,LdnExByDay$i$text),]
    ExtractedListByDay <- rbind(tempListInitial,tempList)
  }
  #General case
  if(x > 2){
    tempList <- LdnExByDay$i[grepl(pattern,LdnExByDay$i$text),]
    ExtractedListByDay <- rbind(ExtractedListByDay,tempList);
  }#Generic Case
  
  
  
}
  