
# Filename: heatmapping.R

library(googleVis)

dat <- read.csv("heatmappingData.csv")

heatMapping <- function(dat) {
  

  
  Gmap <- gvisGeoChart(dat, "metroCode", colorvar = "numberAgent", 
                       options=list(region = "US",
                                    resolution = "metros",
                                    displayMode="regions", 
                                    colorAxis="{colors:['white','blue', 'orange', 'red']}",
                                    backgroundColor="lightblue"), chartid="Density")
  return(Gmap)
}