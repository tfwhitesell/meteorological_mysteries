

# Define server logic required to draw basic line chart
function(input, output, session) {

    output$linePlot <- renderPlot({
        
        weather |> 
            select(year, month_day_constant, tmax_f) |> 
            filter(year %in% input$year) |> 
            ggplot(aes(x = month_day_constant, y = tmax_f, color = as.factor(year))) +
            geom_line() +
            scale_y_continuous(limits = c(min(weather$tmax_f),
                                          max(weather$tmax_f))) +
            scale_x_date(date_labels = "%B") +
            labs(x = "Month", y = "Daily High Temperature", color = "Year", title = "High Temperature by Day")

    })
    
    output$linePlot2 <- renderPlot({
        
        weather |> 
            select(year, month_day_constant, tmin_f) |> 
            filter(year %in% input$year) |> 
            ggplot(aes(x = month_day_constant, y = tmin_f, color = as.factor(year))) +
            geom_line() +
            scale_y_continuous(limits = c(min(weather$tmin_f),
                                          max(weather$tmin_f))) +
            scale_x_date(date_labels = "%B") +
            labs(x = "Month", y = "Daily Low Temperature", color = "Year", title = "Low Temperature by Day")
        
    })

}
