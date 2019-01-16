# Makefile for project pipeline
# Rachel K. Riggs & Constantin Shuster, Jan 2019

# This driver script cleans data of cancer incidence in
# Canada and creates a clean csv
# This script takes no arguments.

# example usage:
# to run:
# make all
# to clean:
# make clean

all : shiny/cancer_incidence/clean_cancer_data.csv

# load in data, clean it, and output clean data
shiny/cancer_incidence/clean_cancer_data.csv : src/clean_data.R data/13100111.csv
	Rscript src/clean_data.R data/13100111.csv shiny/Cancer_Incidence/clean_cancer_data.csv

clean :
	rm -f shiny/cancer_incidence/clean_cancer_data.csv
