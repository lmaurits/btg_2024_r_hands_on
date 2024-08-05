library(tidyverse)

# Read the processed data
my_data <- read_csv("processed_data.csv")

# Fit a model to the data
# This is a "toy" example but this *could* be a heavy duty data analysis
# which takes hours to run.  And/or it could be a non-deterministic analysis
# (e.g. Bayesian model fit via MCMC) which gives slightly different results
# each time you run it, such that there is still value in having a saved
# value even if you can repeate the analysis in a short time.
m <- glm(response ~ condition + gender + age, data=my_data,
         family="binomial")

# Save the fitted model to an .rds file
write_rds(m, "fitted_model.rds")
