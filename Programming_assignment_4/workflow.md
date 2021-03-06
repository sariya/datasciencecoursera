##Work flow:
* Get features loaded in one variable which will be used both by training and test data
* Input Data is read in 2 seperate steps: training and test individually
* Output for mean, and merged data have columns for Std deviation and mean for each of the 6 activities

1. Read `features.txt` with header as F
2. Read `X_test.txt` in `x_test` variable
3. Set column names for data read in step 2 from `features` variable
4. Get rid of parenthesis and dashes in column names
5. Read `subject_test.txt` in test_subject variable. Info for subject ids
6. Read labels for test from `y_test.txt`
7. Add new column **label** to `x_test` variable
8. Add new column **subject** to `x_test` variable
9. Select column containing mean, and std and store in variable **r**
   * Substitute dots in column names
   * Substitute mean as Mean
   * Substitute std as Std
10. Read data for training in `y_training` variable
11. Set column names for training data
12. Get rid of parenthesis and dashes in column names
13. Read subject information for training data in `train_subject` variable
14. Read labels information for training data in `train_labels` variable
15. Add new column **label** to `y_training` variable
16. Add new column **label** to `y_training` variable
17. Select column containing mean, and std and store in variable **j**
   * Substitute dots in column names
   * Substitute mean as Mean
   * Substitute std as Std
18. Bind data from training and test for mean and std: merged data in `t` variable
    * Add new column to it: `activity`
    * Merged data has variable `label` associated with activity 
    
19. Read `activity_labels.txt` information in `activity_labels` variable
    * Get activity list in `activity_list` variable
    * It has 2 variables:
      * lables
      * activity name
20. Add activity information for each label present in merged data set
21. Move activity information in 1st column position front
22. Group data frame by subject, and activity and summarize each of them by mean
23. Output them using write
    * clean data set
    * Mean summary
