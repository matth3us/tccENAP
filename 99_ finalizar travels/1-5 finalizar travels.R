library(tidyverse)
library(geobr)
library(sf)
library(readxl)
setwd("C:/Users/02741207399/Desktop/Escritório de Processos")



## viagens para áreas de ponderação e municípios
travels <- readRDS('./Git/tccENAP/02_ dados/03_ analise/1_tempo_municipios_areas.rds')
muni <- geobr::read_municipality(code_muni = "all", year=2010)


#setores censitários
##Tabela de join entre setores censitários e áreas de ponderação
aPond <- read_excel("./Git/Informações extras IBGE/RESPOSTA_PEDIDO.xlsx") %>% mutate_all(as.character) %>% rename(setor = Setor, area_ponderacao = "Área de ponderação")

#Mapas de setores censitários
#ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/

beaga <- read_sf("./Git/Informações extras IBGE/dados_IBGE_areas_ponderação/dados_modificados/mg_setores_censitarios/31SEE250GC_SIR.shp")%>% 
  mutate_if(is.character, function(x){return(str_conv(x, 'latin1'))}) %>% 
  filter(NM_MUNICIP == 'BELO HORIZONTE') %>% 
  left_join(aPond, by = c("CD_GEOCODI" = "setor")) %>% 
  filter(!is.na(area_ponderacao)) %>% 
  group_by(area_ponderacao, NM_MUNICIP, CD_GEOCODM) %>% 
  summarise(do_union = TRUE) %>% rename(Cidade = NM_MUNICIP, CodIBGE = CD_GEOCODM)
sampa <- read_sf("./Git/Informações extras IBGE/dados_IBGE_areas_ponderação/dados_modificados/sp_setores_censitarios/33SEE250GC_SIR.shp")%>% 
  mutate_if(is.character, function(x){return(str_conv(x, 'latin1'))}) %>% 
  filter(NM_MUNICIP == 'SÃO PAULO') %>% 
  filter(st_is_valid(., reason = TRUE) == 'Valid Geometry') %>% 
  left_join(aPond, by = c("CD_GEOCODI" = "setor")) %>% 
  filter(!is.na(area_ponderacao)) %>% 
  group_by(area_ponderacao, NM_MUNICIP, CD_GEOCODM) %>% 
  summarise(do_union = TRUE) %>% rename(Cidade = NM_MUNICIP, CodIBGE = CD_GEOCODM)
riodj <- read_sf("./Git/Informações extras IBGE/dados_IBGE_areas_ponderação/dados_modificados/rj_setores_censitarios/33SEE250GC_SIR.shp")%>% 
  mutate_if(is.character, function(x){return(str_conv(x, 'latin1'))}) %>% 
  filter(NM_MUNICIP == 'RIO DE JANEIRO') %>% 
  left_join(aPond, by = c("CD_GEOCODI" = "setor")) %>% 
  filter(!is.na(area_ponderacao)) %>% 
  group_by(area_ponderacao, NM_MUNICIP, CD_GEOCODM) %>% 
  summarise(do_union = TRUE) %>% rename(Cidade = NM_MUNICIP, CodIBGE = CD_GEOCODM)
curit <- read_sf("./Git/Informações extras IBGE/dados_IBGE_areas_ponderação/dados_modificados/pr_setores_censitarios/41SEE250GC_SIR.shp")%>% 
  mutate_if(is.character, function(x){return(str_conv(x, 'latin1'))}) %>% 
  filter(NM_MUNICIP == 'CURITIBA') %>% 
  left_join(aPond, by = c("CD_GEOCODI" = "setor")) %>% 
  filter(!is.na(area_ponderacao)) %>% 
  group_by(area_ponderacao, NM_MUNICIP, CD_GEOCODM) %>% 
  summarise(do_union = TRUE) %>% rename(Cidade = NM_MUNICIP, CodIBGE = CD_GEOCODM)

setor <- beaga %>% bind_rows(sampa) %>% bind_rows(riodj) %>% bind_rows(curit) #%>% rename(Cod_Cidade = CodIBGE, Cod_Area_Pond = area_ponderacao) %>% select(Cidade, Cod_Cidade, Cod_Area_Pond, geometry) %>% filter(!is.na(Cod_Area_Pond))
setor <- setor %>% as_tibble %>% st_as_sf()
rm(beaga, sampa, riodj, curit)

# Cruzamento de dados

identif_area2Area <- function(item){
  #identificar municípios de destinos e origens
  dest <- item$destinations %>% st_as_sf(coords = c('lon', 'lat'), crs = st_crs(setor)) %>% st_join(setor) %>% mutate(area_ponderacao = ifelse(is.na(area_ponderacao), "ignorar", area_ponderacao))
  sour <- item$sources %>% st_as_sf(coords = c('lon', 'lat'), crs = st_crs(setor)) %>% st_join(setor) %>% mutate(area_ponderacao = ifelse(is.na(area_ponderacao), "ignorar", area_ponderacao))
  time <- item$durations
  dist <- item$distances
  #corrigir nomes de destinos e origens nas tabelas de tempo e distância de viagem
  colnames(time) <- dest$area_ponderacao
  rownames(time) <- sour$area_ponderacao
  colnames(dist) <- dest$area_ponderacao
  rownames(dist) <- sour$area_ponderacao
  
  #criar novo item, corrigido
  newItem <- list()
  newItem$destinations <- dest
  newItem$sources <- sour      
  newItem$durations <- time[, -which(colnames(time) %in% c("ignorar"))]
  newItem$distances <- dist[, -which(colnames(dist) %in% c("ignorar"))]   
  
  return(newItem)
}

identif_area2Muni <- function(item){
  #identificar municípios de destinos e origens
  dest <- item$destinations %>% st_as_sf(coords = c('lon', 'lat'), crs = st_crs(muni)) %>% st_join(muni)
  sour <- item$sources %>% st_as_sf(coords = c('lon', 'lat'), crs = st_crs(setor)) %>% st_join(setor) %>% mutate(area_ponderacao = ifelse(is.na(area_ponderacao), "ignorar", area_ponderacao))
  time <- item$durations
  dist <- item$distances
  
  #corrigir nomes de destinos e origens nas tabelas de tempo e distância de viagem
  colnames(time) <- dest$code_muni
  rownames(time) <- sour$area_ponderacao
  colnames(dist) <- dest$code_muni
  rownames(dist) <- sour$area_ponderacao
  
  #criar novo item, corrigido
  newItem <- list()
  newItem$destinations <- dest
  newItem$sources <- sour      
  newItem$durations <- time[, -which(colnames(time) %in% c("ignorar"))]
  newItem$distances <- dist[, -which(colnames(dist) %in% c("ignorar"))]   
  
  return(newItem)
}

travelsFinal_1 <-lapply(final[1:33], identif_area2Muni)
travelsFinal_2 <-lapply(final[34:66], identif_area2Area) 
travelsFinal <- c(travelsFinal_1, travelsFinal_2)
rm(travels, travelsFinal_1, travelsFinal_2)

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
  rename(origem = origens, destino = destinos) %>% 
  distinct()

timesDists_2 <- timesDists %>% filter(!is.na(distância)) %>% filter(!is.na(duração))

saveRDS(timesDists_2, "timesDists_areas_pond_2.rds")
