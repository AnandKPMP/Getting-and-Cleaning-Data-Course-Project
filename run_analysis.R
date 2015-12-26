#This script is to 
#       You should create one R script called run_analysis.R that does the following. 
#       1.Merges the training and the test sets to create one data set.
#       2.Extracts only the measurements on the mean and standard deviation for each measurement. 
#       3.Uses descriptive activity names to name the activities in the data set
#       4.Appropriately labels the data set with descriptive variable names. 
#       5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Load Libraries
install.packages("reshape2")
library("reshape2")

## Process Test Data First
        # Get Column names
        featureNames <- read.delim(".\\UCI HAR Dataset\\features.txt", header = FALSE,sep = " ",colClasses = c("NULL",NA))
        labels <- matrix(unlist(featureNames), ncol = 1)
        valid_labels <- make.names(labels, unique = TRUE, allow_ = TRUE)
        
        #Get Acitivity Description
        Activity_Desc <- read.table(".\\UCI HAR Dataset\\activity_labels.txt", col.names = c("ID", "Description"))
        #Step -1 Get Test Data
        #read Test data
        Test_Data <- read.table (".\\UCI HAR Dataset\\test\\X_test.txt",col.names = valid_labels)
        
        #Read Test Subjects
        Test_Subjects <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt", col.names = "Subjects")
        
        #Read  Test Activity
        Test_Activity <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt",col.names = "Activity")
        #Get the Description for the activities
        Test_Activity <- sapply(Test_Activity, function(x)  Activity_Desc[x,2] )
        
        #Extract the Mean and STD for Each measurement
        Test_Data_MeanStd <- Test_Data[ c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543)]
        
        # Add the Activity and subject data set to the Data Set.
        Test_Data_MeanStd$Activities <-  Test_Activity # Activity Data
        Test_Data_MeanStd$Subjects <- Test_Subjects$Subjects  # Subject Data
        # Add a Column to denote if the row is from Test data or Train data
        Test_Train <- data.frame(rep("Testing",length(Test_Activity)))
        
        Test_Data_MeanStd$TestOrTrain <- Test_Train$`Test or Train`
        

#Process Training Data Set
        #Step 1 Read Training data
        Train_Data <- read.table (".\\UCI HAR Dataset\\train\\X_train.txt",col.names = valid_labels)
        
        #Read Training Subjects
        Train_Subjects <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt", col.names = "Subjects")
        
        #Read  Training Activity
        Train_Activity <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt",col.names = "Activity")
        #Get the Description for the activities
        Train_Activity <- sapply(Train_Activity, function(x)  Activity_Desc[x,2] )
        
        #Extract the Mean and STD for Each measurement
        Train_Data_MeanStd <- Train_Data[ c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121,122,123,124,125,126,161,162,163,164,165,166,201,202,214,215,227,228,240,241,253,254,266,267,268,269,270,271,345,346,347,348,349,350,424,425,426,427,428,429,503,504,516,517,529,530,542,543)]
        
        # Add the Activity and subject data set to the Data Set.
        Train_Data_MeanStd$Activities <-  Train_Activity # Activity Data
        Train_Data_MeanStd$Subjects <- Train_Subjects$Subjects  # Subject Data
        # Add a Column to denote if the row is from Test data or Train data
        Test_Train <- data.frame(rep("Training",length(Train_Activity)))
        
        Train_Data_MeanStd$TestOrTrain <- Test_Train$`Test or Train`

        # Merge Train and Test Data.
        Tidy_Data <- rbind(Train_Data_MeanStd,Test_Data_MeanStd)
        
        # Get Descriptive Col names from colnames.csv file and assign it to Tidy_data
        newcoldata <- read.csv(".\\Colnames.csv", header = TRUE)
        colnames(Tidy_Data) <- newcoldata[,3]
        
        #Print to file the Tidy data set and check the file.
        write.csv(Tidy_Data,".\\Tidy.csv")   

# Melt the data set for each variable of the 66 variables. The result is a long skinny data frame with just 4 columns
        
        Tidy_Data_Melted <- melt(Tidy_Data, id = c ("Activities","Subjects"), measure.vars = newcoldata[1:66,3])

# Use the dcast function to pivot the data by mean of Activities and Subject
        ActBySub_data <- dcast(Tidy_Data_Melted, Activities + Subjects ~ variable, mean)

#Wrte the final data into a fle.
        write.table(ActBySub_data,".\\FinalDataset.txt",row.names = FALSE)