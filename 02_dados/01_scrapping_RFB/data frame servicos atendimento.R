library(tidyverse)
servicos_list <- readRDS("C:/Users/02741207399/Desktop/Escritório de Processos/Git/tccENAP/02_dados/01_scrapping_RFB/servicos_atendimento_2019-08-05.rds")

servicos <- servicos_list
for(i in 1:length(servicos)){
  servicos[[i]]$imagens <- NULL
}
rm(i)
servicos <- lapply(servicos, unlist) %>% 
            lapply(., as.data.frame) %>% 
            lapply(., t) %>% 
            lapply(., as.data.frame) %>% 
            do.call(plyr::rbind.fill, .)


servicos <- as.data.frame(servicos) %>% 
              mutate(
                nome_popular= as.character(nome_popular),
                nome_popular = ifelse(nome_popular %in% c("N/A", "N/A ", ""), NA, nome_popular)
                )

urls_atend <- read.csv('C:/Users/02741207399/Desktop/Escritório de Processos/Git/tccENAP/02_dados/01_scrapping_RFB/urls_imagens.csv', encoding = 'UTF-16') %>% select(-id)


servicos <- servicos %>% 
                select(nome, nome_popular, descricao, publico_alvo, urls_imagens, urls_imagens1:urls_imagens5) %>% 
                gather("coluna_fonte", "url", urls_imagens:urls_imagens5) %>% 
                select(-coluna_fonte) %>% 
                left_join(urls_atend, by = c('url')) %>% 
                filter(!is.na(tipo_atendimento)) %>% 
                distinct() %>% 
                group_by(nome) %>% 
                mutate(n = n())
                distinct(nome, .keep_all = TRUE)
                
tipos_atend <- unique(urls_atend$tipo_atendimento)
              
#Quantos e quais serviços são exclusivamente presenciais?
#Quantos e quais servicos podem ser atendidos à distância (facultativamente em unidades de atendimento)?
#http://receita.economia.gov.br/interface/entrega-de-documentos-digitais/abrir-um-dossie-digital-de-atendimento
#Há serviços exclusivamente à distância? Quais?








