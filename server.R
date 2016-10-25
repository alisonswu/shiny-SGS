#     Author : Alison Sihan Wu 
#              Department of Statistics, North Carolina State University
#      Email : swu11@ncsu.edu 
#     GitHub : https://github.com/alisonswu/stochastic_golden_search
        
# server.R
library(shiny)
source("helpers.R")
shinyServer(function(input, output) {

    sim <- eventReactive(input$go, {
        SGS(sigma = input$sigma, N= input$N)
    })

    output$plot1 <- renderPlot({
        plot_search(sim(), input$t)
    })
  
})
