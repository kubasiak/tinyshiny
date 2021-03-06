header <- dashboardHeader(
  title = "Tool"
)
# source("UI/tags.R")$value
# source("UI/sidebar.R")

source("UI/tabItem_IndexSelectionTitle.R")
source("UI/tabItem_IndexSelectionResult.R")
source("UI/tabItem_Owners.R")
source("UI/tabItem_G4Selection.R")
source("UI/tabItem_G4xSelection.R")
source("UI/tabItem_DataCollection.R")


sidebar<-dashboardSidebar(
  width = 290,
  source("UI/tags.R")$value,
  sidebarMenu(
    menuItem('Index Selection', tabName = 'IndexSelect', icon = icon('line-chart'), 
             menuSubItem("Index choice",tabName="IndexSelectionTitle"),
            
             # menuSubItem("Index Selection 1", tabName="IndexSelection")
             menuSubItem('G4 General Std Disclosures', tabName = 'G4Selection' ),
             menuSubItem('G4 Specific Std Disclosures', tabName = 'G4xSelection'),
             menuSubItem("Selected Indices", tabName="IndexSelectionResult"),
             actionButton(inputId="SaveIdxSelection","Save")
    ),
    menuItem('Owners', tabName="Owners"),
    menuItem('Data Collection', tabName="DataCollection")
  )
)

body <- dashboardBody(
  
  tabItems(
    tabItem_IndexSelectionTitle,
    tabItem_IndexSelectionResult,
    tabItem_G4Selection,
    tabItem_G4xSelection,
    tabItem_Owners,
    tabItem_DataCollection
  )  
)

dashboardPage(
  header,
  sidebar,
  body
)
