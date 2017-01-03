
# setwd("./DataCollection")
source("global.R")
function(input,output,session){
  
  alldata<-cleanData2()
  idx<-alldata[[1]]
  
  idx<-cleanData2()[[1]]
  
  # var<-alldata[[2]]
  # attr<-alldata[[3]]
  # idxGroup<-alldata[[4]]
  
  allSelected<-reactive(c(input$indexSelection1,input$indexSelection2,input$indexSelection3,input$indexSelection4,input$indexSelection5,input$indexSelection6,input$indexSelection7,input$indexSelection8))
  allSelectedIdx<- reactive (idx[idx$idxName %in% allSelected(),]) 
  ownershipValues <- reactiveValues()
  
  source('Render/indexSelectionRender.R', local = TRUE)$value
   
  
  output$selected=renderPrint({
    cat('Selected Indices',allSelected(),sep="\n")
  })
  
  output$selectedTable<-renderTable({
    columns=6
    values<-character()
    values<-c(allSelected(),rep("",columns-mod(length(allSelected()),columns)))
    matrix(values,ncol=columns)},include.colnames=FALSE)
  
############################################# O W N E R S ###################################################
  
  output$ownershipTable=renderRHandsontable({
    df<-data.frame(idxId=allSelectedIdx()$idxId,Name=allSelectedIdx()$idxName,
               # Description=allSelectedIdx()$idxDescription %>% substr(1,40),
               Category=allSelectedIdx()$idxCategory)
    ROnames<-names(df)
   
    if(file.exists("Data/Owners.csv")){
      print('file Exists')
      ownerTableFromFile<-read.csv("Data/Owners.csv",sep=";",stringsAsFactors = FALSE)
      df<-merge(df,ownerTableFromFile[,c('idxId','Owner')], by='idxId',all.x=TRUE)
      df$Owner[is.na(df$Owner)]<-""
    }else{
    df$Owner<-rep("",nrow(allSelectedIdx()))
    }
   
    rhandsontable(df,selectCallback = TRUE,readOnly = FALSE, rowHeaders = NULL)%>%
      hot_col(ROnames[1:length(ROnames)], readOnly = TRUE)
  })

  
  output$description=renderPrint({
    thisrow<-input$ownershipTable_select$select$r
    thisIndex<-allSelectedIdx()$idxName[thisrow]
    thisIndexCategory<-allSelectedIdx()$idxCategory[thisrow] %>% as.character()
    thisIndexAspect<-allSelectedIdx()$idxAspect[thisrow]%>% as.character()
    thisDescription<-allSelectedIdx()$idxDescription[thisrow]
    cat(thisIndex,'\n',thisIndexAspect,'\n\n',thisDescription)
  })
  
  observeEvent(input$saveOwners,{
    DF<-hot_to_r(input$ownershipTable)
    write.table(DF,"Data/Owners.csv",sep=";",row.names=FALSE)
  })
  
  output$testOutput<-renderPrint("In this tab please select the indices that you would like to include in your Report. The indices are grouped in Categories and Aspects. ")
  
} # end server


######################################

# test_case <- hot_to_r(input$all_updates)


