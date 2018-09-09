library(readr)
library(ggplot2)
library(plyr)
library(reshape2)

source("FE_Source.R")

str(EGR2014)

str(DEF2014)
summary(DEF2014)
class(DEF2014)

vector9 <- c('SEXO','EST_CIVIL','EDAD_TIPO','CURSO_INS','NIVEL_INS','ACTIV','CATEG','AT_MEDICA',
             'CAL_MEDICO','NUTRITIVO')
vector99 <- c('GESTACION','REG_RES','MES_NAC','ANO1_NAC','ANO2_NAC','SERV_RES')
vector999 <- c('EDAD_CANT')
vector9999 <- c('PESO')
vector99999 <- c('COMUNA')

DEF2014[ , as.vector(vector9)][ DEF2014[ , as.vector(vector9) ] == 9 ] <- NA
DEF2014[ , as.vector(vector99)][ DEF2014[ , as.vector(vector99) ] == 99 ] <- NA
DEF2014[ , as.vector(vector999)][ DEF2014[ , as.vector(vector999) ] == 999 ] <- NA
DEF2014[ , as.vector(vector9999)][ DEF2014[ , as.vector(vector9999) ] == 9999 ] <- NA
DEF2014[ , as.vector(vector99999)][ DEF2014[ , as.vector(vector99999) ] == 99999 ] <- NA

summary(DEF2014)
DEF2014$MES_DEF <- factor(DEF2014$MES_DEF,levels = c(1:12), labels=c('Enero','Febrero','Marzo',
                                                                        'Abril', 'Mayo','Junio',
                                                                        'Julio', 'Agosto', 'Septiembre',
                                                                        'Octubre', 'Noviembre', 'Diciembre'))
DEF2014$SEXO <- factor(DEF2014$SEXO,levels = c(1,2), labels=c('Hombre','Mujer'))
DEF2014$URBA_RURAL <- factor(DEF2014$URBA_RURAL,levels = c(1,2), labels=c('Urbano','Rural'))
barplot(table(DEF2014$SEXO, DEF2014$MES_DEF), main = 'Defunciones por Mes y Sexo',legend.text = c('Hombre','Mujer'))

library(dplyr)
library(reshape2)

#mutate(sum5=count(rownames(.)))
#melted <- melt(DEF2014[c("MES_DEF", "SEXO")], id=c("MES_DEF", "SEXO"))

ca <- dcast(DEF2014, MES_DEF~SEXO,sum)
print(ca)

#def_sex_mes <- DEF2014 %>% 
#  group_by(SEXO,MES_DEF)%>% tally()
#  mutate(perc=count/sum(count))

  
def_sex_mes <- DEF2014 %>% 
  group_by(SEXO,MES_DEF,URBA_RURAL, FUND_CAUSA)%>%
  summarise(count=n()) 

def_sex_mes <- def_sex_mes %>% 
  group_by(MES_DEF)%>%
  mutate(perc=count/sum(count)*100)


#ggplot(def_sex_mes, aes(x=MES_DEF, y=perc*100, fill=factor(SEXO)))


p4 <- ggplot() + geom_bar(aes(y = perc, x = FUND_CAUSA, fill = SEXO), data = def_sex_mes,
                          stat="identity")
p4 <- p4 + geom_text(data=def_sex_mes,
                     aes(x = FUND_CAUSA, y = perc, label = paste0(round(perc,2),"%")),
                     position = position_stack(vjust = 0.5),size=4)

p4 <- p4 + theme(legend.position="bottom", legend.direction="horizontal",
                 legend.title = element_blank())



  p4 <- p4 + facet_wrap(~def_sex_mes$MES_DEF, nrow = 4, ncol = 4, scales = "fixed",
             shrink = TRUE, labeller = "label_value", as.table = TRUE,
             switch = NULL, drop = TRUE, dir = "h", strip.position = "top")

p4

def_comuna <- DEF2014 %>% 
  group_by(COMUNA)%>%
  summarise(count=n()) 

def_comuna <- def_comuna %>% 
  group_by(COMUNA)%>%
  mutate(perc=count/sum(count)*100)

def_comuna
p5 <- ggplot() + geom_bar(aes(y = count, x = factor(COMUNA)), data = def_comuna,
                          stat="identity") 
p5

p5 <- p5 + geom_text(data=def_sex_mes,
                     aes(x = MES_DEF, y = perc, label = paste0(round(perc,2),"%")),
                     position = position_stack(vjust = 0.5),size=4)

p5 <- p5 + theme(legend.position="bottom", legend.direction="horizontal",
                 legend.title = element_blank())
p5
