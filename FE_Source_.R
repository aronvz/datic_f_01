library(readxl)

user <- Sys.getenv("USERNAME")
sub_delito <- "Prevencion del delito\\Frec_DENUNCIAS_ANUAL_2001_2016w.xlsx"
carab_transparencia <- "Carabineros\\SINIESTROS 2010-2017.xlsx"
censo <- "Poblacion Censo.xlsx"
deis <- "DEIS\\DEF.csv"
DEIS_CODIFICACION <- "DEIS\\cie10_codigos.xlsx"
datadir <- c("Proyectos en ejecucion\\2018\\Fundacion Emilia\\")


if (user == "aronv") {
  syntaxdir <- c("D:\\Work\\Datic\\FEmilia\\datic_f_01\\")
  pcdir <- c("G:\\Team Drives\\")
}
if (user == "pamel") {
  syntaxdir <- c("C:\\Users\\pamel\\Documents\\Emilia\\datic_f_01\\")
  pcdir <- c("G:\\Unidades de equipo\\")
}

#Base de datos Siniestros viales Carabineros de Chile. Solicitud por Ley de Transparencia
#print(pcdir, datadir, carab_transparencia)
Siniestros10_17 <- read_excel(paste0(pcdir,datadir,carab_transparencia))

#Base de datos Homicidios. Subsecretaria de Prevencion del delito
FreqDenuncias10_16 <- read_excel(paste0(pcdir,datadir,sub_delito), sheet = "Homicidio", 
                                 col_names = T, skip = 3)

#Base de datos Poblacion por regiones
PoblacionRegiones <- read_excel(paste0(pcdir,datadir,censo))

#DEIS
Deis <- read_csv(paste0(pcdir,datadir,deis))

DEIS_CODIGOS <- read_excel(paste0(pcdir,datadir,DEIS_CODIFICACION))
