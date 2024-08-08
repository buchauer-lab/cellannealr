# Check if a conda environment for running cellanneal exists and installs it if necessary
.onAttach <- function(libname, pkgname){
              if(!reticulate::condaenv_exists("cellannealr-internal")){
                packageStartupMessage("Creating cellannealr-internal conda environment and installing cellanneal and its dependencies")
                reticulate::conda_create("cellannealr-internal", "python==3.10", channel = "anaconda")
                reticulate::conda_install("cellannealr-internal", c("numpy==1.24", "scipy==1.9",
                                                             "matplotlib==3.7", "pandas==1.5",
                                                             "seaborn==0.12"))
                reticulate::conda_install("cellannealr-internal",
                                           c("openpyxl==3.0",
                                             "xlrd==1.2"),
                                           channel = "anaconda")
                reticulate::use_condaenv("cellannealr-internal")
                curl::curl_download("https://github.com/LiBuchauer/cellanneal/archive/refs/heads/master.zip", destfile = "./cellanneal.zip")
                utils::unzip("cellanneal.zip")
                reticulate::py_install("cellanneal-master/", pip = TRUE)
                file.remove("cellanneal.zip")
                unlink("cellanneal-master", recursive = TRUE)
              }
            }

