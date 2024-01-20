library(shiny)
library(tidyverse)
library(shinyWidgets)

weather <- read_csv("data/weather.csv")

year_choices <- weather |> 
    pull(year) |> 
    unique() |> 
    sort()