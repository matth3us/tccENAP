library(tidyverse)

#load dos CSVs para dataframes organizados em lista
ibge <- list() %>% 
            c(., esti_pop = list(read.csv("./02_ dados/01_ IBGE/dados_brutos/estimativa_pop_municipios.csv", header=FALSE, skip=3, encoding="UTF-8") %>% mutate_all(as.character))) %>% 
            c(., pib = list(read.csv("./02_ dados/01_ IBGE/dados_brutos/pib_municipios.csv", header=FALSE, skip=3, encoding="UTF-8") %>% mutate_all(as.character))) %>% 
            c(., pop_eco = list(read.csv("./02_ dados/01_ IBGE/dados_brutos/pop_eco.csv", header=FALSE, skip=4, encoding="UTF-8", sep=";") %>% mutate_all(as.character))) %>% 
            c(., renda = list(read.csv("./02_ dados/01_ IBGE/dados_brutos/rendimento_municipio_2010.csv", header=FALSE, skip=2, encoding="UTF-8", sep=";") %>% mutate_all(as.character)))
            

#nomes das colunas nos data frames
for(i in 1:length(ibge)){
  names(ibge[[i]]) <- as.character(slice(ibge[[i]], 1))
  ibge[[i]] <- slice(ibge[[i]], -1)
}
rm(i)

#alterações pontuais no data frame de população economicamente ativa
ibge$pop_eco <- slice(ibge$pop_eco, -1)

#remoção de linhas em excesso e alterações de colunas nos dataframes
ibge$esti_pop <- slice(ibge$esti_pop, -(5571:nrow(ibge$esti_pop)))
ibge$pib <- slice(ibge$pib, -(5571:nrow(ibge$pib)))
ibge$pop_eco <- slice(ibge$pop_eco, -(66781:nrow(ibge$pop_eco)))
ibge$renda <- slice(ibge$renda, -(5566:nrow(ibge$renda)))



pop_eco_ativo <- ibge$pop_eco %>% 
                    select(-"Situação do domicílio", -"Não economicamente ativa") %>% 
                    rename(
                      municipio = "Município",
                      grupo_idade = "Grupo de idade",                  
                      ativo_econom = "Economicamente ativa",
                    ) %>% 
                    separate(municipio, into=c("municipio", "uf"), sep="\\(") %>% 
                    mutate(uf = as.factor(str_replace(uf, "\\)", ""))) %>% 
                    mutate(ativo_econom = as.numeric(ativo_econom)) %>% 
                    spread(key = grupo_idade, value = ativo_econom) %>% 
                    rename(
                          total = "Total",
                          'ativo-18_19' = "18 e 19 anos",
                          'ativo-20_24' = "20 a 24 anos",
                          'ativo-25_29' = "25 a 29 anos",
                          'ativo-30_34' = "30 a 34 anos",  
                          'ativo-35_39' = "35 a 39 anos",
                          'ativo-40_44' = "40 a 44 anos",
                          'ativo-45_49' = "45 a 49 anos",
                          'ativo-50_54' = "50 a 54 anos",
                          'ativo-55_59' = "55 a 59 anos",
                          'ativo-60_69' = "60 a 69 anos",
                          'ativo-70_plus' = "70 anos ou mais"
                    ) %>% 
                    mutate(
                      'ativo-19less' = total - rowSums(.[4:13])
                    ) %>% 
                    select(-total) %>% 
                    select(-("ativo-18_19"))

pop_eco_inativo <- ibge$pop_eco %>% 
                    select(-"Situação do domicílio", -"Economicamente ativa") %>% 
                    rename(
                      municipio = "Município",
                      grupo_idade = "Grupo de idade",                  
                      inativo_econom = "Não economicamente ativa"
                    ) %>% 
                    separate(municipio, into=c("municipio", "uf"), sep="\\(") %>% 
                    mutate(uf = as.factor(str_replace(uf, "\\)", ""))) %>% 
                    mutate(inativo_econom = as.numeric(inativo_econom)) %>% 
                    spread(key = grupo_idade, value = inativo_econom) %>% 
                    rename(
                      total = "Total",
                      'inativo-18_19' = "18 e 19 anos",
                      'inativo-20_24' = "20 a 24 anos",
                      'inativo-25_29' = "25 a 29 anos",
                      'inativo-30_34' = "30 a 34 anos",  
                      'inativo-35_39' = "35 a 39 anos",
                      'inativo-40_44' = "40 a 44 anos",
                      'inativo-45_49' = "45 a 49 anos",
                      'inativo-50_54' = "50 a 54 anos",
                      'inativo-55_59' = "55 a 59 anos",
                      'inativo-60_69' = "60 a 69 anos",
                      'inativo-70_plus' = "70 anos ou mais"
                    ) %>% 
                      mutate(
                        'inativo-19less' = total - rowSums(.[4:13])
                      ) %>% 
                      select(-total) %>% 
                      select(-("inativo-18_19"))
ibge$pop_eco <- pop_eco_ativo %>% left_join(pop_eco_inativo, by = c("municipio", "uf"))
rm(pop_eco_ativo, pop_eco_inativo)

esti_pop <- ibge$esti_pop %>% 
                      rename(
                        codigo = 'Cód.',
                        municipio = Município,
                        pop_est_2018 = '2018'
                      ) %>% 
                      select(-Nível)

pib <- ibge$pib %>% 
                      rename(
                        codigo = 'Cód.',
                        municipio = Município,
                        pib_2016= '2016'
                      ) %>% 
                      select(-Nível)

renda <- ibge$renda %>% 
                      rename(
                        codigo = 'Cód.',
                        municipio = Município,
                        'pop_2010_0.0_0.5_sal_min' = "Até 1/2 salário mínimo",
                        'pop_2010_0.5_1.0_sal_min' = "Mais de 1/2 a 1 salário mínimo",
                        'pop_2010_01_02_sal_min' = "Mais de 1 a 2 salários mínimos",
                        'pop_2010_02_05_sal_min' = "Mais de 2 a 5 salários mínimos" , 
                        'pop_2010_05_10_sal_min' = "Mais de 5 a 10 salários mínimos",
                        'pop_2010_10_20_sal_min' = "Mais de 10 a 20 salários mínimos",
                        'pop_2010_20_plus_sal_min' = "Mais de 20 salários mínimos",
                        'pop_2010_sem_rendimento' = "Sem rendimento",
                        'pop_2010_sem_declaracao' = "Sem declaração"
                      ) %>% 
                      select(-Nível, -Total) %>% 
                      mutate_at(vars('pop_2010_0.0_0.5_sal_min':'pop_2010_sem_declaracao'), as.numeric)

ibge_df <- renda %>% 
                full_join(pib, by = c("codigo", "municipio")) %>% 
                full_join(esti_pop, by = c("codigo", "municipio")) %>% 
                separate(municipio, into=c("municipio", "uf"), sep="\\(") %>% 
                mutate(uf = as.factor(str_replace(uf, "\\)", ""))) %>% 
                full_join(ibge$pop_eco, by=c('municipio', 'uf'))

rm(esti_pop, pib, renda)

#salvar só quando precisar
saveRDS(ibge_df, "./02_ dados/03_ analise/2_demografia_municipios.rds")
