library(tidyverse)
library(geobr)
unidades <- readRDS("./02_ dados/02_ RFB/dados_modificados/localizacao_unidades_municipios_varias_unidades_2019-09-01.rds")



#Separar dados de áreas de ponderação no SIDRA
Quais são as tabelas do SIDRA para os municípios?
Quais as tabelas do SIDRA que eu consigo para as áreas de ponderação?

#Baixar shapes das áreas de ponderação
areas_rio   <- geobr::read_weighting_area(code_weighting = 3304557, year = 2010) 
areas_sampa <- geobr::read_weighting_area(code_weighting = 3550308, year = 2010)
areas_curit <- geobr::read_weighting_area(code_weighting = 4106902 , year = 2010)
areas_beaga <- geobr::read_weighting_area(code_weighting = 3106200 , year = 2010)
geobr::read_weighting_area(code_weighting = "SP") 
#Identificar em que áreas de ponderação estão cada uma das unidades de atendimento dessas cidades
#Criar tabela de viagem dos municípios para essas unidades