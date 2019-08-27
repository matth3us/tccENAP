library(tidyverse)
muni <- readRDS("./02_ dados/01_ IBGE/dados_modificados/locus_municipios.rds") %>% 
  select(CD_GEOCODM, NM_MUNICIP, NM_UF, LONG, LAT, ALT, geometry)
dstMuni <- muni %>% select(NM_MUNICIP, CD_GEOCODM, geometry) %>% rename(cod_ibge = CD_GEOCODM, nome = NM_MUNICIP)
srcMuni <- muni %>% select(NM_MUNICIP, CD_GEOCODM, geometry) %>% rename(cod_ibge = CD_GEOCODM, nome = NM_MUNICIP) %>% slice(1:20)


tempo_munis <- readRDS("C:/Users/02741207399/Desktop/Escritório de Processos/Git/1_tempo_entre_municipios.rds")

firstL <- tempo_munis[[1]]


sf::st_coordinates(muni$geometry)

## Hacky solution!!!
## Encontrar a cidades com coordernada geográfica mais próxima para cada um dos pontos de destination e source do osrmTable
## fazer isso porque há algum tipo de rounding ou correção sendo feito no
## a diferença de pontos de coordenada já foi descartada;. Segundo o IBGE, a coordenada personalizada deles é, para todos os efeitos, idêntica à utilizada pelo Open Street Map

View(firstL$durations)
geoPos <-muni %>% select(NM_MUNICIP) %>% bind_cols(as.data.frame(sf::st_coordinates(muni$geometry)))
fonte <- firstL$sources %>% mutate(cidade = NA)
dest <- firstL$destinations %>% mutate(cidade = NA)

for(i in 1:nrow(fonte)){
  currFonte <- fonte[i,]
  tempPos <- geoPos %>% 
                rowwise() %>%
                mutate(dist = sqrt(((currFonte$lon-X)^2) + ((currFonte$lat - Y)^2))) %>% 
                ungroup() %>% 
                slice(which.min(dist))
  fonte$cidade[i] <- tempPos$NM_MUNICIP
  rm(tempPos, currFonte)
}

# Encontrar as cidades destinos do primeiro, e igualar em todos os outros

dest <- tempo_munis[[1]]$destinations %>% mutate(cidade = NA)

for(i in 1:nrow(dest)){
  currDest <- dest[i,]
  tempPos <- geoPos %>% 
    rowwise() %>%
    mutate(dist = sqrt(((currDest$lon-X)^2) + ((currDest$lat - Y)^2))) %>% 
    ungroup() %>% 
    slice(which.min(dist))
  dest$cidade[i] <- tempPos$NM_MUNICIP
  rm(tempPos, currDest)
}


dest <- dest %>% rowwise() %>% mutate(geometry = sf::st_as_sf(sp::SpatialPoints(data.frame(X = lon, Y = lat)))) %>% ungroup()

L <- list()

for(i in 1:nrow(dest)){
  geom <- sp::SpatialPoints(dest %>% select(-cidade) %>% slice(i))
  geom <- sf::st_as_sf(geom)
  dest$cidade[i] <- geom[[1]]
}

#### Transformar os pontos em SF Points
#### Identificar dentro de qual shape de município cada ponto se localiza
#### Testar se isso faz com que cada ponto esteja conectado a apenas um único município





