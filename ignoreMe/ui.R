library(shiny)
shinyUI(
  pageWithSidebar(
  headerPanel("Datat science!"),
  sidebarPanel(
    h3('Sidebar Balabala'),
    actionButton("submit","Switch axis"),
    numericInput('numberInput','Value here',50,min=0,max=100,step=1),
    sliderInput('xAcc','Move this bar to change x-axis acceleration',value=0,min=-100,max=100,step=0.5),
    sliderInput('yAcc','Move this bar to change y-axis acceleration',value=0,min=-100,max=100,step=0.5),
    ),

  mainPanel(
    h3('Trouble shooting'),
    h4('Aim for it'),
    verbatimTextOutput("inputValue1"),
    textOutput("inputValue2")
  )
  
))
