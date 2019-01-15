#' clean_data.R
#' Group: lab2- 
#' Authors: Rachel K. Riggs, Constantin Shuster
#' Date: January 14, 2018
#' 
#' This script reads in the raw data (.csv) and cleans it.
#' Observations with NA values are removed, not needed columns are removed.
#' Variables are properly renamed, Appropriate data types are applied, factors with long names are renamed
#' The output is .csv file with clean data in tidy form.
#' 
#' Script input args from command line
#' 1. .csv file path for raw data file
#' 2. .csv file path for clean data file
#' 
#' Usage:
#' Rscript src/clean_data.R ../data/raw/13100111.csv ../data/clean/clean_cancer_data.csv
#' ../data/13100111.csv is the path for input data (raw)
#' ../shiny/cancer_incidence/clean_cancer_data.csv is the path for output data (clean)

#' import libraries
suppressPackageStartupMessages(library(tidyverse))

#' Read command line arguments
args <- commandArgs(trailingOnly = TRUE)
input_file <- args[1]
output_file <- args[2]


#' Un-comment below to run in RStudio while building scripts/app
# df <- read_csv("../data/13100111.csv")

#' remove rows where the STATUS = ".." which means there is a missing value for incidence, 
#' do above by filterting to include only STATUS = NA
#' remove columns that are empty or not needed
clean_df <- function(df){
  new_df <- df %>%
    filter(is.na(STATUS)) %>% 
    select( -DGUID, -UOM_ID, -SCALAR_ID, -SCALAR_FACTOR, - VECTOR, -COORDINATE, - STATUS, -SYMBOL, -TERMINATED, -DECIMALS, -UOM) %>% 
    rename(year = REF_DATE, 
           region = GEO, 
           age = `Age group`, 
           sex = Sex, 
           cancer_type = `Primary types of cancer (ICD-O-3)`,
           stat_type = Characteristics)
  
  return(new_df)
}

# make categorical variables into factors
str_var_to_fct <- function(df){
    new_df <- df %>% 
    mutate(region = as.factor(region)) %>% 
    mutate(age = as.factor(age)) %>%
    mutate(sex = as.factor(sex)) %>% 
    mutate(cancer_type = as.factor(cancer_type)) %>% 
    mutate(stat_type = as.factor(stat_type))
    
    return(new_df)
}

# rename levels within factor variables to more appropriate names that are not very long
rename_fct <- function(df){
  # rename levels of stat_type
  new_df <- df %>% 
    mutate(stat_type = fct_recode(stat_type,
                                  "tot_new" = "Number of new cancer cases",
                                  "incidence_rate" = "Cancer incidence",
                                  "95_ci_hi_rate" = "High 95% confidence interval, cancer incidence",
                                  "95_ci_lo_rate" = "Low 95% confidence interval, cancer incidence"))
  
  # rename levels of cancer_type
  new_df <- new_df %>% 
    mutate(cancer_type = fct_recode(cancer_type,
                                    "All cancers" = "Total, all primary sites of cancer",
                                    "AML" = "Acute myeloid leukemia",
                                    "CML" = "Chronic myeloid leukemia",
                                    "ALL" = "Acute lymphocytic leukemia",
                                    "CLL" = "Chronic lymphocytic leukemia",
                                    "Other" = "Other, ill-defined and unknown sites"))
  
  # rename levels of sex
  new_df <- new_df %>% 
    mutate(sex = fct_recode(sex,
                            "Both" = "Both sexes",
                            "M" = "Males",
                            "F" = "Females"))
  
  # rename levels of age
  new_df <- new_df %>% 
    mutate(age = fct_recode(age,
                            "All" = "Total, all ages",
                            "0-4" = "0 to 4 years",
                            "5-9" = "5 to 9 years",
                            "10-14" = "10 to 14 years",
                            "15-19" = "15 to 19 years",
                            "20-24" = "20 to 24 years",
                            "25-29" = "25 to 29 years",
                            "30-34" = "30 to 34 years",
                            "35-39" = "35 to 39 years",
                            "40-44" = "40 to 44 years",
                            "45-49" = "45 to 49 years",
                            "50-54" = "50 to 54 years",
                            "55-59" = "55 to 59 years",
                            "60-64" = "60 to 64 years",
                            "65-69" = "65 to 69 years",
                            "70-74" = "70 to 74 years",
                            "75-79" = "75 to 79 years",
                            "80-84" = "80 to 84 years",
                            "85-89" = "85 to 89 years",
                            "90+" = "90 years and over",
                            "Unknown" = "Age group, not stated"))
  
  # rename levels of region
  new_df <- new_df %>% 
    mutate(region = fct_recode(region,
                               "NL" = "Newfoundland and Labrador",
                               "PEI" = "Prince Edward Island",
                               "NS" = "Nova Scotia",
                               "NB" = "New Brunswick",
                               "ON" = "Ontario",
                               "BC" = "British Columbia",
                               "QC" = "Quebec",
                               "MB" = "Manitoba",
                               "SK" = "Saskatchewan",
                               "AB" = "Alberta",
                               "YT" = "Yukon",
                               "NWT" = "Northwest Territories",
                               "NU" = "Nunavut",
                               "Canada excl. QC" = "Canada (excluding Quebec)"))
  
  return(new_df)
}


main <- function(){
  # Read raw data and call cleaning functions
  clean_df <- suppressMessages(read_csv(input_file)) %>% 
    clean_df() %>% 
    str_var_to_fct() %>% 
    rename_fct()
  
  # write clean .csv file into shiny folder
  write_csv(clean_df, output_file)
}

main()
