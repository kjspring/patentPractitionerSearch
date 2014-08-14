# data download and subsetting

fileURL <- 'http://www.uspto.gov/ip/boards/oed/attorney-roster/attorney.zip'

download.file(fileURL, "data/raw/roster.zip")
unzip("data/raw/roster.zip", exdir="data/raw")
dat <- read.table("data/raw/WebRoster.txt", 
                  header=F, sep=",",
                  colClasses = "character")

colnames(dat) <- c("lastName", "firstName", 
                   "middleName", "suffix", 
                   "firm", "address1", 
                   "address2", "address3", 
                   "city", "state", 
                   "country", "zip", 
                   "telephone", "registrationNumber", 
                   "classification")

# Remove last NA column
dat <- dat[,-16]

# Clean up the telephone data
dat[dat == ""] <- NA
dat[dat == "--"] <- NA

# Put the extensions into its own column
dat$ext <- ""
EXTs <- grep("EXT", dat$telephone)

for (i in 1:length(EXTs)) {
  sp <- strsplit(dat[EXTs[i],]$telephone, "EXT")
  dat[EXTs[i],]$telephone <- sp[[1]][1]
  dat[EXTs[i],]$ext <- sp[[1]][2]
}

fileURL <- "http://greatdata.com/free-zip-code-database"
download.file(fileURL, "data/raw/roster.zip")
unzip(zipfile="data/raw/free-zip-code-database.zip", 
      files = "free-zip-code-database.csv",
      exdir="data/raw")
zips <- read.csv("data/raw/free-zip-code-database.csv",
                 colClasses = "character") # zip code nees to be char
zips$Latitude <- as.numeric(zips$Latitude) # set long lat as numeric
zips$Longitude <- as.numeric(zips$Longitude)

# Remove any international addresses
dat <- dat[dat$country == "US", ]

# Some zip codes do not have a "-" separator. So look for any larger
# than 5 characters and save only the first 5
longzip <- which(nchar(dat$zip)>5)

for (i in seq_along(longzip)) {
  zipsplit <- substr(dat$zip[i], start=1, stop=5)
  dat[longzip[i], ]$zip = zipsplit[i]
}

# Remove any zip codes less than 5 numbers
shortzip <- which(nchar(dat$zip)<5)
dat <- dat[-shortzip, ]

# Remove any data that has missing zip code data
dat <- dat[-complete.cases(dat$zip),]

# Remove any data that doesn't have any matching zip codes
dat <- dat[dat$zip %in% zips$ZIPCode, ]

# Make latitude and longitude variables
dat$latitude <- NA
dat$longitude <- NA

zips <- zips[zips$ZIPCode %in% dat$zip,] # remove some geolocations

for(i in seq_along(zips$ZIPCode)) { # takes a while to run
  rownum <- which(dat$zip == zips$ZIPCode[i])  # search geolocation
  dat$latitude[rownum] <- zips$Latitude[i] # save latitude
  dat$longitude[rownum] <- zips$Longitude[i] # save longitude
}

write.csv(dat, "data/tidy/workingDat.csv") # Write the data to a file