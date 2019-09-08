library(tidyverse)
library(osrm)
library(sf)
options(osrm.server = 'http://0.0.0.0:5000/')


#tabela RDS com localização dos municípios (source)
muni <- readRDS("./02_ dados/01_ IBGE/dados_modificados/locus_municipios.rds") %>% 
          select(CD_GEOCODM, geometry)

#tabela RDS com localização das áreas de ponderação (destiny)
area <- readRDS("./02_ dados/03_ analise/03_01_areasPond&unidade.rds") %>% select(Cod_Area_Pond, geometry)
for(i in 1:nrow(area)){
  cent <- st_centroid(area$geometry[i])
  area$geometry[i] <- cent[[1]]
}
rm(i)
st_crs(area) <- st_crs(muni)

#Cruzamento de informações
l_Osm <- list();

for(i in 1:279){
  i_st <- i * 20 - 19
  i_en <- ifelse(i_st + 19 > 5565, 5565, i_st + 19)
  
  srcMuni <- muni %>% slice(i_st:i_en)
  outputMuni <- osrmTable(src=srcMuni, dst=area, measure= c('duration', 'distance')) #duration in minutes; distance in meters 
  cat("Cruzamento número ", i, "/279 realizado. \n", sep="")
  l_Osm <- c(l_Osm, list(outputMuni))
}


saveRDS(l_Osm, '1_tempo_municipios_areas.rds')
