library(tidyverse)

my_data <- read_csv("processed_data.csv")
m <- glm(response ~ condition + gender + age, data=my_data,
         family="binomial")
write_rds(m, "fitted_model.rds")
