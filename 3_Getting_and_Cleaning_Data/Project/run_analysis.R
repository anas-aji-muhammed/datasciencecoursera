# Getting and cleaning data project
#Author: Anas Aji MUhammed

#Read activity labels from activity_labels.txt
activityLabels <- fread(file = './UCI HAR Dataset/activity_labels.txt', col.names = c('classLabels', 'activityNames'))

#Read features from features.txt file
features <- fread(file = './UCI HAR Dataset/features.txt', col.names = c('Index', 'featureNames'))

#Match the mean and std features from featureNames
featuresWanted <- grep("(mean|std)\\(\\)", features[, featureNames])
#get the feature names for the wanted features
measurements <- features[featuresWanted, featureNames]
#Remove the paranthesis in measurements
measurements <- gsub('[()]', '', measurements)

#Loading Train data
train <- fread(file = './UCI HAR Dataset/train/X_train.txt')[, featuresWanted, with = FALSE]
trainActivities <- fread("./UCI HAR Dataset/train/y_train.txt", col.names = c("Activity"))
trainSubjects <- fread(file = "./UCI HAR Dataset/train/subject_train.txt", col.names = c('SubjectNum'))

train <- cbind(trainSubjects, trainActivities, train)

#Loading test data
test <- fread(file = './UCI HAR Dataset/test/X_test.txt')[, featuresWanted, with = FALSE]
testActivities <- fread(file = './UCI HAR Dataset/test/y_test.txt', col.names = c('Activity'))
testSubjects <- fread(file = './UCI HAR Dataset/test/subject_test.txt', col.names = c("SubjectNum"))
test <- cbind(testSubjects, testActivities, test)

# combine train and test dataset usin row bind
combine <- rbind(train, test)

combine[["Activity"]] <- factor(combine[, 'Activity']
                                , levels = activityLabels[["classLabels"]]
                                , labels = activityLabels[["activityNames"]])

combine[["SubjectNum"]] <- as.factor(combine[, 'SubjectNum'])

combine <- reshape2::melt(data = combine, id = c("SubjectNum", "Activity"))
combine <- reshape2::dcast(data = combine, SubjectNum + Activity ~ variable, fun.aggregate = mean)

data.table::fwrite(x = combine, file = "./tidyData.txt", quote = FALSE)
