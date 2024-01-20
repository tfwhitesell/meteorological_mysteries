library(shiny)
library(tidyverse)

weather <- read_rds("data/weather.Rds")

year_choices <- weather |> 
    pull(Year) |> 
    unique() |> 
    sort()