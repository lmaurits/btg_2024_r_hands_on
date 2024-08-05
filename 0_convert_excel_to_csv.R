library(tidyverse)
library(readxl)

my_demogs <- read_xlsx("data/data.xlsx", sheet="demogs")
write_csv(my_demogs, "data/demogs.csv")
my_responses <- read_xlsx("data/data.xlsx", sheet="responses")
write_csv(my_responses, "data/responses.csv")
