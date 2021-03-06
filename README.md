# GettingAndCleaningDataProject
Project for Getting and Cleaning Data - Coursera

The run_analysis.R script requires the UCI HAR dataset in order to function. It assumes that the UCI HAR dataset zip file is extracted into the current working directory with folder structure intact. The main function in run_analysis.R is called run() and takes no arguments. There are several helper functions in the script,
but they should not be called except by run(). The result of run is a data.frame that contains a tidy version of the data as defined by the Getting and Cleaning Data Coursera course.

Usage:<br />
$ source('run_analysis.R')<br />
$ result<-run()<br />

The dataset can be found here:<br />
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A description of the data set can be found here:<br />
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Files
CodeBook.md - explains the transformations done to the original data set by the run_analysis.R script<br />
CodeBookOriginalData.md - describes the original data set. This was taken from the UCI HAR data set<br />
run_analysis.R - script that does the transformation and data tidying<br />
tidy.txt - sample output of the run_analysis.R file<br />