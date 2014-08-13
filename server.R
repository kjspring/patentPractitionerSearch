
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#
library(shiny)
library(googleVis)
library(knitr)

source("scripts/find.R")
source("scripts/mapping.R")
source("scripts/listing.R")

zips <- read.csv("data/raw/free-zip-code-database.csv", 
                 colClasses = "character") # Load zip code data
dat <- read.csv("data/tidy/workingDat.csv", 
                colClasses = "character") # Load patent agent registry

counties <- readRDS("data/raw/counties.rds")

knit2html("documentation/doc.Rmd", "www/doc.html", quiet=TRUE)
knit2html("documentation/userInstruction.Rmd", "www/userInstruction.html", quiet=TRUE)

shinyServer(function(input, output) {
  
  dataInput <- reactive({
                  a = find(dat,
                          zips,
                          as.character(input$zip), 
                          as.numeric(input$radius), 
                          as.character(input$check)
    )
  })
  

  # You can access the value of the widget with input$select, e.g.
  output$map <- renderGvis({mapping(dataInput(), zips, as.character(input$zip))})
  
  # Don't want to just render a Table, I want to extract the data from the
  # table and make a nice looking list
  output$resultsHTML <- renderText({
                          listing(dataInput())
                        })
    
  output$resultsNum <- renderText({
                        paste("Total Results: ", nrow(dataInput()))
  })
  
})
