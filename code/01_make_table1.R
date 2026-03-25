here::i_am("code/01_make_table1.R")

#Read in clean data  
data <- readRDS(
  file = here::here("output/data_clean.rds")
)

#Libraries
library(gtsummary)
library(labelled)

#Format nice labels for table
var_label(data) <- list(age = "Age", 
                        gender = "Gender", 
                        education = "Education", 
                        country = "Country", 
                        ethnicity = "Ethnicity")
#Create table1
table1 <- data |> 
  tbl_summary(by = coke, 
              include = c(age, gender, education, country, ethnicity, coke)) |>
  add_overall() |>
  modify_spanning_header(c("stat_1", "stat_2", "stat_3", "stat_4", "stat_5", "stat_6", "stat_7") ~ "**Cocaine Usage**")

#Save table1 for report
saveRDS(
  table1,
  file = here::here("output/table1.rds")
)