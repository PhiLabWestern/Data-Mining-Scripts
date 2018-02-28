####### usr2vec t-SNE plot #####
### by Brent Davis ###
## Input: Path to file to open in JSON format that is readable by jsonlite fromJSON command ##
## Output: Cleaned file for use with usr2vec.
# 1 : Name of file that contains the word embedding. Expecting space delimited.
require(Rtsne)
library(Rtsne)

args = commandArgs(trailingOnly=TRUE)

#toBeGraphed
tBG <- read.table(args[1],sep=' ',header=FALSE)
tBG$V1<-as.character(tBG$V1)


#From this page - https://www.analyticsvidhya.com/blog/2017/01/t-sne-implementation-r-python/
Labels<-tBG$V1
colors=rainbow(length(unique(tBG$label)))
colors=rainbow(length(unique(tBG$V1)))
names(colors) = unique(tBG$V1)

#Check_duplicates=FALSE is fragile but speeds it up.
#Try with Is_distance=TRUE soon. Noted as being experimental but we do have a distance matrix
#(maybe - maybe not the way they want it formatted. Matches their sample data from the example though).

tsne <- Rtsne::Rtsne(tBG[,-1],dims=2,perplexity=2,verbose=TRUE,max_iter=500,Check_duplicates=FALSE)
plot(tsne$Y,t='n',main="tsne")
text(tsne$Y, labels=tBG$V1,col=colors[tBG$V1])
#End from that source.

dev.copy(png,paste(args[1],".tSNEVisual.png"))
dev.off()
