The script run_analysis.R uses dplyr package.
## First step: read all the data using read.table() function

data_xtrain: 7352 obs. of 561 variables, training set

data_xtest: 2947 obs. of 561 variables, test set

data_ytrain: 7352 obs. of 1 variable, training labels (6 sorts of activity: numbers from 1 to 6)

data_ytest: 2947 obs. of 1 variable, test labels (also numbers 1:6, which represent certain kind of activity)

According to activity_labels.txt these numbers mean:
        1 WALKING
        2 WALKING_UPSTAIRS
        3 WALKING_DOWNSTAIRS
        4 SITTING
        5 STANDING
        6 LAYING

data_subject_train: 7352 obs. of 1 variable (numbers 1:30)

data_subject_test: 2947 obs. of 1 variable, (numbers 1:30) each row identifies the subject who performed 
                                            the activity for each window sample. 

features: 561 obs. of 2 variables, list of all features with their names

## Second step: merge the data
We use cbind function to merge the data frames with the same number of rows.
Then we use rbind function to merge the training data and the test data (with the same number of columns).
So we have merged_data data frame with 10299 obs. of 563 variables.

## Third step: extract the data
Using grep function (pattern matching) we find number of rows (numrows variable) with mean values and standard deviations.
We subset data frames and take only features and data corresponding to
the measurements on the mean and standard deviation for each measurement.
Now we have:

features data frame with 66 obs. of 2 variables

merged_data data frame with 10299 obs. of 68 variables.

## Fourth step: Activity names
We replace in the second column of merge_data data frame numbers 1:6 with the Activity names
(as in file activity_labels.txt)

## Fifth step: fill names(merged_data) with appropriate labels
The first column is subject (1:30) who performed the activity

The second column is activity

Another 66 columns labeled in accordance with feature data frame.

To get descriptive variable names we:
        
        Replace the t and f with Time and Frequency
        
        Remove the () and - symbols, expand "mean" and "std" abbreviations

Other abbreviations mean the body linear acceleration ("Acc") and angular velocity ("Gyro"),
which were derived in time to obtain Jerk signals ("Jerk"). 
Also the magnitude ("Mag") of these three-dimensional signals were calculated using the Euclidean norm.
(Information from features_info.txt)

## Sixth step: create a tidy data set with the average of each variable for each activity and each subject
We group data frame by Subject and Activity using group_by function from dplyr package.
Then we find the average of each variable using summarise_each function (also from dplyr package).

tidy_data data frame with 180 obs. of 68 variables - our tidy data set, 
we use write.table function to save it in txt file. 

                                             
