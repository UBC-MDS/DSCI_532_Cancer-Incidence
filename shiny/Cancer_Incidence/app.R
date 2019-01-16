library(shiny)
library(tidyverse)

# setwd("~/UBC/BLOCK 4/DSCI_532/DSCI_532_Cancer-Incidence/shiny/cancer_incidence")
cancer_df <-  read_csv("clean_cancer_data.csv")

# temporary filtering to get things working
cancer_df <- cancer_df %>% 
  filter(stat_type == "Cancer incidence")

##### USER INTERFACE
ui <- fluidPage(

  titlePanel("Cancer Incidence in Canada 1992-2015",
             windowTitle = "Cancer Incidence in Canada"),
   
  # SIDEBAR 
  sidebarLayout(
    sidebarPanel(
      # dropdown menus 
      
      # region
      # this variable is specified in the server -- see below
      uiOutput(outputId = "regionOutput"),
      
      # age
      # this variable is specified in the server -- see below
      uiOutput(outputId = "ageOutput"),
      
      # gender
      selectInput(inputId = "genderInput",
                  label = "Choose gender:",
                  choices = list("Both sexes",
                                 "Males",
                                 "Females"
                                 ),
                  selected = "Both sexes"
                  ),
      
      # cancer type
      # this variable is specified in the server -- see below
      uiOutput(outputId = "typeOutput"),
      
      # slider
      # year range
      sliderInput(inputId = "yearInput",
                  label = "Year range:",
                  min = 1992,
                  max = 2015,
                  value = c(1992,2015),
                  step = 1,
                  dragRange = TRUE, # lets user drage the selected range
                  sep = ""  # gets rid of commas in number formatting
                  )
      
    ),  # end of sidebarPanel
      
   # MAIN PANEL
      mainPanel(
        
        plotOutput(outputId = "time_plot")
         # plotOutput("distPlot")
        
      ) # end of mainPanel
   
   ) # end of sidebarLayout
)  ##### END OF UI



##### SERVER
server <- function(input, output) {
  
  # create a filtered object to avoid copying & pasting this code in multiple places
  filtered <- reactive({
    
    # prevent the user from seeing temporary errors while the app initializes
    if (is.null(input$regionInput)) {
      return(NULL)
    }
    if (is.null(input$ageInput)) {
      return(NULL)
    }
    if (is.null(input$typeInput)) {
      return(NULL)
    }
    
    # what allows the user to filter the data
    cancer_df %>% 
      filter(region == input$regionInput,
             age == input$ageInput,
             sex == input$genderInput,
             cancer_type == input$typeInput,
             year >= input$yearInput[1],
             year <= input$yearInput[2]
      )
  })
  
  # the following code allows the app to automatically choose all of the unique
  # region names without having to specify them explicitly in the UI
  output$regionOutput <- renderUI({
    selectInput(inputId = "regionInput", 
                label = "Choose region:",
                sort(unique(cancer_df$region)),
                selected = "Canada"
                )
  })
  
  # the following code allows the app to automatically choose all of the unique
  # age groups without having to specify them explicitly in the UI
  output$ageOutput <- renderUI({
    selectInput(inputId = "ageInput",
                label = "Choose age group:",
                unique(cancer_df$age),
                selected = "Total, all ages"
                )
  })
  
  # the following code allows the app to automatically choose all of the unique
  # cancer types without having to specify them explicitly in the UI
  output$typeOutput <- renderUI({
    selectInput(inputId = "typeInput",
                label = "Choose cancer type:",
                sort(unique(cancer_df$cancer_type)),
                selected = "Total, all primary sites of cancer"
                )
  })
  
  # make the plot based on the filtered data
  output$time_plot <- renderPlot({
    # prevent the user from seeing temporary errors while the app initializes
    if (is.null(filtered())) {
      return()
    }
    
    ggplot(filtered(), aes(x = year, y = VALUE)) +
      geom_line() +
      geom_point()

  })

} ##### END OF SERVER


# Run the application 
shinyApp(ui = ui, server = server)

