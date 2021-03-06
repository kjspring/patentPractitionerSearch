# Filename: mapping.R

library(googleVis)

mapping <- function(dat, zipDat, zip_usr) {
  
  state <- zipDat[zipDat$ZIPCode %in% zip_usr,]$State[1]
  reg_spec <- paste("US", state, sep="-")
  Gmap <- gvisGeoChart(dat, "loc",
                  options=list(region = reg_spec,
                               #resolution = "metros",
                               resolution = "provinces",
                               displayMode="Markers", 
                               #colorAxis="{colors:['red']}",
                               #sizeAxis="{minValue=0, maxValue=0}",
                               backgroundColor="lightblue"), chartid="Patent")
  return(Gmap)
}