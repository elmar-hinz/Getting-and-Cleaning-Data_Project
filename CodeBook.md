Getting and Cleaning Data – Course Project Codebook
===================================================

Original Data:

The data being covered here is from a series of tests using smartphone accelerometers to monitor 30 people across 6 different activities.  The data was posted and described by the original authors at the following link.  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data used for this analysis can be obtained here.  The README contains a detailed description of how the data was obtained and processed by the original authors.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Raw Data Organization:
The raw data extracts into a folder “UCI HAR Dataset” and under that several descriptive txt files, with two folders, test and train.  Test includes data from a smaller subset of the 30 participants and train covers all the rest.

Inside the main folder the following files are found

README.txt – outlines the significance of each other file/folder, the summary of data gathering and units of the variables.
features_info.txt – describes the data that was measured and what statistical breakdown were done
features.txt – a list of column labels across the whole dataset
activity_labels.txt – a list of the 6 activities across which the measurements were gathered

Within each train/test folder the following files are found

X_train.txt (or _test) – the full dataset containing 561 columns and several thousand rows (row count depends on train/test).  There are no data labels here or any indication of the conditions under which these data were measured.

Subject_train.txt (or test) – a single column list of numbers from 1-30, corresponding to which subject was used in the main data set for a given row.

Y_train.txt (or test) – a single column list of numbers 1-6, detailing which activity was being performed for a given row.

Interial_Signals folder – this is the even more-raw data which the original authors processed to obtain the data in the X_train.txt file.  These files were not used in this analysis, but they are present in the data bundle.

Processing Data:

The run_analysis.R file performs several transformations on the data to give the final data set (this codebook won’t touch on all the details of the code, but only on the general transformations).

1)	First, the bulk datasets for both train and test were loaded in, as well as the individual column datasets corresponding to the subject and activity labels for each of those sets.
2)	Then the subject and activity data are merged with the main data sets for each of train and test.  This adds two columns to each and provides the keys for tracking how the data for each row was obtained. 
3)	Next the train and test tables were merged to form a massive data set containing all the necessary data for this analysis (and lots of unnecessary data too).
4)	Then, all rows that were not a mean or standard deviation measurement were dropped.  Per the assignment, only these rows were to be considered in our final data summary.  This was done via a text search for “mean” or “std” in the variable names derived from the “features.txt” file in the original dataset.
5)	All activity numbers in the pertinent column were replaced by descriptive activity names, for easier identification.  These were matched by the “activity_labels.txt” file in the original data bundle.
6)	The given variable names from the “features.txt” file were replaced by more descriptive names.  Given the subjective nature of this request, they decided to convert to a format which made sense to this author.  Parenthesis, dashes and other non-letter formatting were removed.  Several shorthand abbrevations with which the author was familiar were expanded out as well (std -> standard deviation, acc -> acceleration; the full list can be seen in section 4 of the R file).
7)	The data was grouped by the subject and activity and then the mean was taken.  This gives 180 rows, one for each subject-activity combination.


Data Considerations:
All numerical ‘data’ columns are the means of the original data in each column, grouped by subject and activity.

Variable Descriptions:

"Subject"
(1-30)
Factor; subject number in the study out of 30 members

"Activity"
LAYING, STANDING, SITTING, WALKING, WALKING, DOWNSTAIRS, WALKING, UPSTAIRS
Character; the activity under which each of the data were measured

The following generic description applies to all of the following variables below:

Numeric; mean of all original data values of “{variable name}" as provided in X_train.txt and X_test.txt, grouped by subject and activity.  Units are outlined per type as listed below.

Further details:
_ Axis – measurement taken along the axis noted.
Magnitude – total value, not separated by axis.
Acceleration - Acceleration measured in units of standard gravity (g).
AccelerationJerk - Acceleration Jerk measured in units of standard gravity per second (g/s).
Gyro - Measurements are angular velocity, measured in units of radians/second.
GyroJerk - Measurements are angular Jerk, measured in units of radians/s^3 (as best I can tell, the original codebook wasn’t clear on this).
Fast Fourier Transform – FFT of the original data values

Numeric Variables:

"BodyAcceleration Mean X Axis"
"BodyAcceleration Mean Y Axis"
"BodyAcceleration Mean Z Axis"
"BodyAcceleration Standard Deviation X Axis"
"BodyAcceleration Standard Deviation Y Axis"
"BodyAcceleration Standard Deviation Z Axis"
"GravityAcceleration Mean X Axis"
"GravityAcceleration Mean Y Axis"
"GravityAcceleration Mean Z Axis"
"GravityAcceleration Standard Deviation X Axis" 
"GravityAcceleration Standard Deviation Y Axis"
"GravityAcceleration Standard Deviation Z Axis"
"BodyAccelerationJerk Mean X Axis"
"BodyAccelerationJerk Mean Y Axis" 
"BodyAccelerationJerk Mean Z Axis" 
"BodyAccelerationJerk Standard Deviation X Axis" 
"BodyAccelerationJerk Standard Deviation Y Axis" 
"BodyAccelerationJerk Standard Deviation Z Axis" 
"BodyGyro Mean X Axis"
"BodyGyro Mean Y Axis"
"BodyGyro Mean Z Axis"
"BodyGyro Standard Deviation X Axis"
"BodyGyro Standard Deviation Y Axis"
"BodyGyro Standard Deviation Z Axis" 
"BodyGyroJerk Mean X Axis"
"BodyGyroJerk Mean Y Axis"
"BodyGyroJerk Mean Z Axis" 
"BodyGyroJerk Standard Deviation X Axis"
"BodyGyroJerk Standard Deviation Y Axis"
"BodyGyroJerk Standard Deviation Z Axis"
"BodyAccelerationMagnitude Mean"
"BodyAccelerationMagnitude Standard Deviation"
"GravityAccelerationMagnitude Mean" 
"GravityAccelerationMagnitude Standard Deviation" 
"BodyAccelerationJerkMagnitude Mean"
"BodyAccelerationJerkMagnitude Standard Deviation" 
"BodyGyroMagnitude Mean" 
"BodyGyroMagnitude Standard Deviation" 
"BodyGyroJerkMagnitude Mean"
"BodyGyroJerkMagnitude Standard Deviation"
"Fast Fourier Transform of BodyAcceleration Mean X Axis"
"Fast Fourier Transform of BodyAcceleration Mean Y Axis" 
"Fast Fourier Transform of BodyAcceleration Mean Z Axis" 
"Fast Fourier Transform of BodyAcceleration Standard Deviation X Axis"
"Fast Fourier Transform of BodyAcceleration Standard Deviation Y Axis"
"Fast Fourier Transform of BodyAcceleration Standard Deviation Z Axis" 
"Fast Fourier Transform of BodyAcceleration Mean Frequency X Axis"
"Fast Fourier Transform of BodyAcceleration Mean Frequency Y Axis"
"Fast Fourier Transform of BodyAcceleration Mean Frequency Z Axis"
"Fast Fourier Transform of BodyAccelerationJerk Mean X Axis"
"Fast Fourier Transform of BodyAccelerationJerk Mean Y Axis"
"Fast Fourier Transform of BodyAccelerationJerk Mean Z Axis"
"Fast Fourier Transform of BodyAccelerationJerk Standard Deviation X Axis"
"Fast Fourier Transform of BodyAccelerationJerk Standard Deviation Y Axis"
"Fast Fourier Transform of BodyAccelerationJerk Standard Deviation Z Axis"
"Fast Fourier Transform of BodyAccelerationJerk Mean Frequency X Axis" 
"Fast Fourier Transform of BodyAccelerationJerk Mean Frequency Y Axis" 
"Fast Fourier Transform of BodyAccelerationJerk Mean Frequency Z Axis"
"Fast Fourier Transform of BodyGyro Mean X Axis" 
"Fast Fourier Transform of BodyGyro Mean Y Axis" 
"Fast Fourier Transform of BodyGyro Mean Z Axis" 
"Fast Fourier Transform of BodyGyro Standard Deviation X Axis" 
"Fast Fourier Transform of BodyGyro Standard Deviation Y Axis" 
"Fast Fourier Transform of BodyGyro Standard Deviation Z Axis" 
"Fast Fourier Transform of BodyGyro Mean Frequency X Axis" 
"Fast Fourier Transform of BodyGyro Mean Frequency Y Axis" 
"Fast Fourier Transform of BodyGyro Mean Frequency Z Axis" 
"Fast Fourier Transform of BodyAccelerationMagnitude Mean"
"Fast Fourier Transform of BodyAccelerationMagnitude Standard Deviation"
"Fast Fourier Transform of BodyAccelerationMagnitude Mean Frequency" 
"Fast Fourier Transform of BodyBodyAccelerationJerkMagnitude Mean"
"Fast Fourier Transform of BodyBodyAccelerationJerkMagnitude Standard Deviation" 
"Fast Fourier Transform of BodyBodyAccelerationJerkMagnitude Mean Frequency"
"Fast Fourier Transform of BodyBodyGyroMagnitude Mean" 
"Fast Fourier Transform of BodyBodyGyroMagnitude Standard Deviation" 
"Fast Fourier Transform of BodyBodyGyroMagnitude Mean Frequency" 
"Fast Fourier Transform of BodyBodyGyroJerkMagnitude Mean" 
"Fast Fourier Transform of BodyBodyGyroJerkMagnitude Standard Deviation" 
"Fast Fourier Transform of BodyBodyGyroJerkMagnitude Mean Frequency"