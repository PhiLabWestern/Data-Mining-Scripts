
library(SKAT)
library(parallel)
# Random seeding is performed at lines 20-22 by use of the sample command.
# Set seed so that the same values are generated every single time.
#It would appear that using a loaded in FAM Object is necessary and that it cannot just be made into an object without context.
#Doing so caused errors when generating the null model.
sampleLocation <- "/Users/Eisenhorn/Documents/Thesis/SKAT-O/Example_bped/SampleSetFAM.txt"
FAMObj <- Read_Plink_FAM(sampleLocation,Is.binary=FALSE);
Phenotype <- FAMObj$Phenotype;

#I haven't adjusted the FAM object for anything but proper size, so this is where I change the phenotypes to what I wanted.
Phenotype[1:499] <- 0;
Phenotype[500:600] <- 1;
FAMObj$Phenotype[1:499] <- 0;
FAMObj$Phenotype[500:600] <- 1;

#Creation of the null model using the information from the FAMObj we loaded in earlier.
NullModel <- SKAT_Null_Model(FAMObj$Phenotype~1,out_type="D");

#Making the matrix.
#100,000 total variants being created here.
#Check that the samples in all 600 aren't uniform.
#Set.seed(42) is used to make sure the results are the same. 42 is arbitrary.
set.seed(42);
m3 <- data.frame(replicate(600,sample(0:1,18000,rep=TRUE)));
set.seed(42);
m2 <- data.frame(replicate(600,sample(0:0,80000,rep=TRUE)));
set.seed(42);
m4 <- data.frame(replicate(600,sample(1:2,2000,rep=TRUE)));
m <- rbind(m2,m3,m4);

#Shuffling the values around.
n <- m[sample(nrow(m)),];

#Found out later that the dimensions are backwards. This was a temporary fix. Future ones should reverse the dimensions above.
n <- t(n);

skatResults <- list();

#Fed into the parallel function later.
SKATFunctionInput <- function(i){ 
  
  j <- i+4; 
  skatResults[[length(skatResults)+1]]<-SKAT(n[,i:j],NullModel);
  
}

#Add in multi-threading. R library (Parallel), Mclapply.
# for (i in seq(1, 99996, 5)){
#   
#   j <- i+4;
#   
#   skatResults[[length(skatResults)+1]] <- SKAT(n[,i:j],NullModel);
#   
#   
# }

#Number of cores used in mclapply are detected with this command.
numCores <- detectCores();

#We want the sequence to go 1, 6, 11, etc. Up to 99996.
sequence <- seq(1,99996,5);

#Making use of the parallel package to speed up the loop here.
normalSKATResults <- mclapply(seq,SKATFunctionInput,mc.cores=numCores);


n <- t(n);

#Seeding in effects.
n[6000,500:510] <- 2
n[60000,500:510] <- 2
n[60000,503] <- 1
n[60000, 509] <- 1
n[12345, 511:530] <- 2
n[12345, 514] <- 1
n[12345, 519] <- 1
n[12345, 511] <- 1
n[65432, 561:580] <- 2
n[65431, 561:580] <- 2
n[65432, 400:450] <- 2
n[65431, 570:580] <- 1
n[65431, 100:125] <- 2
n[65431, 150:175] <- 1

n[16,561:580] <- 2
n[16,300:320] <- 2

#Run SKAT on manually grouped epistatic effects.
#Look up different epistasis types and how they present.

#Plan: Implement different kinds of epistasis and test their individual effects.


#Look up false discovery rate (wikipedia), Holm.

#Twitter paper.

#Transpose to put back into 'acceptable' dimensions for SKAT.
n <- t(n);

#Storage container for the seeded results.
seededResults <- list();


#Very similar to previous function. Only difference is that it uses the 'seeded' results. Otherwise identical.
SKATSeededInput <-function(i){ 
  
  j <- i+4; 
  seededResults[[length(seededResults)+1]]<-SKAT(n[,i:j],NullModel);
  
}

#Same as the other mclapply except that it uses the seeded matrix instead.
seededSKATResults <- mclapply(seq,SKATSeededInput,mc.cores=numCores)


# for (i in seq(1, 99996, 5)){
#   
#   j <- i+4;
#   
#   seededResults[[length(seededResults)+1]] <- SKAT(n[,i:j],NullModel);
#   
#   
# }