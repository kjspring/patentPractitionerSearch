
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
shinyUI(
  navbarPage("Practitioner Search",
    tabsetPanel(id="SEARCH", selected="search", type="tabs", position="above",
      tabPanel(value="search",
        fluidRow(
          column(12,        
            fluidRow(
              column(5,
                fluidRow(
                  column(12,
                    textInput("zip", 
                      label = h3("Zip Code Search"),
                      value = "21287"),
                    hr()
                  )
                ),
                fluidRow(
                  column(12,
                    sliderInput("radius",
                      label=h3("Search Area (mi)"),
                      min=1, max=100, value= 5 ),
                    hr()
                  )
                ),
                fluidRow(
                  column(12,
                    checkboxGroupInput("check", label = h3("Practitioner Type"), 
                      choices = c("Attorney" = "ATTORNEY", "Agent" = "AGENT"),
                      selected = c("ATTORNEY", "AGENT")),
                    hr()
                  )
                )
              ),
              column(width = 7,
                br(),
                htmlOutput("map")
              )
            )
          )
        ),
        fluidRow(
          column(12,
            p(" ")
          )
        ),
        fluidRow(
          column(12, 
            verbatimTextOutput("resultsNum")
          )
        )
      ),
      navbarMenu("Docs",
        tabPanel("User Documentation"),
        tabPanel("Coder Documentation")
      )
    )
  )
)