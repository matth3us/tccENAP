library(sf)
library(tidyverse)

#dataframes para correções

UF <- read.csv("./02_ dados/01_ IBGE/dados_brutos/siglas estados UF.csv", sep=";", encoding = "UTF-8") %>% 
                  select(ESTADO, SIGLA) %>% 
                  mutate(ESTADO = str_to_upper(ESTADO))

correctMuni <- read.csv("./02_ dados/02_ RFB/dados_modificados/cidades com problema.csv") %>% 
                  select(-X) %>% 
                  rename(
                    cidade = CIDADE,
                    correct = CORREÇÃO
                    )


#dataframes para cruzamentos

municipios <- read_sf("./02_ dados/01_ IBGE/dados_brutos/BR_Localidades_2010_v1.shp") %>% 
                  filter(NM_CATEGOR == "CIDADE") %>% 
                  select(CD_GEOCODM, NM_MUNICIP, NM_UF) %>% 
                  mutate_if(is.character, .funs = function(x){return(`Encoding<-`(x, "latin1"))}) %>% 
                  mutate(NM_UF = as.factor(NM_UF)) %>%
                  rename(
                    codigo_ibge = CD_GEOCODM,
                    cidade = NM_MUNICIP,
                    estado = NM_UF
                  ) %>% 
                  left_join(UF, by=c("estado" = "ESTADO")) %>% 
                  rowwise() %>% 
                  mutate(
                    key_muni = str_c(cidade, "_", SIGLA, sep="", collapse="")
                  ) %>% 
                  ungroup()

unidRFB <- readRDS("./02_ dados/02_ RFB/dados_modificados/unidades atendimento 2019-08-11.rds") %>% 
                  select(Unidade, Tipo, Estado, Cidade) %>% 
                  mutate(Cidade = str_to_upper(Cidade)) %>% 
                  rename(
                    UF = Estado
                  ) %>% 
                  left_join(correctMuni, by=c("Cidade" = "cidade")) %>% 
                  rename(UF = UF.x) %>% 
                  mutate(
                    UF.y = NULL,
                    correct = as.character(correct),
                    Cidade = ifelse(is.na(correct), Cidade, correct),
                    correct = NULL,
                  ) %>% 
                  rowwise() %>% 
                  mutate(key_muni = str_c(Cidade, "_", UF, sep="", collapse="")) %>% 
                  ungroup()


#teste de join: visualização dos locais das unidades de atendimento da RFB
locus_rfb <- unidRFB %>% left_join(municipios, by="key_muni") %>% select(Unidade, Tipo, cidade, estado, UF, codigo_ibge, geometry)

#all_join
locus_municip <-unidRFB %>% 
                  full_join(municipios, by="key_muni") %>% 
                  select(Unidade, Tipo, cidade, estado, SIGLA, codigo_ibge, geometry) %>% 
                  rename(unidade = Unidade, tipo = Tipo, UF = SIGLA) %>% 
                  mutate(
                    tipo = as.factor(tipo),
                    unidade = str_to_upper(unidade),
                    estado = as.factor(estado),
                    UF = as.factor(UF)
                  )

saveRDS(locus_municip, "./02_ dados/02_ RFB/dados_modificados/locus_municip.rds")





