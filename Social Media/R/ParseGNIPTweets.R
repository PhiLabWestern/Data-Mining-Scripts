##########################
########## Purpose: GNIP sourced tweet parsing tool for personal use.
########## Author: Brent Davis using all of the packages listed in the code and with help from: https://www.r-bloggers.com/looping-through-files/
##########
########## Using Mac OS X filing system. Customize directory to directory from home necessary. Low text options better for speed.
setwd("~/Documents/Thesis/GNIP/PTDataDownload/downloads/Unzipped/")
directory = "/Unzipped/"
tweetSourceFolder <- dir(directory, pattern=".json")
library(streamR)

#Requires a premade list of filesnames for the number of files in our GNIP pull. This must have all the .json files listed in it line by line.
#I used the MAC terminal to do this.

#Change this to be input from the script.
fileName <- "ListOf2016RequestFileNames.txt";
con=file(fileName,open="r")
JSONFileNames=readLines(con);

#Implement the generic non-memory dependent way later.
for(i in 1:length(JSONFileNames)){




  #collectedJSON File is the result of binding the larger then terminal can handle into a single JSON file.
  #temporaryMergingObject <- read.table(JSONFileNames[i],header=TRUE,sep=";", stringsAsFactors=FALSE)
  #collectedJSONFilenames <- rbind(collectedJSONFile,temporaryMergingObject);

  #Start Case
  if(i==1){
    tempListInitial <- parseTweets(JSONFileNames[i]);
   # temporaryMergingObjectInitial <- read.table(JSONFileNames[i],header=TRUE,sep=" ", stringsAsFactors=FALSE)
    #
  }
  # Unique mApply
  if(i==2){
    tempList <- parseTweets(JSONFileNames[i]);
    giganticTweetList <- rbind(tempListInitial,tempList)
    #Gigantic refers to >2 gb of data in the list.
   # giganticTweetsList <- mapply(c,tempListInitial,tempList,SIMPLIFY=FALSE)
   # temporaryMergingObject <- read.table(JSONFileNames[i],header=TRUE,sep=" ", stringsAsFactors=FALSE)
   # collectedJSONFilenames <- rbind(temporaryMergingObjectInitial,temporaryMergingObject);

  }
  if(i > 2){
    tempList <- parseTweets(JSONFileNames[i]);
    giganticTweetList <- rbind(giganticTweetList,tempList);
    #giganticTweetsList <- mapply(c,giganticTweetsList,tempList,SIMPLIFY=FALSE);
   # temporaryMergingObject <- read.table(JSONFileNames[i],header=TRUE,sep=" ", stringsAsFactors=FALSE)
   # collectedJSONFilenames <- rbind(collectedJSONFilenames,temporaryMergingObject);


  }#Generic Case


}

#For use next time without having to run the search every time.
#Not implemented.
#write.table(collectedJSONFilenames, file="GNIPJuly5thList.txt",sep=";",row.names=FALSE,qmethod="double")
