#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

confounders=TRUE
# test if there is at least two arguments: if not, return an error
if (length(args)<2) {
  stop("At least two arguments must be supplied (input file).", call.=FALSE)
} else if (length(args)==2) {
  # default output file
  confounders=FALSE
}

## Reading the input file
df_Y = read.csv(args[1], header=TRUE, stringsAsFactors = FALSE)
df_X = read.csv(args[2], header=TRUE, stringsAsFactors = FALSE)
if(confounders){
  df_C = read.csv(args[3], header=TRUE, stringsAsFactors = FALSE)
}


## Running a few checks
## Matching the samples from Y and X
idx_samplesMatch_YX <- match( df_Y[,1], df_X[,1] )
nbr_NA <- sum( is.na(idx_samplesMatch_YX) )
if(nbr_NA == nrow(df_Y)){
  print("Error: The samples in Y don't match the samples in X.")
  stop("The samples in Y don't match the samples in X.", call.=FALSE)
}
if( (nrow(df_Y)-nbr_NA) < (ncol(df_Y)-1)){
  print("Error: The number of samples is too low to analyze that many variables.")
  stop("The number of samples is too low to analyze that many variables.", call.=FALSE)
}
newY <- df_Y[!is.na(idx_samplesMatch_YX),]
newX <- df_X[idx_samplesMatch_YX[!is.na(idx_samplesMatch_YX)], ]
##Matching the samples from newY and Confounders
if(confounders){
  idx_samplesMatch_nYC <- match(newY[,1], df_C[,1])
  nbr_NAc <- sum( is.na(idx_samplesMatch_nYC))
  if(nbr_NAc == nrow(newY)){
    print("Error: The samples in Y don't match the samples in C.")
    stop("The samples in Y don't match the samples in C.", call.=FALSE)
  }
  if( (nrow(newY)-nbr_NAc) < (ncol(newY)-1)){
    print("Error: The number of samples is too low to analyze that many variables.")
    stop("The number of samples is too low to analyze that many variables.", call.=FALSE)
  }
  newC <- df_C[idx_samplesMatch_nYC[!is.na(idx_samplesMatch_nYC)], ] 
  newY <- newY[!is.na(idx_samplesMatch_nYC),]
  newX <- newX[!is.na(idx_samplesMatch_nYC),]
}  
## Now we run PCEV
library(pcev)

if(confounders){
  res_PCEV <- computePCEV( as.matrix(newY[,-1]), newX[,-1], confounder = newC[,-1])
}else{
  res_PCEV <- computePCEV( as.matrix(newY[,-1]), as.matrix(newX[,-1]) )
}

## Extracting the results
res_VI <- res_PCEV$VIMP
res_pval <- res_PCEV$pvalue
names(res_VI) <- colnames(df_Y)[-1]

print(paste("The p-value is: ", res_pval))

write.csv(res_VI, file="Results_variableImportanceFactors.csv", quote=FALSE)
write.table(res_pval, file="Results_pvalue.txt", quote=FALSE, row.names = FALSE, col.names = FALSE)
write.table(newY[,1], file="SamplesKept.txt", quote=FALSE, row.names = FALSE, col.names = FALSE)


