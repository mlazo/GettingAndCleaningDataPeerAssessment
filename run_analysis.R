##Download the UCI HAR Dataset to your computer and unzip it. Set the working directory to the location of 
# the directory containing the UCI HAR Dataset
# The description of the data can be found at 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# The data can be downloade using the following link
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

#Load the train and test data into data frames
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")

#Merge the X train and test data by adding the x_test data as an addional column to the xtrain data. Then 
#do the same for the y data
X <- rbind(xtrain,xtest)
Y <- rbind(ytrain, ytest)

#Read the subject train and test data into a data.frame and do the same as for the x and the y data
subjtrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjtest <- read.table("UCI HAR Dataset/test/subject_test.txt")
Subj <- rbind(subjtrain, subjtest)


#Read the feature names into a data frame called features
features <- read.table("UCI HAR Dataset/features.txt", header=FALSE,colClasses="character")
# Get the features names that contain mean or std in them
ftresToKeep<- grep("mean\\(\\)|std\\(\\)", features[, 2])


# get the columns from the X dataframe that contain mean or standard deviation (std) data 
# and clean up the column names
X <- X[, ftresToKeep]
names(X) <- features[ftresToKeep, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- gsub("-","",names(X))
names(X) <- tolower(names(X))

#load in the data that contains the activity id's and activity labels
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
# Replace the activity id's in the Y data set with the names of the activities
Y[,1] = activities[Y[,1], 2]

#Set the name of the Y data frame to Activity and the name of the Subject data frame to subject
names(Y)<- "Activity"
names(Subj) <- "subject"
#create the tidy data set by combining the columns from the Subject, Y (eg activities) and X (variables)
# data frames into one data frame and write out the tidy data set
tidy <- cbind(Subj, Y, X)
write.table(tidy, "merged_tidy_data.txt")

##Part 5
# Using the package reshape2 reshape the data. Using the reshaped data 
# creates a second, independent tidy data set with the average of each variable for each activity 
#and each subject. Write the 
library(reshape2)
id_vars = c("subject", "Activity")
molten <- melt(tidy,id_vars)
tidied <- dcast(molten, subject + Activity ~ variable, mean)
write.table(tidied,"Tidy_Data_Set_with_averages.txt")
