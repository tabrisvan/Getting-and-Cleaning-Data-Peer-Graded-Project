# Peer-graded Assignment: Getting and Cleaning Data Course Project

This repository is a submission for Getting and Cleaning Data course project from Tabris. It has the instructions on how to run analysis on Human Activity recognition dataset.

## Dataset

[Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

## Files in the repository

- `CodeBook.md` \- a code book that describes the variables and the data, and the work that I've done to clean up the data.
- `run_analysis.R` \- a R script that performs data preparation and followed by the 5 steps as listed in the instructions of the course project:
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- `UCI_HAR_Summarize.txt` \- the exported cleaned-up data after performing all the steps above.