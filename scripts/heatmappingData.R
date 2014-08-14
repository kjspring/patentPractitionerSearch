# Filename: heatmapping.R

heatmappingData <- function ( ) {
  
  # Heat map of patent practitioner locations

  # load registry data
  dat <- read.csv("data/tidy/workingDat.csv", 
                  colClasses = "character") # Load patent agent registry

  # load metro code data
  region <- read.csv("data/raw/regions.csv",
                   colClasses = "character")
  region$DMA.Region[region$DMA.Region == "Washington, DC (Hagerstown, MD)"] <- "Washington, DC"

  
  st <- read.csv("data/raw/states.csv", colClasses = "character")
  
  # convert metro code state data to state Abbreviation
  for (i in seq_along(unique(region$State))) {
    region$State[region$State == st$State[i]] <- st$Abbreviation[i]
  }
  
  # Remove Puerto Rico agents
  dat <- dat[dat$state != "PR", ]
  
  # map city to region code
  ## Remove any of the registry data that has missing city values
  dat <- dat[complete.cases(dat$city), ]
  dat$city <- tolower(dat$city)

  ## Turn region city to all lower case
  region$City <- tolower(region$City)

  ## Remove any data from the registry that does not match in city
  dat <- dat[dat$city %in% region$City, ]
  
  # region <- region[region$City %in% dat$city, ]
  
  # parse out the state information
  #stateList <- unique(dat$state)
  
  # region <- region[region$State %in% stateList,] need to do reverse
  dat <- dat[dat$state %in% region$State, ]
  
  codes <- unique(region$DMA.Region.Code)
  numCodes <- length(codes)
  
  # metroCode |  numberAgent
  agentDensity <- data.frame(metroCode=codes, 
                              numberAgent=NA)
  
  ## Add a variable to the registry data to include the metro DMC
  for(i in codes) {

    # Make a vector of cities with that region code
    cities <- region[region$DMA.Region.Code == i, ]$City # correct
    states <- region[region$DMA.Region.Code == i, ]$State[1]
    
    # Find these cities in the registry data set
    dat$metroCode[dat$city %in% cities & dat$state %in% states] <- i
  }

  # Remove the data that does not have metro codes
  dat <- dat[complete.cases(dat$metroCode),]
  
  # Find the population density of attorney/agents in that metro code
  for( i in seq_along(codes)) {
    pop <- nrow(dat[dat$metroCode == codes[i], ] )
    agentDensity$numberAgent[i] <- pop
  }
  
  write.csv(agentDensity, "data/tidy/heatmappingData.csv")
  
# return results
  return(agentDensity)
}
