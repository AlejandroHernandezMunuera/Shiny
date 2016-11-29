library(quantmod)
source("helpers.R")

shinyServer(function(input, output) {
  
  dataInput <- reactive({
    getSymbols(input$symb, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })
  
  data <- reactive({
    info <- dataInput()
    if (input$adjust)
      return (adjust(info))
    else
      return (info)
  })
  
  output$plot <- renderPlot({   
    chartSeries(data(), theme = chartTheme("white"), 
                type = "line", log.scale = input$log, TA = NULL)
  })
})