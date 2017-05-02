#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)

confounders=TRUE
# test if there is at least one argument: if not, return an error
if (length(args)<2) {
  stop("At least two arguments must be supplied (input file).n", call.=FALSE)
} else if (length(args)==2) {
  # default output file
  confounders=FALSE
}

## Reading the input file
df_Y = read.csv(args[1], header=TRUE ,stringsAsFactors = FALSE)
df_X = read.csv(args[2], header=TRUE ,stringsAsFactors = FALSE)
if(confounders){
  df_C = read.csv(args[3], header=TRUE, stringsAsFactors = FALSE)
}


## Running a few checks
idx_samplesMatch_YX <- match( df_Y[,1], df_X[,1] )
nbr_NA <- sum( is.na(idx_samplesMatch_YX) )
if(nbr_NA == nrow(df_Y)){
  stop("The samples in Y don't match the samples in X.n", call.=FALSE)
}
if( (nrow(df_Y)-nbr_NA) < (ncol(df_Y)-1)){
  stop("The number of samples is too low that analyze that many variables.n", call.=FALSE)
}


## Now we run PCEV
library(pcev)

if(confounders){
  res_PCEV <- computePCEV(matrix(df_Y[,-1]), matrix(df_X[,-1]), confounder = matrix(df_C))
}else{
  res_PCEV <- computePCEV( as.matrix(df_Y[,-1]), as.matrix(df_X[,-1]) )
}

## Extracting the results
res_VI <- res_PCEV$VIMP
res_pval <- res_PCEV$pvalue
names(res_VI) <- colnames(df_Y)[-1]

print(paste("The p-value is: ", res_pval))

write.csv(res_VI, file="Results_variableImportanceFactors.csv", quote=FALSE)
write.table(res_pval, file="Results_pvalue.txt", quote=FALSE)

