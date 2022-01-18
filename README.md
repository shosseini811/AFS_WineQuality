# AFS_WineQuality

## Problem Statement: 
Using partial least squares regression for generalized linear models (the plsRglm package in R) using caret package, build an ensemble model to predict the quality score given to each wine from the Vinho Verde region of Portugal.

### Project Objective: 
Predict the quality of Wine

Data: https://archive.ics.uci.edu/ml/datasets/Wine+Quality


### Description of attributes
The data consists of 11 features which are: fixed acidity, volatile acidity, citric acid, residual sugar, chlorides, free sulfur dioxide, total sulfur dioxide, density, pH, sulphates, alcohol; and 1 output variable which is quality of wine. There are two data sets for red and white wine types. Data sets will be concatenated, and general model is going to be trained for both red and white wine types.

Each one of the wine samples was evaluated by a  minimum of three sensory assessors, using blind tastes,  which graded the wine on a  scale that ranges from  0  to  10,  that matches to very bad to excellent quality,  respectively.  The final score is given by  the median of these evaluations,  which corresponds to the output variable.

Here is information about the predictors and target of the dataset.

1 - **fixed acidity**: most acids involved with wine or fixed or nonvolatile (do not evaporate readily)

2 - **volatile acidity**: the amount of acetic acid in wine, which at too high of levels can lead to an unpleasant, vinegar taste

3 - **citric acid**: found in small quantities, citric acid can add ‘freshness’ and flavor to wines

4 - **residual sugar**: the amount of sugar remaining after fermentation stops, it’s rare to find wines with less than 1 gram/liter, and wines with greater than 45 grams/liter are considered sweet

5 - **chlorides**: the amount of salt in the wine

6 - **free sulfur dioxide**: the free form of SO2 exists in equilibrium between molecular SO2 (as a dissolved gas) and bisulfite ion; it prevents microbial growth and the oxidation of wine

7 - **total sulfur dioxide**: the amount of free and bound forms of S02; in low concentrations, SO2 is mostly undetectable in wine, but at free SO2 concentrations over 50 ppm, SO2 becomes evident in the nose and taste of wine

8 - **density**: the density of water is close to that of water depending on the percent alcohol and sugar content

9 - **pH**: describes how acidic or basic a wine is on a scale from 0 (very acidic) to 14 (very basic); most wines are between 3-4 on the pH scale

10 - **sulfates**: a wine additive that can contribute to sulfur dioxide gas (S02) levels, which acts as an antimicrobial and antioxidant

11 - **alcohol**: the percent alcohol content of the wine

Output variable (based on sensory data): 

12 - **quality** (score between 0 and 10)


### Using boxplot to find and remove outliers
It is shown below that every feature has several outliers. Some models, in our case PLS, are sensitive to outliers. Therefore, we are going to use Boxplot to detect and remove outliers. 
![alt text](https://github.com/shosseini811/AFS_WineQuality/blob/9025ea8cd9d5efdbd11ff1b32389839462df0c34/Image/boxplot.png)



## Correlation between features
As it is shown below, some features are highly correlated for instance, alchohol and density which actually can cause Multicollinearity. Fortunately, Partial least squares regression is a powerful and frequently applied technique in multivariate statistical process control when the process variables are highly correlated. 

![alt text](https://github.com/shosseini811/AFS_WineQuality/blob/759271d4b55702fcf24b1c94658f12cf74219c54/Image/Correlation.png)

### Modeling, Training and Testing

a) Data Splitting:

Splitting data using Caret package 80% training set and 20% test set.

In this study, we will use formular specification of the PLS model.

cv.modpls<-cv.plsR(quality~.,data=data,nt=10, K=5, NK=20)

We use the default value, k=5 to perform repeated k-fold cross validation, We set the maximum number of components to 10 for the cross-validation function cv.plsR.
NK, number of times the group division is made, is set to 20.

The results, based on the use of the Q2 criterion, shown in below confirm those of the first 5-fold CV cross validation. We decide to retain 1 components.

![alt_text](https://github.com/shosseini811/AFS_WineQuality/blob/edcf653fa47b5c385b6615dec54c5d3142e8a3ae/Image/Q2_criterion.png)

Then, the model is trained based and tested on datasets. Mean absolute error (MAE) for test dataset is shown below.

![alt text](https://github.com/shosseini811/AFS_WineQuality/blob/9ea0d003e8a126489992737e01cf4354d3aa3047/Image/predictions.png)

