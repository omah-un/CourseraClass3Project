#Part 1: Merges the training and the test sets to create one data set.
# Set the URLs
trainSetUrl <- "./UCI HAR Dataset/train/X_train.txt"
trainLabelUrl <- "./UCI HAR Dataset/train/y_train.txt"
trainSubjectUrl <- "./UCI HAR Dataset/train/subject_train.txt"
testSetUrl <- "./UCI HAR Dataset/test/X_test.txt"
testLabelUrl <- "./UCI HAR Dataset/test/y_test.txt"
testSubjectUrl <- "./UCI HAR Dataset/test/subject_test.txt"
featuresUrl <- "./UCI HAR Dataset/features.txt"

#Read the tables from train data and put into one DF
features <- read.table(featuresUrl, header=F)
trainSet <- read.table(trainSetUrl, header=F)
colnames(trainSet) <- features$V2
trainLabel <- read.table(trainLabelUrl, header=F)
trainSubject <- read.table(trainSubjectUrl, header=F)
train <- cbind(trainSet,trainLabel, trainSubject)

#Read the tables from test data and put into one DF
testSet <- read.table(testSetUrl, header=F)
colnames(testSet) <- features$V2
testLabel <- read.table(testLabelUrl, header=F)
testSubject <- read.table(testSubjectUrl, header=F)
test <- cbind(testSet, testLabel, testSubject)

#Merge DF
mergedData <-rbind(train,test)

#Part 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
extractedColumns <- grep("mean\\(\\)|std\\(\\)", features$V2)
extractedValues <- mergedData[c(extractedColumns, 562,563)]


#Part 3: Uses descriptive activity names to name the activities in the data set
colnames(mergedData)[562] <- "Label"
colnames(mergedData)[563] <- "Subject"
activityLabels <- c("walking", "walking upstairs", "walking downstairs",
              "sitting", "standing", "laying")

#Part 4: Appropriately labels the data set with descriptive activity names. 
for (i in 1:6){
  mergedData$Label[mergedData$Label== i] <- activityLabels[i]
}

#Part 5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidySet <- aggregate(. ~ Label+Subject, data = extractedValues, mean)
write.table(means, file="tidySet.txt", row.names=FALSE)
