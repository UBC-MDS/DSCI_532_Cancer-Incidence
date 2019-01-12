# Incidence of Cancer in Canada

By: Rachel Riggs, Constantin Shuster
Date: January 12, 2018

### Project Overview

Cancer is the leading cause of death in Canada, followed by heart disease. It represents close to [30%](https://www150.statcan.gc.ca/n1/pub/82-625-x/2014001/article/11896-eng.htm) of all annual deaths in Canada. However, cancer itself is a heterogenous illness with many different types that afflict the population in different ways. Therefore, in order to improve the health of the Canadian population it would be important to investigate which cancer types afflict the population the most, and whether there are any demographic trends that could be exploited for targeted public health intervention programs such as cancer screening. To aid researchers, physicians and healthcare policymakers in targeting their efforts to reduce the burden of cancer in Canada, we propose to build an interactive data visualization tool that explores cancer incidence in Canada. Using this tool, users will be able to select from various cancer types and view the trend of cancer incidence over time. Users will also be able to filter data by province, gender and age group to aid in the search of any particular demographic trends, such as the association of a particular cancer type with a particular age group, gender, or province.

### Canadian cancer incidence dataset

We will be using a [dataset](https://open.canada.ca/data/en/dataset/e667992c-5f2e-425a-8a44-a880930d82d8) that is maintained by Statistics Canada and publicly available. It contains ~4.9 million entries of epidemiologic statistics on the total number and rates of new primary cancers with 95% confidence interval bounds for incidence rates. Each row in the dataset specifies the year (REF_DATE), province (GEO), age group (21 groups), cancer type (58 types) and statistic type (total incidence, incidence rate, lower/upper bound 95% CI). The dataset spans year 1992 - 2015. Since the dataset is close to 1 gigabyte, our tool will visualize data about the top 10 most and least incident cancers to ensure the tool runs smoothly.

### Usage Scenario
