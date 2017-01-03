tabItem_IndexSelection<-    tabItem(tabName = "IndexSelection",
                                    # h2("Select Indices"),
                                    
                                    fluidPage(
                                       # source("UI/tags.R")$value,
                                      
                                      column(6,
                                             
                                             tabsetPanel(
                                               tabPanel("G4",
                                                        tags$div(class = "multicol", uiOutput("indexSelection1"))
                                               ), 
                                               
                                               tabPanel("EN & EC",
                                                        column(width=6,
                                                               uiOutput('indexSelection2')),
                                                        column(width=6,
                                                               uiOutput('indexSelection3')
                                                               )
                                               ), 
                                               
                                               tabPanel("FS, HR & LA",
                                                        column(width=6,
                                                               uiOutput('indexSelection4'),
                                                               uiOutput('indexSelection5')),
                                                        column(width=6,
                                                               uiOutput('indexSelection6')
                                                        )
                                               ),
                                               tabPanel("SO & PR",
                                                        column(width=6,
                                                               uiOutput('indexSelection7')),
                                                        column(width=6,
                                                               uiOutput('indexSelection8')
                                                        )
                                               )
                                             ) # end TabSetPanel
                                      ),
                                      
                                      column(width=6,
                                            
                                             # tags$div(class = "multicol",  verbatimTextOutput('selected'))
                                             # verbatimTextOutput('selected'),
                                             box(width='100%', tableOutput('selectedTable'))
                                            
                                             )
                                    ), # end fluidpage
                                    tags$style(type='text/css', "#shiftup { width:100%; margin-top: 25px;}"),
                                    tags$style(type='text/css', "#shiftup { width:100%; margin-left: 10px;}")
)