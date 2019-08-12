library(tidyverse)
setwd("~/Área de Trabalho/dados_IBGE/organizar")
fix <- read_csv("0_extract_from_ftp.csv")
fix$inx <- apply(fix, 1, function(url){as.integer(str_locate_all(url, '">')[[1]][nrow(str_locate_all(url, '">')[[1]])])})
fix$inx_file <- apply(fix, 1, function(url){as.integer(str_locate_all(url, '/')[[1]][nrow(str_locate_all(url, '/')[[1]])])})
fix <- fix %>%  mutate(
  url = str_sub(url, 1, inx-1),
  url = str_replace(url, 'href="', ''),
  )

for(i in 1:nrow(fix)){
  fix$file[i] <- str_sub(fix$url[i], fix$inx_file[i]+1, str_length(fix$url[i]))
  fix$len_file[i] <- str_length(fix$file[i])
}
 
fix <- fix %>% filter(len_file > 0) %>% dplyr::select(file, url)

write_csv(fix, '0_ftp_corrected.csv')


#comandos para achar nomes de arquivos
url <- as.character(fontes$url[i])

inx <- 
nome <- str_sub(url, inx+1, str_length(url))