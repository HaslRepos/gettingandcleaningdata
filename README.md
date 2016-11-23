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


####Starting the script:

``` 
source("run_analysis.R")
```


####Reloading the result file into R:

``` 
tidy_data <- read.table("./aggregated_data.txt", sep="|", header = TRUE)
```

####Please Note: The script requires the package dplyr to be installed.



###Processing Description

####Preparation

Load required packages; create directory; download and unzip source data


```
#
# Load the dplyr package, if the package is installed, otherwise stop the process.
#

if("dplyr" %in% installed.packages() == FALSE) {
  stop("dplyr Package not installed!")
}

library(dplyr)

#
# Create a subdirectory, called data, if directory not already exists
#

if (!file.exists("./data")) {
  dir.create("./data")
}

#
# Download source file, if not yet available; stop process, if download not successful
#

if (!file.exists("./data/uci.zip")) {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl, destfile = "./data/uci.zip", method="curl")
  if (!file.exists("./data/uci.zip")) {
    stop("'UCI HAR Dataset.zip' not available!")
  }
}
unzip("./data/uci.zip", exdir = "./data/")
```

####Requirement 1, 3 and 4

Load training and test data and build one combined dataset.
Merge activity id with activity name using join command. Join keeps sort order of first data frame.
Add subject id, activity name and original variable names to measurement data frame.


```
#
# Load variable names and activity names into data frames
#

x_names <- read.table("./data/UCI HAR Dataset/features.txt")
act_names <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names = c("act_id", "activity"))

#
# Load training variable data into data frame, appending previously loaded variable names
# Load training subject vector into data frame
# Load training activity vector into data_frame. Join activity vector and activity names on activity identifier.
#

x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = x_names[,2], check.names = FALSE)
sub_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
act_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = c("act_id"))
act_train <- select(inner_join(act_train, act_names, by = "act_id"), activity)

#
# Load test variable data into data frame, appending previously loaded variable names
# Load test subject vector into data frame
# Load test activity vector into data_frame. Join activity vector and activity names on activity identifier.
#

x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = x_names[,2], check.names = FALSE)
sub_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
act_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = c("act_id"))
act_test <- select(inner_join(act_test, act_names, by = "act_id"), activity)

#
# Combine training and test data frames
#

combined_data <- bind_rows(bind_cols(sub_train, act_train, x_train), bind_cols(sub_test, act_test, x_test))
```

####Requirement 2

Extract measurements providing mean or standard deviation


```
#
# Build subset by selecting activity, subject and all variables providing mean or standard deviation (std). Ignoring meanFreq variables.
#


filter <- grepl("mean|std|subject|activity", names(combined_data)) & !grepl("meanFreq", names(combined_data))
filtered_data <- combined_data[, filter]
```

####Requirement 4

Cleaning up variable names to make them more descriptive. Split names with using -.


```
#
# Cleaning up variable names
#   Set all names to lower case
#   Remove parenthesis
#   Change abbreviated names (age, gyro, mag, std, t, f)
#   Replace duplicated body
#

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
```

####Requirement 5

Aggregate data set by subject and activity. Calculate average for each combination


```
#
# Group cleaned dataset by subject and activity and calculate mean for all variables 
#

aggregated_data <- group_by(filtered_data, subject, activity) %>% summarise_each(funs(mean))

#
# Create output file
#

write.table(aggregated_data, file="aggregated_data.txt", row.name=FALSE, sep="|")
```




###Results

The script results in a tidy wide format data file with 180 rows (30 subjects * 6 activities) and 68 columns (subject, activity and 66 measurement variables).

The data set is tidy:
* Descriptive headings are assigned to each column
* All variables are in different columns
* There are no duplicate columns

The CodeBook, available in this repository, provides additional information for the different columns.




##License Restriction

Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
