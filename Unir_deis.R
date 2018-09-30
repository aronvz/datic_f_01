

DEIS2011 <- read_csv2(paste0(pcdir,datadir,"DEIS\\DEF2011.csv"))
DEIS2011 <- DEIS2011 %>% mutate_if(sapply(DEIS2011,is.numeric), as.character)

DEIS2012 <- read_excel(paste0(pcdir,datadir,"DEIS\\DEF2012.xlsx"))
DEIS2012 <- DEIS2012 %>% mutate_if(sapply(DEIS2012,is.numeric), as.character)

DEIS2013 <- read_csv2(paste0(pcdir,datadir,"DEIS\\DEF2013.csv"))
DEIS2013 <- DEIS2013 %>% mutate_if(sapply(DEIS2013,is.numeric), as.character)

DEIS2014 <- read_csv2(paste0(pcdir,datadir,"DEIS\\DEF2014.csv"))
DEIS2014 <- DEIS2014 %>% mutate_if(sapply(DEIS2014,is.numeric), as.character)

DEIS2015 <- read_excel(paste0(pcdir,datadir,"DEIS\\DEF2015.xlsx"))
DEIS2015 <- DEIS2015 %>% mutate_if(sapply(DEIS2015,is.numeric), as.character)

DEIS2016 <- read_csv2(paste0(pcdir,datadir,"DEIS\\DEF2016.csv"))
DEIS2016 <- DEIS2016 %>% mutate_if(sapply(DEIS2016,is.numeric), as.character)

deis <- DEIS2011 %>% bind_rows(list("2012" = DEIS2012,DEIS2013,DEIS2014,DEIS2015,DEIS2016),.id = "Año") 
write.csv2(deis,paste0(pcdir,datadir,"DEIS\\DEF.csv"))
