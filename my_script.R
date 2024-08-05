library(tidyverse)
library(readxl)

my_data <- read_xlsx("data_bad.xlsx")

first_trial <- filter(my_data, trial == 1)
demographics <- my_data %>%
  select(ID, age, gender) %>%
  filter(age > 10) %>%
  unique()

N_participants <- my_data %>%
  pull(ID) %>%
  unique() %>%
  length()

N_unique_demogs <- my_data %>%
  select(ID, age, gender) %>%
  unique() %>%
  nrow()

stopifnot(N_participants != N_unique_demogs)
