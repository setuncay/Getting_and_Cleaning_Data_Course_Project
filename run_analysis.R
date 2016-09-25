library(dplyr)
# Step 0 => Download the data into the data folder of the current working directory
  if(!file.exists("./data")) {
    dir.create("./data")
    }
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  #download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
# Extract the downloaded zip file
  unzip(zipfile="./data/Dataset.zip",exdir="./data")
#Step 1 => Merge the training and the test sets to create one data set.
  x_train_file_path <- "./data/UCI HAR Dataset/train/X_train.txt"
  y_train_file_path <- "./data/UCI HAR Dataset/train/y_train.txt"
  subject_train_file_path <- "./data/UCI HAR Dataset/train/subject_train.txt"
  x_test_file_path <- "./data/UCI HAR Dataset/test/X_test.txt"
  y_test_file_path <- "./data/UCI HAR Dataset/test/y_test.txt"
  subject_test_file_path <- "./data/UCI HAR Dataset/test/subject_test.txt"
  features_file_path <- "./data/UCI HAR Dataset/features.txt"
  activity_labels_file_path <- "./data/UCI HAR Dataset/activity_labels.txt"
  activity_id_label <- "activityId"
  subject_id_label <- "subjectId"
  #read test, training, feature and activity label frames
  dt_train <- read.table(x_train_file_path)
  dt_train_labels <- read.table(y_train_file_path)
  dt_subject_train <- read.table(subject_train_file_path)
  dt_test <- read.table(x_test_file_path)
  dt_test_labels <- read.table(y_test_file_path)
  dt_subject_test <- read.table(subject_test_file_path)
  dt_features <- read.table(features_file_path)
  dt_activity_labels <- read.table(activity_labels_file_path)
  merged_data <- bind_rows(dt_test, dt_train)
  colnames(merged_data) <- make.names(dt_features$V2, unique = TRUE)
  # Step 2:
  # Extract only the measurements on the mean and standard deviation for each measurement 
  merged_data <- select(merged_data, 
                        contains('mean', ignore.case = FALSE), 
                        contains('std', ignore.case = FALSE))
  # Join activity labels with test and train labels
  test_labels_labeled <- left_join(dt_test_labels, dt_activity_labels, by = 'V1')
  test_labels_labeled <- select(test_labels_labeled, V2)
  train_labels_labeled <- left_join(dt_train_labels, dt_activity_labels, by = 'V1')
  train_labels_labeled <- select(train_labels_labeled, V2)
  data_labels <- bind_rows(test_labels_labeled, train_labels_labeled)
  # Step 3: Name the variable as 'Activity' and merge to the final data set
  colnames(data_labels) <- c('Activity')
  merged_data <- bind_cols(merged_data, data_labels)
  
  # Bind the subjects to the final data set
  data_subjects <- bind_rows(dt_subject_test, dt_subject_train)
  colnames(data_subjects) <- c('Subject')
  merged_data <- bind_cols(merged_data, data_subjects)
  

  names(merged_data)<-gsub("^t", "time", names(merged_data))
  names(merged_data)<-gsub("^f", "frequency", names(merged_data))
  names(merged_data)<-gsub("Acc", "Accelerometer", names(merged_data))
  names(merged_data)<-gsub("Gyro", "Gyroscope", names(merged_data))
  names(merged_data)<-gsub("Mag", "Magnitude", names(merged_data))
  names(merged_data)<-gsub("BodyBody", "Body", names(merged_data))
  names(merged_data)<-gsub("...X", "X", names(merged_data))
  names(merged_data)<-gsub("...Y", "Y", names(merged_data))
  names(merged_data)<-gsub("...Z", "Z", names(merged_data))
  names(merged_data) <- gsub("\\.", "", names(merged_data))
  
  #Final Step
  grouped_data <- group_by(merged_data, Subject, Activity)
  summary_data <- summarise_each(grouped_data, funs(mean))
  # Write to the file system
  write.table(summary_data, 'tidy_data.txt', row.names = FALSE)