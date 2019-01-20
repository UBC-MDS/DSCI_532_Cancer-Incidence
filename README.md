# DSCI 532 Cancer Incidence

Our goal with this project is to create an interactive visualization of cancer incidence in Canada using [Shiny](https://shiny.rstudio.com/).

### Usage

1. Clone/download this repository
2. Download the dataset from [here](https://open.canada.ca/data/en/dataset/e667992c-5f2e-425a-8a44-a880930d82d8)
    - Press 'Access' for:
        - Resource Type = Dataset
        - Format = CSV
        - Language = English
    - Download the .zip file __*~65 MB*__ into the `/data/raw` folder
3. Extract .zip file contents into `/data` folder
    - *Note: the extracted dataset is __*~1 GB*__
4. Create the `clean_cancer_data` file to be used by Shiny app:
    - If user has 'Make' installed:
         - Navigate to the root of this project using the commmand line and run: `make all`
    - If user doesn't have 'Make' installed:
         - Navigate to the root of this project using the command line and run: 
         `Rscript src/clean_data.R data/13100111.csv shiny/Cancer_Incidence/clean_cancer_data.csv`
    - `clean_cancer_data` should appear in `DSCI_532_Cancer-Incidence/shiny/cancer_incidence/`
5. To remove `clean_cancer_data`:
    - If user has 'Make' installed:
        - Navigate to the root of this project using the commmand line and run: `make clean`
    - If user doesn't have 'Make' installed:
        - Delete file manually from `DSCI_532_Cancer-Incidence/shiny/cancer_incidence/`
