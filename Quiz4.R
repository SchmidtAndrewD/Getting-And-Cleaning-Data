# Question 1
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

library(dplyr)
library(curl)
getwd()
setwd("C:/Users/Andrew/Desktop/Data Science Course/Getting and Cleaning Data/Week 4 Quiz")
if(!file.exists("./data")){dir.create("./data")}

housingdata <- read.csv("./data/getdata-data-ss06hid.csv")
list <-strsplit(names(housingdata),split="wgtp")
list[[123]]
## [1] ""   "15"


# Question 2
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
# Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table


data <- read.csv("./data/getdata-data-GDP.csv",skip=4, nrows=190)
cleanedData <- gsub(",","",data$X.4)
cleanedData <- (as.numeric(cleanedData))
mean(cleanedData,na.rm = TRUE)
## [1] 377652.4


# Question 3
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?
# Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table

countryNames <- data$X.3
length(grep("^United",countryNames))
## [1] 3

# Question 4
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Load the educational data from this data set:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?
# Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table http://data.worldbank.org/data-catalog/ed-stats

gdpdata <- read.csv("./data/getdata-data-GDP (1).csv",skip=4,nrows=190)
educationaldata <- read.csv("./data/getdata-data-EDSTATS_Country.csv")

# Merge the two datasets
mergedData <- merge(gdpdata,educationaldata,by.x="X", by.y="CountryCode")
fy.june <- grep('Fiscal year end: June', mergedData$Special.Notes)
length(fy.june)
## [1] 13


# Question 5
# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.

library(TTR)
library(quantmod)

amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

year2012 <- grepl('2012-*', sampleTimes)
sampleTimes2012 <- subset(sampleTimes, year2012)
day <- format(sampleTimes2012, '%A')
table(day)
## day
##    Friday    Monday  Thursday   Tuesday Wednesday 
##        51        47        51        50        51
table(year2012)
## year2012
## FALSE  TRUE 
##  1866   250