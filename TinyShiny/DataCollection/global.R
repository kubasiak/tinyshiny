

################## installing packages & sourcing libraries ####################
Paq <-c("stringr",
        "ggplot2",
        "shiny",
        "dplyr",
        "magrittr",
        'rhandsontable',
        'devtools',
        'shinydashboard',
        'shinyBS'
        )


installed<-rownames(installed.packages)



advLibrary <- function (paq) {
  if(any(!paq %in% rownames(installed.packages()))) {
    print("Installing packages...")
    install.packages(pkgs = paq[!paq %in% rownames(installed.packages())], quiet = T)
  }
  else{
    print("All required packages already installed")
  }
  invisible(sapply(paq[paq %in% installed.packages()], library, character.only = T, warn.conflicts = F, quietly = T, verbose = F))
  paste("Loaded packages ", paste(paq[paq %in% installed.packages()], collapse = ", "), ".", sep = "")
}

advLibrary(Paq) 


################## sourcing files ####################

################# sourcing the library ###########################
sourceDir <- function(path, trace = TRUE, ...) {
  for (nm in list.files(path, pattern = "\\.[RrSsQq]$")) {
    if(trace) cat(nm,":")           
    source(file.path(path, nm), ...)
    if(trace) cat("\n")
  }
}

path_library="Library/"
sourceDir(path_library)
# source("Lib/choosefile.r")




