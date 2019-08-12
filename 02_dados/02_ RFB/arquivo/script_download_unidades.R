library(tidyverse)
library(httr)
unds <- read_csv('und_att.csv') %>% 
          mutate(
            ID = NULL, 
            Estado = as.factor(Estado)
          )

listUnds <- list()

for(i in 1:length(unds$URL)){
  listUnds[[i]] <- GET(unds$URL[i])
  listUnds[[i]]$Estado <- unds$Estado[i]
  listaUnds
}

saveRDS(listUnds, 'unidades_atendimento.rds')
