

# Define server logic required to draw basic line chart
function(input, output, session) {
    
    # daily high temperatures by year
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
    
    # daily low temperatures by year
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
    
    # high temperature difference from mean
    output$linePlot3 <- renderPlot({
        
        weather |> 
            select(year, date, month_day_constant, tmax_diff) |> 
            arrange(date) |> 
            mutate(window_tmax_diff = (slide_dbl(tmax_diff, ~mean(.x), .before = 3) + 
                                           slide_dbl(tmax_diff, ~mean(.x), .after = 3)) / 2) |> 
            filter(between(year, input$slideryear[1], input$slideryear[2])) |> 
            ggplot() +
            geom_line(aes(x = month_day_constant, y = tmax_diff, group = year, color = year)) + 
            geom_line(data = filter(weather, year == input$focus_year), aes(x = month_day_constant, y = tmax_diff), size = 0.9, color = "sienna3") + 
            scale_x_date(date_labels = "%B") +
            scale_color_viridis_c() +
            labs(x = "Month", y = "High Temperature Difference from Mean", color = "Year", title = "High Temperature Differences from Mean by Day")
        
    })
    
    #low temperature difference from mean
    output$linePlot4 <- renderPlot({
        weather |> 
            select(year, date, month_day_constant, tmin_diff) |> 
            arrange(date) |> 
            mutate(window_tmin_diff = (slide_dbl(tmin_diff, ~mean(.x), .before = 3) + 
                                           slide_dbl(tmin_diff, ~mean(.x), .after = 3)) / 2) |> 
            filter(between(year, input$slideryear[1], input$slideryear[2])) |> 
            ggplot() +
            geom_line(aes(x = month_day_constant, y = tmin_diff, group = year, color = year)) + 
            geom_line(data = filter(weather, year == input$focus_year), aes(x = month_day_constant, y = tmin_diff), size = 0.9, color = "sienna3") + 
            scale_x_date(date_labels = "%B") +
            scale_color_viridis_c() +
            labs(x = "Month", y = "Low Temperature Difference from Mean", color = "Year", title = "Low Temperature Differences from Mean by Day")
    })
    
    filtered <- reactive({
        if (input$decade == "All"){
            decade_filter <- decade_choices
        } else {
            decade_filter <- input$decade
        }
        
        weather |>
            filter(decade %in% decade_filter)
    })
    
    # anomalous high temperatures by decade
    output$barPlot <- renderPlot({

        filtered() |> 
            filter(abs(tmax_zscore) >= 3) |> 
            select(month_name_short) |> 
            group_by(month_name_short) |> 
            mutate(month_name_short = factor(month_name_short, levels = month.abb)) |> 
            ggplot(aes(x = month_name_short)) +
            geom_bar(stat = "count") +
            labs(x = "Month", y = "Count of Anomalies", title = "Count of Anomalous High Temperatures by Decade")
    })
    
    # anomalous low temperatures by decade
    output$barPlot2 <- renderPlot({
        
        filtered() |> 
            filter(abs(tmin_zscore) >= 3) |> 
            select(month_name_short) |> 
            group_by(month_name_short) |> 
            mutate(month_name_short = factor(month_name_short, levels = month.abb)) |> 
            ggplot(aes(x = month_name_short)) +
            geom_bar(stat = "count") +
            labs(x = "Month", y = "Count of Anomalies", title = "Count of Anomalous Low Temperatures by Decade")
    })
    
    # boxplot of high temp z-scores by month and decade
    output$boxPlot <- renderPlot({
        filtered() |> 
            select(month_name_short, tmax_zscore) |> 
            group_by(month_name_short) |> 
            mutate(month_name_short = factor(month_name_short, levels = month.abb)) |> 
            ggplot(aes(x = month_name_short, y = tmax_zscore)) +
            geom_boxplot() +
            labs(x = "Month", y = "Z-score", title = "High Temperature Z-scores by Decade")
    })
    
    # boxplot of low temp z-scores by month and decade
    output$boxPlot2 <- renderPlot({
        filtered() |> 
            select(month_name_short, tmin_zscore) |> 
            group_by(month_name_short) |> 
            mutate(month_name_short = factor(month_name_short, levels = month.abb)) |> 
            ggplot(aes(x = month_name_short, y = tmin_zscore)) +
            geom_boxplot() +
            labs(x = "Month", y = "Z-score", title = "Low Temperature Z-scores by Decade")
    })
    
    # filtered <- reactive({
    #     if (input$decade == "All"){
    #         decade_filter <- decade_choices
    #     } else {
    #         decade_filter <- input$decade
    #     }
    #     
    #     weather |>
    #         filter(decade %in% decade_filter)
    # })
    
    # high temperature distribution
    output$histPlot <- renderPlot({
        weather |> 
            ggplot(aes(x = tmax_f)) +
            geom_histogram(binwidth = 1) +
            labs(x = "High Temperature", y = "Count of Days", title = "Distribution of High Temperatures 1899-2023")
    })
    
    # low temperature distribution
    output$histPlot4 <- renderPlot({
        weather |> 
            ggplot(aes(x = tmin_f)) +
            geom_histogram(binwidth = 1) +
            labs(x = "Low Temperature", y = "Count of Days", title = "Distribution of Low Temperatures 1899-2023")
    })
    
    # high temperature distribution by month and decade
    output$histPlot2 <- renderPlot({
        filtered() |> 
            mutate(month_name_short = factor(month_name_short, levels = month.abb)) |> 
            ggplot(aes(x = tmax_f)) +
            geom_histogram(binwidth = 1) +
            facet_wrap(~month_name_short, strip.position = "bottom") +
            labs(x = "High Temperature", y = "Count of Days", title = "Distribution of High Temperatures by Month")
    })
    
    # low temperature distribution by month and decade
    output$histPlot3 <- renderPlot({
        filtered() |>
            mutate(month_name_short = factor(month_name_short, levels = month.abb)) |>
            ggplot(aes(x = tmin_f)) +
            geom_histogram(binwidth = 1) +
            facet_wrap(~month_name_short, strip.position = "bottom") +
            labs(x = "High Temperature", y = "Count of Days", title = "Distribution of High Temperatures by Month")
    })
    
    # ridgeline of month high temps by decade
    output$ridgePlot <- renderPlot({
        month_select <- weather |> 
            select(month_name_short, tmax_f, tmin_f) |> 
            filter(month_name_short == input$month)
        
        weather |> 
            select(month_name_short, tmax_f, decade) |> 
            filter(month_name_short == input$month) |> 
            ggplot(aes(x = tmax_f, y = as.factor(decade), fill = stat(x))) +
            geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
            scale_fill_viridis_c() +
            coord_cartesian(xlim = quantile(month_select$tmax_f, c(0.01, 0.99))) +
            labs(x = "Maximum Temperature",
                 y = "Decade",
                 title = "Density Plot of High Temperatures for Selected Month by Decade")
    })
    
    # ridgeline of month low temps by decade
    output$ridgePlot2 <- renderPlot({
        month_select <- weather |> 
            select(month_name_short, tmax_f, tmin_f) |> 
            filter(month_name_short == input$month)
        
        weather |> 
            select(month_name_short, tmin_f, decade) |> 
            filter(month_name_short == input$month) |> 
            ggplot(aes(x = tmin_f, y = as.factor(decade), fill = stat(x))) +
            geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01) +
            scale_fill_viridis_c() +
            coord_cartesian(xlim = quantile(month_select$tmin_f, c(0.01, 0.99))) +
            labs(x = "Minimum Temperature",
                 y = "Decade",
                 title = "Density Plot of Low Temperatures for Selected Month by Decade")
    })
    
}
