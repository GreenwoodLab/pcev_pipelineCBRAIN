#!/bin/bash
echo "This is a script to create the report from the PCEV pipeline"

sep="========================================================================="
intro="\nThis is a report summarizing the results of the PCEV analysis performed.\nDate: "
intro2="\nYou are using version 1.0 of the pipeline: \n"
today=$(date)
stringOut="$sep$intro$today$intro2 \n$sep"
resultsScreen="resultsScreen.txt"
finalReport="FinalReport.txt"

echo -e $stringOut                                                                                           >$finalReport

ERROR=$(grep "Error:" resultsScreen.txt | wc -m)
if [ $ERROR -ne 0 ]; then
 grep "Error:" $resultsScreen                                                                                 >>$finalReport
else
  grep "The p-value is: " $resultsScreen                                                                      >>$finalReport
  echo -e "\nThe pipeline was run successfully."                                                              >>$finalReport
  echo -e $sep                                                                                                >>$finalReport
fi
##


