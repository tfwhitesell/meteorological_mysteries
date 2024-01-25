
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
        ) #,
        # tabPanel("Temperature Difference from Mean"),
        # tabPanel("another tab")
    )
)
