library(tidyverse)
servicos_list <- readRDS("./02_ dados/02_ RFB/dados_modificados/servicos_atendimento_2019-08-05.rds")

servicos <- servicos_list
for(i in 1:length(servicos)){
  servicos[[i]]$imagens <- NULL
}
rm(i)


urls_atend <- read.csv('./02_ dados/02_ RFB/dados_brutos/urls_imagens.csv', sep=",", encoding = 'UTF-8') %>% select(-id)
tipos_atend <- unique(urls_atend$tipo_atendimento)

servicos <- lapply(servicos, unlist) %>% 
            lapply(., as.data.frame) %>% 
            lapply(., t) %>% 
            lapply(., as.data.frame) %>% 
            do.call(plyr::rbind.fill, .) %>% 
            as.data.frame(.) %>% 
            mutate(
                nome_popular= as.character(nome_popular),
                nome_popular = ifelse(nome_popular %in% c("N/A", "N/A ", ""), NA, nome_popular)
                ) %>% 
            select(nome, nome_popular, descricao, publico_alvo, urls_imagens, urls_imagens1:urls_imagens5) %>% 
            gather("coluna_fonte", "url", urls_imagens:urls_imagens5) %>% 
            select(-coluna_fonte) %>% 
            left_join(urls_atend, by = c('url')) %>% 
            filter(!is.na(tipo_atendimento)) %>% 
            distinct() #%>% 
            #group_by(nome) %>% 
            #mutate(n = n()) %>% 
            #distinct(nome, .keep_all = TRUE)

saveRDS(servicos, "02_serviços_rfb.rds")

#ABAIXO, transformações para entendimento    
eval_servicos <- servicos %>% 
                    mutate(nome2 = nome) %>% 
                    spread(key = tipo_atendimento, value = nome2) %>% 
                    rename(
                      distancia = 'Atendimento a distância', 
                      ecac = 'Atendimento e-CAC',
                      presencial = "Atendimento presencial",
                      internet = "Atendimento pela internet"
                    ) %>% 
                    rowwise() %>% 
                    mutate(
                      tipos = 4-(is.na(distancia) + is.na(internet) + is.na(ecac) + is.na(presencial))
                    ) %>% 
                    ungroup()

n_servicos <- eval_servicos %>% 
                  group_by(nome) %>% 
                  summarise(num = n()) %>% 
                  ungroup()

single_atend <- n_servicos %>% filter(num < 2)
multi_atend  <- n_servicos %>% filter(num > 1)
              
#Quantos e quais serviços são exclusivamente presenciais?
apenas_presencial <- eval_servicos %>% filter(nome %in% single_atend$nome) %>% filter(!is.na(presencial)) %>% select(nome:publico_alvo)

#Quantos e quais servicos podem ser atendidos à distância (facultativamente em unidades de atendimento)?
#http://receita.economia.gov.br/interface/entrega-de-documentos-digitais/abrir-um-dossie-digital-de-atendimento
talvez_presencial <- eval_servicos %>% filter(!(nome %in% single_atend$nome)) %>% filter(!is.na(distancia)) %>% select(nome:publico_alvo)

#Há serviços exclusivamente à distância? Quais?
apenas_distancia <- eval_servicos %>% filter(nome %in% single_atend$nome) %>% filter(!is.na(distancia)) %>% select(nome:publico_alvo)







