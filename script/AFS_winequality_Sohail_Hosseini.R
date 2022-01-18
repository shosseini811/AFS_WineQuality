## --------------------------------------------------------------------------------------------------------------

# removes all objects from the current workspace
rm(list = ls())

set.seed(2022)
# load all packages

library(plsRglm)
library(caret)
library(corrplot)
library(tidyverse)


## --------------------------------------------------------------------------------------------------------------
#load data
red <- read.csv('https://afs-wine-dataset.s3.amazonaws.com/winequality-red.csv', sep=';')
white <- read.csv('https://afs-wine-dataset.s3.amazonaws.com/winequality-white.csv', sep =';')


## --------------------------------------------------------------------------------------------------------------
#look at the data
head(red)


## --------------------------------------------------------------------------------------------------------------

# merge red wine and white wine datasets
data <- rbind(red, white)


## --------------------------------------------------------------------------------------------------------------
# First six rows
head(data)



## --------------------------------------------------------------------------------------------------------------
# last six rows of dataset
tail(data)


## --------------------------------------------------------------------------------------------------------------
# structure of the data
str(data)


## --------------------------------------------------------------------------------------------------------------
# number of missing values in each column
sapply(data, function(x) sum(is.na(x)))


## --------------------------------------------------------------------------------------------------------------
# data summary
summary(data)

## --------------------------------------------------------------------------------------------------------------
# look at outliers
boxplot(data)

## --------------------------------------------------------------------------------------------------------------
clear_data <- function(data){
  
  # each feature of input data is analysed
  for (i in 1:ncol(data)){
    # particular feature observations
    vec <- data[, i]
    
    # values those are out of 1.5 * IQR
    vec_out <- boxplot.stats(vec)$out
    
    # all outlier values found in feature vector assigned as NA
    vec[vec %in% vec_out] <- NA
    
    # data feature is updated
    data[, i] <- vec
  }
  
  # only complete observation data subset is returned
  data[complete.cases(data), ]
}

# Creating new data without outliers using defined function
data <- clear_data(data)


## --------------------------------------------------------------------------------------------------------------
# Correlation between features
correlation <- cor(x=data%>%select_if(is.numeric))
corrplot(correlation, method = 'circle',type='lower')



## --------------------------------------------------------------------------------------------------------------
# looking at boxplot after removing outliers
boxplot(data)


## ----split data------------------------------------------------------------------------------------------------
#Split the dataset to Train and Test
trainRowNumbers <- createDataPartition(data$quality, p=0.8, list=FALSE)

# Create the training  dataset
trainData <- data[trainRowNumbers,]

# Step 3: Create the test dataset
testData <- data[-trainRowNumbers,]



## ----cv.plsR---------------------------------------------------------------------------------------------------
set.seed(2022)

cv.modpls<-cv.plsR(quality~.,data=data,nt=10, verbose =F, NK=20)


## --------------------------------------------------------------------------------------------------------------
cv.modpls


## ----sum up the results----------------------------------------------------------------------------------------
# We sum up the results in a single table using the summary.
res.cv.modpls=cvtable(summary(cv.modpls))


## ----plot number of components---------------------------------------------------------------------------------
# The results, based on the use of the Q2 criterion to find the number of components
plot(res.cv.modpls)


## ----plsR model------------------------------------------------------------------------------------------------
# nt: number of components is set to 1
res<-plsR(quality~.,data=trainData,nt=1,pvals.expli=TRUE)

## --------------------------------------------------------------------------------------------------------------
# Model's Descriptive Statistics
res


## ----prediction MAE--------------------------------------------------------------------------------------------
#Predictions
# Mean Absolute Error
predict <- testData$quality
predictions <- predict(res, testData[,1:11])

MAE(predictions,predict)


## ----Feature Importance----------------------------------------------------------------------------------------
# Plot feature importance
# Grab a coffee, this one takes some time
train(data[,1:11], data[,12], method='plsRglm', verbose =F, preProcess = c("center","scale")) %>% varImp() %>% plot()

