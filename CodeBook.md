Codebook: Getting and Cleaning Data Course Project

The output of the run() function in run_analysis.R performs a number of transformations on the data provided in the zipped file located here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data files are from the UCI Machine Learning Repository, and are of the Human Activity Recognition Using Smartphones Data Set. The codebook for the original dataset can be found at CodeBookOriginalData.md (also part of this repo).

The transformations done on the original data set are as follows.

1) The train and test data sets are merged into a single data set. 
2) The measured data columns (in X_train.txt and X_test.txt) are replaced with their descriptive names (provided in features.txt)
3) Activity codes (in the y_test.txt and y_train.txt files) are joined with their descriptive names (provided in activity_labels.txt)
4) Only features with "mean" and "std" in the name are collected. All other feature columns are discarded.
5) After the above 4 transformations are complete, the data is grouped according to each subject and activity, and the column means are calculated

The order in which the transformations are done are as follows:
For test data set:
1) The full X_test.txt is read into a table, with the column names set as the names provided in features.txt. Column names with the 
	characters "-" or "(" or ")"" are replaced with ".".
2) The X data set is truncated by discarding any column name that doens't contain "mean" or "std"
3) The y_test.txt file is read into a table, with the column name set as "activityCode". This table is then joined with
	a table created by reading "activity_labels.txt" so that the y data is augmented with a column containing descriptive
	activity names.
4) The subject_test.txt file is read into a table, with the column name given as "subjectId"
5) An "id" column is created for all 3 of the tables created above, where the values are the range from 1 to the number of observations.
6) The subject data is merged with the y data based on the id column. The result of that table is then merged with the X data
	based on the id column. The temporary id column is dropped from the result table and then the remaining table is returned
	as the final data table for the test data set.

7) Steps 1-6 are repeated for the train data set.
8) The resulting tables from train and test are combined vertically, starting with the train data set, and ending with the test data set.
9) The table from #8 is summarized based on subjectId and activityName, and the mean of the feature columns are computed. This is the final table.