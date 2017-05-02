#!/bin/bash
echo "This is a script to create the report from the PCEV pipeline"

sep="========================================================================="
intro="\nThis is a report summarizing the different steps performed.\nDate: "
intro2="\n You are using version 1.0 of the pipeline: \n"
today=$(date)
stringOut="$sep$intro$today$intro2 \n$sep"
resultsScreen="resultsScreen.txt"
finalReport="FinalReport.txt"

echo -e $stringOut                                                                                           >$finalReport
grep "The p-value is: " $resultsScreen                                                                      >>$finalReport
echo -e $sep                                                                                                >>$finalReport


echo -e $sep                                                                                                >>$finalReport
echo -e "The pipeline was run successfully.\n"                                                              >>$finalReport
echo -e $sep                                                                                                >>$finalReport
##


