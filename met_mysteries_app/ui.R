
# Define UI for application
fluidPage(

    # Application title
    titlePanel("Nashville Temperature Analysis 1899-2023"),

    # Sidebar with a slider input for number of bins
    multiInput(
        inputId = "year", label = "Year:",
        choices = year_choices,
        selected = min(year_choices)
    ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("linePlot")
        )
)
