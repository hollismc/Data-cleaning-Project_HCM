##Run_analysis.R
library(data.table)
library(dplyr)
library(tidyr)
install.packages("reshape2")
library(reshape2)

#download the files and unzip 
if(!file.exists("./data")) {dir.create("./data")}
fileurl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"  
download.file(fileurl1, destfile = "./data/datasets.zip", method = "curl")
run_analysis = unzip("./data/datasets.zip" )
run_analysis
dim(run_analysis)
run_analysis <- select("./data/datasets.zip",)
run_analysis
#pull out files needed for new data set and define the wanted features
features_text <- read.table(run_analysis[2])
names(features_text) <- "features_txt"

activity_labels <- read.table(run_analysis[1])
names(activity_labels) <- "activity_labels"

features_test <- read.table(run_analysis[15])
names(features_test) <- features_text[,2]
 
activity_test <- read.table(run_analysis[16]) 
names(activity_test) <- "activity"

features_train <- read.table(run_analysis[27])
names(features_train) <- features_text[,2]

activity_train <- read.table(run_analysis[28])
names(activity_train) <- "activity"
 
subject_train <- read.table(run_analysis[26])
names(subject_train) <- "subject"

subject_test <- read.table(run_analysis[14])
names(subject_test) <- "subject"
#bind all "training" sets together
train <- cbind(features_train, subject_train, activity_train) 
#bind all "testing" sets together
test <- cbind(features_test, subject_test, activity_test) 
#create new data by binding train ontop of test
newdata <- rbind(train, test)
#get mean and std of newdata columns (data relevant for the standard deviations and means)
meancol <- grep("mean", names(newdata))
stdcol <- grep("std", names(newdata))
#Reshape the data so that subjects and activities become variables of two independent columns
#add on means and standard deviations
newdata <- newdata %>% select(subject, activity, meancol, stdcol)
 
str(newdata)
#The residual columns show the accelerometer and gyroscope etc.
names(newdata)<-gsub("^t", "time", names(newdata))
names(newdata)<-gsub("^f", "frequency", names(newdata))
names(newdata)<-gsub("Acc", "Accelerometer", names(newdata))
names(newdata)<-gsub("Gyro", "Gyroscope", names(newdata))
names(newdata)<-gsub("Mag", "Magnitude", names(newdata))
names(newdata)<-gsub("BodyBody", "Body", names(newdata))
names(newdata)
#reshaped data using reshape2
melt_data <- melt(newdata, id = c("subject", "activity"))
mean_data <- dcast(melt_data, subject + activity ~ variable, mean)
#read tidy data set into R
write.table(mean_data, "tidy_data.txt", row.names = FALSE, quote = FALSE)

library(knitr)
knit2html("codebook.Rmd")









