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
      
      # Time series sidebar panel
      conditionalPanel(condition="input.tabselected==1",
                       # variables in sidebar panel: region, age, gender, cancer type, slider (years)
                       uiOutput(outputId = "regionOutput"),
                       uiOutput(outputId = "ageOutput"),
                       uiOutput(outputId = "genderOutput"),
                       uiOutput(outputId = "typeOutput"),
                       sliderInput(inputId = "yearInput",
                                   label = "Year range:",
                                   min = 1992,
                                   max = 2015,
                                   value = c(1992,2015),
                                   step = 1,
                                   dragRange = TRUE, # lets user drag the selected range
                                   sep = ""  # gets rid of commas in number formatting
                                   )
                       ),
      # trend sidebar panel
      conditionalPanel(condition="input.tabselected==2",
                       uiOutput(outputId = "varOutput"),
                       uiOutput(outputId = "typeOutput2")
                       )
    ),  # end of sidebarPanel
      
   # MAIN PANEL
      mainPanel(
        tabsetPanel(
          tabPanel("Time series", value = 1, plotOutput(outputId = "time_plot")),
          tabPanel("Trend", value = 2, plotOutput(outputId = "trend_plot")),
          id = "tabselected"
        )
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

  #### TREND GRAPH SIDE PANEL #####
  # select trend variable
  output$varOutput <- renderUI({
    selectInput(inputId = "varInput",
                label = "Choose variable:",
                choices = list("Age", "Gender", "Region")
                )
  })
  
  # select cancer type
  output$typeOutput2 <- renderUI({
    selectInput(inputId = "typeInput2",
                label = "Choose cancer type:",
                sort(unique(cancer_df$cancer_type)),
                selected = "All cancers"
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
      geom_point() +
      theme_bw() +
      theme(panel.grid = element_blank()) +
      ylab("Cancer incidence per 100,000") +
      xlab("Year")

  })
  
  # make TREND plot
  output$trend_plot <- renderPlot({
    
    # prevent the user from seeing temporary errors while the app initializes
    if (is.null(filtered())) {
      return()
    }
    
    age_df <- cancer_df %>% 
      filter(region == "BC",
             sex == "Both",
             year == 2000,
             cancer_type == input$typeInput2)
    
    ggplot(age_df, aes(x = age, y = VALUE)) +
      geom_line() +
      geom_point() +
      xlab("Age") +
      ylab("Cancer incidence per 100,000")
  })
  


} ##### END OF SERVER


# Run the application 
shinyApp(ui = ui, server = server)

