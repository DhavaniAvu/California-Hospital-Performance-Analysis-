---
title: "R Notebook"
output: html_notebook
---

```{r}
library(tidyverse)
library(readr)
library(ggplot2)

```

```{r}
# Read in the dataset
california_hospitals <- read_csv("/Users/dhavani/Downloads/modified_dataset.csv")
str(california_hospitals)
```

```{r}
# Summary statistics for modified_dataset
summary(california_hospitals)
```

```{r}
# view the original column names
colnames(california_hospitals)
```

```{r}
# replace spaces with underscores in column names
colnames(california_hospitals) <- gsub(" ", "_", colnames(california_hospitals))
# replace spaces with underscores in column names
colnames(california_hospitals) <- gsub("/", "Or", colnames(california_hospitals))
# replace spaces with underscores in column names
colnames(california_hospitals) <- gsub("#", "No", colnames(california_hospitals))
```

```{r}
# view the updated column names
colnames(california_hospitals)
```
```{r message=FALSE, warning=FALSE}
# Create visualizations for YEAR
ggplot(california_hospitals, aes(x = YEAR)) +
  geom_histogram() +
  labs(x = "Year", y = "Count", title = "Distribution of Year")

```
```{r}
ggplot(california_hospitals, aes(x = COUNTY)) + 
  geom_bar(fill = "red") + 
  labs(x = "County", y = "Count", title = "Distribution of County") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
```
```{r}
ggplot(california_hospitals, aes(x = ProcedureOrCondition)) +
  geom_bar(fill = "9999FF") +
  labs(x = "Procedure/Condition", y = "Count", title = "Distribution of Procedure/Condition")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
```
```{r message=FALSE, warning=FALSE}
ggplot(california_hospitals, aes( x = Risk_Adjuested_Mortality_Rate)) +
  geom_histogram(fill = "blue") +
  labs(x ="Risk_Adjuested_Mortality_Rate", title ="Distribution of Risk_Adjuested_Mortality_Rate")
```

```{r}
library(cowplot)
# plot for Risk_Adjuested_Mortality_Rate <= 50
plot1 <- ggplot(california_hospitals[!is.na(california_hospitals$Risk_Adjuested_Mortality_Rate) & california_hospitals$Risk_Adjuested_Mortality_Rate <= 50,], 
                aes(x = Risk_Adjuested_Mortality_Rate)) +
  geom_histogram(binwidth = 1, fill = "blue", alpha = 0.5) +
  scale_x_continuous(breaks = seq(0, 50, 5)) +
  labs(x = "Morality Rate (<= 50)", y = "Count", title = "Distribution of Morality Rate") +
  theme_bw()

# plot for Risk_Adjuested_Mortality_Rate > 50
plot2 <- ggplot(california_hospitals[!is.na(california_hospitals$Risk_Adjuested_Mortality_Rate) & california_hospitals$Risk_Adjuested_Mortality_Rate > 50,], 
                aes(x = Risk_Adjuested_Mortality_Rate)) +
  geom_histogram(binwidth = 1, fill = "blue", alpha = 0.5) +
  scale_x_continuous(breaks = seq(50, 100, 5)) +
  labs(x = "Morality Rate (> 50)", y = "Count", title = "Distribution of Morality Rate") +
  theme_bw()


plot_grid(plot1, plot2, ncol = 2, align = "h")
```

Question 2

```{r}
# Read in the dataset
hospital_data <- california_hospitals
ca_hospitals <- subset(hospital_data, COUNTY != "AAAA")

# Calculate the average risk-adjusted mortality rate for each procedure/condition
ca_avg_mortality <- aggregate(Risk_Adjuested_Mortality_Rate ~ ProcedureOrCondition,
                              data = ca_hospitals, FUN = mean)

ca_avg_mortality

```
We can create a bar plot to show the average risk-adjusted mortality rate for each procedure/condition. This will give us an overview of which procedures/conditions tend to have higher or lower mortality rates overall.

```{r}

#Bar plot of average mortality rates by procedure/condition
ggplot(ca_avg_mortality, aes(x = ProcedureOrCondition, 
                             y = Risk_Adjuested_Mortality_Rate)) +
  geom_bar(stat = "identity", fill = "orange") +
  xlab("Procedure/Condition") +
  ylab("Average Risk-Adjusted Mortality Rate") +
  ggtitle("Average Mortality Rates by Procedure/Condition in California Hospitals")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
```

```{r}
# Merge the average mortality rates with the hospital data
ca_hospitals <- merge(ca_hospitals, ca_avg_mortality, 
                      by = "ProcedureOrCondition", suffixes = c("", ".statewide"))

```

Scatter plot of hospital mortality rates vs. statewide average mortality rates
We can create a scatter plot to compare each hospital's risk-adjusted mortality rate for a given procedure/condition with the statewide average for that procedure/condition. This will allow us to see which hospitals have higher or lower mortality rates than the statewide average, and how far away they are from the average.


```{r}
ggplot(ca_hospitals, aes(x = Risk_Adjuested_Mortality_Rate.statewide, y = Risk_Adjuested_Mortality_Rate)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "red") +
  xlab("Statewide Average Risk-Adjusted Mortality Rate") +
  ylab("Hospital Risk-Adjusted Mortality Rate") +
  ggtitle("Hospital Mortality Rates vs. Statewide Average by Procedure/Condition in California") +
  facet_wrap(~ ProcedureOrCondition, ncol = 3, scales = "free")

```


```{r}

# Create a new column to indicate if the hospital has a higher 
#or lower mortality rate than the statewide average
ca_hospitals$Mortality.Rate.Comparison <- 
  ifelse(
    ca_hospitals$Risk_Adjuested_Mortality_Rate > 
      ca_hospitals$Risk_Adjuested_Mortality_Rate.statewide, "Higher", ifelse(ca_hospitals$Risk_Adjuested_Mortality_Rate <                                                                ca_hospitals$Risk_Adjuested_Mortality_Rate.statewide, "Lower", "Average"))

# Print the hospitals that have consistently higher or
#lower mortality rates than the statewide average for a particular procedure/condition
consistent_hospitals <- subset(ca_hospitals, 
                               Mortality.Rate.Comparison != "Average")


```

```{r}
ggplot(ca_hospitals, aes(x = ProcedureOrCondition, 
                         fill = Mortality.Rate.Comparison)) +
  geom_bar() +
  xlab("Procedure/Condition") +
  ylab("Number of Hospitals") +
  ggtitle(
    "Distribution of Hospitals by Mortality Rate Comparison in California") +
  facet_wrap(~ Mortality.Rate.Comparison, ncol = 1, scales = "free_y") +
  scale_fill_manual(values = c("Higher" = "darkred", 
                               "Lower" = "seagreen", "Average" = "gray"))+  theme(axis.text.x = element_text(angle = 90, hjust = 1))


```
These plots provide a visual summary of the results we obtained earlier. We can see that some procedures/conditions, tend to have higher mortality rates overall, while others, tend to have lower mortality rates. We can also see that there are some hospitals that consistently have higher or lower mortality rates than the statewide average for a given procedure/condition, while others are closer to the average.

Question 3

To analyze the relationship between the geographical location of a hospital and its risk-adjusted mortality rate for specific procedures/conditions, we can start by creating a scatterplot.

First import required libraries Next, we can filter the data to only include the necessary columns for our analysis, and remove any rows with missing latitude or longitude data:


```{r}
# Load necessary libraries
library(ggplot2)
library(dplyr)
library(ggplot2)
library(tidyr)
library(lmtest)

hospital_data <- california_hospitals

relevant_data <- hospital_data[, c("COUNTY", "HOSPITAL",
                                   "ProcedureOrCondition",
                                   "Risk_Adjuested_Mortality_Rate",
                                   "LONGITUDE", "LATITUDE")]

relevant_data <- relevant_data[!is.na(relevant_data$LONGITUDE)
                               & !is.na(relevant_data$LATITUDE), ]

```

Now, we can create a scatterplot using ggplot2, with longitude and latitude on the x and y axes, respectively, and risk-adjusted mortality rate represented by color:

```{r}
ggplot(data = relevant_data, aes(x = LONGITUDE, y = LATITUDE,
                                 color = Risk_Adjuested_Mortality_Rate)) + 
  geom_point() +
  labs(title = "Relationship between Hospital Location 
       and Risk-Adjusted Mortality Rate", 
       x = "Longitude", y = "Latitude",
       color = "Risk-Adjusted Mortality Rate")

```
The resulting plot will show whether there is any relationship between hospital location and risk-adjusted mortality rate, with higher mortality rates represented by darker colors.

In addition to the scatterplot, we can also calculate the correlation coefficient between latitude/longitude and risk-adjusted mortality rate using the cor() function

This will give us a numeric value for the correlation, with positive values indicating a positive correlation (i.e., higher mortality rates in areas with higher latitude/longitude values) and negative values indicating a negative correlation (i.e., higher mortality rates in areas with lower latitude/longitude values).

```{r}
cor(relevant_data[c("LONGITUDE", "LATITUDE")], 
    relevant_data$Risk_Adjuested_Mortality_Rate)
```

Based on the correlation output you provided, it appears that there is a weak correlation between the geographical location of a hospital and its risk-adjusted mortality rate for specific procedures/conditions. The correlation coefficient for longitude and risk-adjusted mortality rate is negative, indicating a very weak negative relationship, while the correlation coefficient for latitude and risk-adjusted mortality rate is positive, indicating a very weak positive relationship.

Now lets build a regression model for further analysis 

```{r}

# Filter for specific procedure/condition
my_procedure <- "AMI"
# You can replace this with any other procedure/condition
filtered_data <- hospital_data %>%
  filter(`ProcedureOrCondition` == my_procedure)

# Remove rows with missing location data
filtered_data <- filtered_data %>%
  drop_na(LONGITUDE, LATITUDE)

# Run linear regression model
model <- lm(Risk_Adjuested_Mortality_Rate ~ LONGITUDE + LATITUDE,
            data = filtered_data)

# Check model assumptions
plot(model)

```

```{r}
# Check model significance
summary(model)
```

Based on the output of the regression model, we can conclude that there is a statistically significant relationship between the geographical location of a hospital (latitude and longitude) and its risk-adjusted mortality rate for specific procedures/conditions.

The coefficients for both longitude and latitude are positive, indicating that as the longitude and latitude of a hospital increase, its risk-adjusted mortality rate also tends to increase.

However, it is important to note that the R-squared value for the model is very low (0.005545), meaning that only a small percentage of the variation in risk-adjusted mortality rate can be explained by longitude and latitude. Therefore, other factors beyond geographical location may also play a significant role in determining a hospital's risk-adjusted mortality rate.

Overall, these analyses can provide insight into whether there is any relationship between hospital location and risk-adjusted mortality rate for specific procedures/conditions.
