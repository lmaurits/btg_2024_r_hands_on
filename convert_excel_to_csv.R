library(tidyverse)
library(readxl)

my_demogs <- read_xlsx("data.xlsx", sheet="demogs")
write_csv(my_demogs, "demogs.csv")
my_responses <- read_xlsx("data.xlsx", sheet="responses")
write_csv(my_responses, "responses.csv")
