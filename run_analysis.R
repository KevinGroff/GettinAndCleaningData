#Project assumes UCI HAR Dataset folder and all underlying folders and files exist in users working directory

#Set paths to files in working directory
path_DataFiles<-file.path(getwd(),"UCI HAR Dataset")
path_TestFiles<-file.path(path_DataFiles, "test")
path_TrainFiles<-file.path(path_DataFiles, "train")

#Read required files from working directory to data frames
df_FeatureNames <- read.table(file.path(path_DataFiles,"features.txt"), header = FALSE, col.names = c("Feature_ID", "Feature"))
df_ActivityLabels <- read.table(file.path(path_DataFiles,"activity_labels.txt"),header = FALSE, col.names = c("Activity_ID", "Activity_Name"))
df_Y_Test  <- read.table(file.path(path_TestFiles, "Y_test.txt" ),header = FALSE)
df_Y_Train <- read.table(file.path(path_TrainFiles, "Y_train.txt"),header = FALSE)
df_Subject_Train <- read.table(file.path(path_TrainFiles, "subject_train.txt"),header = FALSE, col.names = c("Subject_ID"))
df_Subject_Test  <- read.table(file.path(path_TestFiles , "subject_test.txt"),header = FALSE, col.names = c("Subject_ID"))
df_X_Test  <- read.table(file.path(path_TestFiles, "X_test.txt" ),header = FALSE)
df_X_Train <- read.table(file.path(path_TrainFiles, "X_train.txt"),header = FALSE)


#Merge Test and Train data
df_SubjectFull <- rbind(df_Subject_Train, df_Subject_Test)
df_Y_Full<- rbind(df_Y_Train, df_Y_Test)
df_X_Full<- rbind(df_X_Train, df_X_Test)

#Assign names of features from FeatureNames file
names(df_Y_Full)<- c("Activity_ID")
names(df_X_Full)<- df_FeatureNames$Feature

#Create a complete dataset
df_CombinedFA <- cbind(df_SubjectFull, df_Y_Full)
df_CombinedFull <- cbind(df_X_Full, df_CombinedFA)

#Find all the columns names that have mean and standard deviation in the title
df_MeanSTDFeatureNames<-df_FeatureNames$Feature[grep("mean\\(\\)|std\\(\\)", df_FeatureNames$Feature)]

#Create list of columns needed for summary data
c_MeanSTDColumnNames<-c(as.character(df_MeanSTDFeatureNames), "Subject_ID", "Activity_ID" )

#Remove unwanted columns from the dataset
df_CombinedFull<-subset(df_CombinedFull,select=c_MeanSTDColumnNames)

#Rename columns to friendlier names
names(df_CombinedFull)<-gsub("Acc", "Accelerometer", names(df_CombinedFull))
names(df_CombinedFull)<-gsub("Gyro", "Gyroscope", names(df_CombinedFull))
names(df_CombinedFull)<-gsub("Mag", "Magnitude", names(df_CombinedFull))
names(df_CombinedFull)<-gsub("BodyBody", "Body", names(df_CombinedFull))
names(df_CombinedFull)<-gsub("^t", "Time", names(df_CombinedFull))
names(df_CombinedFull)<-gsub("^f", "Frequency", names(df_CombinedFull))

#Find mean by Subject and Activity
df_Output<-aggregate(. ~Subject_ID + Activity_ID, df_CombinedFull, mean)

#Add activity labels to dataset
df_Output<-merge(df_ActivityLabels, df_Output,by="Activity_ID")

#Sort dataset ordered by subject and activity
df_Output<-df_Output[order(df_Output$Subject_ID,df_Output$Activity_ID),]

#Output dataset
write.table(df_Output, file = "Output_Tidy.txt",row.name=FALSE)
