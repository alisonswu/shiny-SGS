#     Author : Alison Sihan Wu 
#              Department of Statistics, North Carolina State University
#      Email : swu11@ncsu.edu 
#     GitHub : https://github.com/alisonswu/shiny-SimNetwork

# ui.R
library(shiny)
if(!"shinythemes" %in% installed.packages()){install.packages("shinythemes")}
library(shinythemes)

alignCenter <- function(el) {
    htmltools::tagAppendAttributes(el,
        style="margin-left:auto;margin-right:auto;"
    )
}

shinyUI(fluidPage(theme = shinytheme("sandstone"),
  titlePanel("Stochastic Golden Search"),
  
  sidebarLayout(
      
    sidebarPanel(width = 3,
        withMathJax(), 
        h5( '$$\\mu(x) = 2x^2 - 1.6x + 0.32$$'),
        h5( '$$Y|x \\sim \\mu(x)+ N(0,\\sigma^2)$$'),
        h5("Choose Setup",style = "color:#0099cc"),
        numericInput("sigma", 
            label = '$$\\sigma \\mbox{ (noise size)}$$',
            min = 0.01, max = 0.2, step = 0.01,
            value = 0.1),
        
        numericInput('N', 
            label = "$$T \\mbox{ (search stages)}$$", 
            min = 0, max = 20, step = 1, 
            value = 10),
    
        h5("Click Button to Simulate",style = "color:#0099cc"),
        actionButton("go", "simulate")
    ),
     
      mainPanel(width = 8, align = "center",
          plotOutput("plot1", width = "90%"),
          br(),
          alignCenter(
              sliderInput("t", "stage", 
                  min=1, max=10, value=1,  step=1, width = "70%", animate=animationOptions(loop=TRUE))
          )
          
                  
                  
              )
              
          )
         
  )
    
)


