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

areasP <- beaga %>% bind_rows(sampa) %>% bind_rows(riodj) %>% bind_rows(curit) %>% rename(Cod_Cidade = CodIBGE, Cod_Area_Pond = area_ponderacao) %>% select(Cidade, Cod_Cidade, Cod_Area_Pond, geometry) %>% filter(!is.na(Cod_Area_Pond))
rm(beaga, sampa, riodj, curit)

#unidades RFB
unidades <- readRDS("./Git/tccENAP/02_ dados/02_ RFB/dados_modificados/localizacao_unidades_municipios_varias_unidades_2019-09-01.rds") %>%
                sf::st_as_sf(coords = c('lon', 'lat'), crs = st_crs(areasP)) %>% 
                select(-c(Cidade, Endereço)) %>% 
                filter(!(Unidade %in% c("São Paulo - Malha Pf","São Paulo - Paulista","São Paulo - Cnpj - Plantão","Maiores Contribuintes (Demac) - Rj","Rio I - Centro Cidadão","Rio I - Centro Empresa","Rio I - Plantão Fiscal")))
                #Remover unidades na mesma área de ponderação



areasP <- areasP %>% 
                  st_join(unidades, left=TRUE) %>% 
                  mutate(is_rfb = !is.na(Unidade)) %>% 
                  select(Estado, Cod_Cidade, Cidade, Cod_Area_Pond, Bairro, Logradouro, Unidade, is_rfb, geometry) %>% 
                  filter()

#conferir unidades sem área de ponderação agregada
areasP_unids <- areasP %>% filter(is_rfb) %>% select(-is_rfb)

#Limpar e juntar dados demográficos
areasRenda <- read.csv("./Git/tccENAP/02_ dados/01_ IBGE/dados_brutos/2030.csv", header=T, skip=4, encoding="UTF-8") %>% 
                        mutate_all(as.character) %>% 
                        filter(!is.na(Sem.rendimento)) %>% 
                        select(-Total) %>% 
                        rename(
                                codigo = Cód.,
                                area_ponderacao = Área.de.Ponderação,
                                pop_2010_0.0_1.0_sal_min = "Até.1.salário.mínimo",
                                pop_2010_1.0_2.0_sal_min = Mais.de.1.a.2.salários.mínimos,
                                pop_2010_2.0_3.0_sal_min = Mais.de.2.a.3.salários.mínimos,
                                pop_2010_3.0_5.0_sal_min = Mais.de.3.a.5.salários.mínimos,
                                pop_2010_5.0_10.0_sal_min = Mais.de.5.a.10.salários.mínimos,
                                pop_2010_10.0_20.0_sal_min = Mais.de.10.a.20.salários.mínimos,
                                pop_2010_20_plus_sal_min = Mais.de.20.salários.mínimos,
                                pop_2010_sem_rendimento = Sem.rendimento
                        ) %>% 
                        mutate_at(vars(pop_2010_0.0_1.0_sal_min:pop_2010_sem_rendimento), funs(as.numeric))
                        
areasIdade_ativo <- read.csv("./Git/tccENAP/02_ dados/01_ IBGE/dados_brutos/1572.csv", header=T, skip=4, encoding="UTF-8") %>% 
                        mutate_all(as.character) %>% 
                        filter(Condição.de.atividade.e.condição.de.ocupação == "Economicamente ativas") %>% 
                        select(-Condição.de.atividade.e.condição.de.ocupação) %>% 
                        mutate_at(vars("Total":"X70.anos.ou.mais"), funs(as.numeric)) %>% 
                        mutate('ativo-19less' = Total - rowSums(.[4:14])) %>% 
                        select(-Total) %>% 
                        rename(
                                codigo = Cód.,
                                area_ponderacao = Área.de.Ponderação,
                                "ativo-20_24" = "X20.a.24.anos",
                                "ativo-25_29" = "X25.a.29.anos",
                                "ativo-30_34" = "X30.a.34.anos",
                                "ativo-35_39" = "X35.a.39.anos",
                                "ativo-40_44" = "X40.a.44.anos",
                                "ativo-45_49" = "X45.a.49.anos",
                                "ativo-50_54" = "X50.a.54.anos",
                                "ativo-55_59" = "X55.a.59.anos",
                                "ativo-64_65" = "X60.a.64.anos",
                                "ativo-65_69" = "X65.a.69.anos",
                                "ativo-70_plus" = "X70.anos.ou.mais",
                        )

areasDemog <- read.csv("./Git/tccENAP/02_ dados/01_ IBGE/dados_brutos/1572.csv", header=T, skip=4, encoding="UTF-8") %>% 
                        mutate_all(as.character) %>% 
                        filter(Condição.de.atividade.e.condição.de.ocupação == "Não economicamente ativas") %>% 
                        select(-Condição.de.atividade.e.condição.de.ocupação) %>% 
                        mutate_at(vars("Total":"X70.anos.ou.mais"), funs(as.numeric)) %>% 
                        mutate('inativo-19less' = Total - rowSums(.[4:14])) %>% 
                        select(-Total) %>% 
                        rename(
                                codigo = Cód.,
                                area_ponderacao = Área.de.Ponderação,
                                "inativo-20_24" = "X20.a.24.anos",
                                "inativo-25_29" = "X25.a.29.anos",
                                "inativo-30_34" = "X30.a.34.anos",
                                "inativo-35_39" = "X35.a.39.anos",
                                "inativo-40_44" = "X40.a.44.anos",
                                "inativo-45_49" = "X45.a.49.anos",
                                "inativo-50_54" = "X50.a.54.anos",
                                "inativo-55_59" = "X55.a.59.anos",
                                "inativo-64_65" = "X60.a.64.anos",
                                "inativo-65_69" = "X65.a.69.anos",
                                "inativo-70_plus" = "X70.anos.ou.mais",
                        ) %>% 
                        left_join(areasIdade_ativo, by=c('codigo', 'area_ponderacao'))  %>% 
                        right_join(areasRenda, by=c('codigo', 'area_ponderacao'))
                
#join de geometria e demografia
areasP <- areasP %>% full_join(areasDemog, by = c("Cod_Area_Pond" = "codigo"))
rm(areasIdade_ativo, areasRenda, aPond, unidades, areasDemog)
saveRDS(areasP, "03_01_areasPond&unidade.rds")











