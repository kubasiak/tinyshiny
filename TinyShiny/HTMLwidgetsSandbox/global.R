
myseed <- 2345
# Clear the console
cat("\014")
# Remove scientific notation
options(scipen=999)


################## installing packages & sourcing libraries ####################
Paq <-c("shiny",
        "htmlwidgets",
        "dplyr",
        "magrittr"
)



advLibrary <- function (paq) {
  if(any(!paq %in% rownames(installed.packages()))) {
    print("Installing packages...")
    install.packages(pkgs = paq[!paq %in% rownames(installed.packages())], quiet = T)
  }
  else{
    print("All required packages already installed")
  }
  invisible(sapply(paq, library, character.only = T, warn.conflicts = F, quietly = T, verbose = F))
  paste("Loaded packages ", paste(paq, collapse = ", "), ".", sep = "")
}

advLibrary(Paq) 


################# sourcing the library ###########################
sourceDir <- function(path, trace = TRUE, ...) {
  for (nm in list.files(path, pattern = "\\.[RrSsQq]$")) {
    if(trace) cat(nm,":")           
    source(file.path(path, nm), ...)
    if(trace) cat("\n")
  }
}

path_library="Lib/"
sourceDir(path_library)



