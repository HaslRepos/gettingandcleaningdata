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

#
# Build subset by selecting activity, subject and all variables providing mean or standard deviation (std). Ignoring meanFreq variables.
#


filter <- grepl("mean|std|subject|activity", names(combined_data)) & !grepl("meanFreq", names(combined_data))
filtered_data <- combined_data[, filter]

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

#
# Group cleaned dataset by subject and activity and calculate mean for all variables 
#

aggregated_data <- group_by(filtered_data, subject, activity) %>% summarise_each(funs(mean))

#
# Create output file
#

write.table(aggregated_data, file="aggregated_data.txt", row.name=FALSE)

