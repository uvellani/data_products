Titanic Survival Study
========================================================
author: uvellani
date: November 21, 2015
transition: concave

Studying the Titanic Disaster
========================================================

- The ship Titanic on its maiden voyage from Southampton UK to New York on 15 April 1912 hit an iceberg and sank. More than 1500 passengers and crew died. 
- There are interesting patterns that are seen when you compare survival rates by gender, age and class of cabin. 
- This interactive app built using the Shiny package in R is designed to analyze the survival patterns by group.

The app has three primary components
- An exploratory function.
- A linear modeling function.
- A hypothesis test of proportions.

Explore
========================================================
The explore function is used for interactive exploratory analysis of the survival data. The number of survivors and deaths for the selected combination of variables are plotted on a histogram plot.

<small>For e.g. to answer the question how many male crew members survived, Crew is selected for Class and Male is selected for Sex and All for Age.  And this plot is shown.</small>
<img src="TitanicSurvival-figure/unnamed-chunk-1-1.png" title="plot of chunk unnamed-chunk-1" alt="plot of chunk unnamed-chunk-1" width="200px" height="300px" />

Model
========================================================
A logistic regression model is fitted with the key predictors, Class, Sex or Age with the Survived variable as the response in order to gauge the odds of survival within the selected group. 

<small>For e.g. these are the odds of survival for male and female passengers. A female passenger has more than ten times(10.14) the odds of a male passenger for survival.  
We use glm for this purpose -   
fit <- glm(Survived~Sex,family=binomial,data=fitdat) </small>


```
(Intercept)   SexFemale 
  0.2690616  10.1469660 
```

Probability
========================================================
In this analysis we compare the proportions of survival within each group to see if there is a significant difference in proportions. The null hypothesis is that the proportions are equal. We use prop.test for this purpose.

<small>For e.g. this compares survival proportions of males and females. The estimate of proportions are given as well as the probability at 95% confidence that the two proportions are equal. Which is this case is virtually zero - 7.565462e-101. </small>


```
$estimate
   prop 1    prop 2 
0.7879838 0.2680851 
```

```
$p.value
[1] 7.565462e-101
```
