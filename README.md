# Meteorological Mysteries: Decoding Unusual Weather Patterns With Data

The increasing frequency and severity of extreme weather events have highlighted the importance of understanding anomalies in weather patterns. By analyzing historic weather data, we can gain a better understanding of how the frequency and severity of anomalous conditions are changing. 

### **Contents**  
- [Motivation](#Motivation)
- [Data Questions](#Data-Questions)
- [Known Issues and Challenges](#Known-Issues-and-Challenges)
- [Data Sources and Tools](#Data-Sources-and-Tools)
- [Shiny App](#Shiny-App)
- [Approach Outline](#Approach-Outline)
- [Citations](#Citations)

### Motivation
Everyone has a collection of weather anecdotes – the summers are hotter, we used to get gentle rain storms and now most of them seem to produce some sort of flooding or tornado or hail threat, winter temperatures fluctuate more than they used to so the little snow we get doesn’t last, and what was going on with the 50+ temperatures on Christmas day in upstate New York – it was well below freezing with more than 2 feet of snow just a couple of days earlier. While these stories feel true and that they form a trend, we as humans are prone to confirmation bias so are they a variation of “when I was young” stories or are the anecdotes indicative of reality? Examining the data using anomaly detection techniques can illuminate the historical trend and point the way to where our weather might go next.

The subject of anomaly detection has been coming up with increasing frequency in conversations and has broad applicability.  While this project involves weather data, the principles of anomaly detection have applications to a broad range of data domains including finance and IT performance metrics which are of particular interest to me professionally.

### Data Questions
- Has the frequency of anomalies changed over time?
- Are temperature and precipitation anomalies correlated and how strong is the correlation?
- Are anomalies more common at certain times of year, and has that pattern changed over time?
- Has what could be considered an anomaly changed over time, ie a temperature that would have been far out of the norm in 1950 would be considered typical now?
- Has the intraday temperature range (the difference between the recorded low and high temperatures) changed, and is that seasonal?

### **Known Issues and Challenges**
- While NOAA has rigorous data quality checks, the data is incomplete. I'm gathering data from several weather stations in geographic proximity to both give a longer time horizon and make the analysis more resistant to missing data.
- Anomaly detection algorithms are new to me.

### **Data Sources and Tools**
- NOAA (fill in exact address)
- Python
- R
- Shiny

### **Shiny App**
Future

### **Citations**

*Back to [Contents](#Contents)*