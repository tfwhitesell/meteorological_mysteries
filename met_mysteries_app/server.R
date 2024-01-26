

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
    
    output$linePlot3 <- renderPlot({
        
        weather |> 
            select(year, date, month_day_constant, tmax_diff) |> 
            arrange(date) |> 
            mutate(window_tmax_diff = (slide_dbl(tmax_diff, ~mean(.x), .before = 3) + 
                                           slide_dbl(tmax_diff, ~mean(.x), .after = 3)) / 2) |> 
            filter(between(year, input$slideryear[1], input$slideryear[2])) |> 
            ggplot() +
            geom_line(aes(x = month_day_constant, y = tmax_diff, group = year, color = year)) + 
            geom_line(data = filter(weather, year == input$focus_year), aes(x = month_day_constant, y = tmax_diff), color = "red") + 
            scale_x_date(date_labels = "%B") +
            scale_color_viridis_c() +
            labs(x = "Month", y = "High Temperature Difference from Mean", color = "Year", title = "High Temperature Differences from Mean by Day")
        
    })
    
    output$linePlot4 <- renderPlot({
        weather |> 
            select(year, date, month_day_constant, tmin_diff) |> 
            arrange(date) |> 
            mutate(window_tmin_diff = (slide_dbl(tmin_diff, ~mean(.x), .before = 3) + 
                                           slide_dbl(tmin_diff, ~mean(.x), .after = 3)) / 2) |> 
            filter(between(year, input$slideryear[1], input$slideryear[2])) |> 
            ggplot() +
            geom_line(aes(x = month_day_constant, y = tmin_diff, group = year, color = year)) + 
            geom_line(data = filter(weather, year == input$focus_year), aes(x = month_day_constant, y = tmin_diff), color = "red") + 
            scale_x_date(date_labels = "%B") +
            scale_color_viridis_c() +
            labs(x = "Month", y = "Low Temperature Difference from Mean", color = "Year", title = "Low Temperature Differences from Mean by Day")
    })
    
}
