# medical_insurance_analysis.R
# Analyse drivers of medical insurance charges:
#  • EDA (scatterplots, correlation)
#  • Multiple linear regression models
#  • Model comparison (AIC, BIC, MSE, adj. R²)
#  • Stepwise selection

# Setup
library(tidyverse)  # for data manipulation and plotting
install.packages("MASS")
library(MASS)        # for stepAIC()
install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)  # for chart.Correlation()

# Load data into R
insurance_data <- read.csv("medical_insurance.csv")

# EDA: Selected variables and scatterplots
selected_variables <- insurance_data[, c("age", "bmi", "children", "charges")]
pairs(selected_variables)
chart.Correlation(selected_variables, histogram = TRUE, pch = 19)
cor(selected_variables)

# Scatter Plot: Age vs Charges
ggplot(insurance_data, aes(x = age, y = charges)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", color = "blue") +
  labs(title = "Scatter Plot of Age vs. Charges", x = "Age", y = "Charges") +
  theme_minimal()

# Prepare data: convert smoker to numeric flag
insurance_data$smoker_numeric <- ifelse(insurance_data$smoker == "yes", 1, 0)

# Train/test split\set.seed(123)
index <- sample(nrow(insurance_data), nrow(insurance_data) * 0.90)
insurance.train <- insurance_data[index, ]
insurance.test <- insurance_data[-index, ]

# Model 1: age, bmi, smoker
model_1 <- lm(charges ~ age + bmi + smoker_numeric, data = insurance_data)
summary_model_insurance <- summary(model_1)
print(summary_model_insurance)
cat("Adjusted R²:", summary_model_insurance$adj.r.squared, "\n")
cat("Residual Std Error:", summary_model_insurance$sigma, "\n")
cat("Residual Variance:", summary_model_insurance$sigma^2, "\n")
cat("AIC:", AIC(model_1), "BIC:", BIC(model_1), "MSE:", mean(resid(model_1)^2), "\n")

# Model diagnostics
plot(model_1$fitted.values, model_1$residuals, col = "blue")
abline(0, 0, col = "red")
par(mfrow = c(2, 2))
plot(model_1)

# Model 2: all predictors
model_2 <- lm(charges ~ ., data = insurance_data)
summary(model_2)
cat("AIC:", AIC(model_2), "BIC:", BIC(model_2), "MSE:", mean(resid(model_2)^2), "\n")

# Model 3: drop sex and region
model_3 <- lm(charges ~ . - sex - region, data = insurance_data)
summary(model_3)
cat("AIC:", AIC(model_3), "BIC:", BIC(model_3), "MSE:", mean(resid(model_3)^2), "\n")

# Stepwise selection
ullmodel <- lm(charges ~ 1, data = insurance.train)
fullmodel <- lm(charges ~ ., data = insurance.train)

# Forward selection
model.step.f <- step(nullmodel, scope = list(lower = nullmodel, upper = fullmodel), direction = 'forward')
summary(model.step.f)

# Backward elimination
model.step.b <- step(fullmodel, direction = 'backward')
summary(model.step.b)

# Stepwise both\ nmodel.step.s <- step(nullmodel, scope = list(lower = nullmodel, upper = fullmodel), direction = 'both')
summary(model.step.s)

# Evaluate on test set
best_mod <- model.step.s
preds <- predict(best_mod, insurance.test)
cat("Test MSE of best model:", mean((insurance.test$charges - preds)^2), "\n")
