library(shiny)
library(leaflet)

shinyUI(fluidPage(
  
       sliderInput("slider1", label = h4("Historical wildfires in British Columbia (> 400 hectares)"),
                  sep = "",width = 730,
                  min = 1950, max = 2013, value = 2013),
 
         plotOutput('bar.graph',height = 160,width = 730),
         leafletOutput('leaflet.map',height = 520,width = 730)
  
  ))