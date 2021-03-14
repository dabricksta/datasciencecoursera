## Human Activity Recognition Using Smartphones Dataset

### Description

There is only one R file, the required run_analysis.R code, and it is short and thoroughly commented.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear 
acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data 
manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating 
the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in 
fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has 
gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 
See 'features_info.txt' for more details. 

**Each record provides:**

1. Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
2. Triaxial Angular velocity from the gyroscope. 
3. Its activity label. 
4. An identifier of the subject who carried out the experiment.


**The original dataset includes the following files:**

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

**References**

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones 
using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). 
Vitoria-Gasteiz, Spain. Dec 2012

**http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones**


* The newly generated dataset includes the mean value and standard deviation for the 3-axial signals in the X, Y and Z directions for each subject:
* Other signals were excluded from the dataset
* Includes the subject and activity performed
* Both final datasets (clean_dataset and average_values) can be found within the UCI folder
* For description of script operations and steps for modifications of the original datasets, please refer to README document

* *tBodyAcc-XYZ*
* *tGravityAcc-XYZ*
* *tBodyAccJerk-XYZ*
* *tBodyGyro-XYZ*
* *tBodyGyroJerk-XYZ*
* *tBodyAccMag*
* *tGravityAccMag*
* *tBodyAccJerkMag*
* *tBodyGyroMag*
* *tBodyGyroJerkMag*
* *fBodyAcc-XYZ*
* *fBodyAccJerk-XYZ*
* *fBodyGyro-XYZ*
* *fBodyAccMag*
* *fBodyAccJerkMag*
* *fBodyGyroMag*
* *fBodyGyroJerkMag*

