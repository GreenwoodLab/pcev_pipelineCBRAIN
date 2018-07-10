#!/bin/bash

echo "This is a script to run a pcev analysis from the R package."

Output=$1
Y_file=$2
X_file=$3
C_file=$4



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
pcev_for_cbrain.R $Y_file $X_file $C_file | tee "resultsScreen.txt"
if [ "$?" != "0" ]; then
  error_exit "Error while running the R script."
fi

echo "== Run reportRedaction =="
reportRedaction.sh 
if [ "$?" != "0" ]; then
  error_exit "Error while writing the report."
fi

mkdir $Output
mv "SamplesKept.txt"    $Output
mv "FinalReport.txt"    $Output
mv "resultsScreen.txt"  $Output
mv "Results_pvalue.txt" $Output
mv "Results_variableImportanceFactors.csv" $Output




