Date March 19 2016

Work flow:

* Get features loaded in one variable which will be used both by training and test data
* Input Data is read in 2 seperate steps: training and test individually

1. Read `features.txt` with header as F
2. Read `X_test.txt` in `x_test` variable
3. Set column names for data read in step 2 from `features` variable
4. Get rid of parenthesis and dashes in column names
5. Read `subject_test.txt` in test_subject variable. Info for subject ids
6. Read labels for test from `y_test.txt`
7. Add new column **label** to `x_test` variable
8. Add new column **subject** to `x_test` variable
9. Select column containing mean, and std
   * Substitute dots in column names
   * Substitute mean as Mean
   * Substitute std as Std

Merged data has 89 columns
* 89 columns, and 10299 rows in merged data: output - `clean_data.txt`
* 89 columns, and 180 rows in merged data with summary processed by grouping: output - `mean_clean_data.txt`
* Activity `column 1`
* Subject `column 2`
* Activity label `column 3`