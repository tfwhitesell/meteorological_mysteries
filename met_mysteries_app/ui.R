
# Define UI for application
fluidPage(
    
    # Application title
    titlePanel("Nashville Temperature Analysis 1899-2023"),
    
    # Sidebar with a multi-select input for years to display
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
    ),
)

