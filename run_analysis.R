##TidyData project script. Assumes work directory has been set.
##If the ~60Mb file has already been downloaded, skip the first (#download) steps.

#download file, save as 'project.zip' in working directory.  Be sure to use binary mode.
fileUrl="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="project.zip", mode="wb")

#extract training dataset as 'table1'.  yields 7352 cases, 561 variables--type is numeric.  
#warnings are ignorable.
table1=read.table(unz("project.zip", "UCI HAR Dataset/train/X_train.txt"))

#extract test dataset as 'table2'.  yields 2947 cases, 561 variables--type is numeric.
#warnings are ignorable.
table2=read.table(unz("project.zip", "UCI HAR Dataset/test/X_test.txt"))

#merge training (table1) and test (table2) data using rbind(), into 'datafull'.  
#yields 10299 cases, 561 variables--type is numeric.
datafull=rbind(table1, table2)

#remove test, training tables from workspace.
rm(table1, table2)

#------------------- Project step 1 completed, in data.frame "datafull" -----------------

#extract list of variables/features saved in test, train files.
#yields table of 561 cases, 2 variables. V1 is feature/var number; V2 is name, type is factor)
features=read.table(unz("project.zip", "UCI HAR Dataset/features.txt"))

#create vector "keepvar" as subset of features that include "mean" or "std" in name.
#yields integer vector of length 79
keepvar = grep("mean|std", as.character(features[,2]))

#retain only the 79 variables that had "mean" or "std" in name, save as table = "data"
#yields table of 10299 cases, 79 variables.
data = datafull[,keepvar]

# ---------------- Project step 2 completed, in data.frame "data" ----------------------

#create table with subject ID for each case.  
#extract subject_id from training files.  yields 7352 cases, 1 (integer) var.
subj_train=read.table(unz("project.zip", "UCI HAR Dataset/train/subject_train.txt"))

#extract subject_id from test files.  yields 2947 cases, 1 (integer) var.
subj_test=read.table(unz("project.zip", "UCI HAR Dataset/test/subject_test.txt"))

#combine train, test subject ID files into one, using rbind().  yields 10299 cases,
#1 integer variable.  table is "subjects"
subjects=rbind(subj_train, subj_test)

#rename "V1" in subjects table as "subject"
colnames(subjects) = "subject"

#create labels table for each case, indicating which of 6 activities was involved.
#extract labels for training subset.  yields 7352 cases, 1 (integer) var.
train_labels=read.table(unz("project.zip", "UCI HAR Dataset/train/y_train.txt"))

#extract labels for test subset. yields 2947 cases, 1 (integer) var.
test_labels=read.table(unz("project.zip", "UCI HAR Dataset/test/y_test.txt"))

#combine train, test subject ID files into one, using rbind(). yields 10299 cases, 1 (integer) var.
labels=rbind(train_labels, test_labels)

#extract the activity labels from zipped file. yields 6 cases, 2 variables.
#V1 is the numeric value (1..6), and V2 is the activity name (e.g., "WALKING") 
activities=read.table(unz("project.zip", "UCI HAR Dataset/activity_labels.txt"))

#add the activities name as a new column in the labels table.
labels$act.name = as.character(activities[labels[,1],2])

#append the labels file to data file using cbind().  yields 10299 cases, 81 variables.
#save as table "dataset" 
#variable 80 is "subject"
#variable 81 is "act.name" (1 of 6)
dataset = cbind(data, subjects, labels[,2])
colnames(dataset)[81] = "activity"

#replace column names V1..V79 with their matching labels
for (i in 1:79) { colnames(dataset)[i] = as.character(features[keepvar[i],2]) }

# ------------------- Project steps 3,4 completed, in table, "dataset" --------------------

##activate dplyr package
library(dplyr)

#group dataset first by subject # and by activity 
#by_all is table containing grouped data set of 10299 cases, 81 variables.
by_all = group_by(dataset, subject, activity)

#now obtain means of each variable, grouped by by_all table.
#save as table, "tidy_dat".  yields 180 grouped observations by 81 variables.
tidy_dat=summarise_each(by_all, funs(mean))

#this is the final, "tidy" data set; in "wide" form.  Each row gives mean values for each var.,
#for 1 subject, on 1 type of activity.

