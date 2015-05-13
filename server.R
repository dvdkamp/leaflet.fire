# server.R
library(rgdal)
library(leaflet)

shinyServer(function(input, output) {

  
  fire.perims = subset(readOGR("data/","fire.perims.ll.large"),FIRE_YEAR>=1960)
  fire.counts = as.data.frame(table(fire.perims@data$FIRE_YEAR))
  fire.counts$Var1 = as.numeric(as.character(fire.counts$Var1))
     
  output$bar.graph <-renderPlot({
      par(mar = c(2.2,2,0.3,0))
      barplot(fire.counts$Freq,
              names = fire.counts$Var1,
              col = c("red","blue")[(as.numeric(fire.counts$Va==input$slider1) +1)],
              ylab = "")
    title("Fire Counts", line = -2,cex.main = 2)
  })  
  
  output$leaflet.map <- renderLeaflet({
    leaflet() %>% 
      setView(-123.976, 53.965, zoom = 5) %>% addTiles() %>% addPolygons(data = subset(fire.perims,FIRE_YEAR == input$slider1))
  })
  
  
})

