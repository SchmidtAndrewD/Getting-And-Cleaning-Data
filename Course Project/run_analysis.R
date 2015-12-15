##################################################################################################################
##################################################################################################################
##################################################################################################################
############     GETTING AND CLEANING DATA - COURSE PROJECT --  FIRST 26 LINES ARE ASSIGNMENT      ###############
##################################################################################################################
##################################################################################################################
##################################################################################################################

# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# Here are the data for the project:     

#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Good luck!


##################################################################################################################
##################################################################################################################
##################################################################################################################
########################              LOAD LIBRARIES & DATA FOR PROJECT                ###########################
##################################################################################################################
##################################################################################################################
##################################################################################################################


## STEP A: load/install required packages
library(reshape2)
library(data.table)
library(plyr) 

## STEP B: load/install required data
getwd()
setwd("C:/Users/Andrew/Desktop/Data Science Course/Getting and Cleaning Data/Course Project")
getwd()

##  STEP C: load Supporting Metadata
featureNames    <- read.table("./UCI HAR Dataset/features.txt")
activityLabels  <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

##  STEP D: Read training data
subjectTrain    <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain   <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain   <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)

##  STEP E: Read testing data
subjectTest     <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest    <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest    <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)


##################################################################################################################
##################################################################################################################
##################################################################################################################
############       PART 1: Merges the training and the test sets to create one data set               ############
##################################################################################################################
##################################################################################################################
##################################################################################################################

subject         <- rbind(subjectTrain, subjectTest)
activity        <- rbind(activityTrain, activityTest)
features        <- rbind(featuresTrain, featuresTest)

##  Name the columns
colnames(features) <- t(featureNames[2])

##  Merge the data
colnames(activity)  <- "Activity"
colnames(subject)   <- "Subject"
completeData        <- cbind(features,activity,subject)

##View(completeData)

print("PART 1: Merges the training and the test sets to create one data set")
Q1_Answer <-- completeData 
View(Q1_Answer)

##################################################################################################################
##################################################################################################################
##################################################################################################################
####      PART 2: Extracts only the measurements on the mean and standard deviation for each measurement      ####
##################################################################################################################
##################################################################################################################
####################################################################################################################    Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement

# Extract the column indices that have either mean or std in them.
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)

# Add activity and subject columns to the list and look at the dimension of completeData
requiredColumns <- c(columnsWithMeanSTD, 562, 563)
dim(completeData)

#View(completeData)
extractedData <- completeData[,requiredColumns]
dim(extractedData)

#View(extractedData)
print("PART 2: Extracts only the measurements on the mean and standard deviation for each measurement")
Q2_Answer <-- extractedData
View(Q2_Answer)
dim(Q2_Answer)


##################################################################################################################
##################################################################################################################
##################################################################################################################
############      PART 3: Uses descriptive activity names to name the activities in the data set      ############
##################################################################################################################
##################################################################################################################
##################################################################################################################


##  Make Activity a Character 
extractedData$Activity <- as.character(extractedData$Activity)

##  activity names
for (i in 1:6){   extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])  }

extractedData$Activity <- as.factor(extractedData$Activity)

print("PART 3: Uses descriptive activity names to name the activities in the data set  ")
Q3_Answer <-- extractedData
View(Q3_Answer)


##################################################################################################################
##################################################################################################################
##################################################################################################################
############      PART 4: Appropriately labels the data set with descriptive variable names           ############
##################################################################################################################
##################################################################################################################
##################################################################################################################


# Review names
names(extractedData)

##  Modify names
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("fBody", "FrequencyBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "StandardDeviation", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

# Review Names

print("PART 4: Appropriately labels the data set with descriptive variable names")
print(names(extractedData))
Q4_Answer <-- extractedData
View(Q4_Answer)


##################################################################################################################
##################################################################################################################
##################################################################################################################
############      PART 5: Creates a second,independent tidy data set and ouput it                     ############
##################################################################################################################
##################################################################################################################
##################################################################################################################

extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

##  Create Tidy Data
tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]

print("PART 5: Creates a second,independent tidy data set and ouput it ")
write.table(tidyData, file = "TidyDataSet.txt", row.names = FALSE)

print("Part 5 Answer Exported to TidyDataSet.txt")
print("Part 5 Answer Viewed Here")
View(tidyData)

TidyDataSet    <- read.table("./TidyDataSet.txt" , header=T)
View(TidyDataSet)






##################################################################################################################
##################################################################################################################
##################################################################################################################
##################              PART 6: Codebook data set and ouput it                ############################
##################################################################################################################
##################################################################################################################
##################################################################################################################

# Read Dataset Back into R:
  TidyDataSet    <- read.table("./TidyDataSet.txt" , header=T)
View(TidyDataSet)

##  Structure of TidyDataSet
str(TidyDataSet)

##  Summary of TidyDataSet
summary(TidyDataSet)


library(knitr)
library(markdown)
knit("codebook.Rmd")
knit2html("codebook.Rmd")