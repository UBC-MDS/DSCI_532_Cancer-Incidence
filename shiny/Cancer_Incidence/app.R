library(shiny)
library(tidyverse)

cancer_df <- read.csv("clean_cancer_data.csv", stringsAsFactors = FALSE)
# cancer_df <- read_csv("clean_cancer_data.csv")

# temporary filtering to get things working
cancer_df <- cancer_df %>% 
  filter(stat_type == "incidence_rate")

##### USER INTERFACE
ui <- fluidPage(

  titlePanel("Cancer Incidence in Canada",
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
      # this variable is specified in the server -- see below
      uiOutput(outputId = "genderOutput"),
      
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
                  dragRange = TRUE, # lets user drag the selected range
                  sep = ""  # gets rid of commas in number formatting
                  )
      
    ),  # end of sidebarPanel
      
   # MAIN PANEL
      mainPanel(
        plotOutput(outputId = "time_plot")
      ) # end of mainPanel
   
   ) # end of sidebarLayout
)  ##### END OF UI



##### SERVER
server <- function(input, output) {
  
  # the following code allows the app to automatically choose all of the unique
  # region names without having to specify them explicitly in the UI
  output$regionOutput <- renderUI({
    selectInput(inputId = "regionInput", 
                label = "Choose region:",
                sort(unique(cancer_df$region)),
                selected = "Canada"
    )
  })
  
  # allow the app to automatically choose the unique age groups
  output$ageOutput <- renderUI({
    selectInput(inputId = "ageInput",
                label = "Choose age group:",
                unique(cancer_df$age),
                selected = "All"
    )
  })
  
  # allow the app to automatically choose the unique cancer types
  output$typeOutput <- renderUI({
    selectInput(inputId = "typeInput",
                label = "Choose cancer type:",
                sort(unique(cancer_df$cancer_type)),
                selected = "All cancers"
    )
  })
  
  # allows the app to automatically choose the unique gender groups
  output$genderOutput <- renderUI({
    selectInput(inputId = "genderInput",
                label = "Choose gender:",
                sort(unique(cancer_df$sex)),
                selected = "Both"
    )
  })

  
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

