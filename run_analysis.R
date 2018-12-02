
# Load training data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Load test data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Load feature
features <- read.table('./UCI HAR Dataset/features.txt')

# Load activity labels
activityLabels = read.table('./UCI HAR Dataset/activity_labels.txt')


# Giving column names
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

# Merging data
mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)
setAllInOne <- rbind(mrg_train, mrg_test)

# Getting column names
colNames <- colnames(setAllInOne)

# Getting column names for mean and std dev
mean_and_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)


setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]


# Name the data
setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

# Creating new data set
newTidydataSet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
newTidydataSet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

write.table(newTidydataSet, "newTidydataSet.txt", row.name=FALSE)









