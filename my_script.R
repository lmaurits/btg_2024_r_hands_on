library(tidyverse)
library(readxl)

my_data <- read_xlsx("data_bad.xlsx")

first_trial <- filter(my_data, trial == 1)
demographics <- my_data %>%
  select(ID, age, gender) %>%
  filter(age > 10) %>%
  unique()


                       