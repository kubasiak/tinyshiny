library(dplyr)
library(magrittr)
library(mcsm)
library(mvtnorm)
library(ellipse)
library(ggplot2)
#Number of distributions
K=3
d=2
s<-0.5
nSim<-1000
# parameters of each distribution
mu<-list()
sigma<-list()
ellip<-list()
for (i in 1:K){
  mu[[i]]<-sample(1:4,d)
  mat1<-matrix(rnorm(d^2,0,s),ncol=d)
  sigma[[i]]<-mat1%*%t(mat1)
  ellip[[i]]<-ellipse(sigma[[i]],centre=mu[[i]])
}
# color for each distribution
distColor<-data.frame(hsv=hsv((1:K)/K))
distColor$distR=distColor$hsv %>% substr(2,3) %>% as.hexmode %>% as.integer
distColor$distG=distColor$hsv %>% substr(4,5)%>% as.hexmode %>% as.integer
distColor$distB=distColor$hsv %>% substr(6,7)%>% as.hexmode %>% as.integer


# prior probabilities 
temp<-runif(K,min=0,max=1)
pi<-temp/sum(temp)


# simulating
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

plot(allX,main="All simulated Points",cex=0.5)
for (i in 1:K)
{
  points(x[[i]],col=i,cex=0.5)
}

#  calculating posterior for each simulated point in allX
normalisation<-rep(0,nrow(allX))
for(i in 1:K){
normalisation<- normalisation + pi[i]*dmvnorm(allX[,1:2],mean=mu[[i]],sigma=sigma[[i]])
}
for (i in 1:K){
  gamma<-pi[i]*dmvnorm(allX[,1:2],mean=mu[[i]],sigma=sigma[[i]])/normalisation
  
  allX<-cbind(allX,gamma)
  
}
colnames(allX)[3:(K+2)]<-paste0("gamma",1:K)

# allX[,3:ncol(allX)] %<>% round() 
classification<-allX[,3:(K+2)]
classification %<>% round() %>% as.data.frame()
names(classification)<-paste0("class",1:K)
allX<-cbind(allX,classification)
# plot(allX[,1:2],main="All simulated Points",cex=0.5,col=as.matrix(classification[,1:K])%*%(1:K))



###################
 allXColors<-as.matrix(allX[,3:(K+2)])%*%as.matrix(distColor[,2:4]) %>% round() %>% as.data.frame
 allXColors$color<-paste0("#",as.hexmode(allXColors$distR),as.hexmode(allXColors$distG),as.hexmode(allXColors$distB))
allX<-cbind(allX,allXColors)
 

# plotting real distributions
p<-ggplot(data=allX,aes(d1,d2))+geom_point(alpha=1/4,color=allX$color,size=1.5)+ 
  theme_bw()
  
for (k in 1:K){
  p<-p+geom_path(data=as.data.frame(ellip[[k]]),aes(x,y),color=distColor$hsv[k])
}

p

