
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Find a Patent Practitioner"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      #sliderInput("bins",
      #            "Number of bins:",
      #            min = 1,
      #            max = 50,
      #            value = 30),
    #),
      # Put a text box to enter zip code
      #textInput("zip", label=h3("Zip Code")),
      
      # Put a text box to enter miles radius
      selectInput("select", 
                  label = h3("Select box"), 
                  choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3), 
                  selected = 1),
      #selectInput(inputId = "radius", label="Miles Radius", 
      #            choices = list("> 5 miles" = 5,
      #                           "> 10 miles" = 10,
      #                           "> 20 miles" = 20,
      #                           "> 50 miles" = 50,
      #                           "> 100 miles" = 100,
      #                           "No limit" = 0) ),
      #hr(),
      #verbatimTextOutput("radius"),
    ),
      # Need a Go button
      #actionButton("search", label = "Search"),
      # Put a check box to select Agent/Attorney/Both
      #checkboxGroupInput(name = "type",
      #                   label = "Practitioner Type",
      #                   choices = list("Attorney" = 1,
      #                                  "Agent" = 2) ),
      
      #selectInput("select", label = h3("Results Returned"),
      #            choices = list("1-20", "21-50" = 2,
      #                           "51-100" = 3, "101-200" = 3,
      #                           "200+")),

    # Show a plot of the generated distribution
    mainPanel(
      #plotOutput("distPlot") 
      # this will output the heat map
      #tableOutput(outputId) # this will output the list of practitioners
    )
  )
))
