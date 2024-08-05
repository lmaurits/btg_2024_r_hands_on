library(tidyverse)

# Read separate data files for participant demographics and responses
my_demogs <- read_csv("data/demogs.csv")
my_responses <- read_csv("data/responses.csv")

# Join the two tibbles into one, using the shared ID column as a key to link
# rows
my_data <- left_join(my_responses, my_demogs, by="ID")

# Quick sanity check - is the number of unique participant IDs equal to the 
# number of unique combinations of (ID, sex, age)?  Stop if not, to catch
# manual data formatting bugs
N_participants <- my_data %>%
  pull(ID) %>%
  unique() %>%
  length()

N_unique_demogs <- my_data %>%
  select(ID, age, gender) %>%
  unique() %>%
  nrow()

stopifnot(N_participants == N_unique_demogs)

# Here we might do other data preparation tasks...

# Save our results to a .csv file which will be read by our analysis script
write_csv(my_data, "data/processed_data.csv")