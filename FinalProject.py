#!/usr/bin/env python
# coding: utf-8

# In[2]:


import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

# Read the dataset from a csv file
df = pd.read_csv("My_Data_Set.csv", encoding='ISO-8859-1')

# Print the structure of the dataset
print(df.info())


# In[3]:


# decribe the summary of the dataset
print(df.describe(include='all'))


# In[4]:


# Calculate the middle index
middle_index = len(df) // 2
print("No of total rows" , len(df))
print()

# Display the middle 10 rows of the dataset
print(df.iloc[middle_index - 5 : middle_index + 5])


# In[5]:


print("Before modifications:", df.shape, "  ", end ="")
# drop rows with empty cells or "."
df = df.dropna(subset=['Risk Adjuested Mortality Rate', 
                       '# of Deaths', '# of Cases','Hospital Ratings'], how='any')
df = df[~df.isin(['.']).any(axis=1)]
print("After modifications:", df.shape)
print()

# Display the middle 10 rows of the dataset
# Display the middle 10 rows of the dataset
print(df.iloc[middle_index - 5 : middle_index + 5])


# In[6]:


# Print the structure of the dataset
print(df.info())

Though the Risk Adjuested Mortality Rate , # of Deaths, # of Cases, LONGITUDE, LATITUDE variables are numeric but they are considered as object. So change the data type for further analysis 
# In[7]:


# Convert required columns to numeric
df['Risk Adjuested Mortality Rate'] = pd.to_numeric(
    df['Risk Adjuested Mortality Rate'], errors='coerce')
df['# of Deaths'] = pd.to_numeric(df['# of Deaths'], errors='coerce')
df['# of Cases'] = pd.to_numeric(df['# of Cases'], errors='coerce')
df['LONGITUDE'] = pd.to_numeric(df['LONGITUDE'], errors='coerce')
df['LATITUDE'] = pd.to_numeric(df['LATITUDE'], errors='coerce')


# In[8]:


# Save the modified dataset as a new CSV file
df.to_csv('modified_dataset.csv', index=False)
print("Saved the modifications")


# In[9]:


# Print the column names
print(df.columns)

# Replace spaces with underscores in column names
df.columns = df.columns.str.replace(" ", "_")

# Print the modified column names
print(df.columns)


# In[10]:


# Histogram of quality ratings
sns.histplot(df['Hospital_Ratings'], bins=10)
plt.xlabel('Hospital_Ratings')
plt.ylabel('Count')
plt.title('Histogram of Quality Ratings')
plt.show()


# In[11]:


# Histogram of risk-adjusted mortality rates
sns.histplot(df['Risk_Adjuested_Mortality_Rate'], bins=10)
plt.xlabel('Risk_Adjuested_Mortality_Rate')
plt.ylabel('Count')
plt.title('Histogram of Risk-Adjusted Mortality Rates')
plt.show()


# In[12]:


# plot of quality ratings by procedure/condition
sns.histplot(df['Procedure/Condition'], bins=10)
plt.xlabel('Procedure/Condition')
plt.xticks(rotation=90)
plt.ylabel('Count')
plt.title('Histogram of Risk-Adjusted Mortality Rates')
plt.show()


# In[16]:


# Filter the relevant columns
data = df[["HOSPITAL", "Procedure/Condition", 
           "Risk_Adjuested_Mortality_Rate", "Hospital_Ratings"]]

# Group the data by hospital and procedure/condition, 
# and calculate the mean mortality rate for each group
grouped_data = data.groupby(
    ["HOSPITAL", "Procedure/Condition"]).mean().reset_index()

# Join the grouped data with the hospital ratings
joined_data = pd.merge(grouped_data, data[
    ["HOSPITAL", "Hospital_Ratings"]].drop_duplicates(), on="HOSPITAL")

# Filter out rows with null or "None" values in the "Hospital_Ratings" column
joined_data = joined_data[(joined_data["Hospital_Ratings"].notnull()) &
                          (joined_data["Hospital_Ratings"] != "None")]

# Calculate the mean mortality rate for hospitals with each rating
mean_rates = joined_data.groupby(
    "Hospital_Ratings")["Risk_Adjuested_Mortality_Rate"].mean()

# Print the results
print(mean_rates)


# In[19]:


# Filter the data to include only relevant columns and rows
filtered_data = data[['Procedure/Condition', 
                     'Risk_Adjuested_Mortality_Rate', 'Hospital_Ratings']]

# Exclude rows where Hospital_Ratings is None
filtered_data = filtered_data[filtered_data['Hospital_Ratings'] != 'None']

# Group the data by hospital ratings 
# and calculate mean risk-adjusted mortality rate for each procedure/condition
grouped_data = filtered_data.groupby(
   ['Hospital_Ratings', 'Procedure/Condition']).mean()

# Plot the results
fig, ax = plt.subplots(figsize=(12, 8))
grouped_data.unstack().plot(ax=ax, kind='bar')
plt.legend(title='Procedure/Condition')
plt.ylabel('Mean Risk-Adjusted Mortality Rate')
plt.xlabel('Hospital Ratings')
plt.title('Relationship b/w Hospital Ratings and Risk-Adjusted Mortality Rates')
plt.show()


# In[226]:


data= df

# Extract unique cells from a column
procedures = data["Procedure/Condition"].unique() # List of procedures/conditions
hospitals = data[data["Procedure/Condition"].isin(procedures)]


# Filter the hospitals based on their quality ratings
quality_ratings = ["Better", "As Expected", "Worse"] # List of quality ratings
hospitals = hospitals[hospitals["Hospital_Ratings"].isin(quality_ratings)]

# Calculate the mean risk-adjusted mortality rates for each combination of procedure/condition and quality rating
result = hospitals.groupby(["Procedure/Condition", "Hospital_Ratings"])["Risk_Adjuested_Mortality_Rate"].mean()

# Pivot the data to get mean risk-adjusted mortality rates for each combination of procedure/condition and quality rating
pivot_table = pd.pivot_table(hospitals, values="Risk_Adjuested_Mortality_Rate", index="Procedure/Condition", columns="Hospital_Ratings", aggfunc=np.mean)

print(pivot_table)

Based on the output of the code, we can see that hospitals with higher quality ratings are generally associated with lower risk-adjusted mortality rates for specific procedures/conditions. This can be observed from the fact that the "As Expected" and "Better" mortality rates are generally lower for hospitals with higher quality ratings, while the "Worse" mortality rates are generally higher for hospitals with lower quality ratings. However, this is not always the case, as there are some exceptions where hospitals with higher quality ratings have higher mortality rates for certain procedures/conditions, such as "Acute Stroke Subarachnoid". Overall, we can say that there is a correlation between hospital quality ratings and risk-adjusted mortality rates for specific procedures/conditions
# In[ ]:




