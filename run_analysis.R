## This code creates a tiday data set containing the mean and standard deviation measures 
## from the samsung smartphone dataset at UC Irvine
## data comes from a zip file, and due to size it remains in the zip file, and is processed without unzipping
## only columns with std (standard deviation) and mean included
## final output aggregated to 

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileLoc <- "./data/samsung.zip"
download.file(fileUrl, fileLoc, method = "curl")  ## need to eliminate curl method if using PC
zipFileInfo <- unzip(fileLoc, list=TRUE)
## zipFileInfo - to get order of files; key ones are members 1, 2, 16, 17, 18, 30, 31, and 32
## feature names (column headers) in 2nd file in zipped list
featurenames <- read.delim(unz(fileLoc, as.character(zipFileInfo[2,1])),sep = " ",header = FALSE) ## need to use fixed width method FOR?
## provide column headers for clarity
colnames(featurenames) <- c("colNbr","featureDesc")
## filter on colnames with mean or std (standard deviation) - leave out meanFreq
featurenamesFilter <- sapply(featurenames[,2],function(x){grepl("mean()|std()",x) & !grepl("meanFreq",x) })
featurenamesFiltered <-featurenames[featurenamesFilter,2]
## and remove special characters
featurenamesFiltered <- gsub("\\(","",featurenamesFiltered)
featurenamesFiltered  <- gsub("\\)","",featurenamesFiltered)
featurenamesFiltered <- gsub("-","",featurenamesFiltered)
featurenamesFiltered <- gsub("\\,","",featurenamesFiltered)
featurenamesFiltered <- gsub("std","Std",featurenamesFiltered)
featurenamesFiltered <- gsub("mean","Mean",featurenamesFiltered)
## set up proper format of colClasses - variables to skip are NULL, keepers are numeric; need an extra col for row names
mycols<- rep("NULL", 561)
mycols[featurenamesFilter] <- "numeric"
mywidths<-rep(16,561)
##  need to develop data-chunking loop logic to avoid choking memory with complete file 
##  read test data (row 17 in zip file) for just filtered variables and attach column names
getphonechunk <- function(ziprow=17, pass=1, numrows=500) { 
    ## Ranks one state st for pre-prepped data frame df

    infile <- read.fwf(unz(fileLoc, as.character(zipFileInfo[ziprow,1])),header = FALSE, 
                       widths=mywidths,  n=numrows,  skip=numrows*(pass-1),
                       ## col.names = featurenames$featureDesc, ## add col names at end
                       colClasses = mycols ) ## need to use fixed width method FOR?
}  ## end of function
## apply function to test data
phonedata <- getphonechunk(ziprow=17, pass=1, numrows=1000)
phonedata <-rbind(phonedata,getphonechunk(ziprow=17, pass=2, numrows=1000)) 
phonedata <-rbind(phonedata,getphonechunk(ziprow=17, pass=3, numrows=1000)) 
## repeat with training data
phonedata <-rbind(phonedata,getphonechunk(ziprow=31, pass=1, numrows=900)) 
phonedata <-rbind(phonedata,getphonechunk(ziprow=31, pass=2, numrows=900)) 
phonedata <-rbind(phonedata,getphonechunk(ziprow=31, pass=3, numrows=900)) 
phonedata <-rbind(phonedata,getphonechunk(ziprow=31, pass=4, numrows=900)) 
phonedata <-rbind(phonedata,getphonechunk(ziprow=31, pass=5, numrows=900)) 
phonedata <-rbind(phonedata,getphonechunk(ziprow=31, pass=6, numrows=900)) 
phonedata <-rbind(phonedata,getphonechunk(ziprow=31, pass=7, numrows=900)) 
phonedata <-rbind(phonedata,getphonechunk(ziprow=31, pass=8, numrows=900)) 
phonedata <-rbind(phonedata,getphonechunk(ziprow=31, pass=9, numrows=900)) 

## make a subjects column to df
phonesubject <- read.csv(unz(fileLoc, as.character(zipFileInfo[16,1])),header = FALSE)
phonesubject <- rbind(phonesubject, read.csv(unz(fileLoc, as.character(zipFileInfo[30,1])),header = FALSE))
phonedata$subject <- as.factor(phonesubject$V1)
## and add activity column to df with proper activity names
phoneactivity <- read.csv(unz(fileLoc, as.character(zipFileInfo[18,1])),header = FALSE)
phoneactivity <- rbind(phoneactivity, read.csv(unz(fileLoc, as.character(zipFileInfo[32,1])),header = FALSE))
phonelabels <- read.table(unz(fileLoc, as.character(zipFileInfo[1,1])),header = FALSE)
phoneactivity <- merge(phoneactivity, phonelabels)
phonedata$activity <- phoneactivity$V2
table(phonedata$subject,phonedata$activity)

## Use aggregate to get means by subject and activity for all variables
phonetidy <- aggregate(x = phonedata[,1:66], by = list(phonedata$subject,phonedata$activity), FUN = "mean")
## now add column headers
colnames(phonetidy) <- c("subject","activity",featurenamesFiltered)
## Write result to a .csv file
outfileloc <- "./data/tidysmartphone.csv"
write.table(phonetidy,outfileloc, sep = ",", row.names = FALSE)

