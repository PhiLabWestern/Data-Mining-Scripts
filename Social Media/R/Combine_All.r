############
#Script to concatenate matrices from a SSD_Info file in R.
#Written by Brent Davis on March 22nd 2016
#Assumes that an SSD file is open.
#Assumes SSD files range from 1 to 20330. MODIFY THIS BASED ON SET IDS.
####
####
# Current Issues: Need to run null hypothesis set again with new matrix in order to use it in regular SKAT.
############

#SET_ID_NUMS <- 10;

#If SSD_INFO isn't called that, change it to what it is.
#Second argument is one since we're going from 1 to n where n is Set_ID size.
#Third argument is false since we don't want labels? Maybe we do. Currently think we don't.
X <- Get_Genotypes_SSD(SSD.INFO, 1, is_ID = TRUE);
dX <- as.data.frame(X);
colnames(dX) <- paste(paste("Gene",1,sep="_"), colnames(dX),sep="_")

for (i in 2:SET_ID_NUMS){
  
  Y <- Get_Genotypes_SSD(SSD.INFO, i, is_ID = TRUE);
  dY <- as.data.frame(Y);
  colnames(dY) <- paste(paste("Gene",i,sep="_"), colnames(dY),sep="_")
  dX <- cbind(dX,dY);
  X <- cbind(X,Y);

}

#Use default settings for cov. Makes a covariate matrix for use with the null model.
covMatrix <- cov(X)

#Might want to rename y.b into something more meaningful. Meant for the binary labeling of phenotypes
#That is seen in the example given. Uses dichotomous outcome hence out_type="D"
nullModel <- SKAT_Null_Model(y.b ~ covMatrix, out_type="D")


#For use with adabag or ada, need to concatenate on y.b to the end of the Z matrix...
Z <- cbind(X,y.b)