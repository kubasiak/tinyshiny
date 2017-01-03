cleanData<-function(){
  if(1){
  print('Getting data')
idx<-read.csv("./Data/wskazniki_demo2.csv",sep=";")
var<-read.csv("./Data/zmienne_demo.csv",sep=";")
attr<-read.csv("./Data/atrybuty_demo.csv",sep=";")
idxGroup<-read.csv("Data/idxGroups_demo.csv",sep=";")

names(idx)<-c("idxId","idxName","idxDescription","idxGroup","idxGroupId")
names(var)<-c("varId","varName","varUnit","varDescription","idxId")
names(attr)<-c("attrId","attrName","varId","idxId")
idx$idxName<-gsub("[[:space:]]", "", idx$idxName)
idx$idxDescription<-gsub("\n", "", idx$idxDescription)


return(list(idx,var,attr,idxGroup))}
}