# Combines test and train set from the UCI HAR dataset and summarizes the mean & std features
# based on subject and activity.
# This function assumes that the UCI HAR dataset has been unzipped as is into the current
# working directory.
run <- function()
{
    path<-"./UCI HAR Dataset"
    
    combinedData<-mergeTestAndTrainData(path)
    
    # averages the columns per subject and activity   
    result<-ddply(combinedData,.(subjectId,activityName),numcolwise(mean))
}

# Merges the test and train data sets in UCI HAR Dataset. Assumes default
# directory structure from .zip file
mergeTestAndTrainData <- function(path)
{
    # create paths to train set and test set
    trainPath<-paste0(path,"/train")
    testPath<-paste0(path,"/test")
    
    # path to the labels
    labelsPath<-paste0(path,"/activity_labels.txt")
    labelsData<-read.table(labelsPath,col.names=c("activityCode","activityName"))
    
    # path to the features 
    featuresPath<-paste0(path,"/features.txt")
    featuresData<-read.table(featuresPath,col.names=c("colId","colName"))
    
    # load the train data into a data.frame
    trainData<-mergeFiles(trainPath,"X_train.txt","y_train.txt","subject_train.txt",featuresData,labelsData)
    
    # load the test data into a data.frame
    testData<-mergeFiles(testPath,"X_test.txt","y_test.txt","subject_test.txt",featuresData,labelsData)
    
    # merge the train and test data
    combinedData<-rbind(trainData,testData)
}

# Merge data from files xFile, yFile, & subjFile in the given path.
# Assumes all 3 files have the same number of rows, and will create an id column in all 3 so that
# it can join the rows on.
# Returns: data.frame with merged data
mergeFiles <- function(path, xFile, yFile, subjFile, featuresData, labelsData)
{
    fulltestx<-read.table(paste0(path,"/",xFile),col.names=featuresData$colName)
    testy<-read.table(paste0(path,"/",yFile),col.names=c("activityCode"))
    testsubj<-read.table(paste0(path,"/",subjFile),col.names=c("subjectId"))
    
    # filter only for mean or std columns in testx
    testx<-fulltestx[,grep("mean|std",names(fulltestx))]
    
    # fill in activity names
    testy<-merge(testy,labelsData,by.x="activityCode",by.y="activityCode",sort=FALSE)
    
    # append an ID column to each table to allow joining.
    # we use the length of the first column of each data frame.
    testy$id<-1:length(testy[[1]])
    testsubj$id<-1:length(testsubj[[1]])
    testx$id<-1:length(testx[[1]])
    
    result<-merge(merge(testsubj,testy,by.x="id",by.y="id"),testx,by.x="id",by.y="id")
    
    #drop temp id column
    result[,!(names(result) %in% "id")]
}