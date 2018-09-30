library(dplyr)
library(ggplot2)
library(reshape)

<<<<<<< HEAD
#Carga de siniestros
S_10_17 <- read_excel("SINIESTROS 2010-2017.xlsx")
Frec_DENUNCIAS_10_16 <- read_excel("Frec_DENUNCIAS_ANUAL_2001_2016w.xlsx", sheet = "Homicidio", 
                                   col_names = T, skip = 3)
Frec_DENUNCIAS_10_16
SINIESTROS = S_10_17[S_10_17$Muertos > 0,]ñ
=======
syntaxdir <- c("C:\\Users\\pamel\\Google Drive\\DATIC\\Emilia\\datic_f_01\\")
source(paste0(syntaxdir,"FE_Source.R"))
>>>>>>> cfab334ec6b0551fbc2f7adba3f4744c87055698

#################################################################
#Grafico 1 adas
#adasdasda s asdasd 
#################################################################

Fallecidos10_17 = Siniestros10_17[Siniestros10_17$Muertos > 0,]
Fallecidos = Fallecidos10_17 %>% 
  group_by(Año) %>%
  summarise(tot = sum(Muertos))


Homicidios = FreqDenuncias10_16 %>%
  filter(REGION == 99) %>% 
  select(14:20)

Homicidios <- as.data.frame(t(Homicidios))
Homicidios$Año <- rownames(Homicidios)

Fallecidos <- Fallecidos[c(1:7),]
Fallecidos$Año <- as.character(Fallecidos$Año)

res3 = left_join(Homicidios,Fallecidos, by = "Año")

mm <- melt(res3, id = 'Año')
mm$variable <- ifelse(mm$variable == "V1","Casos policiales homicidios",ifelse(mm$variable == "tot","Fallecidos por siniestros viales",NA))

ggplot(mm, aes(x = Año, y = value, fill = variable)) +
  geom_bar(stat = "identity", color = "black", position = position_dodge()) +
  geom_text(aes(y = value, label = value), position = position_dodge(width = 0.9), vjust = -0.25, size = 3) + 
  scale_fill_discrete(name = " ") +
  ggtitle("Gráfico 1: Casos policiales de Homicidios y Fallecidos en Siniestros Viales \na Nivel Nacional (2010-2016)") +
  theme(plot.title = element_text(size = 10),legend.position = "bottom",axis.title = element_blank()) +
  scale_y_continuous(breaks = c(seq(0,2000,200)))


#################################################################
#Grafico 2
#################################################################

Fallecidos13Region = Fallecidos10_17 %>% 
  filter(Año == 2013) %>%
  group_by(REGION) %>%
  summarise(tot = sum(Muertos)) %>%
  mutate(Reg = ifelse(REGION == "I REGION TARAPACA", 1,
                      ifelse(REGION == "II REGION ANTOFAGASTA", 2,
                             ifelse(REGION == "III REGION ATACAMA", 3,
                                    III REGION ATACAMA
  )))


Homicidios = FreqDenuncias10_16 %>%
  filter(UN_ADMIN == "REGION" & REGION != 99) %>% 
  select(REGION,"2013")


res3 = left_join(Homicidios,Fallecidos13Region, by = "Año")

mm <- melt(res3, id = 'Año')
mm$variable <- ifelse(mm$variable == "V1","Casos policiales homicidios",ifelse(mm$variable == "tot","Fallecidos por siniestros viales",NA))

ggplot(mm, aes(x = Año, y = value, fill = variable)) +
  geom_bar(stat = "identity", color = "black", position = position_dodge()) +
  geom_text(aes(y = value, label = value), position = position_dodge(width = 0.9), vjust = -0.25, size = 3) + 
  scale_fill_discrete(name = " ") +
  ggtitle("Gráfico 1: Casos policiales de Homicidios y Fallecidos en Siniestros Viales \na Nivel Nacional (2010-2016)") +
  theme(plot.title = element_text(size = 10),legend.position = "bottom",axis.title = element_blank()) +
  scale_y_continuous(breaks = c(seq(0,2000,200)))




