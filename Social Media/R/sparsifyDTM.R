#Convert dtm to sparse matrix.

dtm.to.sm <- function(dtm){
  sparseMatrix(i=dtm$i, j=dtm$j, x=dtm$v,
               dims=c(dtm$nrow, dtm$ncol))
}
