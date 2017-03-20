# setwd('TinyShiny/MixingModelsPart1/')
library(dplyr)
library(magrittr)
library(mcsm)
library(mvtnorm)
library(ellipse)
library(ggplot2)
source('gammaNK.R')
source('gaussParametersEM.R')
#Number of distributions
K=4
d=2
s<-0.6
nSim<-800
nIter<-100
maxMu<-4.5
minSigma<-0.1
# parameters of each distribution
mu<-list()
sigma<-list()
ellip<-list()

for (i in 1:K){
  mu[[i]]<-runif(d,min=-maxMu,max=maxMu)
  mat1<-matrix(rnorm(d^2,0,s),ncol=d)
  sigma[[i]]<-mat1%*%t(mat1)+minSigma
  ellip[[i]]<-ellipse(sigma[[i]],centre=mu[[i]])
}
# color for each distribution
distColor<-data.frame(hsv=hsv((1:K)/K))
distColor$distR=distColor$hsv %>% substr(2,3) %>% as.hexmode %>% as.integer
distColor$distG=distColor$hsv %>% substr(4,5)%>% as.hexmode %>% as.integer
distColor$distB=distColor$hsv %>% substr(6,7)%>% as.hexmode %>% as.integer

# prior probabilities 
temp<-runif(K,min=0,max=1)
pi<-round(temp/sum(temp),2) 
muDf<-as.data.frame(mu)
names(muDf)<-paste0("mu",1:K)

# simulating measurments
x<-list()
allX<-NULL
idx<-0
xlimits<-c(0,0)
for(i in  1:K)
{
  sampleSize<-round(nSim*pi[i])
  # x[[i]]<-mvrnorm(n=sampleSize,mu=mu[[i]],Sigma=sigma[[i]])
  x[[i]]<-rmvnorm(n=sampleSize,mean=mu[[i]],sigma=sigma[[i]])
  
  allX<-rbind(allX,x[[i]])
}
colnames(allX)<-paste0("d",1:d)



#############################################################################
# Setting some starting parameters for component distributions
fittedEllip<-list()
fittedPi<-rep(1,K)/K
fittedMu<-data.frame(matrix(rep(0,K*d),ncol=K))
fittedMu<-data.frame(matrix(sample((1:10)/3,K*d,replace=TRUE),ncol=K))
names(fittedMu)<-paste0("mu",1:K)
fittedSigma<-list()
for (k in 1:K){
  fittedSigma[[k]]<-diag(1,d)*abs(rnorm(d))
  fittedEllip[[k]]<-ellipse(fittedSigma[[k]],centre=fittedMu[,k])
}


# #  Iteratin - finding best parameters

delta<-integer()
epsilon<-10e-3
fittedGammas<-as.data.frame(matrix(0,nrow(allX),ncol=K))
par(mfrow=c(1,2))
maxIter=0
for (i in 1:nIter)
{
  oldGammas<-fittedGammas
  fittedGammas<-gammaNK(allX,fittedMu,fittedSigma,fittedPi,K,d)
  
  newDelta<-sum((oldGammas-fittedGammas)^2)
  delta<-c(delta,newDelta)
  if(newDelta>epsilon)
  {
    maxIter<-i
    newParameters<-gaussParametersEM(allX,fittedGammas = fittedGammas, fittedMu = fittedMu, fittedSigma=fittedSigma, fittedPi=fittedPi,d=d,K=K)
    
    
    fittedMu<-newParameters[[1]]
    fittedSigma<-newParameters[[2]]
    fittedPi<-newParameters[[3]]
  }
  fittedEllip<-list()
  if (i%%2==0 | i==1){
    plot(log(delta), type='l', xlim=c(0,nIter),col='red',lwd=2)
    plot(allX, cex=0.7, main=paste('iteration ',maxIter))
  }
  
  for (k in 1:K){
    fittedEllip[[k]]<-ellipse(fittedSigma[[k]],centre=fittedMu[,k])
    if (i%%2==0 | i==1){
      lines(fittedEllip[[k]],col=k+1,lwd=2)}
    
  }
}
for (k in 1:K)
{lines(ellip[[k]],lwd=1)
}
par(mfrow=c(1,1))


###################################
# Labeling problem

# We have now fitted K distributions to replicate original K distributions, we don't know however which order is correct. fittedMu[[1]] does not have to correspond to mu[[1]]

sim<-matrix(0,ncol=K,nrow=K)
for(k1 in 1:K){
  for (k2 in 1:K )
sim[k1,k2]<-gaussianSimilarity(k1,k2,allX,mu,sigma,fittedMu,fittedSigma,d)
}


sim<-round(sim,3)
# sim<-(1/pi) %*% t(1/pi) %*% sim %*%( 1/pi) %*% t(1/pi)
 sim<-sapply(1:K,function(k1){sim[k1,]/sum(sim[k1,])})
# sim<-sapply(1:K,function(k2){sim[,k2]/pi[k2]})

msg<-"Not unique solution"
Kfitted<-sapply(1:K,function(k){which(sim[,k]==max(sim[,k]))})
if (sum(duplicated(Kfitted))==0){msg<-"Well Done! Unique solution"}
fittedSigmaOrdered<-fittedSigma[Kfitted]
fittedMuOrdered<-fittedMu[Kfitted]
fittedPiOrdered<-fittedPi[Kfitted]
fittedEllipOrdered<-fittedEllip[Kfitted]

fittedGammas<-gammaNK(allX,fittedMu,fittedSigma,fittedPi,K,d)
finalGammas<-gammaNK(allX,fittedMuOrdered,fittedSigmaOrdered,fittedPiOrdered,K,d)
realGammas<-gammaNK(allX[,1:2],muDf,sigma,pi,K,d)



allXColors<-as.matrix(finalGammas)%*%as.matrix(distColor[,2:4]) %>% round() %>% as.data.frame
allXColors$color<-paste0("#",as.hexmode(allXColors$distR),as.hexmode(allXColors$distG),as.hexmode(allXColors$distB))


# allXColorsReal<-as.matrix(realGammas)%*%as.matrix(distColor[,2:4]) %>% round() %>% as.data.frame
# allXColorsReal$colorReal<-paste0("#",as.hexmode(allXColors$distR),as.hexmode(allXColors$distG),as.hexmode(allXColors$distB))


## plotting
p<-ggplot(data=data.frame(allX),aes(d1,d2))+geom_point(alpha=1/4,color=allXColors$color,size=1.5)+theme_bw()+ggtitle(msg)
for (k in 1:K){
  p<-p+geom_path(data=as.data.frame(ellip[[k]]),aes(x,y),color=distColor$hsv[k])+geom_path(data=as.data.frame(fittedEllipOrdered[[k]]),aes(x,y),color=distColor$hsv[k],linetype=2)
}
p
