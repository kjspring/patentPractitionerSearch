
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
shinyUI(
  fluidPage(
    titlePanel("Patent Practitioner Search"),
    
    sidebarLayout(
      sidebarPanel("",
                   textInput("zip", 
                             label = h5("Zip Code Search"),
                             value = "21287"),
                   hr(),
                   sliderInput("radius",
                               label=h5("Search Area (mi)"),
                               min=1, max=100, value= 5 ),
                   hr(),
                   checkboxGroupInput("check", label = h5("Practitioner Type"), 
                                      choices = c("Attorney" = "ATTORNEY", "Agent" = "AGENT"),
                                      selected = c("ATTORNEY", "AGENT")),
                   hr(),
                   verbatimTextOutput("resultsNum")
                   ),
      mainPanel( htmlOutput("map")
                  )
                ) ,
    fluidRow(
      tableOutput("searchTable")
            )
    
        )
)

