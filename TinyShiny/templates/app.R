
rm(list = ls(all = TRUE)); gc()

T<-TRUE
F<-FALSE
setwd('C:/Users/...')

source("global.r")
source("ui.r")

shinyApp(shinyUI,server)
