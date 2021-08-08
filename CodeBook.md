# CodeBook for run_analysis.R



The script run_analysis.R performs data preparation and then followed by the 5 required steps in the course project's introduction:

0. **Downloads and unzips the data.**
   - Dataset downloaded and extracted under the folder called "UCI HAR Dataset"

1. **Merges the training and the test sets to create one data set.**

   First, read the data into R:

   - `features` \- `./UCI HAR Dataset/features.txt` : 561(rows) $\times$​ 2(columns)

     - Each row corresponds to a different feature of the dataset;

     - The first column is just a counter;

     - The second column contains strings that are features of the dataset.

   - `activities` \- `./UCI HAR Dataset/activity_labels.txt` : 6(rows) $\times$ 2(columns)

     - The activity labels are stored as *value - key* in each row.

   - `X_train` \- `./UCI HAR Dataset/train/X_train.txt` : 7352(rows) $\times$ 561(columns)

     - Each row is a different record;

     - Columns corresponds to different features, that is, the second column of `features`

   - `y_train` \- `./UCI HAR Dataset/train/y_train.txt` : 7352(rows) $\times$ 1(column)

     - The values correspond to differents rows in `X_train`, the number of 1\-6 indicates different activity labels that are listed in `activities`

   - `X_test` \- `./UCI HAR Dataset/test/X_test.txt` : 2947(rows) $\times$ 561(columns)

     - Each row is a different record;

     - Columns corresponds to different features, that is, the second column of `features`

   - `y_test` \- `./UCI HAR Dataset/test/y_test.txt` : 2947(rows) $\times$ 1(column)

     - The values correspond to differents rows in `X_test`, the number of 1\-6 indicates different activity labels that are listed in `activities`

   - `subject_train` \- `./UCI HAR Dataset/train/subject_train.txt` : 7352(rows) $\times$ 1(column)

     - The values correspond to differents rows in `X_train`, the number of 1\-30 indicates different volunteers that attended the experiments

   - `subject_test` \- `./UCI HAR Dataset/test/subject_test.txt` : 2947(rows) $\times$ 1(column)

     - The values correspond to differents rows in `X_test`, the number of 1\-30 indicates different volunteers that attended the experiments

   Then, 

   - use `rbind()` to merge `X_train` and `X_test` into `X` : 10299(rows) $\times$​​ 561(columns)
   - use `rbind()` to merge `y_train` and `y_test` into `y` : 10299(rows) $\times$ 1(column)
   - use `rbind()` to merge `subject_train` and `subject_test` into `subject` : 10299(rows) $\times$ 1(column)

   Finally, use `cbind()` to merge them all together into `UCI_HAR_Data` : 10299(rows) $\times$​ 563(columns)

2. **Extracts only the measurements on the mean and standard deviation for each measurement.**

   `UCI_HAR_mean_and_std ` (10299 rows  $\times$ 1 column) is created by subsetting `UCI_HAR_Data`, selecting only columns: `subject`, `activity_code` and the measurements on the `mean` and *standard deviation* (`std`) for each measurement

3. **Uses descriptive activity names to name the activities in the data set**

   - That is, to replace the numbers in the `activity_code` column of `UCI_HAR_mean_and_std` according to *value \- key* in `activities`. 
   - After changing the column contents from codes to labels, alter the column name from `activity_code` to `activity_label` to make the coding style more consistent.

4. **Appropriately labels the data set with descriptive variable names.** 

   - All `Acc` in column names replaced by `Accelerometer`
   - All `Gyro` in column names replaced by `Gyroscope`
   - All `Body` that appears more than once(`BodyBody`) in column names replaced by `Body`
   - All `Mag` in column names replaced by `Magnitude`
   - All start with character `f` in column names replaced by `FrequencyDomain`
   - All start with character `t` in column names replaced by `TimeDomain`
   - All of the above discriptive words in column names are seperated by `.`, and `.` that appears multiple times in a row are replaced with a single `.`
   - All `.` that appear in the end of the column names are deleted.

5. **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

   - `UCI_HAR_Data_Summarize` (180 rows  $\times$​ 88 column) is created by sumarising `UCI_HAR_mean_and_std` and taking the means of each measurement for each activity_label and each subject, after groupped by `subject` and `activity_label`.
   - Export `UCI_HAR_Data_Summarize` into `UCI_HAR_Data_Summarize.txt` file.

