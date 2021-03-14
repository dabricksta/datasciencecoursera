library(data.table)
library(xlsx)
library(plyr)
library(dplyr)
library(magrittr)
library(reshape2)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

codebook <- url("http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones")
download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
              , destfile = 'courseprojectdata.zip'
              , method = 'curl')

# LUnzip and grab files names
dir.create("courseprojectdata")
zip <- unzip("courseprojectdata.zip", exdir = "courseprojectdata")

# Load data into working directory
for(i in 5:length(zip)){
  assign(basename(zip[i])
         , read.table(zip[i])
         , envir = globalenv()
  )
}

# Load non-data files
for(i in c(1:2)){
  assign(basename(zip[i])
         , read.table(zip[i])
         , envir = globalenv()
  )
}

# Merges the training and the test sets to create one data set.
names(subject_test.txt) <- 'subject'
names(subject_train.txt) <- 'subject'
names(y_test.txt) <- 'activity'
names(y_train.txt) <- 'activity'
names(activity_labels.txt) <- c('code', 'activity_name')

# Uses descriptive activity names to name the activities in the data set
test <- cbind(X_test.txt, subject_test.txt, y_test.txt) %>%
  merge(., activity_labels.txt, by.x = 'activity', by.y = 'code')
train <- cbind(X_train.txt, subject_train.txt, y_train.txt) %>%
  merge(., activity_labels.txt, by.x = 'activity', by.y = 'code')

# No idea why activity ends up as the first column and code doesn't even join but it throws off
# column ordering for the next part so goodbye~
full_ds <- rbind(test, train) %>%
  dplyr::select(., -activity)

# Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std_cols <- grep("-mean()|-std()", features.txt$V2)
mean_std <- full_ds[, mean_std_cols]

# Appropriately labels the data set with descriptive variable names.
names(mean_std) <- tolower(features.txt[mean_std_cols, 2]) %>%
  gsub("\\(|\\)", "", .)
names(full_ds) <- tolower(features.txt[, 2]) %>%
  # Gotta reassign the last two column names as the dataset is slightly wider than features.txt
  append(., c("subject", "activity_name")) %>%
  gsub("\\(|\\)", "", .)

# From the data set in the previous step, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
avgs <- reshape2::melt(full_ds, id = c("subject", "activity_name")) %>%
  reshape2::dcast(., subject + activity_name ~ variable, fun.aggregate = mean)

# Output for upload to Github
write.table(avgs, "./UCI HAR Dataset/avgs.txt", row.names = FALSE)
write.table(full_ds, "./UCI HAR Dataset/full_ds.txt", row.names = FALSE)