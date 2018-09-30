library(dplyr)
library(ggplot2)
#devtools::install_github('thomasp85/gganimate')
#instalar tweer
library(gganimate)
library(reshape)
library(tidyr)
library(stringr)

source(paste0(syntaxdir,"FE_Source_.R"))
plic <- installed.packages(.Library, priority = "high", fields = "License")


Fallecidos10_17 <- Siniestros10_17[Siniestros10_17$Muertos > 0,]
Fallecidos10_17 <- Fallecidos10_17 %>% 
  mutate(Reg = ifelse(REGION == "I REGION TARAPACA", 1,
                      ifelse(REGION == "II REGION ANTOFAGASTA", 2,
                             ifelse(REGION == "III REGION ATACAMA", 3,
                                    ifelse(REGION == "IV REGION COQUIMBO", 4,
                                           ifelse(REGION == "V REGION VALPARAISO", 5,
                                                  ifelse(REGION == "VI REGION LIB.B.O'HIGGINS", 6,
                                                         ifelse(REGION == "VII REGION MAULE", 7,
                                                                ifelse(REGION == "VIII REGION BIO BIO", 8,
                                                                       ifelse(REGION == "IX REGION ARAUCANIA", 9,
                                                                              ifelse(REGION == "X REGION LOS LAGOS", 10,
                                                                                     ifelse(REGION == "XI REGION AISEN DEL GRL. C.IBA", 11,
                                                                                            ifelse(REGION == "XII REGION MAGALLANES Y ANT.CH", 12,
                                                                                                   ifelse(REGION == "REGION METROPOLITANA", 13,
                                                                                                          ifelse(REGION == "XIV REGION DE LOS RIOS", 14,
                                                                                                                 ifelse(REGION == "XV REGION ARICA Y PARINACOTA", 15,NA
                                                                                                                 )))))))))))))))) 
Fallecidos10_17 <- Fallecidos10_17 %>%
  group_by(Año,Reg,REGION) %>%
  summarise(Fallecidos = sum(Muertos),
            Graves = sum(Graves)) %>%
  mutate(Victimas = Fallecidos + Graves) 

#################################################################
#Grafico 1 
#################################################################

Fallecidos <- Fallecidos10_17 %>% 
  group_by(Año) %>%
  summarise(Fallecidos = sum(Fallecidos),
            Graves = sum(Graves)) %>%
  mutate(Victimas = Fallecidos + Graves)


Homicidios <- FreqDenuncias10_16 %>%
  filter(REGION == 99) %>% 
  select(14:20) %>%
  gather(Año, Homicidios) %>%
  mutate(Año = as.numeric(Año))

res1 <- left_join(Homicidios,Fallecidos, by = "Año")

datacast1 <- melt(as.data.frame(res1), id = 'Año')
datacast1$variable <- ifelse(datacast1$variable == "Homicidios","Casos policiales homicidios",
                             ifelse(datacast1$variable == "Fallecidos","Fallecidos por siniestros viales",NA))

g1 <- ggplot(na.omit(datacast1), aes(x = Año, y = value, fill = variable)) +
  geom_bar(stat = "identity", color = "black", position = position_dodge()) +
  geom_text(aes(y = value, label = value), position = position_dodge(width = 0.9), vjust = -0.25, size = 3) + 
  scale_fill_discrete(name = " ") +
  ggtitle("Gráfico 1: Casos policiales de Homicidios y Fallecidos en Siniestros Viales \na Nivel Nacional (2010-2016)") +
  scale_y_continuous(breaks = c(seq(0,1800,200)), limits = c(0,1800)) +
  scale_x_continuous(breaks = unique(datacast1$Año)) +
  labs(y = "Casos policiales", caption = "Fuente: elaboración propia en base a:\n
- Fallecidos: Carabineros de Chile, Solicitud de Información por Ley de Transparencia No AD009W0031944.\n
- Homicidios: Subsecretaría de Prevención del Delito. http://www.seguridadpublica.gov.cl/estadisticas/") +
  theme(plot.title = element_text(size = 10),legend.position = "bottom", axis.text.y = element_text(size = 8),
        panel.background = element_rect(fill = "gainsboro"), axis.text.x = element_text(size = 8))

png(file = "graf1.png")
g1
dev.off()
#################################################################
#Grafico 2
#################################################################
Fallecidos <- Fallecidos10_17 %>%
  group_by(Año,Reg,REGION) %>%
  filter(Año %in% c(2013,2014,2015,2016)) 

FreqDenuncias10_16 <- FreqDenuncias10_16 %>%
  filter(UN_ADMIN == "REGION", REGION != 99) %>%
  mutate(Reg = as.numeric(REGION))
Denuncias10_16 <- melt(as.data.frame(FreqDenuncias10_16), 
                       id = c("Reg","REGION","ORDEN", "UN_ADMIN", "UNIDAD TERRITORIAL"))
Denuncias <- Denuncias10_16 %>%
  filter(variable %in% c(2013,2014,2015,2016)) %>%
  mutate(Año = as.numeric(as.character(variable)),
         Denuncias = as.numeric(as.character(value))) %>%
  select(Año,Reg,Denuncias)

res2 <- left_join(Denuncias,Fallecidos, by = c("Año","Reg"))
res2 <- left_join(res2,PoblacionRegiones, by = "Reg")

datamelt2 <- melt(as.data.frame(res2), id = c("Año",'Reg','REGION','Poblacion2002','Poblacion2017','orden'))
datamelt2$variable <- ifelse(datamelt2$variable == "Denuncias","Casos policiales homicidios",
                             ifelse(datamelt2$variable == "Fallecidos","Fallecidos por siniestros viales",NA))

datamelt2$REG_w <- paste0(substr(str_split(datamelt2$REGION,"REGION", simplify = TRUE)[,2],1,2),
                          tolower(substr(str_split(datamelt2$REGION,"REGION", simplify = TRUE)[,2],3,nchar(str_split(datamelt2$REGION,"REGION", simplify = TRUE)[,2]))))
levels_reg <- unique(datamelt2$REG_w)[order(unique(datamelt2$orden))]
datamelt2$REG_w <- factor(datamelt2$REG_w , levels = levels_reg)

options(gganimate.dev_args = list(width = 1000, height = 700))

p <- datamelt2 %>% 
  filter(variable %in% c("Casos policiales homicidios", "Fallecidos por siniestros viales")) %>%
  group_by(variable) %>%
  mutate(pct = as.numeric(as.character(value))/(Poblacion2017/1000)*100) %>% 
  filter(!is.na(REG_w)) %>%
  ggplot(aes(x = REG_w, y = pct, fill = variable)) + 
  geom_bar(stat = 'identity', position = 'dodge') + 
  geom_text(aes(y = pct + .5, label = paste0(round(pct,1), '%')), position = position_dodge(width = .9), size = 3) + 
  scale_fill_discrete(name = " ") +
  ggtitle("Gráfico 2: Tasa de Homicidios y Fallecidos en Siniestros Viales \npor cada 100.000 habitantes según región") +
  theme(plot.title = element_text(size = 10),legend.position = "bottom", axis.text.x = element_text(angle = 70, hjust = 1,size = 9), axis.text.y = element_text(size = 9)) +
  scale_y_continuous(breaks = c(seq(0,100,20)), limits = c(0,20)) +
  labs(y = "Tasa",x = "Región", subtitle = "Año: {current_frame}", caption = "Fuente: elaboración propia en base a:\n
         - Fallecidos: Carabineros de Chile. Solicitud de Información por Ley de Transparencia No AD009W0031944.\n
       - Homicidios: Subsecretaría de Prevención del Delito. http://www.seguridadpublica.gov.cl/estadisticas/") +
  transition_manual(Año)


animate(p)

#Grafico 4

