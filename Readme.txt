This run_analysis script will open the data that you have downloaded from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
unzipped and store the folder UCI HAR Dataset on your computer. Set that directory where you store that folder as your working directory in R. 
You will need to download and install the reshape2 package in R prior to running the run_analysis file. 
Assuming that you have set your working directory correctly and installed the reshape2 package all that you need to do is open and run the run_analysis.R file. It will open the data files, do the required transformations and create two files. One will contain the merged data containing the mean and standard deviation columns from the original data set, as well as the subject ids and activity names. 
The second file will contain averages over the means and standard deviations for each subject, for each activity
