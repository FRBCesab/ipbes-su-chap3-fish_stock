#' IPBES Sustainable Use Assessment - Figure Chapter 3 - Global Fish Stocks
#' 
#' This R script reproduces the Figure 'Global Fish Stock' of the chapter 3 
#' of the IPBES Sustainable Use Assessment. This figure shows the evolution of
#' the estimated abundance of global fish stocks.
#' 
#' @author Nicolas Casajus <nicolas.casajus@fondationbiodiversite.fr>
#' @date 2022/02/07



## Install `remotes` package ----

if (!("remotes" %in% installed.packages())) install.packages("remotes")


## Install required packages (listed in DESCRIPTION) ----

remotes::install_deps(upgrade = "never")


## Load project dependencies ----

devtools::load_all(".")

