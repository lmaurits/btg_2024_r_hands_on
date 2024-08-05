library(tidyverse)
library(readxl)

my_data <- read_xlsx("data_bad.xlsx")

first_trial <- filter(my_data, trial == 1)
demographics <- my_data %>%
  select(ID, age, gender) %>%
  filter(age > 10) %>%
  unique()





my_demogs <- read_xlsx("data.xlsx", sheet="demogs")
my_responses <- read_xlsx("data.xlsx", sheet="responses")
my_data <- left_join(my_responses, my_demogs, by="ID")

N_participants <- my_data %>%
  pull(ID) %>%
  unique() %>%
  length()

N_unique_demogs <- my_data %>%
  select(ID, age, gender) %>%
  unique() %>%
  nrow()

stopifnot(N_participants == N_unique_demogs)

m <- glm(response ~ condition + gender + age, data=my_data,
    family="binomial")

my_data <- my_data %>%
  mutate(predictions = predict(m, type="response"))

ggplot(my_data) +
  geom_point(aes(x=age, y=predictions, colour=condition))
