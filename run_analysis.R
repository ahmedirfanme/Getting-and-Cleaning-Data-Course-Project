#download file
if(!file.exists("wk4project")){dir.create("wk4project")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "C:/Users/usman/Documents/DataScience/wk4project/dataset.zip")

#unzipping the content
unzip("C:/Users/usman/Documents/DataScience/wk4project/dataset.zip", exdir = "C:/Users/usman/Documents/DataScience/wk4project/data")

#setting file path
filepath <- file.path("C:/Users/usman/Documents/DataScience/wk4project/data", "UCI HAR Dataset")

#read the content
activitytest <- read.table(file.path(filepath, "test", "y_test.txt"), header = FALSE)
activitytrain <- read.table(file.path(filepath, "train", "y_train.txt"), header = FALSE)
subjecttest <- read.table(file.path(filepath, "test", "subject_test.txt"), header = FALSE)
subjecttrain <- read.table(file.path(filepath, "train", "subject_train.txt"), header = FALSE)
featuretest <- read.table(file.path(filepath, "test", "X_test.txt"), header = FALSE)
featuretrain <- read.table(file.path(filepath, "train", "X_train.txt"), header = FALSE)
featurenames <- read.table(file.path(filepath, "features.txt"), header = FALSE)
activitylabels <- read.table(file.path(filepath, "activity_labels.txt"), header = FALSE)

# adding meaningful columns
colnames(activitytest) <- 'activity'
colnames(activitytrain) <- 'activity'
colnames(subjecttrain) <- 'subject'
colnames(subjecttest) <- 'subject'
colnames(featuretest) <- featurenames$V2
colnames(featuretrain) <- featurenames$V2
colnames(activitylabels) <- c('activity', 'activitydescription')

#Merge test and train data and then into one data set
merged_test <- cbind(subjecttest, activitytest, featuretest)
merged_train <- cbind(subjecttrain, activitytrain, featuretrain)
merged_data <- rbind(merged_test, merged_train)

#Extracts measurements on the mean and standard deviation for each measurement
merged_data_select <- merged_data[, c(1,2, grep("mean\\(\\)|std\\(\\)", names(merged_data)))]

#Uses descriptive activity names to name the activities in the data set
merged_data_activity <- merge(merged_data, activitylabels, 'activity')

# Data sort
data_sorted <- merged_data_activity[, -1]

#re-order column
data_reorder <- data_sorted[c(1,68, 2:67)]

#ordering the data by subject and activity description
data_ordered <- data_reorder[order(data_reorder$subject, data_reorder$activitydescription),]

#Renaming variables
names(data_ordered) <- gsub("\\(\\)", "", names(data_ordered))
names(data_ordered) <- gsub("mean", "Mean", names(data_ordered))
names(data_ordered) <- gsub("std", "Std", names(data_ordered))
names(data_ordered) <- gsub("-", "", names(data_ordered))

#second, independent tidy data set with the average of each variable for each activity and each subject
data2 <- aggregate(. ~data_ordered$subject + data_ordered$activitydescription, data_ordered[, 3:68], mean)
