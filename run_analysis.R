run_analysis <- function(){
        
        library(dplyr)
        
        data_xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", 
                                  header = FALSE, nrows = 7352)
        data_xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                                 header = FALSE, nrows = 2947)
        data_ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", 
                                  header = FALSE, nrows = 7352)
        data_ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", 
                                 header = FALSE, nrows = 2947)
        data_subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", 
                                         header = FALSE, nrows = 7352)
        data_subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", 
                                        header = FALSE, nrows = 2947)
        features <- read.table("./UCI HAR Dataset/features.txt", 
                               header = FALSE, nrows = 561)
        
        data_train <- cbind(data_xtrain, data_ytrain, data_subject_train)
        data_test <- cbind(data_xtest, data_ytest, data_subject_test)
        merged_data <- rbind(data_train, data_test)
        
        numrows <- c(grep("mean()", features[,2], fixed = TRUE), 
                     grep("std()", features[,2], fixed = TRUE))
        
        features <- features[numrows, ]
        merged_data <- merged_data[ ,c(563, 562, numrows)]
        
        for(i in 1:10299)
        if(merged_data[i,2] == 1){
                merged_data[i,2] <- "WALKING"
        } else if(merged_data[i,2] == 2){
                merged_data[i,2] <- "WALKING_UPSTAIRS"
        } else if(merged_data[i,2] == 3){
                merged_data[i,2] <- "WALKING_DOWNSTAIRS"
        } else if(merged_data[i,2] == 4){
                merged_data[i,2] <- "SITTING"
        } else if(merged_data[i,2] == 5){
                merged_data[i,2] <- "STANDING"
        } else if(merged_data[i,2] == 6){
                merged_data[i,2] <- "LAYING"
        }
        
        names(merged_data)[1:2] <- c("Subject", "Activity")
        
        features[,2] <- sub("tB", "TimeB", features[,2], fixed = TRUE)
        features[,2] <- sub("tG", "TimeG", features[,2], fixed = TRUE)
        features[,2] <- sub("fB", "FrequencyB", features[,2], fixed = TRUE)
        features[,2] <- sub("fG", "FrequencyG", features[,2], fixed = TRUE)
        features[,2] <- sub("-std()-", "StandardDeviation", features[,2], fixed = TRUE)
        features[,2] <- sub("-std()", "StandardDeviation", features[,2], fixed = TRUE)        
        features[,2] <- sub("-mean()-", "MeanValue", features[,2], fixed = TRUE)
        features[,2] <- sub("-mean()", "MeanValue", features[,2], fixed = TRUE)
        
        
        for(i in 3:68){
                names(merged_data)[i] <- as.character(features[i-2,2])
        }
        
        merged_data <- group_by(merged_data, Subject, Activity)
        tidy_data <- summarise_each(merged_data, funs(mean))
        write.table(tidy_data, file = "./result.txt", row.names = FALSE)
        
}