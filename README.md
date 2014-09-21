The script run_analysis.R does the following steps:
        
1)read all the data using read.table() function into 7 data frames:
data_xtrain, data_xtest, data_ytrain, data_ytest, data_subject_train, data_subject_test, features 
2)merge the data frames using cbind() and rbind() functions => merged_data data frame keep all the data
3)extract only the measurements on the mean and standard deviation for each measurement
using grep() function to find patterns "mean()" and "std()" in features data frame
4)subset data frames in accordance with 3)
5)replace in the 2nd column of merge_data data frame numbers 1:6 with the Activity names
6)Using sub() function replace patterns in features data frame column to get descriptive variable names
Add these names to names(merged_data) using for construction.
7)Using group_by() and summarise_each() functions from dplyr package 
we create a tidy data set with the average of each variable for each activity and each subject

More information in CodeBook.md