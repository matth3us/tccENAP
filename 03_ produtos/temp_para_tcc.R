library(tidyverse)
  download.file("https://www.dropbox.com/s/jkiiwwxz73eys9e/01_viagens.rds?raw=1", destfile = "viagens.rds")

  servicos <- readRDS("C:/Users/02741207399/Desktop/Escritório de Processos/Git/Informações extras IBGE/TCC - produtos/02_serviços.rds")
viagens <- readRDS("C:/Users/02741207399/Desktop/Escritório de Processos/Git/Informações extras IBGE/TCC - produtos/01_viagens.rds")
demog <- readRDS("C:/Users/02741207399/Desktop/Escritório de Processos/Git/Informações extras IBGE/TCC - produtos/03_demografia.rds")

#quais os códigos de ibge dos municípios e áreas de ponderação para cada unidade da RFB?
unids <- readRDS("C:/Users/02741207399/Desktop/Escritório de Processos/Git/tccENAP/02_ dados/03_ analise/00_unidades_RFB_cod_ibge.rds") %>% 
            mutate(ibge_unid = ifelse(is.na(ibge_area), ibge_municipio,  ibge_area)) %>% 
            distinct()

#qual a unidade de atendimento mais próxima, saindo do município?
classif <- viagens %>% 
  filter(destino %in% unids$ibge_unid) %>% 
  filter(!is.na(duração)) %>% 
  group_by(origem) %>% 
  summarise(
    minDuração = min(duração),
    minDestino = destino[which.min(duração)]
  ) %>% 
  left_join(unids, by=c("minDestino" = "ibge_unid"))

plot(map_info)

