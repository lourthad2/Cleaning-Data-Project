#1.Merges the training and the test sets to create one data set
setwd("C:/hadoop/R/Data")
traindata <- read.table("./UCI HAR Dataset/train/X_train.txt") 
dim(traindata)
head(traindata)
trainlabel <- read.table("./UCI HAR Dataset/train/y_train.txt") 
table(trainlabel) 
trainsubj <- read.table("./UCI HAR Dataset/train/subject_train.txt") 
testdata <- read.table("./UCI HAR Dataset/test/X_test.txt") 
dim(testdata)
testlabel <- read.table("./UCI HAR Dataset/test/y_test.txt")  
table(testlabel)  
testsubj <- read.table("./UCI HAR Dataset/test/subject_test.txt") 
joindata <- rbind(traindata, testdata) 
dim(joindata) 
joinlabel <- rbind(trainlabel, testlabel) 
dim(joinlabel) 
joinsubj <- rbind(trainsub, testsubj) 
dim(joinsubj) 

#2 Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table("./UCI HAR Dataset/features.txt") 
dim(features)   
meanstddev <- grep("mean\\(\\)|std\\(\\)", features[, 2]) 
length(meanstddev)
joindata <- joindata[, meanstddev] 
dim(joindata) 
names(joindata) <- gsub("\\(\\)", "", features[meanstddev, 2]) 
names(joindata) <- gsub("mean", "Mean", names(joindata)) 
names(joindata) <- gsub("std", "Std", names(joindata))  
names(joindata) <- gsub("-", "", names(joindata)) 

#3 Uses descriptive activity names to name the activities in the data set     
                                                      
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")                   
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))                 
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))  
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))  
actvlabel <- activity[joinlabel[, 1], 2]                           
joinlabel[, 1] <- actvlabel                                        
names(joinlabel) <- "activity"                                         

#4.Appropriately labels the data set with descriptive variable names. 
                                                          
names(joinsubj) <- "subject"                                        
cleanseddata <- cbind(joinsubj, joinlabel, joindata)                 
dim(cleanseddata)                                           
write.table(cleanseddata, "merged_data.txt") 

# 5.creates a second, independent tidy data set with the average of each variable 
#for each activity and each subject.

subjlen <- length(table(joinsubj)) 
actvlen <- dim(activity)[1]  
colnlen <- dim(cleanseddata)[2] 
result <- matrix(NA, nrow=subjlen*actvlen, ncol=colnlen)  
result <- as.data.frame(result) 
colnames(result) <- colnames(cleanseddata) 
row <- 1 
for(i in 1:subjlen) { 
  for(j in 1:actvlen) { 
    result[row, 1] <- sort(unique(joinsubj)[, 1])[i] 
    result[row, 2] <- activity[j, 2] 
    bool1 <- i == cleanseddata$subject 
    bool2 <- activity[j, 2] == cleanseddata$activity 
    result[row, 3:colnlen] <- colMeans(cleanseddata[bool1&bool2, 3:colnlen]) 
    row <- row + 1 
  } 
} 
head(result) 
write.table(result, "data_with_means.txt") 

