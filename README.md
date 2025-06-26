# Medical Insurance Costs Analysis

This repository contains my personal project materials and presentations on analyzing medical insurance charges. Below you’ll find everything I did—from data exploration to modeling—and the slides I created for both the EDA and final results.

---

## 📁 What's Inside

- **`medical_insurance_analysis.R`**  
  My complete R script that:
  - Loads the data  
  - Performs exploratory data analysis (scatterplots, pairwise plots, correlation matrix)  
  - Builds and compares multiple linear regression models  
  - Runs AIC-based forward/backward/stepwise selection  
  - Evaluates the final model on a test split

- **`Medical_Insurance_Cost_EDA.pptx`**  
  Slide deck covering the exploratory data analysis phase:
  - Scatter plots (e.g., Age vs. Charges)  
  - Pairwise scatter and correlation plots  
  - Initial insights and data relationships

- **`Medical_Insurance_Cost_Modeling.pptx`**  
  Final presentation with full workflow and findings:
  - EDA recap  
  - Regression model summaries (AIC, BIC, MSE, adjusted R²)  
  - Diagnostic plots and assumption checks  
  - Stepwise selection results  
  - Key takeaways and conclusions

---

## 🎯 Project Summary

- **Goal:** Identify which factors (age, BMI, children, smoker status, etc.) most influence insurance charges.  
- **Data:** Medical insurance dataset (~1,338 records) from Kaggle.  
- **Methods:** EDA, multiple linear regression, and stepwise model selection.  
- **Key Insight:** Smoking status increases annual charges by ~\$24K on average; best model explains ~75% of variance.

---

## 🔍 How to Browse

1. Open the **`Medical_Insurance_Cost_EDA.pptx`** to see my initial exploration of the data.  
2. Review the **`Medical_Insurance_Cost_Modeling.pptx`** for the full modeling process and results.  
3. Inspect **`Medical_Insurance_analysis.R`** if you want to see the exact code and steps I used.

That's it—this repo is a record of my work and findings for this analytics project.
