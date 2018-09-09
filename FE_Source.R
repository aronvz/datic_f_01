library(readxl)

#The master Databases are in "Proyectos en ejecucion\\2018\\Fundacion Emilia"
datadir <- c("Proyectos en ejecucion\\2018\\Fundacion Emilia\\")
pcdir <- c("G:\\Unidades de equipo\\")

#Base de datos Siniestros viales Carabineros de Chile. Solicitud por Ley de Transparencia
Siniestros10_17 <- read_excel(paste0(pcdir,datadir,"SINIESTROS 2010-2017.xlsx"))


#Base de datos Homicidios. Subsecretaria de Prevencion del delito
FreqDenuncias10_16 <- read_excel(paste0(pcdir,datadir,"Frec_DENUNCIAS_ANUAL_2001_2016w.xlsx"), sheet = "Homicidio", 
                                   col_names = T, skip = 3)

