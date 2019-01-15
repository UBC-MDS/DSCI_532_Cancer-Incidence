# Makefile for project pipeline

all : data/clean/clean_cancer_data.csv

data/clean/clean_cancer_data.csv : data/raw/13100111.csv src/clean_data.R
	Rscript src/clean_data.R data/raw/13100111.csv data/clean/clean_cancer_data.csv

clean :
	rm -f data/clean/clean_cancer_data.csv
