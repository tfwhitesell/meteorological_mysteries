library(shiny)
library(tidyverse)
library(shinyWidgets)

weather <- read_csv("data/weather.csv")

year_choices <- weather |> 
    pull(year) |> 
    unique() |> 
    sort()

decade_choices <- weather |>
    # filter(between(year, 1900, 2019)) |> 
    pull(decade) |>
    unique() |>
    sort()

decade_choices <- c("All", decade_choices)