library(dplyr)
library(ggplot2)
#devtools::install_github('thomasp85/gganimate')
#instalar tweer primero
library(gganimate)
library(reshape)
library(tidyr)
library(stringr)
library(magick)

source("FE_Source_.R")

library(readr)
DEIS <- read_delim("G:/Team Drives/Proyectos en ejecucion/2018/Fundacion Emilia/DEIS/DEF.csv", 
                  ";", escape_double = FALSE, trim_ws = TRUE)

CARAB_TOTAL <- Siniestros10_17 %>% 
  group_by(Año) %>%
  summarise(Fallecidos = sum(Muertos),
            Graves = sum(Graves)) %>%
  mutate(Victimas = Fallecidos + Graves)

DEIS_TOTAL_DIAG1 <- DEIS %>%
  #group_by(ANO_DEF) %>%
  #count() %>%
  left_join(DEIS_CODIGOS, by = c("DIAG1" = "CIE10"))
  
DEIS_TOTAL_DIAG2 <- DEIS %>%
  #group_by(ANO_DEF) %>%
  #count() %>%
  left_join(DEIS_CODIGOS, by = c("DIAG2" = "CIE10"))

DEIS_TOTAL_DIAG <-  bind_rows(DEIS_TOTAL_DIAG1, DEIS_TOTAL_DIAG2)
  group_by(ANO_DEF) %>%
  count()
  
DEIS_TOTAL_DIAG_FINAL <-  DEIS_TOTAL_DIAG  %>%
  group_by(ANO_DEF) %>%
  count()
  

#res1 <- left_join(Homicidios,Fallecidos, by = "Año")

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