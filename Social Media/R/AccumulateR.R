#/usr/bin/env Rscript
#Input: Multiple workspaces that are output from the SifteR.sh process.

args = commandArgs(trailingOnly=TRUE)

#i is the month, so 1:12.
for (i in 1:12){

  #J should be the highest number of parts encountered. Figure out smart way to determine later. Currently manual.
  for (j in 1:5){
    if (j >= 10){

      if (i >= 10){
        print(paste("Loading ", "F:/BashScripts/Rparts/RS_2016-",i,".part.",j,".RData",sep=""))
        if (file.exists(paste("F:/BashScripts/Rparts/RS_2016-",i,".part",j,".RData",sep=""))){
          load(paste("F:/BashScripts/Rparts/RS_2016-",i,".part",j,".RData",sep=""))
        }

      }
      else{
        print(paste("Loading ", "F:/BashScripts/Rparts/RS_2016-",i,".part.",j,".RData",sep=""))
        if (file.exists(paste("F:/BashScripts/Rparts/RS_2016-0",i,".part.",j,".RData",sep=""))){
          load(paste("F:/BashScripts/Rparts/RS_2016-0",i,".part.",j,".RData",sep=""))
        }

      }

    }
    else{ #So j is smaller then 10. This is to follow the -d naming convention of the split command.

      if (i >= 10){
        print(paste("Loading ", "F:/BashScripts/Rparts/RS_2016-",i,".part.",j,".RData",sep=""))
        if (file.exists(paste("F:/BashScripts/Rparts/RS_2016-",i,".part.0",j,".RData",sep=""))){
          load(paste("F:/BashScripts/Rparts/RS_2016-",i,".part.0",j,".RData",sep=""))
        }

      }
      else{
        print(paste("Loading ", "F:/BashScripts/Rparts/RS_2016-",i,".part.",j,".RData",sep=""))
        if(file.exists(paste("F:/BashScripts/Rparts/RS_2016-0",i,".part.0",j,".RData",sep=""))){
          load(paste("F:/BashScripts/Rparts/RS_2016-0",i,".part.0",j,".RData",sep=""))
        }
      }
    }
  }




}
