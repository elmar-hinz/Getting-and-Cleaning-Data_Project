#You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# load required libraries
library(data.table)
library(dplyr)

# 1. Merges the training and the test sets to create one data set.
#       First we need to load the files into data tables (faster than data frames, useful for these large data sets)
#       Next we need to merge the two tables on a common column

# Files are in our root directory, under /UCI HAR Dataset/
#       'train/X_train.txt': Training set.
#       'train/y_train.txt': Training labels.
#       'train/subject_train.txt': Training labels.
#       'test/X_test.txt': Test set.
#       'test/y_test.txt': Test labels.
#       'test/subject_test.txt': Test labels.

# Labels from the activity_labels.txt file
#       1 WALKING
#       2 WALKING_UPSTAIRS
#       3 WALKING_DOWNSTAIRS
#       4 SITTING
#       5 STANDING
#       6 LAYING

activityKey <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
variableKey <- read.table(".\\UCI HAR Dataset\\features.txt", header = FALSE)

# read in the files
trainSet <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt", header = FALSE) 
trainActivity <- read.table(".\\UCI HAR Dataset\\train\\Y_train.txt", header = FALSE) 
trainSubject <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", header = FALSE) 
testSet <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt", header = FALSE) 
testActivity <- read.table(".\\UCI HAR Dataset\\test\\Y_test.txt", header = FALSE) 
testSubject <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", header = FALSE) 

# merge the tables
# set tables have 561 columns of various data values
# activity tables have a single column outlining the activity for each corresponding set line
# subject labels have a single column specifying the subject for each measurement
# need to merge the subject, acitivty, and rest of the data in that order
# then merge the two full datasets after those steps

testMerged <- cbind.data.frame(testSubject,testActivity, testSet)
trainMerged <- cbind.data.frame(trainSubject,trainActivity, trainSet)
fullMerged <- rbind.data.frame(testMerged,trainMerged)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# need to find those values correspdonging to mean or standard deviation
# this gives a vector with the data values that need to be kept
meanStdList <- sort(append(grep("mean",variableKey$V2),grep("std",variableKey$V2)))

# lets add 2 to each value to account for the shift, and add columns 1,2; so we can run this on the merged table
adjustedMeanStdList <- sort(append((meanStdList +2),1:2))

# now copy only those columns out of the original table, this is our list of means and standard deviations
extractedList <- fullMerged[,adjustedMeanStdList]


# 3. Uses descriptive activity names to name the activities in the data set
# we do a quick replacement using the activityKey variable defined above
# this replaces all the numbers in the table with the descriptive names given in the activity_labels.txt file
extractedList$V1.1 <- activityKey[extractedList$V1.1]



# 4. Appropriately labels the data set with descriptive variable names.
# We need to go back and label with the variable key we defined before
extractedVariableKey <- variableKey[meanStdList,]
names(extractedList)[1] <- "Subject"
names(extractedList)[2] <- "Activity"
# we need to convert the variable key list from a factor to chatacrer for this renaming
extractedVariableKey[,2] <- as.character(extractedVariableKey[,2])
# now rename all the other columns
extractedVariableKey[,2] <- gsub(".)","",extractedVariableKey[,2])
extractedVariableKey[,2] <- gsub("^f","Fast Fourier Transform of ",extractedVariableKey[,2])
extractedVariableKey[,2] <- gsub("^t","",extractedVariableKey[,2])
extractedVariableKey[,2] <- gsub("-"," ",extractedVariableKey[,2])
extractedVariableKey[,2] <- gsub("std","Standard Deviation",extractedVariableKey[,2])
extractedVariableKey[,2] <- gsub("Acc","Acceleration",extractedVariableKey[,2])
extractedVariableKey[,2] <- gsub("mean","Mean",extractedVariableKey[,2])
extractedVariableKey[,2] <- gsub("Freq"," Frequency",extractedVariableKey[,2])
extractedVariableKey[,2] <- gsub("Mag","Magnitude",extractedVariableKey[,2])
extractedVariableKey[,2] <- gsub("X","X Axis",extractedVariableKey[,2])
extractedVariableKey[,2] <- gsub("Y","Y Axis",extractedVariableKey[,2])
extractedVariableKey[,2] <- gsub("Z","Z Axis",extractedVariableKey[,2])

names(extractedList)[3:81] <- extractedVariableKey[,2]


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# summarize over subject and activity, then sort by subject and activity

extractedList$Subject <- as.factor(extractedList$Subject)

groupedSummary <- group_by(extractedList,Subject,Activity)
finalSummary <- groupedSummary %>% summarize_each(funs(mean))

write.table(finalSummary, file = "TidyData.txt", row.names = FALSE)

