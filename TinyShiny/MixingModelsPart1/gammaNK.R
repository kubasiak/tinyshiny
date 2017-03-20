gammaNK<-function(allX,fittedMu,fittedSigma,fittedPi,K,d){
  
  #  calculating posterior for each simulated point in allX
  gammas<-numeric()
  
  for (k in 1:K){
    gamma<-fittedPi[k]*dmvnorm(allX[,1:2],mean=fittedMu[,k],sigma=fittedSigma[[k]])
    gammas<-cbind(gammas,gamma)
  }
  gammas<-as.data.frame(gammas)
  colnames(gammas)<-paste0("gamma",1:K)
  gammas$normalisation<-apply(gammas,1,sum)
  gammas[,1:K]<-gammas[,1:K]/gammas$normalisation
  
  gammas$normalisation<-NULL
  gammas
}