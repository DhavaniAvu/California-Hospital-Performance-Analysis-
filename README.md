# California-Hospital-Performance-Analysis

## Project Overview:
This project analyzes the dataset of California Hospital Inpatient Mortality Rates and Quality Ratings. The goal is to explore how hospital quality ratings relate to risk-adjusted mortality rates and how geographical location might influence these factors. The analysis aims to shed light on hospital performance and highlight areas for potential improvement.

## Research Questions and Findings:

### 1) Are hospitals with higher quality ratings more likely to have lower risk-adjusted mortality rates for specific procedures or conditions?

#### Analysis: 
Python was used to visualize data for hospital ratings, mortality rates, and specific procedures. The mean risk-adjusted mortality rates were calculated based on the quality ratings.

#### Findings: 
Generally, hospitals with higher quality ratings tend to have lower risk-adjusted mortality rates. However, some highly-rated hospitals exhibit higher mortality rates for certain procedures.

### 2) Do any hospitals in California consistently have higher or lower mortality rates than the statewide average for specific procedures or conditions?

#### Analysis: 
R was used to filter the dataset for California hospitals and compare the average risk-adjusted mortality rates for each procedure/condition against the statewide averages.

####  Findings: 
Certain hospitals consistently show higher or lower mortality rates compared to the state average. Plots reveal the distribution of hospitals by their comparison category.

### 3) Is there a relationship between a hospital's geographical location and its risk-adjusted mortality rate for specific procedures or conditions?

#### Analysis: 
R was employed to create scatterplots and regression models to examine the relationship between hospital location (latitude and longitude) and risk-adjusted mortality rates.

#### Findings:
A weak correlation was found between geographical location and mortality rates. Regression analysis indicates a statistically significant relationship, though with a low R-squared value.

## Tools and Technologies Used:

### Programming Languages: 
Python, R, SQL
### Data Manipulation and Analysis:
pandas, numpy

### Data Visualization: 
matplotlib, seaborn

### Statistical Analysis: 
scipy, statsmodels

### Regression Analysis: 
R regression models

## Insights:
The analysis shows a correlation between hospital quality ratings and risk-adjusted mortality rates, with higher-rated hospitals generally having lower mortality rates. However, there are exceptions. The geographical location of hospitals shows only a weak correlation with mortality rates. The results highlight the need to consider additional factors beyond location and quality ratings when evaluating hospital performance.


## REFER THE PDF FOR PAPER OF THIS PROJECT AND OTHER CODE FILES AND CSV FILE FOR CODING AND ANALYSIS REVIEW.

