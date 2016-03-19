Date 19 March 2016
Sanjeev Sariya

* Script: `run_analysis.R`
* Run this script inside downloaded data directory: "UCI HAR Dataset"
* Script will merge data and generate clean data with 89 columns:
  * 86 measurements
  * 3 columns: subject, label, and activity
    * 6 activities
    * 30 subjects
* Output will be generated in  "UCI HAR Dataset"
* 2 output **.txt** files:
  * clean_data.txt: Clean data merged from training and test data
    * 10299 rows
  * mean_clean_data.txt: Summary of each measured variable grouped by subject and activity
    * 180 rows
