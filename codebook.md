Codebook for Samsung Smartphone
=====

This practice session involves making use of the UC Irvine Samsung smartphone dataset, described in more detail at this link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data for the exercise came packaged in a zip file:  

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The dataset contains over 561 variables, plus a subject, plus an activity. The goal of the dataset is to predict the activity (sitting, standing, walking, etc.) from the variables,whichcomefromcaptureofoutputofthesmartphones’gyroscopeandaccelerometers.

The variables are listed below, and can be decoded as follows:

The t or f at the start is for time or frequency
The next part is the measure, which can be
BodyAcc – body acceleration
GravityAcc – gravity acceleration
BodyAccJerk – jerk value of body acceleration
BodyGyro – body gyroscope
BodyGyroJerk
Etc.

And then there’s the measure –
Mean
Std – standard deviation

Note that all the measures and centered and scaled to fall between -1 and 1.

The only manipulation of the data in this instance was to take the original mean and standard deviation values and produce means of these values across the different observations, grouping by the combination of subject and activity.


The variables that follow below are the 66 that have standard deviation or mean in their names.  



subject
activity
tBodyAccMeanX
tBodyAccMeanY
tBodyAccMeanZ
tBodyAccStdX
tBodyAccStdY
tBodyAccStdZ
tGravityAccMeanX
tGravityAccMeanY
tGravityAccMeanZ
tGravityAccStdX
tGravityAccStdY
tGravityAccStdZ
tBodyAccJerkMeanX
tBodyAccJerkMeanY
tBodyAccJerkMeanZ
tBodyAccJerkStdX
tBodyAccJerkStdY
tBodyAccJerkStdZ
tBodyGyroMeanX
tBodyGyroMeanY
tBodyGyroMeanZ
tBodyGyroStdX
tBodyGyroStdY
tBodyGyroStdZ
tBodyGyroJerkMeanX
tBodyGyroJerkMeanY
tBodyGyroJerkMeanZ
tBodyGyroJerkStdX
tBodyGyroJerkStdY
tBodyGyroJerkStdZ
tBodyAccMagMean
tBodyAccMagStd
tGravityAccMagMean
tGravityAccMagStd
tBodyAccJerkMagMean
tBodyAccJerkMagStd
tBodyGyroMagMean
tBodyGyroMagStd
tBodyGyroJerkMagMean
tBodyGyroJerkMagStd
fBodyAccMeanX
fBodyAccMeanY
fBodyAccMeanZ
fBodyAccStdX
fBodyAccStdY
fBodyAccStdZ
fBodyAccJerkMeanX
fBodyAccJerkMeanY
fBodyAccJerkMeanZ
fBodyAccJerkStdX
fBodyAccJerkStdY
fBodyAccJerkStdZ
fBodyGyroMeanX
fBodyGyroMeanY
fBodyGyroMeanZ
fBodyGyroStdX
fBodyGyroStdY
fBodyGyroStdZ
fBodyAccMagMean
fBodyAccMagStd
fBodyBodyAccJerkMagMean
fBodyBodyAccJerkMagStd
fBodyBodyGyroMagMean
fBodyBodyGyroMagStd
fBodyBodyGyroJerkMagMean
fBodyBodyGyroJerkMagStd
