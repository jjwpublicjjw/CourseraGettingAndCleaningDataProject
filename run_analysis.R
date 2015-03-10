#
# Note: The following code does not attempt to optimize memory
# usage. In particular, rather than working with variables "in 
# place" by updating the variable contents over time, multiple
# variables are used, and each reflects the results of an 
# individual processing step. That is, rather than  
#
#   a <- initialize()
#   a <- update(a)
#   a <- update(a)
#
# an approach like
#
#   a <- initialize()
#   b <- update(a)
#   c <- update(b)
#
# is taken. The latter approach should require significantly
# more memory than the former, but it simplifies the process 
# of incrementally developing and debugging the code.
#

# 
# The following variables contain the local filesystem 
# locations of the components within the target dataset.
# The current values reflect the expectation that the 
# archive obtained from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# has simply been expanded in the R working directory.
# If the archive contents are reorganized or renamed 
# following the expansion, these variables need to be 
# adjusted accordingly
# 
baseDataPath <- './UCI HAR Dataset/'
featuresDataFilePath <- paste(baseDataPath, 'features.txt', sep = "")
activitiesDataFilePath <- paste(baseDataPath, 'activity_labels.txt', sep = "")

trainDirectoryPath <- paste(baseDataPath, 'train/', sep = "")
trainSetFilePath <- paste(trainDirectoryPath, 'X_train.txt', sep = "")
trainLabelFilePath <- paste(trainDirectoryPath, 'y_train.txt', sep = "")
trainSubjectFilePath <- paste(trainDirectoryPath, 'subject_train.txt', sep = "")

testDirectoryPath <- paste(baseDataPath, 'test/', sep = "")
testSetFilePath <- paste(testDirectoryPath, 'X_test.txt', sep = "")
testLabelFilePath <- paste(testDirectoryPath, 'y_test.txt', sep = "")
testSubjectFilePath <- paste(testDirectoryPath, 'subject_test.txt', sep = "")

#
# The following variables contain the "raw" contents of 
# the dataset files. The raw contents are combined and 
# manipulated in subsequent processing.
#
features <- read.table(featuresDataFilePath)
activities <- read.table(activitiesDataFilePath)

rawTrainSet <- read.table(trainSetFilePath)
trainLabels <- read.table(trainLabelFilePath)
trainSubjects <- read.table(trainSubjectFilePath)

rawTestSet <- read.table(testSetFilePath)
testLabels <- read.table(testLabelFilePath)
testSubjects <- read.table(testSubjectFilePath)

# 
# Copy raw data for manipulation
# 
trainData <- rawTrainSet
testData <- rawTestSet

#
# Add feature names
#
names(trainData) <- features$V2
names(testData) <- features$V2

#
# Create field to keep track of origin of 
# data after the training and test data is
# combined. This information is not 
# specifically used here, but it might
# be of interest in some future processing.
#
trainData$Origin <- factor("TRAIN")
testData$Origin <- factor("TEST")

# 
# Associate activity information
# 
trainData$Activity.Code <- trainLabels$V1
testData$Activity.Code <- testLabels$V1

# translate numeric activity code into factor
activityLookup <- function(code){
  activities[code, ]$V2
}

trainData$Activity = sapply(trainData$Activity.Code, activityLookup)
testData$Activity = sapply(testData$Activity.Code, activityLookup)

# 
# Associate subject information
# 
trainData$Subject <- trainSubjects$V1
testData$Subject <- testSubjects$V1
  
#
# Merge training and test data
#
combinedData <- rbind(trainData, testData)

#
# Eliminate all measurements other than
#  -activity
#  -subject
#  -mean
#  -standard deviation
#
meanPositions <- grep("-mean\\(\\)", names(combinedData))
stdPositions <- grep("-std\\(\\)", names(combinedData))
reducedData <- combinedData[, c(meanPositions, stdPositions)]
reducedData$Activity <- combinedData$Activity
reducedData$Subject <- combinedData$Subject

#
# Rename fields
#  Necessary to avoid errors in subsequent use of data.table
#  functionality because the original field names include 
#  characters such as "-" and "()" that cause them to be
#  interpreted as literal R syntax
#
names(reducedData) <- gsub("-", ".", names(reducedData))
names(reducedData) <- gsub("\\(\\)", "", names(reducedData))

#
# Use data.table to calculate the means of all fields, 
# grouped by Activity and Subject
#
#  Note: I discovered the technique used here at the following URL:
#    http://stackoverflow.com/questions/18091146/aggregate-all-columns-with-data-table
#  As the comments on that page note, the technique is described in
#  the ?data.table reference material
#
# The statement 
#   meanSummary <- reducedDataTable[, lapply(.SD, mean), by = list(Subject, Activity)]
# can be interpreted in something like the following fashion:
#   Assign to meanSummary the data.table obtained by:
#      1. beginning with the reducedDataTable data.table
#      2. partitioning reducedDataTable by unique pairs of (Subject, Activity) values
#      3. calculating the mean of each column in each partition
#
# One explanation of the .SD syntax is available in the data.table vignette FAQ
# (http://cran.r-project.org/web/packages/data.table/vignettes/datatable-faq.pdf)
#    "When grouping, the j expression can use column names as variables, 
#     as you know, but it can also use a reserved symbol .SD which refers
#     to the Subset of the Data.table for each group (excluding the grouping
#     columns). So to sum up all your columns it's just 
#     DT[,lapply(.SD,sum),by=grp]."
#
library(data.table)
reducedDataTable <- data.table(reducedData)
meanSummary <- reducedDataTable[, lapply(.SD, mean), by = list(Subject, Activity)]
meanSummary <- meanSummary[order(Subject, Activity)]

write.table(meanSummary, 'UCI.HAR.Data.Means.txt', row.name = FALSE)
