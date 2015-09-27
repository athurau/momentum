library(shiny)

pmt <- function(rate, nper, pv) if (rate == 0) pv / nper else pv*rate/(1-(1+rate)^(-nper))
TA <- function(rate, nper, pv, txRA){
  output <- array(0,nper)
  output[1] <- pv
  pmtValue <- pmt(rate, nper, pv)
  for (i in 2:nper) output[i] <- output[i-1] * (1 + rate) - pmtValue
  txSurvie <- 1 - txRA
  for (i in 2:nper) output[i:nper] <- output[i:nper] * txSurvie
  return(output)
}

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  nbMois <- reactive({input$nbAnnees * 12})
  txMensuel <- reactive({input$TF /1200})
  pmtValue <- reactive({pmt(txMensuel(), nbMois(), input$CRD0)})
  TAValue <- reactive({TA(txMensuel(), nbMois(), input$CRD0, input$txRA /1200)})
  output$mensuality <- renderPrint({pmtValue()})
  output$amortizingPlot <- renderPlot({
    plot(1:nbMois(), TAValue(), type = "l", xlab = "Month" , ylab = "Amount of capital remaining due")
  })
  output$downloadData <- downloadHandler(
    filename = "AmortizationTable.csv",
    content = function(file) {
      write.table(TAValue(), file, col.names = FALSE, sep = ";")
    })
}
)
