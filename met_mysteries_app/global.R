library(shiny)
library(tidyverse)
library(shinyWidgets)

weather <- read_rds("data/weather.Rds")

year_choices <- weather |> 
    pull(year) |> 
    unique() |> 
    sort()