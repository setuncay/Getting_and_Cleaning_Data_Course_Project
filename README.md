# Coursera Getting and Cleaning Data Course Project
## Aim
The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. For this purpose, the input data set used is:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This project contains run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## File List

1. run_analysis.R => Contains the implementation performing above 5 steps.
2. CodeBook.md => Lists and describes the variables produced by run_analysis.R
3. tidy_data.txt => Contains the output of run_analysis.R

## How to Run

1. 'dplyr' package is required, so if required please install dplyr package via install.packages("dplyr")
2. Run load_analysis.R within R. Please note that this script will create a new folder called 'data' (if it doesn't exist) in current working directory and download the compressed data file into this folder. Upon download, the script will automatically extract the contents of the compressed file within 'data' folder.
3. load_analysis.R will produce 'tidy_data.txt' in current working directory containing the tidy data set as required.

