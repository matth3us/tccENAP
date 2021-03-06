library(tidyverse)
library(osrm)
options(osrm.server = 'http://0.0.0.0:5000/')


#tabela RDS com localização dos municípios
muni <- readRDS("./02_ dados/01_ IBGE/dados_modificados/locus_municipios.rds") %>% 
            select(CD_GEOCODM, NM_MUNICIP, NM_UF, LONG, LAT, ALT, geometry)

#destino da viagem
dstMuni <- muni %>% select(CD_GEOCODM, geometry) %>% rename(cod_ibge = CD_GEOCODM)

l_Osm <- list();

for(i in 1:279){
  i_st <- i * 20 - 19
  i_en <- ifelse(i_st + 19 > 5565, 5565, i_st + 19)
  
  srcMuni <- muni %>% select(CD_GEOCODM, geometry) %>% rename(cod_ibge = CD_GEOCODM) %>% slice(i_st:i_en)
  outputMuni <- osrmTable(src=srcMuni, dst=dstMuni, measure= c('duration', 'distance')) #duration in minutes; distance in meters 
  cat("Cruzamento número ", i, "/279 realizado. \n", sep="")
  l_Osm <- c(l_Osm, list(outputMuni))
}
                                              
saveRDS(l_Osm, '1_tempo_entre_municipios.rds')