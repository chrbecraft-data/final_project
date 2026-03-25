#Libraries
library(readr)
library(dplyr)

#Read in data from project directory 
here::i_am("code/00_clean_data.R")
absolute_path_to_data <- here::here("drug_consumption.data")
data <- read_csv("drug_consumption.data", col_names = FALSE)

#Rename columns 
data_clean <- rename(data, 
                     "id" = "X1", "age" = "X2","gender" = "X3",
                     "education" = "X4", "country" = "X5", "ethnicity" = "X6", 
                     "nscore" = "X7", "escore" = "X8", "oscore" = "X9", 
                     "ascore" = "X10", "cscore" = "X11", "impulsive" = "X12", 
                     "ss" = "X13", "alcohol" = "X14", "amphet" = "X15", 
                     "amyl" = "X16", "benzos" = "X17", "caff" = "X18", 
                     "cannabis" = "X19", "choc" = "X20", "coke" = "X21", 
                     "crack" = "X22", "ecstasy" = "X23", "heroin" = "X24", 
                     "ketamine" = "X25", "legalh" = "X26", "lsd" = "X27", 
                     "meth" = "X28", "mushrooms" = "X29", "nicotine" = "X30", 
                     "semer" = "X31", "vsa" = "X32")

#Recode drug response values
data_clean <- data_clean |>
  mutate(across(alcohol : vsa,
                ~ recode(., 
                         "CL0" = "Never used",
                         "CL1" = "Used over a decade ago",
                         "CL2" = "Used in last decade",
                         "CL3" = "Used in last year", 
                         "CL4" = "Used in last month", 
                         "CL5" = "Used in last week", 
                         "CL6" = "Used in last day"
                )
  ))

#Recode demographic values
data_clean <- data_clean |>
  mutate(
    age = recode(age,
                 "-0.95197" = "18-24",
                 "-0.07854" = "25-34",
                 "0.49788" = "35-44",
                 "1.09449"  = "45-54", 
                 "1.82213" = "55-64", 
                 "2.59171" = "65+"),
    gender = recode(gender, 
                    "0.48246" = "Female", 
                    "-0.48246" = "Male"), 
    education = recode(education, 
                       "-2.43591" = "Left school before 16 years", 
                       "-1.73790" = "Left school at 16 years", 
                       "-1.43719" = "Left school at 17 years", 
                       "-1.22751" = "Left school at 18 years", 
                       "-0.61113" = "Some college or university, no certificate or degree", 
                       "-0.05921" = "Professional certificant/diploma", 
                       "0.45468" = "University degree", 
                       "1.16365" = "Masters degree", 
                       "1.98437" = "Doctorate degree"), 
    country = recode(country, 
                     " -0.09765" = "Australia", 
                     "0.24923" = "Canada", 
                     "-0.46841" = "New Zealand", 
                     "-0.28519" = "Other", 
                     " 0.21128" = "Republic of Ireland", 
                     "0.96082" = "UK", 
                     "-0.57009" = "USA"), 
    ethnicity = recode(ethnicity, 
                       "-0.50212" = "Asian", 
                       "-1.10702" = "Black", 
                       " 1.90725" = "Mixed-Black/Asian", 
                       "0.12600" = "Mixed White/Asian", 
                       "-0.22166" = "Mixed-White/Black", 
                       "0.11440" = "Other", 
                       "-0.31685" = "White")
  )

#Remove personality columns for simplicity 
data_clean <- data_clean |> select(-(nscore : ss))

#Save clean data to use later
saveRDS(
  data_clean, 
  file = here::here("output/data_clean.rds")
)