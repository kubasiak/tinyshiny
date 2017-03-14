
# setwd("./DataCollection")
source("global.R")
function(input,output,session){
  
  
  alldata<-cleanData2()
  idx<-alldata[[1]]
  
  idx<-cleanData2()[[1]]
  
  # all info about selected indices will be stored here
  allSelectedIdxTable<-reactive({
    merge(hot_to_r(input$ownershipTable)[c("idxId","Owner")],allSelectedIdx(),by="idxId",all.y=TRUE)
    })
  allSelected<-reactive(c(input$indexSelection1,input$indexSelection2,input$indexSelection3,input$indexSelection4,input$indexSelection5,input$indexSelection6,input$indexSelection7,input$indexSelection8))
  
   allSelectedIdx<- reactive (idx[idx$idxName %in% allSelected(),]) 
   if(file.exists("Data/allSelected.csv")){
     cho<-read.csv("Data/allSelected.csv",sep=";",stringsAsFactors = FALSE)[[1]]
   }else(cho<-as.character(idx$idxName[idx$idxLabel=="Obligatory"]))
   ##
   
  source('Render/indexSelectionRender.R', local = TRUE)$value
   observeEvent(input$SaveIdxSelection,{
     write.table(allSelected(),"Data/allSelected.csv",sep=";",row.names=FALSE)
   })
   
  # selected indices print out
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
      hot_col(names(df)[names(df)!="Owner"], readOnly = TRUE)
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
    DF<<-hot_to_r(input$ownershipTable)
    write.table(DF,"Data/Owners.csv",sep=";",row.names=FALSE)

    # print(names(allSelectedIdxTable))
    # write.table(allSelectedIdxTable(),"Data/allSelectedIdxTable.csv",sep=";",row.names=FALSE)
  })
  
  output$testOutput<-renderPrint("In this tab please select the indices that you would like to include in your Report. The indices are grouped in Categories and Aspects. ")
  
  output$owners<-renderTable(allSelectedIdxTable())
  ################################################  DATA #################################
  output$selectOwner<-renderUI({
   ## to niestety nie dziala 
    DF<<-hot_to_r(input$ownershipTable)
    if(is.null(nrow(DF)) | !"Owner" %in% names(DF)){return()}else{
    selectizeInput(inputId="selectOwner",choices=unique(DF$Owner),label="Owner")
}
    })
  
  
} # end server


######################################

# test_case <- hot_to_r(input$all_updates)


