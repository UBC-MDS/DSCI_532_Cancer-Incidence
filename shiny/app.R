library(shiny)
library(tidyverse)
library(leaflet)

# read the clean data file
cancer_df <- read_csv("clean_cancer_data.csv", col_types = "iccccdddd")

# factor columns with characters 
cancer_df %>% 
  mutate(region = as.factor(region)) %>% 
  mutate(age = as.factor(age)) %>%
  mutate(sex = as.factor(sex)) %>% 
  mutate(cancer_type = as.factor(cancer_type))

# refactor ordering of age factors so age group 5-9 is after 0-4
cancer_df$age <- cancer_df$age %>% fct_relevel("0-4", "5-9")

# read in geo spatial data
canada_spatial <- geojson_read("canada_provinces.geojson", what = "sp")

# rename province abbreviations for the map so they match with geo data so they can be merged
cancer_df_map <- cancer_df %>% 
  mutate(region = fct_recode(region,
                             "British Columbia" = "BC",
                             "Newfoundland and Labrador" = "NL",
                             "Northwest Territories" = "NWT",
                             "Nunavut" = "NU",
                             "Saskatchewan" = "SK",
                             "Quebec" = "QC",
                             "Alberta" = "AB",
                             "Manitoba" = "MB",
                             "Nova Scotia" = "NS",
                             "Ontario" = "ON",
                             "New Brunswick" = "NB",
                             "Prince Edward Island" = "PEI",
                             "Yukon" = "YT")) %>%
  data.frame

##### USER INTERFACE
ui <- fluidPage(

  titlePanel("Cancer Incidence in Canada (1992-2015)",
             windowTitle = "Cancer Incidence in Canada"),
   
  # SIDEBAR 
  sidebarLayout(
    sidebarPanel(
      
      # TIME SERIES SIDEBAR PANEL
      # input variables in this panel are identified by '.._time'
      conditionalPanel(condition="input.tabselected==1",
                       # variables in sidebar panel: region, age, gender, cancer type, slider (years)
                       selectInput(inputId = "region_time", 
                                   label = "Choose region:",
                                   sort(unique(cancer_df$region)),
                                   selected = "Canada"),
                       
                      
                       selectInput(inputId = "age_time",
                                   label = "Choose age group:",
                                   sort(unique(cancer_df$age)),
                                   selected = "All"),
                       
                       selectInput(inputId = "gender_time",
                                   label = "Choose gender:",
                                   sort(unique(cancer_df$sex)),
                                   selected = "Both"),
                       
                       selectInput(inputId = "type1_time",
                                   label = "Choose cancer type 1:",
                                   sort(unique(cancer_df$cancer_type)),
                                   selected = "All cancers"),
                       
                       selectInput(inputId = "type2_time",
                                   label = "Choose cancer type 2:",
                                   sort(unique(cancer_df$cancer_type)),
                                   selected = "All cancers"),
                       
                       selectInput(inputId = "type3_time",
                                   label = "Choose cancer type 3:",
                                   sort(unique(cancer_df$cancer_type)),
                                   selected = "All cancers"),
                       
                       sliderInput(inputId = "year_time",
                                   label = "Year range:",
                                   min = 1992,
                                   max = 2015,
                                   value = c(1992,2015),
                                   step = 1,
                                   dragRange = TRUE, # lets user drag the selected range
                                   sep = ""  # gets rid of commas in number formatting
                                   )
                       ), #end of conditional panel for time series
      
      # AGE SIDEBAR PANEL
      # input variables in this panel are identified by '.._age'
      conditionalPanel(condition="input.tabselected==2",
                       
                       selectInput(inputId = "region_age", 
                                   label = "Choose region:",
                                   sort(unique(cancer_df$region)),
                                   selected = "Canada"),
                       
                       selectInput(inputId = "gender_age",
                                   label = "Choose gender:",
                                   sort(unique(cancer_df$sex)),
                                   selected = "Both"),
                       
                       selectInput(inputId = "type_age",
                                   label = "Choose cancer type:",
                                   sort(unique(cancer_df$cancer_type)),
                                   selected = "All cancers"),
                       
                       selectInput(inputId = "year_age",
                                   label = "Choose year:",
                                   choices = list(1995, 2000, 2005, 2010, 2015),
                                   selected = 2000)
                       
                       ),# end of conditional panel for age trend
      
      # MAP SIDEBAR PANEL
      # input variables in this panel are identified by ".._map"
      conditionalPanel(condition="input.tabselected==3",
                       
                       # variables in sidebar panel: age, gender, cancer type, slider (years)
                       selectInput(inputId = "age_map",
                                   label = "Choose age group:",
                                   sort(unique(cancer_df$age)),
                                   selected = "All"),
                       
                       selectInput(inputId = "gender_map",
                                   label = "Choose gender:",
                                   sort(unique(cancer_df$sex)),
                                   selected = "Both"),
                       
                       selectInput(inputId = "type_map",
                                   label = "Choose cancer type:",
                                   sort(unique(cancer_df$cancer_type)),
                                   selected = "All cancers"),
                       
                       selectInput(inputId = "year_map",
                                   label = "Choose year:",
                                   choices = list(1995, 2000, 2005, 2010, 2015),
                                   selected = 2000)

                       ) #end of conditional panel for map
      
      ),  # end of sidebarPanel
      
   # MAIN PANEL
      mainPanel(
        tabsetPanel(
          tabPanel("Cancer rate over time", value = 1, plotOutput(outputId = "time_plot")),
          tabPanel("Cancer rate by age group", value = 2, plotOutput(outputId = "age_plot")),
          tabPanel("Cancer Incidence Map", value = 3, leafletOutput(outputId = "map",height = 400)),
          id = "tabselected"
        ) #end of tabsetPanel
      ) # end of mainPanel
   ) # end of sidebarLayout
)##### END OF UI



##### SERVER
server <- function(input, output) {

  # create a filtered df for time series to avoid copying/paste
  time_filter <- reactive({
    
    # what allows the user to filter the data
    cancer_df %>% 
      filter(region == input$region_time,
             age == input$age_time,
             sex == input$gender_time,
             cancer_type == input$type1_time |
               cancer_type == input$type2_time |
               cancer_type == input$type3_time,
             year >= input$year_time[1],
             year <= input$year_time[2]
      )
  })
  
  # create a filtered df for age trend to avoid copy/paste
  age_filter <- reactive({
    
    # what allows the user to filter the data
    cancer_df %>% 
      filter(region == input$region_age,
             sex == input$gender_age,
             cancer_type == input$type_age,
             year == input$year_age
      )
  })
  
  # create a filtered df for map
  map_filter <- reactive({
    
    # what allows the user to filter the data
    map_data <- cancer_df_map %>% 
      filter(age == input$age_map,
             sex == input$gender_map,
             cancer_type == input$type_map,
             year == input$year_age)
    sp::merge(canada_spatial, map_data, by.x = "name", by.y = "region", duplicateGeoms=TRUE)
  })

  
  # make TIME SERIES plot
  output$time_plot <- renderPlot({

    ggplot(time_filter(), aes(x = year, y = incidence_rate)) +
      geom_line(aes(color = cancer_type), size = 1) +
      geom_point(aes(color = cancer_type), size = 2) +
      theme_bw() +
      scale_x_continuous(breaks = seq(min(time_filter()$year), max(time_filter()$year), by = 1)) +
      labs(color = "cancer type",
           x = "Year",
           y = "Cancer incidence per 100,000")
  })
  
  # make AGE plot
  output$age_plot <- renderPlot({
    
    ggplot(age_filter(), aes(x = age, y = incidence_rate)) +
      geom_col() +
      theme_classic() +
      xlab("Age group") +
      ylab("Cancer incidence per 100,000")
  })
  
  # make MAP
  output$map <- renderLeaflet({
    data_map <- map_filter()
    
    bins <- c(0, 10, 20, 50, 100, 200, 500, 1000, Inf)
    labels <- sprintf(
      "<strong>%s</strong><br/>%g cancer incidence per\n100,000 people",
      data_map$name, data_map$incidence_rate
    ) %>% lapply(htmltools::HTML)

    leaflet() %>%
      setView(-95, 60,  zoom = 3) %>% 
      addTiles() %>% 
      addPolygons(data = data_map,
                  color = "white",
                  weight = 1,
                  opacity = 1,
                  fillOpacity = 0.8,
                  fillColor = ~colorBin("OrRd", incidence_rate, bins = bins)(incidence_rate),
                  highlightOptions = highlightOptions(color = "white", 
                                                      weight = 2.5,
                                                      bringToFront = TRUE),
                  layerId = ~name,
                  label = labels
      ) %>% 
      addLegend(position = "topright", 
                pal = colorBin("OrRd", data_map$incidence_rate, bins = bins), 
                value = data_map$incidence_rate, 
                title = paste("Cancer Incidence per 100,000"))
  })

} ##### END OF SERVER


# Run the application 
shinyApp(ui = ui, server = server)

