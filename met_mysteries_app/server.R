

# Define server logic required to draw basic line chart
function(input, output, session) {

    output$distPlot <- renderPlot({

        weather |> 
            select(year, date, tmax_f, month_name_short) |> 
            filter(year == input$year) |> 
            filter(!is.na(tmax_f)) |> 
            group_by(date) |> 
            summarize(high_temp = mean(tmax_f)) |> 
            ggplot(aes(x = date, y = high_temp)) +
            geom_line() +
            scale_y_continuous(limits = c(min(weather$tmax_f, na.rm = TRUE),
                                          max(weather$tmax_f, na.rm = TRUE))) +
            scale_x_date(date_labels = "%B") +
            labs(x = "Date", y = "Daily High Temperature", title = "High Temperature by Day")

    })

}
