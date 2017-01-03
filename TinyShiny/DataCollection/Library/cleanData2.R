cleanData2<-function(){
  if(1){
  print('Getting data')
idx<-read.csv("./Data/Index.csv",sep=";")
idx$idxName<-gsub("[[:space:]]", "", idx$idxName)
idx$idxDescription<-gsub("\n", "", idx$idxDescription)

return(list(idx))}
}