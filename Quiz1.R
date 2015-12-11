# set working directory
setwd('/home/mhwong/Coursera/Getting And Cleaning Data/Quiz1')

# Question 1
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# How many properties are worth $1,000,000 or more?

# download file from server
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", 
              destfile = "q1.csv", 
              method = "curl")

# read csv file
q1 <- read.csv(file = "q1.csv", header = TRUE)

# count properties with value more than 1,000,000
nrow(q1[which(q1$VAL == 24),])

##  53




# Question 2

# Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate?

# Tidy data has variable values that are internally consistent.
# Tidy data has one variable per column. (Answer)
# Tidy data has no missing values.
# Tidy data has one observation per row.


## Tidy data has one variable per column.



# Question 3
# Download the Excel spreadsheet on Natural Gas Aquisition Program here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx
# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
# dat 
# What is the value of:
# sum(dat$Zip*dat$Ext,na.rm=T)
# (original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)

# download file from server
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",
              destfile = "q3.xlsx",
              method = "curl")

# load xlsx library
library(xlsx)

# read xlsx file
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("q3.xlsx", sheetIndex = 1, header = TRUE, colIndex = colIndex, rowIndex = rowIndex)

# sum
sum(dat$Zip*dat$Ext,na.rm=T) 

##  36534720



# Question 4
# Read the XML data on Baltimore restaurants from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml
# How many restaurants have zipcode 21231?

# download file from server
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",
              destfile = "q4.xml",
              method = "curl")

# load library
library(XML)

# read xml file
q4 <- xmlTreeParse(file = "q4.xml", useInternalNodes = TRUE)

# get root node
rootNode <- xmlRoot(q4)

# sum the zipcode == 21231
sum(xpathSApply(doc = rootNode, path = "//zipcode", fun = xmlValue) == 21231)

##  127



# Question 5
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
# using the fread() command load the data into an R object
# DT
# Which of the following is the fastest way to calculate the average value of the variable
# pwgtp15 
# broken down by sex using the data.table package?

# download file from server
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",
              destfile = "q5.csv",
              method = "curl")

# load library
library(data.table)

# read csv file using fread
DT <- fread("q5.csv", header = TRUE)

# best way to calculate mean by sex
sapply(split(DT$pwgtp15,DT$SEX),mean)

##  sapply(split(DT$pwgtp15,DT$SEX),mean)