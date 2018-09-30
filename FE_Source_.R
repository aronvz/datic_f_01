library(readxl)

user <- Sys.getenv("USERNAME")
sub_delito <- "Prevencion del delito\\Frec_DENUNCIAS_ANUAL_2001_2016w.xlsx"
carab_transparencia <- "Carabineros\\SINIESTROS 2010-2017.xlsx"
censo <- "Poblacion Censo.xlsx"
deis <- "DEIS\\DEF.csv"

if (user == "aronvz") {
  syntaxdir <- c("D:\\Work\\Datic\\FEmilia\\datic_f_01\\")
  #The master Databases are in "Proyectos en ejecucion\\2018\\Fundacion Emilia"
  datadir <- c("Proyectos en ejecucion\\2018\\Fundacion Emilia\\")
  pcdir <- c("G:\\Team Drives\\")
}
if (user == "pamel") {
  syntaxdir <- c("C:\\Users\\pamel\\Documents\\Emilia\\datic_f_01\\")
  #The master Databases are in "Proyectos en ejecucion\\2018\\Fundacion Emilia"
  datadir <- c("Proyectos en ejecucion\\2018\\Fundacion Emilia\\")
  pcdir <- c("G:\\Unidades de equipo\\")
}

#Base de datos Siniestros viales Carabineros de Chile. Solicitud por Ley de Transparencia
Siniestros10_17 <- read_excel(paste0(pcdir,datadir,carab_transparencia))

#Base de datos Homicidios. Subsecretaria de Prevencion del delito
FreqDenuncias10_16 <- read_excel(paste0(pcdir,datadir,sub_delito), sheet = "Homicidio", 
                                 col_names = T, skip = 3)

#Base de datos Poblacion por regiones
PoblacionRegiones <- read_excel(paste0(pcdir,datadir,censo))

#DEIS
Deis <- read_csv(paste0(pcdir,datadir,deis))