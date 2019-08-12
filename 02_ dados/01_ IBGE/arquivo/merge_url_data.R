#merge url data

library(tidyverse)
setwd("/home/celso/Área de Trabalho/dados_IBGE/arquivo")
allFiles <- list.files()
data <- list()
for(i in 1:length(allFiles)){
  data[[i]] <- read_csv(paste(getwd(), '/', allFiles[i], collapse='', sep=''))
}
allData <- do.call('rbind', data)
allData <- unique(allData)

#achar / na coluna files para separar o que não são arquivos
allData <- allData %>% mutate(testFile = str_detect(file, '/')) %>%  filter(testFile == FALSE) %>%  select(file, url, path)

#encontrar o caminho de organização das pastas - replicar organização dos arquivos FTP
for(i in 1:nrow(allData)){
  allData$inx[i] <- as.integer(str_locate_all(allData$url[i], '/')[[1]][3])
  allData$path[i] <- str_sub(allData$url[i], allData$inx[i], str_length(allData$url[i]))
}
allData <- allData %>% dplyr::select(file, url, path)

#salvar arquivo final
write_csv(allData, 'dados_tcc.csv')


