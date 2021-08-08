library(dplyr)

file_name <- "UCI HAR Dataset.zip"
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file_folder <- "UCI HAR Dataset"

##==========================================================================
##Step.0 Downloading and unzipping data
##==========================================================================

# download the zip file
if(!file.exists(file_name)){
  download.file(file_url, file_name, method = "curl")
}

# unzip the zip file
if(!file.exists("UCI HAR Dataset")){
  unzip(file_name)
}


##==========================================================================
##Step.1 Merges the training and the test sets to create one data set.
##==========================================================================

# 1.1 read data into R

# for detailed information about the data please see CodeBook.md
features <- read.table(paste(file_folder,"features.txt", sep = "/"), col.names = c("i", "column_names"))
activities <- read.table(paste(file_folder,"activity_labels.txt", sep = "/"), col.names = c("activity_code", "activity_label"))
X_train <- read.table(paste(file_folder,"train/X_train.txt", sep = "/"), col.names = features$column_names)
y_train <- read.table(paste(file_folder,"train/y_train.txt", sep = "/"), col.names = c("activity_code"))
X_test <- read.table(paste(file_folder,"test/X_test.txt", sep = "/"), col.names = features$column_names)
y_test <- read.table(paste(file_folder,"test/y_test.txt", sep = "/"), col.names = c("activity_code"))
subject_train <- read.table(paste(file_folder,"train/subject_train.txt", sep = "/"), col.names = c("subject"))
subject_test <- read.table(paste(file_folder,"test/subject_test.txt", sep = "/"), col.names = c("subject"))


# 1.2 merge data

# merge the pre-processed train and test data into X
X <- rbind(X_train, X_test)

# merge the train and test data of activity codes into y
y <- rbind(y_train, y_test)

# merge the train and test data of subjects into subject
subject <- rbind(subject_train, subject_test)

# merge X, y and subject into one data frame named UCI_HAR_Data
UCI_HAR_Data <- cbind(subject, y, X)


##==========================================================================
##Step.2 Extracts only the measurements on the mean and standard 
##       deviation for each measurement. 
##==========================================================================

UCI_HAR_mean_and_std <- UCI_HAR_Data %>% select(subject, activity_code, matches("(mean)|(std)"))

##==========================================================================
##Step.3 Uses descriptive activity names to name the activities 
##       in the data set 
##==========================================================================

UCI_HAR_mean_and_std$activity_code <- activities[UCI_HAR_mean_and_std$activity_code, "activity_label"]
# change the column name of 'activity_code' to 'activity_label'
UCI_HAR_mean_and_std <- rename(UCI_HAR_mean_and_std, c('activity_label' = 'activity_code'))


##==========================================================================
##Step.4 Appropriately labels the data set with descriptive variable names. 
##==========================================================================

colnames(UCI_HAR_mean_and_std) <- gsub("Jerk", "Jerk.", colnames(UCI_HAR_mean_and_std))
colnames(UCI_HAR_mean_and_std) <- gsub("Acc", "Accelerometer.", colnames(UCI_HAR_mean_and_std))
colnames(UCI_HAR_mean_and_std) <- gsub("Gyro", "Gyroscope.", colnames(UCI_HAR_mean_and_std))
colnames(UCI_HAR_mean_and_std) <- gsub("mean", "Mean.", colnames(UCI_HAR_mean_and_std))
colnames(UCI_HAR_mean_and_std) <- gsub("std", "STD.", colnames(UCI_HAR_mean_and_std))
colnames(UCI_HAR_mean_and_std) <- gsub("Mag", "Magnitude.", colnames(UCI_HAR_mean_and_std))
colnames(UCI_HAR_mean_and_std) <- gsub("Freq", "Frequency.", colnames(UCI_HAR_mean_and_std))
colnames(UCI_HAR_mean_and_std) <- gsub("angle", "Angle.", colnames(UCI_HAR_mean_and_std))
colnames(UCI_HAR_mean_and_std) <- gsub("gravity", "Gravity.", colnames(UCI_HAR_mean_and_std))
colnames(UCI_HAR_mean_and_std) <- gsub("(^t)|((\\.)t)", "TimeDomain.", colnames(UCI_HAR_mean_and_std))
colnames(UCI_HAR_mean_and_std) <- gsub("^f", "FrequencyDomain.", colnames(UCI_HAR_mean_and_std))
colnames(UCI_HAR_mean_and_std) <- gsub("(Body)+", "Body.", colnames(UCI_HAR_mean_and_std))
colnames(UCI_HAR_mean_and_std) <- gsub("(\\.)+", ".", colnames(UCI_HAR_mean_and_std))
colnames(UCI_HAR_mean_and_std) <- gsub("(\\.)$", "", colnames(UCI_HAR_mean_and_std))


##==========================================================================
##Step.5 From the data set in step 4, creates a second, 
##       independent tidy data set with the average of each
##       variable for each activity and each subject. 
##==========================================================================

UCI_HAR_Data_Summarize <- UCI_HAR_mean_and_std %>% 
  group_by(subject, activity_label) %>%
  summarise_all(mean)

# write the data into text file and save it to the working directory
write.table(UCI_HAR_Data_Summarize, "UCI_HAR_Data_Summarize.txt", row.name=FALSE)
