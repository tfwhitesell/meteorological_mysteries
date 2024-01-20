

# Define server logic required to draw basic line chart
function(input, output, session) {

    output$linePlot <- renderPlot({

        weather |> 
            select(year, date, day_of_year, month_day, tmax_f, month_name_short) |> 
            filter(year %in% input$year) |> 
            filter(!is.na(tmax_f)) |> 
            group_by(year, day_of_year) |> 
            summarize(high_temp = mean(tmax_f)) |> 
            ggplot(aes(x = day_of_year, y = high_temp, color = as.factor(year))) +
            geom_line() +
            scale_y_continuous(limits = c(min(weather$tmax_f, na.rm = TRUE),
                                          max(weather$tmax_f, na.rm = TRUE))) +
            labs(x = "Date", y = "Daily High Temperature", title = "High Temperature by Day")

    })

}
