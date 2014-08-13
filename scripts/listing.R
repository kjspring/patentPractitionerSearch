# Filename: listing.R

listing <- function(a ) {
  # This function outputs HTML using the shiny library
  # to generate the HTML code needed to display the values 
  # extracted from the returned table from the find() function.
  
  # convert any NA to readable
  a[is.na(a)] <- " "
  
  html_vec <- vector()
  
  for(i in 1:nrow(a)) {
    html_vec[i] <- paste(
      fluidRow(
        column(12,
               fluidRow(
                 column(5,
                        h4(paste(a$firstName[i], 
                                 a$middleName[i], 
                                 a$lastName[i], 
                                 sep=" ")
                        ),
                        fluidRow(
                          column(8,
                                 em(a$firm[i])),
                          column(4,
                                 h5(a$telephone[i])
                                 )
                        ),
                        fluidRow(
                          column(10,
                                 paste(a$address1[i], 
                                       a$address2[i], 
                                       a$address3[i], 
                                       sep = " "),
                                 fluidRow(
                                   column(12,
                                          paste(a$city[i], 
                                                a$state[i], 
                                                a$zip[i], 
                                                sep=", "))
                                 )
                          ),
                          column(2)
                        )
                 ),
                 column(7, align="right",
                        h5(a$classification[i]))
               ),
               fluidRow(
                 column(5),
                 column(7,
                        align="right",
                        paste(a$dist[i], "mi away", sep=" "))
               )
        )
      ),
      hr()
    )
    
  }
  return(HTML(paste(html_vec)))
}

