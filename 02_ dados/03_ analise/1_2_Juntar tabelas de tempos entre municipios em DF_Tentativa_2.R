library(tidyverse)
library(geobr)
library(sf)
shapes <- geobr::read_municipality(code_muni = "all", year=2010)

## Teste de join do pacote SF, realizado com sucesso
#points <- readRDS("~/Área de Trabalho/tempo_municipios.rds")[[1]]$destinations %>% st_as_sf(coords = c('lon', 'lat'), crs = st_crs(shapes))
#test <- st_join(points, shapes)

## Teste 2 de join, com menos pontos
#points2 <- readRDS("~/Área de Trabalho/tempo_municipios.rds")[[1]]$sources %>% st_as_sf(coords = c('lon', 'lat'), crs = st_crs(shapes))
#test2 <- st_join(points2, shapes)

## Teste 3, antes do real thing
#points3 <- travels[[1]]$sources %>% st_as_sf(coords = c('lon', 'lat'), crs = st_crs(shapes))
#test3 <- st_join(points3, shapes)

## Identificação de municípios para toda a tabela
travels <- readRDS(file.choose()) #arquivo processado no OpenStreetMap

counter <- 0
identif <- function(item){
  #identificar municípios de destinos e origens
  dest <- item$destinations %>% st_as_sf(coords = c('lon', 'lat'), crs = st_crs(shapes)) %>% st_join(shapes)
  sour <- item$sources %>% st_as_sf(coords = c('lon', 'lat'), crs = st_crs(shapes)) %>% st_join(shapes)
  time <- item$durations
  dist <- item$distances
  #corrigir nomes de destinos e origens nas tabelas de tempo e distância de viagem
  colnames(time) <- dest$code_muni
  rownames(time) <- sour$code_muni
  colnames(dist) <- dest$code_muni
  rownames(dist) <- sour$code_muni

  #criar novo item, corrigido
  newItem <- list()
  newItem$destinations <- dest
  newItem$sources <- sour      
  newItem$durations <- time
  newItem$distances <- dist      
  
  counter <<- counter+1
  cat("Item no. ", counter, "/", length(travels), "\n", sep="", collapse="")  
  return(newItem)
}

travelsFinal <-lapply(travels, identif) 
rm(counter, travels)

#arquivo tempo_municipios_corrigido
travelsFinal <- readRDS(file.choose())

#junção de lista para toda a tabela
allTimes <- travelsFinal %>% 
              lapply(., "[[", "durations") %>% 
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
              do.call(bind_rows, .) %>% 
              gather(key = 'destinos', value = 'distância', -origens) %>% 
              full_join(allTimes, by = c("origens", "destinos")) %>% 
              rename(origem = origens, destino = destinos)

saveRDS(timesDists)

# inserir código em script do OpenStreetMap
# Aplicar mesmo algoritmo para identificar localização de unidades de atendimento em áreas de ponderação





