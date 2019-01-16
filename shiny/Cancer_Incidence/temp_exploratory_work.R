cancer_df <- read_csv("clean_cancer_data.csv")
cancer_df <- read.csv("clean_cancer_data.csv", stringsAsFactors = FALSE)

print(str(cancer_df))

head(cancer_df)
colnames(cancer_df)

unique(cancer_df$region)
unique(cancer_df$age)
unique(cancer_df$sex)
unique(cancer_df$cancer_type)
unique(cancer_df$stat_type)
min(cancer_df$year)
max(cancer_df$year)

head(cancer_df[cancer_df$sex == "Both",])
head(cancer_df[cancer_df$sex == "M",])
head(cancer_df[cancer_df$sex == "F",])

# ggplot(cancer_df, aes(x = year, y = ))


# cancer_rate_subset <- cancer_df %>% 
#   filter(UOM == "Rate per 100,000 population")
# 
# cancer_count_subset <- cancer_df %>% 
#   filter(UOM == "Number")


dim(cancer_rate_subset)
dim(cancer_count_subset)
dim(cancer_df)


ggplot(cancer_df, aes(x = year, y = VALUE)) +
  geom_line()


filter_test1 <- cancer_df %>% 
  filter(region == "ON",
         age == "All",
         sex == "F",
         cancer_type == "Stomach",
         stat_type == "incidence_rate")


filter_test2 <- cancer_df %>% 
  filter(region == "ON",
         age == "All",
         sex == "F",
         cancer_type == "Stomach")


dim(filter_test1)
dim(filter_test2)

ggplot(filter_test1, aes(x = year, y = VALUE)) +
  geom_point() +
  geom_line()

# ggplot(filter_test2, aes(x = year, y = VALUE)) +
#   geom_line()







