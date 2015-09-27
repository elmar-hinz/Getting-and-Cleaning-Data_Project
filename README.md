Only one script was used to process the data into the final dataset as outlined in the assignment requirements.  run_analysis.R contains all of the logic needed to perform this processing and transformation.
This document will step through how to process the data to obtain the same results using the run_analysis.R script so the user can replicate the results.  The basic logic steps used in the R script will also be covered.


Script preparation and output:
1)	The raw data used in this exercise can be found at the following address; download and extract it to the R working directory. https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2)	When extracted, it should create a folder named “UCI HAR Dataset” in the working directory, along with 2 subfolders and several txt files.  This is the structure which the script expects when performing the analysis.
3)	To execute run_analysis.R, two packages need to be installed: “data.table” and “dplyr”.  Please obtain and install those prior to running the script.
4)	Now you are ready to run the script.  Upon running the complete script, a file named “TidyData.txt” will be created in your working directory.  This file is a data.table export of the final summarized data.

Script Processing:
1)	First the script loads up the “data.table” and “dplyr” libraries that are needed based on the functions used.
2)	Create “variableKey” (from the features.txt file included with the data download) and “activityKey” (transcribed from the activlity_labels.txt file) so we can later map the correct names to the values in the table and column numbers.
3)	Read in the source data from both train and test sets, including activity and subject tables.
4)	Merge the subject, activity and full data tables to form full test and train tables (in testMerged and trainMerged).
5)	Combine test and train tables to create a complete merged table (fullMerged) with all data.
6)	Use grep to generate a vector listing the variable numbers which correspond to instances where the substrings “mean” and “std” were found in the variableKey table (meanStdList).
7)	The vector is then modified to account for the extra 2 columns at the beginning of the data table (subject andactivity), but incrementing all values by 2 and then adding 1,2 (adjustedMeanStdList).
8)	This new vector is then used as a filter to drop all columns from the full data set which don’t appear in the vector (extractedList).
9)	Activity names are added to the data table (extractedList) by a quick match of the activity numerical values (1-6) from the activity_labels.txt file into the values of the filtered data.
10)	Subject and Activity are given quick labels before going into the list of 561 data variables.
11)	To provide informative names of all variables the variable key list is filtered by the original mean/std filter list so that only labels for those lines preserved in data remain (extractedVariableKey).
12)	This table is then subjected to several ‘gsub’ functions to remove some of the uglier formatting and make the final output tidy (extractedVariableKey).
13)	“()” groups are removed
14)	The “f” at the beginning of some lines is clarified as a fast fourier transform
15)	The “t” is removed, since more variables being time-based is intuitive and not needed with the non-time based lines being called out as FFTs.
16)	“-“ are removed
17)	“std” -> standard deviation
18)	“Acc”-> acceleration
19)	“mean” -> Mean
20)	“Freq” -> Frequency
21)	“Mag” -> Magnitude
22)	“X” -> X axis
23)	“Y” -> Y axis
24)	“Z” -> Zaxis

25)	The transformed variable list is then applied back to the filtered data list with the names() function (extractedVariableKey[,2] applied to ExtractedList).
26)	Subject is forced to a factor variable so it can be grouped by (dplyr cannot group by integers).
27)	Groups are defined as Subject and activity (groupedSummary).
28)	The finalSummary table is created as a mean summarization of the data set over the subject and activity groupings.
29)	Output table “TidyData.txt” is written.


