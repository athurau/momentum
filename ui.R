library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Momentum - a Mortgage MoNThly Payment Calculator"),
  
  sidebarPanel(
    h3("Enter the values of your loan:"),
    numericInput("CRD0", label=h3("Initial amount ($)"), value=300000),
    numericInput("nbAnnees", label=h3("Payback period (years)"), value=30),
    numericInput("TF", label=h3("Annual interest rate (%)"), value=3),
    numericInput("txRA", label=h3("Annual prepayment rate (%)"), value=0) 
    ),
  
  mainPanel(
    h3("Mensuality without prepayment ($)"),
    verbatimTextOutput("mensuality"),
    plotOutput("amortizingPlot"),
    downloadButton("downloadData", "Download amortization table (with prepayments)")
    )
))
