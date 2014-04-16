#Part 1: Merges the training and the test sets to create one data set.

#Read the tables from train data and put into one DF
features <- read.table("./UCI HAR Dataset/features.txt")
trainSet <- read.table("./UCI HAR Dataset/train/X_train.txt")
colnames(trainSet) <- features$V2
trainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSet,trainLabel, trainSubject)

#Read the tables from test data and put into one DF
testSet <- read.table("./UCI HAR Dataset/test/X_test.txt")
colnames(testSet) <- features$V2
testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSet, testLabel, testSubject)

#Merge DF
mergedData <-rbind(train,test)

#Part 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
extractedColumns <- grep("mean\\(\\)|std\\(\\)", features$V2)
extractedValues <- mergedData[c(extractedColumns, 562,563)]


#Part 3: Uses descriptive activity names to name the activities in the data set
colnames(mergedData)[562] <- "Label"
colnames(mergedData)[563] <- "Subject"
activityLabels <- c("walking", "walking upstairs", "walking downstairs","sitting", "standing", "laying")

#Part 4: Appropriately labels the data set with descriptive activity names. 
for (i in 1:6){
  mergedData$Label[mergedData$Label== i] <- activityLabels[i]
}

#Part 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidySet <- aggregate(. ~ Label+Subject, data = extractedValues, mean)
write.table(means, file="tidySet.txt", row.names=FALSE)





