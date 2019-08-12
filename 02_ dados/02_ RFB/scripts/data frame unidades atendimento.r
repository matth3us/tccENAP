library(tidyverse)
unids_list <- readRDS("./02_dados/01_scrapping_RFB/unids_validas_RFB_2019_08_08.rds")
unids <- unids_list %>% 
              lapply(., unlist) %>% 
              lapply(., as.data.frame) %>% 
              lapply(., t) %>% 
              lapply(., as.data.frame) %>% 
              do.call(plyr::rbind.fill, .) %>% 
              mutate(
                Tipo = as.factor(str_to_upper(str_sub(Unidade, 1, 3))),
                Unidade = as.character(stringr::str_to_title(str_sub(Unidade, 4, -1))),
                Cidade = stringr::str_to_title(Cidade),
                Bairro = as.character(stringr::str_to_title(Bairro)),
                CEP = as.character(CEP),
                Estado = as.character(Estado),
                Logradouro = as.character(stringr::str_to_title(Logradouro)),
                Desativada = str_detect(Unidade, 'Desativada'),
                Desativado = str_detect(Unidade, 'Desativado')
                )  %>% 
                filter(!Desativada) %>%
                filter(!Desativado) %>% 
                select(Unidade, Tipo, Estado, Cidade, Bairro, CEP, Logradouro, Atendimento, "Telefone(s)", Observações) %>% 
                arrange(Estado, Cidade, Tipo, Unidade)
saveRDS(unids, "./02_dados/01_scrapping_RFB/unidades atendimento 2019-08-11.rds")

perCity <- unids %>% 
              group_by(Cidade, Estado) %>% 
              summarise(Num_unidades = n()) %>% 
              ungroup()

