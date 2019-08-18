library(tidyverse)
lista <- list.files('./02_ dados/01_ IBGE/dados_brutos', pattern = "*.csv", full.names = TRUE)
ibge <- lapply(lista, function(i){read.csv(i, header=FALSE, skip=3, encoding="UTF-8") %>% mutate_all(as.character)})
names(ibge) <- lista %>% str_replace("./02_ dados/01_ IBGE/dados_brutos/", "") %>% str_replace(".csv", "") 

for(i in 1:length(ibge)){
  names(ibge[[i]]) <- ibge[[i]][1,]
  ibge[[i]] <- ibge[[i]][2:nrow(ibge[[i]]),]
}

saveRDS(ibge, paste("./02_ dados/01_ IBGE/dados_brutos/ibge_", Sys.Date(),".rds", sep=""))

