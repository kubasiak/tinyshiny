
source("UI/panel1.r")
source("UI/panel2.r")


header<-  dashboardHeader(title='Title')
sidebar<-  dashboardSidebar(
  
  
  
  
  sidebarMenu(
    
    img(src="logo01.png",width=230),
    hr(),
    menuItem("Panel One", tabName = "tabOne", icon = icon("map-marker"))
    ,
    hr(),
    menuItem("Panel Two", tabName = "tabTwo", icon = icon("bar-chart"))

  )
)
body<-  dashboardBody(
  
  ######################################################################################  
  # Also add some custom CSS to make the title background area the same
  # color as the rest of the header.
  tags$link(rel = "stylesheet", type = "text/css", href = "custom_light.css"),
  tags$head(includeCSS('www/style.css')),
  tags$head(tags$style(HTML(".handsontable col.rowHeader { width: 140px; } "))),
  
  
  ######################################################################################  
  tabItems(
    tab_One
    ,
    tab_Two

    
  )# end of tab items
)# end of dashboard body

###############################################################################################

shinyUI<-dashboardPage(header,sidebar,body,skin='purple')
#shinyUI<-navbarPage(header,sidebar,body,skin='purple',position = "fixed-top")
