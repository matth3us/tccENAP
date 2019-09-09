library(tidyverse)
library(geobr)
library(sf)


## Identificação de municípios para toda a tabela
travels <- readRDS('./02_ dados/03_ analise/1_tempo_municipios_areas.rds')
area <- readRDS("./02_ dados/03_ analise/03_01_areasPond&unidade.rds")
muni <- geobr::read_municipality(code_muni = "all", year=2010)


identif <- function(item){
  #identificar municípios de destinos e origens
  dest <- item$destinations #%>% st_as_sf(coords = c('lon', 'lat'), crs = st_crs(area)) %>% st_join(area)
  sour <- item$sources %>% st_as_sf(coords = c('lon', 'lat'), crs = st_crs(muni)) %>% st_join(muni)
  time <- item$durations
  dist <- item$distances
  #corrigir nomes de destinos e origens nas tabelas de tempo e distância de viagem
  colnames(time) <- (area %>% sf::st_drop_geometry())$Cod_Area_Pond
  rownames(time) <- sour$code_muni
  colnames(dist) <- (area %>% sf::st_drop_geometry())$Cod_Area_Pond
  rownames(dist) <- sour$code_muni
  
  #criar novo item, corrigido
  newItem <- list()
  newItem$destinations <- dest
  newItem$sources <- sour      
  newItem$durations <- time
  newItem$distances <- dist      
  
  return(newItem)
}

travelsFinal <-lapply(travels, identif) 
rm(travels)

#arquivo tempo_municipios_corrigido
#travelsFinal <- readRDS(file.choose())

#junção de lista para toda a tabela
allTimes <- travelsFinal %>% 
  lapply(., "[[", "durations") #%>% 
  lapply(., function(x){
    df <- as.data.frame(x)
    df$origens <- rownames(x)
    return(df)
  }) %>% 
  do.call(bind_rows, .) %>% 
  gather(key = 'destinos', value = 'duração', -origens)

timesDists <- travelsFinal %>% 
  lapply(., "[[", "distances") %>% 
  lapply(., function(x){
    df <- as.data.frame(x)
    df$origens <- rownames(x)
    return(df)
  }) %>% 
  do.call(bind_rows, .) #%>% 
  gather(key = 'destinos', value = 'distância', -origens) %>% 
  full_join(allTimes, by = c("origens", "destinos")) %>% 
  rename(origem = origens, destino = destinos) %>% 
  distinct()

saveRDS(timesDists %>% distinct(), "timesDists.rds")

#nrow(timesDists %>% distinct())
# inserir código em script do OpenStreetMap





