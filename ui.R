library(shiny)
library(leaflet)

shinyUI(fluidPage(
  
       sliderInput("slider1", label = h4("Historical wildfires in British Columbia (> 200 hectres)"),
                  sep = "",width = 750,
                  min = 1960, max = 2013, value = 2013),
 
         plotOutput('bar.graph',height = 160,width = 750),
         leafletOutput('leaflet.map',height = 520,750)
  
  ))