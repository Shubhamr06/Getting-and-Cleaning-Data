setwd("D:/books/csv")
getwd()
## Reading training datasets
x_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")

## Reading testing datasets
x_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")

## Reading feature vector
features<-read.table("UCI HAR Dataset/features.txt")
## Reading activityLabels
activityLables<-read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activityLables)
features[,2]
nrow(features)
ncol(features)
subject_test
subject_train
activityLables
colnames(activityLables)
## assining colnames
colnames(x_train)
colnames(x_train)<-features[,2]
colnames(y_train)<-"activityID"
colnames(subject_train)<-"subjectID"
colnames(x_test)<-features[,2]
colnames(y_test)<-"activityID"
colnames(subject_test)<-"subjectID"
colnames(activityLables)<-c("activityID","subjectID")
##Merge all data in one set
mrg_train<-cbind(x_train,y_train,subject_train)
mrg_test<-cbind(x_test,y_test,subject_test)
setAllinone<-rbind(mrg_train,mrg_train)
## Extracting only the measurements on the mean and standard deviation for each measurement##
colnames<-colnames(setAllinone)
colnames
##Create vector for defining ID, mean and standard deviation
mean_std_std<-(grepl("activityID",colnames)|grepl("subjectID",colnames)|grepl("mean..",colnames)|grepl("std..",colnames))
mean_std_std
## Making nessesary subset from setAllInOne
setforMeanAndstd<-setAllinone[,mean_std_std==TRUE]
setforMeanAndstd
## Using descriptive activity names to name the activities in the data set
setWithActivityNames <- merge(setforMeanAndstd, activityLables,
                              by = 'activityID',
                              all.x=TRUE)
setWithActivityNames
##Creating a second, independent tidy data set with the average of each variable for each activity and each subject:
## Making second tidy data set
library(dplyr)
library(plyr)
secTidySet <- aggregate(. ~ subjectID + activityID,setWithActivityNames, mean)
?aggregate
sectidyset<-aggregate(.~activityID,data = setWithActivityNames,FUN = mean)
sectidyset
sectidyset$subjectID.y
sectidyset$subjectID
sectidyset<-sectidyset[order(sectidyset$subjectID.x,sectidyset$subjectID.y,sectidyset$activityID),]
sectidyset
##writing sectidyset in text
write.table(sectidyset,"sectidyset.txt",row.names = FALSE)
