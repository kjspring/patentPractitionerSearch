# Find and subset practitioners from user input
library(fields)

# test data
#zip <- "77054"
#radius <- 5 # miles
#check = "AGENT"

find <- function(dat, zips, zip, radius, check) {
  
  # Check user input
  # Need to check if proper zip code input by user
  if(nchar(zip) > 5 | nchar(zip) < 5) {
    stop("Please enter only a 5 digit zip code.")
  }
  
  # Read the registered practitioner working data
  # Hidden so only read once when server started
  #dat <- read.csv("data/tidy/workingDat.csv", 
  #                colClasses = "character")
  dat$latitude <- as.numeric(dat$latitude) # set long lat as numeric
  dat$longitude <- as.numeric(dat$longitude)
  dat$loc <- paste(dat$latitude, dat$longitude, sep=":")
  
  # Read the zip code data
  # hidden because run once with server open
  #zips <- read.csv("data/raw/free-zip-code-database.csv", 
  #                 colClasses = "character") # zip code nees to be char
  
  zips$Latitude <- as.numeric(zips$Latitude) # set long lat as numeric
  zips$Longitude <- as.numeric(zips$Longitude)
  
  # Subset the practitioner data for only lon/lat & index
  datSub <- dat[,19:18]
  
  # Find the longitude/latitude of the user entered zip code
  coordZip <- zips[zips$ZIPCode %in% zip,][6:5]
  
  # distant matrix distance between datSub and user inputted zip)  
  dist <- rdist.earth(datSub, coordZip)
  
  # which of the distances are less than the radius
  index <- which(dist < radius)
  datFind <- dat[index, ]
  
  # If the data frame is empty return an error saying none found
  if(nrow(datFind) == 0) {
    stop("No patent agents found in the area specified")
  }
  
  # Also subset by input search of Attorney/Agent/Both
  if(length(check) == 2) {
    datFind <- datFind[,-1]
    return(datFind)
  } else {
    datFind <- datFind[datFind$classification==check, ]
    return(datFind)
  }
}