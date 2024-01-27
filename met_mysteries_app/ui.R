
# Define UI for application

fluidPage(
    
    # overall title
    titlePanel("Nashville Temperature Analysis 1899-2023"),
    
    # page 1
    tabsetPanel(
        tabPanel("Year Over Year Comparison",
                 multiInput(
                     inputId = "year", label = "Year:",
                     choices = year_choices,
                     selected = min(year_choices)
                 ),
                 
                 # Show a plot of the generated distribution
                 mainPanel(
                     fluidRow(
                         plotOutput("linePlot")
                     ),
                     fluidRow(
                         plotOutput("linePlot2")
                     )
                 )
        ),
        tabPanel("Temperature Difference from Mean",
                 sliderInput(
                     "slideryear",
                     "Select a year:",
                     min = min(year_choices),
                     max = max(year_choices),
                     value = c(min(year_choices), max(year_choices)),
                     sep = "",
                     dragRange = TRUE),
                 
                 selectInput("focus_year", 
                             label = "Select focus year:", 
                             choices = year_choices),
                 
                 mainPanel(
                     fluidRow(
                         plotOutput("linePlot3")
                     ),
                     fluidRow(
                         plotOutput("linePlot4")
                     )
                 )
        ),
        tabPanel("Z-score Anomalies by Month and Year",
                 selectInput("decade",
                             label = "Select a decade:",
                             choices = decade_choices),
                 
                 mainPanel(
                     fluidRow(
                         column(width = 6,
                                plotOutput("barPlot")
                         ),
                         column(width = 6,
                                plotOutput("barPlot2")
                         )
                     ),
                     fluidRow(
                         column(width = 6,
                                plotOutput("boxPlot")
                         ),
                         column(width = 6,
                                plotOutput("boxPlot2")
                         )
                     )
                 )
        )
    )
)
