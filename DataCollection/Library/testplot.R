testplot<-function(N=100,col='steelblue'){
  #' Test plot
  #'
  #' This is a function to plot simple plot in color
  #' @param N test sample
  #' @param col marker color
  #' @keywords test
  #' @export
  #' @examples testplot(N=50,col="red")

  var<-rnorm(N)
  prob<-dnorm(var)
  plot(var,prob,col=col,pch=21,bg='lightblue',main="Testplot")
  text(x=mean(var),y=mean(prob),paste("N =",as.character(N)))

}
