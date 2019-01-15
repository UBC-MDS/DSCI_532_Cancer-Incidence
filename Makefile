# Makefile for project pipeline

all : shiny/cancer_incidence/clean_cancer_data.csv

shiny/cancer_incidence/clean_cancer_data.csv : data/13100111.csv src/clean_data.R
	Rscript src/clean_data.R data/13100111.csv shiny/cancer_incidence/clean_cancer_data.csv

clean :
	rm -f shiny/cancer_incidence/clean_cancer_data.csv
