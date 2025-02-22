install.packages("dplyr")
library(dplyr)

d <- read.csv("Gögn/pisa.csv", stringsAsFactors = FALSE)

d <- d %>% filter(year >= 2003)

d <- d %>% mutate(mean_grade = rowMeans(select(., math, read, science), na.rm = TRUE))

table(d$country)