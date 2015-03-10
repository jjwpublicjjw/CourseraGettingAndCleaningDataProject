# Human Activity Recognition Using Smartphones Data Set - Summarized Means and Standard Deviations 

The data set provided here is the result of manipulating the 'Human Activity 
Recognition Using Smartphones Data Set' available from the UCI Machine Learning 
Repository. The original data set is described in detail at the following URL:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The original data set itself is available at the following URL:

Original Dataset: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The information available at that UCI URL includes the following description:

> "Abstract: Human Activity Recognition database built from the recordings 
> of 30 subjects performing activities of daily living (ADL) while carrying 
> a waist-mounted smartphone with embedded inertial sensors."
> ...
> "The experiments have been carried out with a group of 30 volunteers within 
> an age bracket of 19-48 years. Each person performed six activities (WALKING, 
> WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a 
> smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer 
> and gyroscope, we captured 3-axial linear acceleration and 3-axial angular 
> velocity at a constant rate of 50Hz. The experiments have been video-recorded 
> to label the data manually. The obtained dataset has been randomly partitioned 
> into two sets, where 70% of the volunteers was selected for generating the 
> training data and 30% the test data."
> ...
> "For each record in the dataset it is provided: 
> - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
> - Triaxial Angular velocity from the gyroscope. 
> - A 561-feature vector with time and frequency domain variables. 
> - Its activity label. 
> - An identifier of the subject who carried out the experiment."

The data set provided here is a summary of some of the information in the 
original data set, obtained by:

1. Combining the training and test partitions from the original data set
2. Repartitioning the combined data set by the subject (numeric identifier
   of volunteer) and activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, 
   SITTING, STANDING, LAYING)
3. Calculating the mean values of a subset of the variables in the original
   data set across the Subject/Activity partitions

The repartitioning step involved labeling each data set record with the 
subject and activity information from the original data set. This information
is available in the Subject and Activity variables of the summary data set.
The Subject variable contains a numeric identifier between 1 and 30. The Activity
variable contains one of the following text labels: "WALKING", "WALKING_UPSTAIRS",
"WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING".

The summary data set does not include the mean values for every variable
from the original data set. Only variables from the original data that measure
mean and standard deviation are included/summarized. These variables were 
identified by simple pattern matching on the names in the original data set: 
the summary includes the means of all variables in the original data set with 
names containing either "-mean()" or "-std()". 

The names of the variables in the summary data set were obtained by applying
a simple renaming scheme to the original variable names: "-" was replaced by
"." and "()" was deleted. For example, "tBodyAcc-mean()-X" was renamed to 
"tBodyAcc.mean.X" and "fBodyBodyGyroJerkMag-std()" was renamed to 
"fBodyBodyGyroJerkMag.std". This renaming was necessary to permit easy 
manipulation of the data within R, in which the "-" and "()" characters
have syntactic significance.

## Summary Data Set Fields

Legend: m(tBodyAcc-mean()-X) signifies the mean of the
tBodyAcc-mean()-X values in the original data set for a
Subject/Activity partition.

|Summary Field Name|Description|
|------------------|-----------|
|Subject|Numeric identifier of volunteer measured|
|Activity|Activity measured|
|tBodyAcc.mean.X|m(tBodyAcc-mean()-X)|
|tBodyAcc.mean.Y|m(tBodyAcc-mean()-Y)|
|tBodyAcc.mean.Z|m(tBodyAcc-mean()-Z)|
|tGravityAcc.mean.X|m(tGravityAcc-mean()-X)|
|tGravityAcc.mean.Y|m(tGravityAcc-mean()-Y)|
|tGravityAcc.mean.Z|m(tGravityAcc-mean()-Z)|
|tBodyAccJerk.mean.X|m(tBodyAccJerk-mean()-X)|
|tBodyAccJerk.mean.Y|m(tBodyAccJerk-mean()-Y)|
|tBodyAccJerk.mean.Z|m(tBodyAccJerk-mean()-Z)|
|tBodyGyro.mean.X|m(tBodyGyro-mean()-X)|
|tBodyGyro.mean.Y|m(tBodyGyro-mean()-Y)|
|tBodyGyro.mean.Z|m(tBodyGyro-mean()-Z)|
|tBodyGyroJerk.mean.X|m(tBodyGyroJerk-mean()-X)|
|tBodyGyroJerk.mean.Y|m(tBodyGyroJerk-mean()-Y)|
|tBodyGyroJerk.mean.Z|m(tBodyGyroJerk-mean()-Z)|
|tBodyAccMag.mean|m(tBodyAccMag-mean())|
|tGravityAccMag.mean|m(tGravityAccMag-mean())|
|tBodyAccJerkMag.mean|m(tBodyAccJerkMag-mean())|
|tBodyGyroMag.mean|m(tBodyGyroMag-mean())|
|tBodyGyroJerkMag.mean|m(tBodyGyroJerkMag-mean())|
|fBodyAcc.mean.X|m(fBodyAcc-mean()-X)|
|fBodyAcc.mean.Y|m(fBodyAcc-mean()-Y)|
|fBodyAcc.mean.Z|m(fBodyAcc-mean()-Z)|
|fBodyAccJerk.mean.X|m(fBodyAccJerk-mean()-X)|
|fBodyAccJerk.mean.Y|m(fBodyAccJerk-mean()-Y)|
|fBodyAccJerk.mean.Z|m(fBodyAccJerk-mean()-Z)|
|fBodyGyro.mean.X|m(fBodyGyro-mean()-X)|
|fBodyGyro.mean.Y|m(fBodyGyro-mean()-Y)|
|fBodyGyro.mean.Z|m(fBodyGyro-mean()-Z)|
|fBodyAccMag.mean|m(fBodyAccMag-mean())|
|fBodyBodyAccJerkMag.mean|m(fBodyBodyAccJerkMag-mean())|
|fBodyBodyGyroMag.mean|m(fBodyBodyGyroMag-mean())|
|fBodyBodyGyroJerkMag.mean|m(fBodyBodyGyroJerkMag-mean())|
|tBodyAcc.std.X|m(tBodyAcc-std()-X)|
|tBodyAcc.std.Y|m(tBodyAcc-std()-Y)|
|tBodyAcc.std.Z|m(tBodyAcc-std()-Z)|
|tGravityAcc.std.X|m(tGravityAcc-std()-X)|
|tGravityAcc.std.Y|m(tGravityAcc-std()-Y)|
|tGravityAcc.std.Z|m(tGravityAcc-std()-Z)|
|tBodyAccJerk.std.X|m(tBodyAccJerk-std()-X)|
|tBodyAccJerk.std.Y|m(tBodyAccJerk-std()-Y)|
|tBodyAccJerk.std.Z|m(tBodyAccJerk-std()-Z)|
|tBodyGyro.std.X|m(tBodyGyro-std()-X)|
|tBodyGyro.std.Y|m(tBodyGyro-std()-Y)|
|tBodyGyro.std.Z|m(tBodyGyro-std()-Z)|
|tBodyGyroJerk.std.X|m(tBodyGyroJerk-std()-X)|
|tBodyGyroJerk.std.Y|m(tBodyGyroJerk-std()-Y)|
|tBodyGyroJerk.std.Z|m(tBodyGyroJerk-std()-Z)|
|tBodyAccMag.std|m(tBodyAccMag-std())|
|tGravityAccMag.std|m(tGravityAccMag-std())|
|tBodyAccJerkMag.std|m(tBodyAccJerkMag-std())|
|tBodyGyroMag.std|m(tBodyGyroMag-std())|
|tBodyGyroJerkMag.std|m(tBodyGyroJerkMag-std())|
|fBodyAcc.std.X|m(fBodyAcc-std()-X)|
|fBodyAcc.std.Y|m(fBodyAcc-std()-Y)|
|fBodyAcc.std.Z|m(fBodyAcc-std()-Z)|
|fBodyAccJerk.std.X|m(fBodyAccJerk-std()-X)|
|fBodyAccJerk.std.Y|m(fBodyAccJerk-std()-Y)|
|fBodyAccJerk.std.Z|m(fBodyAccJerk-std()-Z)|
|fBodyGyro.std.X|m(fBodyGyro-std()-X)|
|fBodyGyro.std.Y|m(fBodyGyro-std()-Y)|
|fBodyGyro.std.Z|m(fBodyGyro-std()-Z)|
|fBodyAccMag.std|m(fBodyAccMag-std())|
|fBodyBodyAccJerkMag.std|m(fBodyBodyAccJerkMag-std())|
|fBodyBodyGyroMag.std|m(fBodyBodyGyroMag-std())|
|fBodyBodyGyroJerkMag.std|m(fBodyBodyGyroJerkMag-std())|
