tabItem_G4xSelection<-tabItem(tabName="G4xSelection",
                              # h2("Select Indices"),
                              
                              fluidPage(
                                # source("UI/tags.R")$value,
                                
                           
                                       
                                       tabsetPanel(
                                         
                                         tabPanel("Economy & Environment",
                                                  column(width=6,
                                                         uiOutput('indexSelection2')),
                                                  column(width=6,
                                                         uiOutput('indexSelection3'),
                                                         uiOutput('indexSelection4')
                                                  )
                                         ), 
                                         
                                         tabPanel("Human Rights & Labor Practices",
                                                  column(width=6,
                                                         uiOutput('indexSelection5')),
                                                  column(width=6,
                                                         uiOutput('indexSelection6')
                                                  )
                                         ),
                                         tabPanel("Society & Product Responsibility",
                                                  column(width=6,
                                                         uiOutput('indexSelection7')),
                                                  column(width=6,
                                                         uiOutput('indexSelection8')
                                                  )
                                         )
                                       ) # end TabSetPanel
                                
                                       
                                
                              ), # end fluidpage
                              tags$style(type='text/css', "#shiftup { width:100%; margin-top: 25px;}"),
                              tags$style(type='text/css', "#shiftup { width:100%; margin-left: 10px;}")
                              
                             )