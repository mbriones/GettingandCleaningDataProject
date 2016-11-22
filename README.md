# GettingandCleaningDataProject
The R script, run_analysis.R, does the following:

1. Download the dataset into the working directory.
2. Load the activity and feature information.
3. Loads the training and test datasets with columns that only have a mean or standard deviation.
4. Loads the activity and subject data for each dataset, and merges those columns with the dataset, and then finally merges the training, test, activity, and subject datasets.
5. Converts the activity and subject columns into factors.
6. Creates a tidy dataset that consists of the average value of each variable for each subject and activity pair.
7. The end result is shown in the file tidy.txt.
