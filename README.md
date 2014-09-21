DataCleaning
============

Project from data cleaning mooc

Contents:

1. file: run_analysis.R     Script of R commands to go from fetching files to final, tidy data set
2. README.md                This file.  Codebook follows for "tidy" data file as generated from script.


Codebook:

Subject: Integer (range of 1..30), representing one of 30 participants in study.
Activity:Character ("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", or "LAYING")
Mean scores on individual variables (79 in all).  Each is a numeric variable.
Key to names (five basic elements to name)
  Element #1
    "t" ...   indicates a time variable
    "f"...    indicates a FFT transformed variable
  Element #2
    "Body"    indicates body movement
    "Gravity" indicates gravity input
  Element #3
    "Acc"     indicates acceleration reading (read from accelerometer)
    "Gyro"    indicates gyroscope reading 
    "Jerk"    indicates product of linear acceleration and angular velocity
  Element #4
    "mean"    indicates mean measurement was recorded.
    "std"     indicates standard deviation of measurements for this subject was recorded.
  Element #5
    "X"       indicates X-axis movement (e.g., left-right)
    "Y"       indicates Y-axis movement (e.g., up-down)
    "Z"       indicates Z-axis movement (e.g., forward-back)
    
Example: "tBodyAcc-mean()-X"   
    #1: time measure variable
    #2: Body movement
    #3: (Body) acceleration
    #4: mean score
    #5: X-axis

Final, tidy data table yields 180 rows, 81 columns.  Each row represents mean scores by subject and activity, for each of the 79 variables that were recorded in the original data set as means or SDs.

    
   
    
