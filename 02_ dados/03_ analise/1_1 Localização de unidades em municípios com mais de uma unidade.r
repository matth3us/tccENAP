library(tidyverse)
library(geobr)
unidades <- readRDS("./02_ dados/02_ RFB/dados_modificados/localizacao_unidades_municipios_varias_unidades_2019-09-01.rds")



#Separar dados de áreas de ponderação no SIDRA
Quais são as tabelas do SIDRA para os municípios?
Quais as tabelas do SIDRA que eu consigo para as áreas de ponderação?

#Mapas de áreas de ponderação
#ftp://geoftp.ibge.gov.br/organizacao_do_territorio/malhas_territoriais/malhas_de_setores_censitarios__divisoes_intramunicipais/censo_2010/setores_censitarios_shp/
  
mg <- read_sf("~/Área de Trabalho/git_folders/dados_IBGE_areas_ponderação/dados_modificados/mg_setores_censitarios/31SEE250GC_SIR.shp")%>% mutate_if(is.character, function(x){return(str_conv(x, 'latin1'))})
sp <- read_sf("~/Área de Trabalho/git_folders/dados_IBGE_areas_ponderação/dados_modificados/sp_setores_censitarios/33SEE250GC_SIR.shp")%>% mutate_if(is.character, function(x){return(str_conv(x, 'latin1'))})
rj <- read_sf("~/Área de Trabalho/git_folders/dados_IBGE_areas_ponderação/dados_modificados/rj_setores_censitarios/33SEE250GC_SIR.shp")%>% mutate_if(is.character, function(x){return(str_conv(x, 'latin1'))})
pr <- read_sf("~/Área de Trabalho/git_folders/dados_IBGE_areas_ponderação/dados_modificados/pr_setores_censitarios/41SEE250GC_SIR.shp")%>% mutate_if(is.character, function(x){return(str_conv(x, 'latin1'))})

#ALTERAR SUMMARISE PARA PRESERVAR OUTRAS COLUNAS
riodj <- rj %>% filter(NM_MUNICIP == 'RIO DE JANEIRO') %>% group_by(CD_GEOCODB) %>% summarise(do_union = TRUE)
sampa <- sp %>% filter(NM_MUNICIP == 'SÃO PAULO') %>% group_by(CD_GEOCODB) %>% summarise(do_union = TRUE)
beaga <- mg %>% filter(NM_MUNICIP == 'BELO HORIZONTE') %>% group_by(CD_GEOCODB) %>% summarise(do_union = TRUE)
curit <- pr %>% filter(NM_MUNICIP == 'CURITIBA') %>% group_by(CD_GEOCODB) %>% summarise(do_union = TRUE)

test <- st_is_valid(sp %>% filter(NM_MUNICIP == 'SÃO PAULO'), reason = TRUE)
test[!(test == 'Valid Geometry')]
#algumas geometrias de são paulo estão dando erro. Tentar consertar. 
#https://www.r-spatial.org/r/2017/03/19/invalid.html
