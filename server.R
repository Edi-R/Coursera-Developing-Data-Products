library(shiny)
library(markdown)

repayment <- function(loan_amt,term,rate,freq) {
  multiplier <- ifelse(freq=="M",12,ifelse(freq=="W",52,26))
  r <- rate/100/multiplier
  return (round(r*loan_amt/(1-(1+r)^(-term*multiplier)),0))
}

bal_remain_table <- function(loan_amt,term,rate,freq) {
  rp <- repayment (loan_amt,term,rate,freq )
  multiplier <- ifelse(freq=="M",12,ifelse(freq=="W",52,26))
  r = rate/100/multiplier
#  r <- rate/100
  periods <- term*multiplier
  pv <- loan_amt
  
  loan_repayment_table <- data.frame(pd=integer(),
                                     bal_amt=integer()
                                     )
  
  for (i in 1:periods) {
    bal_amt <- round(pv*(1+r) - rp*(((1+r)-1)/r),0)
    loan_repayment_table <- rbind(loan_repayment_table,data.frame(pd=i,bal_amt))
    pv <- bal_amt
  }
  return (loan_repayment_table)
}

shinyServer(function(input, output) {

#  b <- reactive({bal_remain_table(input$loan_amt,input$term,input$rate,input$freq)})
  output$text1<- renderText({repayment(input$loan_amt,input$term,input$rate,input$freq)})  
  
  output$table1<- renderDataTable({
    data<-bal_remain_table(input$loan_amt,input$term,input$rate,input$freq)
    names(data) <-c(switch(input$freq,"W"="Week","M"="Month","F"="Fortnight"),"Loan Balance")
    data
    }, options = list(dom='tip', pageLength = 10))
})