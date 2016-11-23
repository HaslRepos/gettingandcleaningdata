#Getting and Cleaning Data Course Project


The goal of this project is to produce a tidy data file based on a dataset from the UCI Machine Learning Repository.

##Project Requirements

* Data
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

* Documentation
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

* Create one R script called run_analysis.R that does the following:
	* Merges the training and the test sets to create one data set.
	* Extracts only the measurements on the mean and standard deviation for each measurement. 
	* Uses descriptive activity names to name the activities in the data set
	* Appropriately labels the data set with descriptive variable names. 
	* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



##Implementaion

The script ``` run_analysis.R ``` performs the analysis of the source dataset and creates a tidy data file called ``` aggregated_data.txt ```. 

###Starting the script:

``` 
source("run_analysis.R")
```

###Reloading the result file into R:

``` 
tidy_data <- read.table("./aggregated_data.txt", sep="|", header = TRUE)
```

###Please Note: The script requires the package dplyr to be installed.



###Processing Description 

####Preparation
Load the dplyr package, if the package is installed, otherwise stop the process.
Create a subdirectory, called data,  

cif("dplyr" %in% installed.packages() == FALSE) {
  stop("dplyr Package not installed!")
}

library(dplyr)

if (!file.exists("./data")) {
  dir.create("./data")
}

if (!file.exists("./data/uci.zip")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile = "./data/uci.zip", method="curl")
  if (!file.exists("./data/uci.zip")) {
    stop("'UCI HAR Dataset.zip' not available!")
  }
}
unzip("./data/uci.zip", exdir = "./data/")
``` 


x_names <- read.table("./data/UCI HAR Dataset/features.txt")
act_names <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names = c("act_id", "activity"))

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = x_names[,2], check.names = FALSE)
sub_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
act_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = c("act_id"))
act_train <- select(inner_join(act_train, act_names, by = "act_id"), activity)

x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = x_names[,2], check.names = FALSE)
sub_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
act_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = c("act_id"))
act_test <- select(inner_join(act_test, act_names, by = "act_id"), activity)

combined_data <- bind_rows(bind_cols(sub_train, act_train, x_train), bind_cols(sub_test, act_test, x_test))

filter <- grepl("mean|std|subject|activity", names(combined_data)) & !grepl("meanFreq", names(combined_data))
filtered_data <- combined_data[, filter]

names(filtered_data) <- tolower(names(filtered_data))
names(filtered_data) <- gsub("\\(\\)", "", names(filtered_data))
names(filtered_data) <- gsub("acc", "-acceleration", names(filtered_data))
names(filtered_data) <- gsub("gyro", "-angularvelocity", names(filtered_data))
names(filtered_data) <- gsub("mag", "-magnitude", names(filtered_data))
names(filtered_data) <- gsub("jerk", "-jerk", names(filtered_data))
names(filtered_data) <- gsub("std", "stddev", names(filtered_data))
names(filtered_data) <- gsub("^t", "time-", names(filtered_data))
names(filtered_data) <- gsub("^f", "frequency-", names(filtered_data))
names(filtered_data) <- gsub("bodybody", "body", names(filtered_data))

aggregated_data <- group_by(filtered_data, subject, activity) %>% summarise_each(funs(mean))

write.table(filtered_data, file="filtered_data.txt", row.name=FALSE, sep="|")
write.table(aggregated_data, file="aggregated_data.txt", row.name=FALSE, sep="|")




##License Restriction

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
