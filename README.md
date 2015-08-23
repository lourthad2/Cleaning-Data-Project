# Cleaning-Data-Project

This file describes how run_analysis.R script works.

1. Unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
and rename the folder with "data/UCI HAR Dataset".
2. Make sure the folder "data" and the run_analysis.R script are both in the current working directory.
3.  use source("run_analysis.R") command.
4. you will find  output files are generated in the current working directory: data_with_means.txt (it contains a data frame 
called result)
5. Use the command data <- read.table("data_with_means.txt") to read the file. 
