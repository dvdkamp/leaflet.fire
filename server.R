# server.R
library(rgdal)
library(leaflet)
library(dplyr)

shinyServer(function(input, output) {

  ## Read in fire perimeter data
  fire.perims = subset(readOGR("data/","fire.perims.ll.large"),FIRE_YEAR>=1950)
  
  ## create yearly fire count dataset
  fire.counts = fire.perims@data %>% group_by(FIRE_YEAR) %>% summarise(fire.count = n())
     
  ## create bar graph where the colour is dictated by the selected year
  output$bar.graph <-renderPlot({
      par(mar = c(2.2,2,0.3,0))
      barplot(fire.counts$fire.count,
              names = fire.counts$FIRE_YEAR,
              col = c("red","blue")[(as.numeric(fire.counts$FIRE_YEAR==input$slider1) +1)],
              ylab = "")
    title("Yearly Fire Counts", line = -2,cex.main = 2)
  })  
 
  ## generate leaflet map centred over BC 
  output$leaflet.map <- renderLeaflet({
    leaflet() %>% 
      setView(-123.976, 53.965, zoom = 5) %>% addTiles() %>% addPolygons(data = subset(fire.perims,FIRE_YEAR == input$slider1))
  })
  
  
})

