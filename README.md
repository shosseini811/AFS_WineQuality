# AFS_WineQuality

## Problem Statement: 
Using partial least squares regression for generalized linear models (the plsRglm package in R) using caret package, build an ensemble model to predict the quality score given to each wine from the Vinho Verde region of Portugal.

### Project Objective: 
Predict the quality of Wine

Data: https://archive.ics.uci.edu/ml/datasets/Wine+Quality


### Description of attributes
The data consists of 11 features which are: fixed acidity, volatile acidity, citric acid, residual sugar, chlorides, free sulfur dioxide, total sulfur dioxide, density, pH, sulphates, alcohol; and 1 output variable which is quality of wine. There are two data sets for red and white wine types. Data sets will be concatenated, and general model is going to be trained for both red and white wine types.

Each one of the wine samples was evaluated by a  minimum of three sensory assessors, using blind tastes,  which graded the wine on a  scale that ranges from  0  to  10,  that matches to very bad to excellent quality,  respectively.  The final score is given by  the median of these evaluations,  which corresponds to the output variable.  

### Using boxplot to find and remove outliers
![alt text](https://github.com/shosseini811/AFS_WineQuality/blob/9025ea8cd9d5efdbd11ff1b32389839462df0c34/Image/boxplot.png)



## Correlation between features

![alt text](https://github.com/shosseini811/AFS_WineQuality/blob/17532a9f127eadd9a8a63ead6865cb3d3172b814/Image/Correlation.png)

### The results, based on the use of the Q2 criterion to find the number of components
![alt_text](https://github.com/shosseini811/AFS_WineQuality/blob/edcf653fa47b5c385b6615dec54c5d3142e8a3ae/Image/Q2_criterion.png)
