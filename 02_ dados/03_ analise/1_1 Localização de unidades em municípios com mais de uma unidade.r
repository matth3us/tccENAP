library(tidyverse)
library(geobr)
library(sf)
library(readxl)
setwd("C:/Users/02741207399/Desktop/Escritório de Processos")


#Tabela de join entre setores censitários e áreas de ponderação
aPond <- read_excel("./Git/Informações extras IBGE/RESPOSTA_PEDIDO.xlsx") %>% mutate_all(as.character) %>% rename(setor = Setor, area_ponderacao = "Área de ponderação")

#Mapas de setores censitários
#ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/

beaga <- read_sf("./Git/Informações extras IBGE/dados_IBGE_areas_ponderação/dados_modificados/mg_setores_censitarios/31SEE250GC_SIR.shp")%>% 
        mutate_if(is.character, function(x){return(str_conv(x, 'latin1'))}) %>% 
        filter(NM_MUNICIP == 'BELO HORIZONTE') %>% 
        left_join(aPond, by = c("CD_GEOCODI" = "setor")) %>% 
        group_by(area_ponderacao, NM_MUNICIP, CD_GEOCODM) %>% 
        summarise(do_union = TRUE) %>% rename(Cidade = NM_MUNICIP, CodIBGE = CD_GEOCODM)
sampa <- read_sf("./Git/Informações extras IBGE/dados_IBGE_areas_ponderação/dados_modificados/sp_setores_censitarios/33SEE250GC_SIR.shp")%>% 
        mutate_if(is.character, function(x){return(str_conv(x, 'latin1'))}) %>% 
        filter(NM_MUNICIP == 'SÃO PAULO') %>% 
        filter(st_is_valid(., reason = TRUE) == 'Valid Geometry') %>% 
        left_join(aPond, by = c("CD_GEOCODI" = "setor")) %>% 
        group_by(area_ponderacao, NM_MUNICIP, CD_GEOCODM) %>% 
        summarise(do_union = TRUE) %>% rename(Cidade = NM_MUNICIP, CodIBGE = CD_GEOCODM)
riodj <- read_sf("./Git/Informações extras IBGE/dados_IBGE_areas_ponderação/dados_modificados/rj_setores_censitarios/33SEE250GC_SIR.shp")%>% 
        mutate_if(is.character, function(x){return(str_conv(x, 'latin1'))}) %>% 
        filter(NM_MUNICIP == 'RIO DE JANEIRO') %>% 
        left_join(aPond, by = c("CD_GEOCODI" = "setor")) %>% 
        group_by(area_ponderacao, NM_MUNICIP, CD_GEOCODM) %>% 
        summarise(do_union = TRUE) %>% rename(Cidade = NM_MUNICIP, CodIBGE = CD_GEOCODM)
curit <- read_sf("./Git/Informações extras IBGE/dados_IBGE_areas_ponderação/dados_modificados/pr_setores_censitarios/41SEE250GC_SIR.shp")%>% 
        mutate_if(is.character, function(x){return(str_conv(x, 'latin1'))}) %>% 
        filter(NM_MUNICIP == 'CURITIBA') %>% 
        left_join(aPond, by = c("CD_GEOCODI" = "setor")) %>% 
        group_by(area_ponderacao, NM_MUNICIP, CD_GEOCODM) %>% 
        summarise(do_union = TRUE) %>% rename(Cidade = NM_MUNICIP, CodIBGE = CD_GEOCODM)

areasP <- beaga %>% bind_rows(sampa) %>% bind_rows(riodj) %>% bind_rows(curit) %>% rename(Cod_Cidade = CodIBGE, Cod_Area_Pond = area_ponderacao) %>% select(Cidade, Cod_Cidade, Cod_Area_Pond, geometry) 
rm(beaga, sampa, riodj, curit)

#unidades RFB
unidades <- readRDS("./02_ dados/02_ RFB/dados_modificados/localizacao_unidades_municipios_varias_unidades_2019-09-01.rds") %>%
              sf::st_as_sf(coords = c('lon', 'lat'), crs = st_crs(areasP)) %>% 
              select(-c(Cidade, Endereço))

areasP <- areasP %>% 
                  st_join(unidades, left=TRUE) %>% 
                  mutate(is_rfb = is.na(Unidade)) %>% 
                  select(Estado, Cod_Cidade, Cidade, Cod_Area_Pond, Bairro, Logradouro, Unidade, is_rfb, geometry)

areasP_unids <- areasP %>% filter(!is_rfb) %>% select(-is_rfb)

#conferir unidades sem área de ponderação agregada

#Limpar e juntar dados demográficos



saveRDS(areasP, "03_01_areasPond&unidade.rds")









