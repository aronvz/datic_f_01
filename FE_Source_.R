library(readxl)

user <- Sys.getenv("USERNAME")
deis <- "Frec_DENUNCIAS_ANUAL_2001_2016w.xlsx"
sub_delito <- "Frec_DENUNCIAS_ANUAL_2001_2016w.xlsx"
carab_transparencia <- "SINIESTROS 2010-2017.xlsx"
censo <- "Poblacion Censo.xlsx"

if(user = "aronvz"){
  syntaxdir <- c("D:\\Work\\Datic\\FEmilia\\datic_f_01\\")
  #The master Databases are in "Proyectos en ejecucion\\2018\\Fundacion Emilia"
  datadir <- c("Proyectos en ejecucion\\2018\\Fundacion Emilia\\")
  pcdir <- c("G:\\Team Drives\\")
  #Base de datos Siniestros viales Carabineros de Chile. Solicitud por Ley de Transparencia
  Siniestros10_17 <- read_excel(paste0(pcdir,datadir,carab_transparencia))
  
  #Base de datos Homicidios. Subsecretaria de Prevencion del delito
  FreqDenuncias10_16 <- read_excel(paste0(pcdir,datadir,"Frec_DENUNCIAS_ANUAL_2001_2016w.xlsx"), sheet = "Homicidio", 
                                   col_names = T, skip = 3)
  
  #Base de datos Poblacion por regiones
  PoblacionRegiones <- read_excel(paste0(pcdir,datadir,"Poblacion Censo.xlsx"))

}
if(user = "pamel"){
  syntaxdir <- c("C:\\Users\\pamel\\Documents\\Emilia\\datic_f_01\\")
  #The master Databases are in "Proyectos en ejecucion\\2018\\Fundacion Emilia"
  datadir <- c("Proyectos en ejecucion\\2018\\Fundacion Emilia\\")
  pcdir <- c("G:\\Unidades de equipo\\")
  #Base de datos Siniestros viales Carabineros de Chile. Solicitud por Ley de Transparencia
  Siniestros10_17 <- read_excel(paste0(pcdir,datadir,carab_transparencia))
  
  #Base de datos Homicidios. Subsecretaria de Prevencion del delito
  FreqDenuncias10_16 <- read_excel(paste0(pcdir,datadir,"Frec_DENUNCIAS_ANUAL_2001_2016w.xlsx"), sheet = "Homicidio", 
                                   col_names = T, skip = 3)
  
  #Base de datos Poblacion por regiones
  PoblacionRegiones <- read_excel(paste0(pcdir,datadir,censo))
}

