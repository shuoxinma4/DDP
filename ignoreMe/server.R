library(shiny)
TIME_INTERVAL<-1000
FRAME_PER_SECOND<-1000/TIME_INTERVAL
movementUpdate<-function(movementVectorIn){
  movementVectorIn$xPos<-movementVectorIn$xPos+FRAME_PER_SECOND*movementVectorIn$xSpeed
  movementVectorIn$xSpeed<-movementVectorIn$xSpeed+FRAME_PER_SECOND*movementVectorIn$xAcc
  return(movementVectorIn)
}

shinyServer(
  function(input,output,session){
    values <- reactiveValues()
    values$xPos<-0
    values$xSpeed<-0
    values$xAcc<-0
    output$inputValue1<-renderPrint({
      input$submit
      isolate(input$xAcc)
      })
    thisTimer<-reactiveTimer(intervalMs = TIME_INTERVAL, NULL)
    observe({
      thisTimer()
      isolate(values$xAcc<-input$xAcc)
      isolate(values<-movementUpdate(movementVectorIn=values))
      output$inputValue2<-renderPrint({isolate(values$xPos)})
    })
  }
  
)
