library(readr)
#The master Databases are in "Proyectos en ejecucion\\2018\\Fundacion Emilia"
datadir <- c("Proyectos en ejecucion\\2018\\Fundacion Emilia")
pcdir <- c("G:\\Unidades de equipo\\")

EGR2014 <- read_delim(paste0(pcdir,datadir,"egr_2014.csv"), 
                      ";", escape_double = FALSE, trim_ws = TRUE)

DEF2014 <- read_delim(paste0(pcdir,datadir,"DEF2014.csv"), 
                      ";", escape_double = FALSE, trim_ws = TRUE)