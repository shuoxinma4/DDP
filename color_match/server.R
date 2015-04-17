library(shiny)
# setwd("D:/codes/R/DDP/color match/")
X_MIN=-10
X_MAX=10
X_RESO=0.1
X_LEN=(X_MAX-X_MIN)/X_RESO
generateGMM<-function(thisMus,thisStds)
{
  xCoor<-seq(X_MIN,X_MAX,by = X_RESO)
  yCoor<-rep(0,X_LEN)
  for(idx in 1:length(thisMus))
    yCoor<-yCoor+1/thisStds[idx]/sqrt(2*pi)*exp(-((xCoor-thisMus[idx])^2)/(thisStds[idx]^2))
  data<-list(x=xCoor,y=yCoor)
  return(data)
}
# match the color of the current plot

shinyServer(
  function(input,output){
    estMus<-c(0,0)
    estStds<-c(1,1)
    trueMus<-c(-2,6)
    trueStds<-c(1,3)
    output$duoPlots<-renderPlot({
      estMus<-c(input$mean0,input$mean1)
      estStds<-c(input$std0,input$std1)
      thisTrueData<-generateGMM(trueMus,trueStds)
      thisEstData<-generateGMM(estMus,estStds)
      plot(thisTrueData$x,thisTrueData$y ,type = "l",col=2,ylim=c(-1,1),xlab="",ylab="")
      legend(X_MAX-5,0.8,"True distribution",text.col = 2,bty='n')
      par(new=T)
      plot(thisEstData$x,thisEstData$y ,type = "l",axes=F,col=3,ylim=c(-1,1),xlab="X coordinates",ylab="Y coordinates")
      legend(X_MAX-5,0.6,"Guessed distribution",text.col = 3,bty='n')
      par(new=F)
    })
    output$errorPlot<-renderPlot({
      estMus<-c(input$mean0,input$mean1)
      estStds<-c(input$std0,input$std1)
      thisTrueData<-generateGMM(trueMus,trueStds)
      thisEstData<-generateGMM(estMus,estStds)
      currentMSE<-round(mean((thisTrueData$y-thisEstData$y)^2),4)
      if(currentMSE<0.01)
      {
        plot(thisTrueData$x,thisTrueData$y-thisEstData$y ,type = "l",col=4,xlab="X coordinates",ylab="Y coordinates",ylim=c(-5,5))
        text(0,4.5,'You got it. Wula.')
      }
      else{
      plot(thisTrueData$x,thisTrueData$y-thisEstData$y ,type = "l",col=4,xlab="X coordinates",ylab="Y coordinates",ylim=c(-5,5))
      text(0,4.5,paste('Your MSE =',currentMSE))
      }
    })
  }
  
)
