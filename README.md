# Meteorological Mysteries: Decoding Unusual Weather Patterns With Data

The increasing frequency and severity of extreme weather events have highlighted the importance of understanding anomalies in weather patterns. By analyzing historic weather data, we can gain a better understanding of how the frequency and severity of anomalous conditions are changing. 

### **Contents**  
- [Motivation](#motivation)
- [Data Questions](#data-questions)
- [Known Issues and Challenges](#known-issues-and-challenges)
- [Data Sources](#data-sources)
- [Data Cleaning and Prep](#data-cleaning-and-prep)
- [Tools Used](#tools-used)
- [Shiny App](#shiny-app)
- [Approach Outline](#approach-outline)

### Motivation
Everyone has a collection of weather anecdotes – the summers are even hotter than they used to be, we used to get gentle rain storms and now most of them seem to produce some sort of flooding or tornado or hail threat, winter temperatures fluctuate more than they used to so the little snow we get doesn’t last, and what was going on with the 50+ temperatures on Christmas day in upstate New York – it was well below freezing with more than 2 feet of snow just a couple of days earlier! While these stories feel true and definitely form a trend, we as humans are prone to confirmation bias. So are they a variation of “when I was young” stories or are the anecdotes indicative of reality? Examining the data using anomaly detection techniques can illuminate the historical trend and point the way to where our weather might go next.

The subject of anomaly detection has been coming up with increasing frequency in conversations and has broad applicability.  While this project involves weather data, the principles of anomaly detection have applications to many data domains including finance and IT performance metrics which are of particular interest to me professionally.

### Data Questions
- Has the frequency of anomalies changed over time?
- Are anomalies more common at certain times of year, and has that pattern changed over time?
- Has what could be considered an anomaly changed over time, ie a temperature that would have been far out of the norm in 1950 would be considered typical now?

### **Known Issues and Challenges**
- No one weather station has absolutely complete data. In addition, weather stations can be "replaced" with another station in the same location but a different statiod id.
- No single station had records over the full period of time I wanted to examine.
- The Global Historical Climatology Network (GHCN) provides data in a very specific fixed-width file format which requires building a parser to import in a usable format.

### **Data Cleaning and Prep**
- Select stations to include in the analysis. Selection was based on geographic proximity, station length of service, and completeness of the station's records in the primary measurements collected (maximum and minimum daily temperatures, and daily precipitation).
- Build parser in python to download files for selected stations and transform the dly format into a format usable for analysis.
- Reshaped the data to have one row per station per day. Original data had one row per month per station per observation type (minimum and maximum temperature, precipitation, etc).
- Converted measurement data to standard units - original temperatures were reported in tenths of degrees Celcius, and precipitation in tenths of mm.
- Additional data cleaning to handle missing values, and flip temperatures values where the high and low temperatures for the day were entered in the wrong order.

### **Data Sources**
- [Global Historical Climatology Network data files](https://www.ncei.noaa.gov/pub/data/ghcn/daily/)

### **Tools Used**
- Python
- R
- Shiny

### **Shiny App**
Link coming soon

*Back to [Contents](#contents)*