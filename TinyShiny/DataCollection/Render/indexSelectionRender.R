indexList1<-  as.character(idx$idxName[idx$idxCategoryId==1])
special1<- as.character(idx$idxName[idx$idxCategoryId==1 & idx$idxLabel=='Obligatory'])


#####################################################################################################
indexDescription1<- as.character(idx$idxDescription[idx$idxCategoryId==1] )
categ1<-unique(idx$idxCategory[idx$idxCategoryId==1])


output$indexSelection1<-renderUI({
  list(
    checkboxGroupInput("indexSelection1",
                       tags$span(categ1,   
                                 tipify(bsButton("idx1", "?", style = "inverse", size = "extra-small"), "Group 1")),
                       choices=indexList1,selected=cho) ,
    makeCheckboxTooltip(checkboxValue=indexList1,buttonLabel="?",Tooltip=indexDescription1,specialOnes = special1)
    
  )
})
###########################################################################################################
indexList2<-  as.character(idx$idxName[idx$idxCategoryId==2])
special2<- as.character(idx$idxName[idx$idxCategoryId==2 & idx$idxLabel=='Obligatory'])


indexDescription2<- as.character(idx$idxDescription[idx$idxCategoryId==2] )
categ2<-unique(idx$idxCategory[idx$idxCategoryId==2])

output$indexSelection2<-renderUI({
  list(
    checkboxGroupInput('indexSelection2',
                       tags$span(categ2,   
                                 tipify(bsButton("idx2", "?", style = "inverse", size = "extra-small"), "Group 2")),
                       choices=indexList2,selected=cho),
    makeCheckboxTooltip(checkboxValue=indexList2,buttonLabel=rep("?"),Tooltip=indexDescription2, specialOnes = special2)
    
  )
})
###########################################################################################################
indexList3<-  as.character(idx$idxName[idx$idxCategoryId==3])
special3<- as.character(idx$idxName[idx$idxCategoryId==3 & idx$idxLabel=='Obligatory'])

indexDescription3<- as.character(idx$idxDescription[idx$idxCategoryId==3] )
categ3<-unique(idx$idxCategory[idx$idxCategoryId==3])

output$indexSelection3<-renderUI({
  list(
    checkboxGroupInput("indexSelection3",
                       tags$span(categ3,   
                                 tipify(bsButton("idx3", "?", style = "inverse", size = "extra-small"), "Group 3")),
                       choices=indexList3,selected=cho),
    makeCheckboxTooltip(checkboxValue=indexList3,buttonLabel=rep("?"),Tooltip=indexDescription3,special3)
    
  )
})
###########################################################################################################
indexList4<-  as.character(idx$idxName[idx$idxCategoryId==4])
special4<- as.character(idx$idxName[idx$idxCategoryId==4 & idx$idxLabel=='Obligatory'])

indexDescription4<- as.character(idx$idxDescription[idx$idxCategoryId==4] )
categ4<-unique(idx$idxCategory[idx$idxCategoryId==4])

output$indexSelection4<-renderUI({
  list(
    checkboxGroupInput("indexSelection4",
                       tags$span(categ4,   
                                 tipify(bsButton("idx4", "?", style = "inverse", size = "extra-small"), "Group 4")),
                       choices=indexList4,selected=cho) ,
    makeCheckboxTooltip(checkboxValue=indexList4,buttonLabel=rep("?"),Tooltip=indexDescription4,specialOnes = special4)
    
  )
})
###########################################################################################################
indexList5<-  as.character(idx$idxName[idx$idxCategoryId==5])
special5<- as.character(idx$idxName[idx$idxCategoryId==5 & idx$idxLabel=='Obligatory'])

indexDescription5<- as.character(idx$idxDescription[idx$idxCategoryId==5] )
categ5<-unique(idx$idxCategory[idx$idxCategoryId==5])

output$indexSelection5<-renderUI({
  list(
    checkboxGroupInput("indexSelection5",
                       tags$span(categ5,   
                                 tipify(bsButton("idx5", "?", style = "inverse", size = "extra-small"), "Group 5")),
                       choices=indexList5,selected=cho) ,
    makeCheckboxTooltip(checkboxValue=indexList5,buttonLabel=rep("?"),Tooltip=indexDescription5,specialOnes = special5)
    
  )
})
###########################################################################################################
indexList6<-  as.character(idx$idxName[idx$idxCategoryId==6])
special6<- as.character(idx$idxName[idx$idxCategoryId==6 & idx$idxLabel=='Obligatory'])

indexDescription6<- as.character(idx$idxDescription[idx$idxCategoryId==6] )
categ6<-unique(idx$idxCategory[idx$idxCategoryId==6])

output$indexSelection6<-renderUI({
  list(
    checkboxGroupInput("indexSelection6",
                       tags$span(categ6,   
                                 tipify(bsButton("idx6", "?", style = "inverse", size = "extra-small"), "Group 6")),
                       choices=indexList6,selected=cho) ,
    makeCheckboxTooltip(checkboxValue=indexList6,buttonLabel=rep("?"),Tooltip=indexDescription6,specialOnes = special6)
    
  )
})
###########################################################################################################
indexList7<-  as.character(idx$idxName[idx$idxCategoryId==7])
special7<- as.character(idx$idxName[idx$idxCategoryId==7 & idx$idxLabel=='Obligatory'])

indexDescription7<- as.character(idx$idxDescription[idx$idxCategoryId==7] )
categ7<-unique(idx$idxCategory[idx$idxCategoryId==7])

output$indexSelection7<-renderUI({
  list(
    checkboxGroupInput("indexSelection7",
                       tags$span(categ7,   
                                 tipify(bsButton("idx7", "?", style = "inverse", size = "extra-small"), "Group 7")),
                       choices=indexList7,selected=cho) ,
    makeCheckboxTooltip(checkboxValue=indexList7,buttonLabel=rep("?"),Tooltip=indexDescription7,specialOnes = special7)
    
  )
})
###########################################################################################################
indexList8<-  as.character(idx$idxName[idx$idxCategoryId==8])
special8<- as.character(idx$idxName[idx$idxCategoryId==8 & idx$idxLabel=='Obligatory'])

indexDescription8<- as.character(idx$idxDescription[idx$idxCategoryId==8] )

categ8<-unique(idx$idxCategory[idx$idxCategoryId==8])

output$indexSelection8<-renderUI({
  list(
    checkboxGroupInput("indexSelection8",
                       tags$span(categ8,   
                                 tipify(bsButton("idx8", "?", style = "inverse", size = "extra-small"), "Group 8")),
                       choices=indexList8,selected=cho) ,
    makeCheckboxTooltip(checkboxValue=indexList8,buttonLabel=rep("?"),Tooltip=indexDescription8,specialOnes=special8)
    
  )
})
###########################################################################################################
###########################################################################################################

