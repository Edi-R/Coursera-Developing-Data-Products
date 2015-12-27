library(shiny)
library(markdown)

shinyUI(navbarPage("Calculate Loan Repayments",
  tabPanel("Table",
  sidebarLayout(
    sidebarPanel(
      helpText("Enter Loan Details"),      
      numericInput('loan_amt',"Loan Amount ($)",100000,min=0,max=999999999),
      numericInput('term',"LoanTerm (Years)",5,min=1,max=30),
      numericInput('rate',"Annual Interest Rate (%)",4.00,step=0.01),
      selectInput("freq",label="Repayment Frequency",
                  choices = list("Fortnightly"="F",
                                 "Monthly"="M",
                                 "Weekly" ="W"),
                  selected = "M"
      ),
      submitButton("Submit")
      
    ),
  mainPanel(
#      dataTableOutput('table')
    h4("Loan Repayment Amount"),
    textOutput("text1"),
    h4("Payment Schedule"),
    dataTableOutput('table1')
    )
  )
),
tabPanel("About",
         mainPanel(
           p("This app calculates periodic loan repayments and loan balance remaining."),
           br(),
           p("Enter the loan details, then press the submit button."),
           br(),
           p("The minimum loan repayment amount and the outstanding balance at the end of each period will be shown.")
           )
         )

  )
)