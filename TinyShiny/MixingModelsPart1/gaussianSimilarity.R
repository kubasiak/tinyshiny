gaussianSimilarity<-function(k1,k2,allX,muList1,sigmaList1,muList2,sigmaList2,d){
  
  mu1<-muList1[[k1]]
  mu2<-muList2[[k2]]
  sigma1<-sigmaList1[[k1]]
  sigma2<-sigmaList2[[k2]]
  sum(dmvnorm(allX[,1:d],mean=mu1,sigma=sigma1)*dmvnorm(allX[,1:d],mean=mu2,sigma=sigma2))
   
}