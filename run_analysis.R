#OpenReshape2 Package
library(reshape2)

#Download Dataset
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file = file.path(getwd(), "RunData.zip")
download.file(url, file)

unzip(zipfile = "RunData.zip", exdir=getwd())

RunData = file.path(getwd(), "UCI HAR Dataset")

#Load the Activity Labels and the Features
RunActivityLabels = read.table("UCI HAR Dataset/activity_labels.txt")
RunActivityLabels[,2] = as.character(RunActivityLabels[,2])
RunFeatures = read.table("UCI HAR Dataset/features.txt")
RunFeatures[,2] = as.character(RunFeatures[,2])

#Take Only The Mean And Standard Deviation
RunFeaturesData = grep(".*mean.*|.*std.*", RunFeatures[,2])
RunFeaturesData.names = RunFeatures[RunFeaturesData,2]
RunFeaturesData.names = gsub('-mean', 'Mean', RunFeaturesData.names)
RunFeaturesData.names = gsub('-std', 'Std', RunFeaturesData.names)
RunFeaturesData.names = gsub('[-()]', '', RunFeaturesData.names)

#Load the Datasets
RunTrain = read.table("UCI HAR Dataset/train/X_train.txt")[RunFeaturesData]
RunTrainActivities = read.table("UCI HAR Dataset/train/Y_train.txt")
RunTrainSubjects = read.table("UCI HAR Dataset/train/subject_train.txt")
RunTrain = cbind(RunTrainSubjects, RunTrainActivities, RunTrain)

RunTest = read.table("UCI HAR Dataset/test/X_test.txt")[RunFeaturesData]
RunTestActivities = read.table("UCI HAR Dataset/test/Y_test.txt")
RunTestSubjects = read.table("UCI HAR Dataset/test/subject_test.txt")
RunTest = cbind(RunTestSubjects, RunTestActivities, RunTest)

#Merge Datasets and Add Labels
AllRunData = rbind(RunTrain, RunTest)
colnames(AllRunData) = c("Subject", "Activity", RunFeaturesData.names)

#Turn Data into Factors
AllRunData$Activity = factor(AllRunData$Activity, levels = RunActivityLabels[,1], labels = RunActivityLabels[,2])
AllRunData$Subject = as.factor(AllRunData$Subject)

AllRunData.melted = melt(AllRunData, id = c("Subject", "Activity"))
AllRunData.mean = dcast(AllRunData.melted, Subject + Activity ~ variable, mean)

#Write Tidy Data
write.table(AllRunData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)


#Produce Codebook
library(knitr)
knit2html("codebook.Rmd")










