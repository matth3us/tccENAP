library(tidyverse)
muni <- readRDS("./02_ dados/01_ IBGE/dados_modificados/locus_municipios.rds") %>% 
  select(CD_GEOCODM, NM_MUNICIP, NM_UF, LONG, LAT, ALT, geometry)
dstMuni <- muni %>% select(NM_MUNICIP, CD_GEOCODM, geometry) %>% rename(cod_ibge = CD_GEOCODM, nome = NM_MUNICIP)
srcMuni <- muni %>% select(NM_MUNICIP, CD_GEOCODM, geometry) %>% rename(cod_ibge = CD_GEOCODM, nome = NM_MUNICIP) %>% slice(1:20)


tempo_munis <- readRDS("C:/Users/02741207399/Desktop/Escritório de Processos/Git/1_tempo_entre_municipios.rds")

firstL <- tempo_munis[[1]]

colnames(firstL$durations) <- dstMuni$cod_ibge
colnames(firstL$distances) <- dstMuni$cod_ibge
rownames(firstL$durations) <- srcMuni$cod_ibge
rownames(firstL$distances) <- srcMuni$cod_ibge

sf::st_coordinates(dstMuni$geometry[1])

## Hacky solution!!!
## Encontrar a cidades com coordernada geográfica mais próxima para cada um dos pontos de destination e source do osrmTable
## fazer isso porque há algum tipo de rounding ou correção sendo feito no
## a diferença de pontos de coordenada já foi descartada;. Segundo o IBGE, a coordenada personalizada deles é, para todos os efeitos, idêntica à utilizada pelo Open Street Map


