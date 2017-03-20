gaussParametersEM<-function(allX,fittedGammas=NULL,fittedMu=NULL,fittedSigma=NULL,fittedPi=NULL,realMu=NULL, realSigma=NULL,realPi=NULL,d,K){
  
  Nk<-apply(fittedGammas,2,sum)
  N<-round(sum(Nk))
  ## fitting MU
  if (!is.null(realMu)){fittedMuNew<-realMu}else{
    fittedMuNew<-sapply(1:K,function(k){t(allX)%*%fittedGammas[,k]/Nk[k]})
    fittedMuNew<-as.data.frame(fittedMuNew)
    names(fittedMuNew)<-paste0("mu",1:K)
  }
  ## fitting Sigma
  if (!is.null(realSigma)){fittedSigmaNew<-realSigma}else{
    fittedSigmaNew<-list()
    for (k in 1:K){
      # vect<-as.matrix(allX-t(fittedMu[,k]))
      fittedSigmaNew[[k]]<-matrix(0,ncol=d,nrow=d)
      for (n in 1:nrow(allX)){
        # temp<-matrix(vect[n,])
        temp<-matrix(allX[n,]-t(fittedMu[,k]))
        fittedSigmaNew[[k]]<-fittedSigmaNew[[k]]+
          temp%*%t(temp)*fittedGammas[n,k]
      }
      fittedSigmaNew[[k]]<-fittedSigmaNew[[k]]/Nk[k]
    }
  }
  
  ## fitting Pi
  if(!is.null(realPi)){fittedPiNew<-realPi}else{
    fittedPiNew<-Nk/N
  }
  
  return(list(fittedMuNew,fittedSigmaNew,fittedPiNew))
}