shinyUI(navbarPage("Local Patent Practitioners",
                   tabPanel("Search",
                            fluidRow(
                              column(12,        
                                     fluidRow(
                                       column(4,
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
                                       column(width = 8,
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
                            ),
                            fluidRow(
                              column(12,
                                #verbatimTextOutput("resultsHTML")
                                htmlOutput("resultsHTML")
                                #tableOutput("searchTable")
                                )
                              )
                   ),
                   navbarMenu("Docs",
                              tabPanel("User Instructions",
                                       includeHTML("www/userInstruction.html")
                              ),
                              
                              tabPanel("Data Analysis Docs",
                                      includeHTML("www/doc.html")
                                       )
                              ) 
))
