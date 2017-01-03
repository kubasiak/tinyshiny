tabItem_Owners<-  tabItem(tabName = "Owners",
                          fluidPage(
                            h2("Ownership Setting"),
                            
                            
                            tabsetPanel(
                              tabPanel("Insert Owners",
                                       actionButton('saveOwners',"Save")
                                       ,
                                       column(width=8,
                                              rHandsontableOutput("ownershipTable")),
                                       column(width=4,
                                              verbatimTextOutput('description')       
                                       )
                                       
                                       
                              ),
                              
                              tabPanel("Result",
                                       column(width=6),
                                       column(width=6)
                                       
                                       
                              )
                            )
                          )
) # end tabitem Owners