sidebar <- dashboardSidebar(
  # source("UI/tags.R")$value,
  sidebarMenu(
    menuItem("Hello", tabName="Title"),
    menuItem("Index Selection",
             # id="subtabs", 
             tabName = "IndexSelection", 
             icon = icon("dashboard")
             # ,
             # tags$div(class="smaller", 
             #          menuSubItem("G4 General Standard Disclosures", tabName="G4selection"),
             #          menuSubItem("G4 Specific Standard Disclosures", tabName="G4x")
             #          
             # )
    )
    ,
    menuItem("Owners", icon = icon("th"), tabName = "Owners",
             badgeLabel = "new", badgeColor = "green")
  )
)


