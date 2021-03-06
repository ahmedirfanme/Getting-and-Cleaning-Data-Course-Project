---
title: "Codebook.md"
author: "Irfan Ahmed"
date: "4/23/2020"
output: html_document
---

The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

1. Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

2.Assign each data to variables
featuresnames <- features.txt : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

activitylabels <- activity_labels.txt : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its codes (labels)

subjecttest <- test/subject_test.txt : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed

featurestest <- test/X_test.txt : 2947 rows, 561 columns
contains recorded features test data

activitytest <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’code labels

subjecttrain <- test/subject_train.txt : 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed

featurestrain <- test/X_train.txt : 7352 rows, 561 columns
contains recorded features train data

activitytrain <- test/y_train.txt : 7352 rows, 1 columns
contains train data of activities’code labels

Merges the training and the test sets to create one data set
merged_train is created by merging SubjectTrain, ActivityTrain and FeaturesTrain using cbind() function
merged_test is created by merging SubjectTest, ActivityTest and FeaturesTest using cbind() function
merged_data is created by merging Train and Test using cbind() function

Extracts only the measurements on the mean and standard deviation for each measurement
data is created by subsetting data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the data replaced with corresponding activity taken from second column of the activities variable

Appropriately labels the data set with descriptive variable names
code column in TidyData renamed into activities
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All BodyBody in column’s name replaced by Body
All Mag in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
data2 is created by summarizing data taking the means of each variable for each activity and each subject, after groupped by subject and activity.
