# Quiz data.table Week 1 

# Reading data
mydata <- fread('hw1_data.csv')

# For column names of the dataset 
names(mydata)

# For first two rows 
mydata[c(1,2)]

# For number of rows in data.table
nrows(mydata)

# Extracting the last 2 rows of the data.table
tail(mydata,2)

# Removing Missing Values 
mydata[complete.cases(mydata),]