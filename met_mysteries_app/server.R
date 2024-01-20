

# Define server logic required to draw basic line chart
function(input, output, session) {

    output$linePlot <- renderPlot({

        weather |> 
            select(year, month_day_constant, tmax_f) |> 
            filter(year %in% input$year) |> 
            filter(!is.na(tmax_f)) |> 
            group_by(year, month_day_constant) |> 
            summarize(high_temp = mean(tmax_f)) |> 
            ggplot(aes(x = month_day_constant, y = high_temp, color = as.factor(year))) +
            geom_line() +
            scale_y_continuous(limits = c(min(weather$tmax_f, na.rm = TRUE),
                                          max(weather$tmax_f, na.rm = TRUE))) +
            scale_x_date(date_labels = "%B") +
            labs(x = "Month", y = "Daily High Temperature", color = "Year", title = "High Temperature by Day")

    })
    
    output$linePlot2 <- renderPlot({
        
        weather |> 
            select(year, month_day_constant, tmin_f) |> 
            filter(year %in% input$year) |> 
            filter(!is.na(tmin_f)) |> 
            group_by(year, month_day_constant) |> 
            summarize(low_temp = mean(tmin_f)) |> 
            ggplot(aes(x = month_day_constant, y = low_temp, color = as.factor(year))) +
            geom_line() +
            scale_y_continuous(limits = c(min(weather$tmin_f, na.rm = TRUE),
                                          max(weather$tmin_f, na.rm = TRUE))) +
            scale_x_date(date_labels = "%B") +
            labs(x = "Month", y = "Daily Low Temperature", color = "Year", title = "Low Temperature by Day")
        
    })

}
