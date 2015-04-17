library(shiny)
currentMSE<-0
shinyUI(
  pageWithSidebar(
  headerPanel("One of the stupid games"),
  sidebarPanel(
    h3('Try to match the sum of the Gaussian mixture model by changing the parameters'),
    h4('Just move the sliders to make your MSE=0!'),
    sliderInput('mean0','Move this bar to change the FIRST mean',value=0,min=-20,max=20,step=0.1),
    sliderInput('std0','Move this bar to change the FIRST std',value=0.1,min=0.1,max=10,step=0.1),
    sliderInput('mean1','Move this bar to change the SECOND mean',value=0,min=-20,max=20,step=0.1),
    sliderInput('std1','Move this bar to change the SECOND std',value=0.1,min=0.1,max=10,step=0.1),
    actionButton("submit","They say everything exists for a reason."),
    actionButton("submit","But I don't know why I am here.")
  ),

  mainPanel(
    h3('Match the Gaussian Mixture model!'),
    h4('The hidden truth and your guess'),
    plotOutput('duoPlots'),
    h4('Your Error'),
    plotOutput('errorPlot')

  )
  
))
