library(tidyverse)

my_demogs <- read_csv("demogs.csv")
my_responses <- read_csv("responses.csv")
my_data <- left_join(my_responses, my_demogs, by="ID")

write_csv(my_data, "processed_data.csv")