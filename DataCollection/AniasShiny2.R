library(shiny)
library(shinyBS)
source('global.R')

server <- function(input, output) {
  
  # makeCheckboxTooltip <- function(checkboxValue, buttonLabel, Tooltip){
  #   tags$script(HTML(paste0("
  #                           $(document).ready(function() {
  #                           var inputElements = document.getElementsByTagName('input');
  #                           for(var i = 0; i < inputElements.length; i++){
  #                           var input = inputElements[i];
  #                           
  #                           if(input.getAttribute('value') == '", checkboxValue, "'){
  #                           var buttonID = 'button_' + Math.floor(Math.random()*1000);
  #                           
  #                           var button = document.createElement('button');
  #                           button.setAttribute('id', buttonID);
  #                           button.setAttribute('type', 'button');
  #                           button.setAttribute('class', 'btn action-button btn-inverse btn-xs');
  #                           button.appendChild(document.createTextNode('", buttonLabel, "'));
  #                           
  #                           input.parentElement.parentElement.appendChild(button);
  #                           shinyBS.addTooltip(buttonID, \"tooltip\", {\"placement\": \"bottom\", \"trigger\": \"hover\", \"title\": \"", Tooltip, "\"}) 
  #                           };
  #                           }
  #                           });
  #                           ")))
  #                           }
  # 
  
  
  choices_from_file <- read.table("./Data/choices_ff.txt")
  cho<-as.character(choices_from_file[,1])
  # output$distPlot <- renderPlot({
  #   hist(rnorm(input$obs), col = 'darkgray', border = 'white')
  #   
    output$rendered <-   renderUI({
      list(
        checkboxGroupInput("qualdim",  tags$span("Auswahl der Qualitätsdimension",   
                                                 tipify(bsButton("pB2", "?", style = "inverse", size = "extra-small"), "Here, I can place some help")),
                choices = cho,
                selected =cho[1]),
        makeCheckboxTooltip(checkboxValue = cho, buttonLabel = "?", Tooltip = cho)
              )
    })
    
  # })
                            }

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs", "Number of observations:", min = 10, max = 500, value = 100),
      uiOutput("rendered")
    ),
    mainPanel(plotOutput("distPlot"))
  )
)

shinyApp(ui = ui, server = server)