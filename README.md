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

4. To create the clean data file used in the Shiny app:

  Using the command line, navigate to the root of this project and run the below command:
```
make all
```
5. To clean up:
```
make clean
```
