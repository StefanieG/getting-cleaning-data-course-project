## Set your working directory:
setwd("~/Documents/Data_Science/3_Getting-and-cleaning-data/Coursera-Course3")

library(plyr)

## Question 1: Merge the training and test sets to create one data set
## Merge the training set:
x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")

## Merge the test set:
x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")

## Create the data sets for x, y and "subjects":
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)


## Question 2: Extract only the measurements on the mean and standard deviation for each measurement
## Read the labels from the "features" file:
features <- read.table("features.txt")

## Get only columns with mean() or std() in their names:
mean_std <- grep("-(mean|std)\\(\\)", features[, 2])

## Subset the desired columns:
x_data <- x_data[, mean_std]

## Correct the column names:
names(x_data) <- features[mean_std, 2]


## Question 3:Use descriptive activity names to name the activities in the data set
## Read lables from the "activities" file:
activities <- read.table("activity_labels.txt")

## Update values with correct activity names:
y_data[, 1] <- activities[y_data[, 1], 2]

## Correct column names:
names(y_data) <- "activity"


## Question 4: Appropriately label the data set with descriptive variable names
## Correct column names:
names(subject_data) <- "subject"

## Bind all the data in a single data set:
all_data <- cbind(x_data, y_data, subject_data)


## Question 5: Create a second, independent tidy data set with the average of each variable
## for each activity and each subject

averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "tidy_data.txt", row.name=FALSE)


##Thanks to eriky and OscarPDR. 