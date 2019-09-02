library(tidyverse)
library(geobr)
library(sf)

## Teste de join do pacote SF, realizado com sucesso
shapes <- geobr::read_municipality(code_muni = "all", year=2010)
points <- readRDS("~/Área de Trabalho/tempo_municipios.rds")[[1]]$destinations %>% st_as_sf(coords = c('lon', 'lat'), crs = st_crs(shapes))
test <- st_join(points, shapes)

## Teste 2 de join, com menos pontos
points2 <- readRDS("~/Área de Trabalho/tempo_municipios.rds")[[1]]$sources %>% st_as_sf(coords = c('lon', 'lat'), crs = st_crs(shapes))
test2 <- st_join(points2, shapes)


## Operação de junção para toda a tabela  
travels <- readRDS("~/Área de Trabalho/tempo_municipios.rds")
identif <- function(item){
  dest <- item$destinations
  sour <- item$sources
  time <- item$durations
  dist <- item$distances
}

l <- lapply(travels, identif)



### 4. Fazer o mesmo para todas os data frames das listas de tempos entre municípios
### 5. juntar todos os dataframes em uma única matrix de ~5500x5500
### 6. Salvar o Data Frame como um RDS
### 7. Aplicar mesmo algoritmo para identificar localização de unidades de atendimento em áreas de ponderação





