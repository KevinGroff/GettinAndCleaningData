#CODEBOOK
This is a code book describes the variables, the data, and any transformations used for this project.

#DATA SOURCE

Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#FILES USED
getdata-projectfiles-UCI HAR Dataset.zip 

features.txt

activity_labels.txt

Y_test.txt

Y_train.txt

subject_train.txt

subject_test.txt

X_test.txt

X_train.txt

#DATA SET DESCRIPTION

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


#SCRIPT REQUIREMENTS
Project requires UCI HAR Dataset folder and all underlying folders and files exist in users working directory

#TRANSFORMATION STEPS
A single R script titled run_analysis.R does the following
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. 
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#VARIABLES
path_DataFiles<-file.path(getwd(),"UCI HAR Dataset")

path_TestFiles<-file.path(path_DataFiles, "test")

path_TrainFiles<-file.path(path_DataFiles, "train")

path_DataFiles - path to UCI HAR Dataset folder

path_TestFiles - path to test folder

path_TrainFiles - path to train folder

df_FeatureNames - List of feature names

df_ActivityLabels - List of activity lables

df_Y_Test - Y_test.txt data

df_Y_Train - Y_train.txt data

df_Subject_Train - subject_train.txt data

df_Subject_Test  - subject_test.txt data

df_X_Test  - X_test.txt data

df_X_Train - X_train.txt data
