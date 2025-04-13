# 🏥 California Hospital Performance Analysis

A comprehensive data-driven analysis of **California Hospital Inpatient Mortality Rates and Quality Ratings**, leveraging Python, R, and SQL to understand how hospital quality ratings correlate with patient outcomes and geographic patterns. This project combines statistical analysis, exploratory visualization, and basic modeling techniques to derive meaningful healthcare insights.

---

## 📌 Overview

This study investigates:
- The relationship between hospital quality ratings and risk-adjusted mortality rates.
- Identification of hospitals that consistently perform above or below the state average.
- Geographic trends in mortality outcomes using spatial data (latitude and longitude).

---

## ❓ Research Questions

1. Do hospitals with higher quality ratings tend to have lower mortality rates for specific procedures?
2. Are there hospitals in California that consistently have higher or lower mortality rates than the state average?
3. Is there any relationship between a hospital’s geographic location and its risk-adjusted mortality rate?

---

## 🧰 Tools & Technologies

- **Languages:** Python, R, SQL  
- **Libraries:**
  - Python: `pandas`, `numpy`, `seaborn`, `matplotlib`
  - R: `ggplot2`, `dplyr`, `tidyverse`, `stats`
- **Database:** MYSQL
- **Source:** [California Hospital Inpatient Mortality Rates and Quality Ratings Dataset](https://catalog.data.gov/dataset/california-hospital-inpatient-mortality-rates-and-quality-ratings-6815c)

---

## 🧹 Data Cleaning & Feature Engineering

Performed using **Python**:
- Removed missing/invalid values (`NA`, `.`)
- Converted object-type columns to numeric:
  - `Risk Adjusted Mortality Rate`
  - `# of Deaths`, `# of Cases`, `Longitude`, `Latitude`
- Renamed columns for consistent access (replaced spaces with underscores)
- Saved cleaned data as `modified_dataset.csv`

> 🔧 Basic feature engineering was performed. No advanced transformations (like one-hot encoding, scaling, or feature synthesis) were required for this descriptive/statistical study.

---

## 📊 Analytical Techniques Used

### ✅ Exploratory Data Analysis (EDA)
- Histograms for:
  - Hospital Ratings
  - Mortality Rates
  - Procedure Frequencies
- Pivot tables and grouped aggregations
- Visual relationship analysis between hospital rating and procedure-based mortality

### ✅ Statistical Analysis
- Descriptive statistics (mean, std, quartiles)
- Correlation analysis between:
  - Risk-Adjusted Mortality Rate ↔ Hospital Rating
  - Mortality Rate ↔ Geographical coordinates

### ✅ Basic Modeling & Evaluation
- **Simple Linear Regression** (in R):
  - Modeled mortality rate using latitude and longitude
  - Coefficients and **R² score (0.0055)** reported
- The weak R² indicates geography alone does not explain mortality variations

> ⚠️ Advanced predictive modeling (e.g., Logistic Regression, Random Forest, etc.) and model evaluation metrics (MAE, RMSE, F1-score) were **not** part of this analysis scope.

---

## 📈 Key Findings

- 📉 **Hospitals with "Better" or "As Expected" ratings tend to have lower mortality rates**
- 🏥 Some hospitals **consistently outperform or underperform** state-wide averages
- 🌎 Geographic trends show weak correlation with mortality outcomes

---

## 🗂 Project Structure

📁 CaliforniaHospitalAnalysis/ 
├── FinalProject.py # Data cleaning and visualization in Python 
├── FinalProject.Rmd # Statistical modeling and visualizations in R 
├── FinalProject.sql # SQL-based data queries and aggregation 
├── CaliforniaHospitalProject.pdf # Full report in IEEE-style format 
├── modified_dataset.csv # Cleaned dataset used across tools


---

## ⚠️ Limitations

- 📍 Dataset only covers **California hospitals**
- 📄 Data is **self-reported** by hospitals (may include bias or errors)
- 🧬 Lacks **patient-level clinical variables** (e.g., age, comorbidities)
- ⏱ Covers a **limited time range (2016–2021)** and may not reflect recent trends

---

## 📚 References

- [California Hospital Dataset (Data.gov)](https://catalog.data.gov/dataset/california-hospital-inpatient-mortality-rates-and-quality-ratings-6815c)
- [Blackwell et al. (2016) – JAHA](https://www.ahajournals.org/doi/10.1161/JAHA.116.003731)
- [Desai et al. (2018) – JAMA Open](https://doi.org/10.1001/jamanetworkopen.2018.3519)
- [Reistetter et al. (2015) – APMR](https://doi.org/10.1016/j.apmr.2015.02.020)

---

## 🙌 Acknowledgments

This project was created as part of **AIT-580: Data Analytics** at **George Mason University**, under the guidance of **Prof. Alla Webb**.  
Special thanks to the **Department of Health Care Access and Information** for providing open access to this dataset.

---

## ✅ Conclusion

- Strong correlation exists between hospital quality ratings and mortality outcomes.
- Geographic location plays a minor role, but other unobserved factors may be more influential.
- These insights can inform **healthcare policies, patient decisions**, and **hospital improvement initiatives**.

---
