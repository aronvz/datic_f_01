library(readr)
#The master Databases are in "Proyectos ejecucion, 2018, F Emilia."
EGR2014 <- read_delim("D:/Work/Datic/FEmilia_Datos/SSegreso2014/egr_2014.csv", 
                      ";", escape_double = FALSE, trim_ws = TRUE)

DEF2014 <- read_delim("D:/Work/Datic/FEmilia_Datos/SSPais2014/DEF2014.csv", 
                      ";", escape_double = FALSE, trim_ws = TRUE)