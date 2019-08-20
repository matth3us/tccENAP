library(tidyverse)
muni <- readRDS("./02_ dados/01_ IBGE/dados_modificados/locus_municipios.rds") %>% 
            select(CD_GEOCODM, NM_MUNICIP, NM_UF, LONG, LAT, ALT, geometry)


#reescrever o código, para fazer de 100 em 100.

inputMuni <- muni %>% select(CD_GEOCODM, geometry) %>% rename(cod_ibge = CD_GEOCODM)
srcMuni <- inputMuni %>% slice(1:100)
dstMuni <- inputMuni %>% slice(101:102)



library(osrm)
options(osrm.server = 'http://0.0.0.0:5000/')
outputMuni <- osrmTable(src=srcMuni, dst=dstMuni, measure= c('duration', 'distance')) #duration in minutes; distance in meters
saveRDS(outputMuni, '1_tempo_entre_municipios.rds')