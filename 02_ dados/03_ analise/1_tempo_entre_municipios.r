muni <- readRDS("./02_ dados/01_ IBGE/dados_modificados/locus_municipios.rds") %>% 
            select(CD_GEOCODM, NM_MUNICIP, NM_UF, LONG, LAT, ALT, geometry)

inputMuni <- muni %>% select(CD_GEOCODM, geometry) %>% rename(cod_ibge = CD_GEOCODM)

library(osrm)
options(osrm.server: 'http://0.0.0.0:5000/')
outputMuni <- osrmTable(loc = inputMuni, measure= c('duration', 'distance')) #duration in minutes; distance in meters
saveRDS(outputMuni, '1_tempo_entre_municipios.rds')