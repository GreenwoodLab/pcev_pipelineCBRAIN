#!/bin/bash

echo "ImputePrepSanger version 1.1: This is a script to create vcf files for imputation on the Sanger servers"

Y_file=$1
X_file=$2
C_file=$3

PROGNAME=$(basename $0)

function error_exit
{
#	----------------------------------------------------------------
#	Function for exit due to fatal program error
#		Accepts 1 argument:
#			string containing descriptive error message
#	----------------------------------------------------------------
	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}
echo "== Run the R script =="
Rscript pcev_for_cbrain.R $Y_file $X_file $C_file | tee "resultsScreen.txt"
if [ "$?" != "0" ]; then
  error_exit "Error while running the R script."
fi

echo "== Run reportRedaction =="
./reportRedaction.sh 
if [ "$?" != "0" ]; then
  error_exit "Error while writing the report."
fi

echo "The pipeline was run successfully."


