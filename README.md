# Getting-and-Cleaning-Data-Course-Project
This Repository is created as part of Getting and Cleaning Data Course Project work by Anand

# Pre-requiste for running the "run_analyis.R" script

# Pre-requiste
Please check the following before running the run_analyis script.
1. Extract the Course Project files. \n 
2. Using setwd() function, set the current working directory to folder containing the "UCI HAR Dataset" folder \n 
	e.g. setwd("C:\\Users\\CourseEra\\Projects")	\n 
3. Verify the same by executing "getwd()" function. 
4. ** IMPORTANT ** Copy the  "Colnames.csv" file from repository to the current working folder. Use the Windows drag and drop feature to manually copy it.
	This is CRITICAL STEP. If this step is done you will get the following ERROR Message during execution.
	*** In file(file, "rt") :   cannot open file '.\Colnames.csv': No such file or directory ***
5. It is assumed that the current directory contains the  "UCI HAR Dataset" FOLDER. This folder contains all the sub-folders and files listed below
	a. test (DIRECTORY)
	b. train (DIRECTORY)
	c. activity_labels.txt
	d. features.txt
	e. features_info.txt
	f. README.txt

## Running the script
Once all the pre-requiste are satisfied, Open the script in R-Studio and click the Run icon.

## Outputs
The script produces TWO files
1. Tidy.csv - This is the OUTPUT of STEP-4 of the assignment. This data adheres to the following first 4 steps of the assignment 
		a.Merges the training and the test sets to create one data set.
        b.Extracts only the measurements on the mean and standard deviation for each measurement. 
        c.Uses descriptive activity names to name the activities in the data set
        d.Appropriately labels the data set with descriptive variable names. 
2. FinalDataset.txt - This is the FINAL OUTPUT of STEP-5. which is 
		e.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
