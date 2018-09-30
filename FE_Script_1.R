setwd("D:/Work/Emilia/Etapa_1/")  
library(readxl)
library(dplyr)

#Carga de siniestros
S_10_17 <- read_excel("SINIESTROS 2010-2017.xlsx")
Frec_DENUNCIAS_10_16 <- read_excel("Frec_DENUNCIAS_ANUAL_2001_2016w.xlsx", sheet = "Homicidio", 
                                   col_names = T, skip = 3)
Frec_DENUNCIAS_10_16
SINIESTROS = S_10_17[S_10_17$Muertos > 0,]ñ


SIN = SINIESTROS %>% group_by(Año) %>%
  summarise(tot = sum(Muertos))


DEN = Frec_DENUNCIAS_10_16[c(1), c(14:20)]
DEN
DEN_N <- as.data.frame(t(DEN))
class(DEN_N)

DEN_N$Año <- rownames(DEN_N)


DEN_N
SIN <- SIN[c(1:7),]

res = cbind(DEN_N,SIN)
res2 = merge(DEN_N,SIN, by="Año")
str(DEN_N)
str(SIN)
SIN$Año <- as.character(SIN$Año)
res3 = left_join(DEN_N,SIN, by="Año")

library(ggplot2)
library(reshape)

mm <- melt(res3, id='Año')

ggplot(mm, aes(x=Año, y = value, fill = variable))+
  geom_bar(stat="identity", color="black", position=position_dodge()) +
  geom_text(data=mm,aes(x=Año,y=value,label=value),vjust=-1,hjust=0) +
  xlab("NEW RATING TITLE") + 
  ylab("NEW DENSITY TITLE") +
  #guides(fill=guide_legend(title="New Legend Title"))
  scale_fill_discrete(name = " ") +
  #theme(legend.position = c(.2,.85))#"bottom")
  theme(legend.position = "bottom" ) +
  scale_y_continuous(breaks=c(seq(0,2000,200)))





