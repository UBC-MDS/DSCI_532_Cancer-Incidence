library(tidyverse)
library(forcats)

df <- read_csv("data/raw/13100111.csv")

# remove columns that are empty or not needed
# remove rows where the STATUS = .. which means there is a missing value for incidence
clean_df <- df %>%
  filter(is.na(STATUS)) %>% 
  select( -DGUID, -UOM_ID, -SCALAR_ID, -SCALAR_FACTOR, - VECTOR, -COORDINATE, -SYMBOL, -TERMINATED) %>% 
  rename(year = REF_DATE, 
         region = GEO, 
         age = `Age group`, 
         sex = Sex, 
         cancer_type = `Primary types of cancer (ICD-O-3)`,
         stat_type = Characteristics)

write_csv(clean_df, "data/clean/clean_cancer_data.csv")
