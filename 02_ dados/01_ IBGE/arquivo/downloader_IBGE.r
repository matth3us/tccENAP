# Script para baixar
library(httr)
library(tidyverse)
library(RCurl)

setwd("~/Área de Trabalho/dados_IBGE")
tabela_urls <- read_csv(file.choose()) %>% rowid_to_column("ID") %>% mutate(baixado = NA)

#conferir urls quebradas


#demorando demais, fazer por for com CAT para testar 
#fontes <- tabela_urls %>% 
#              rowwise() %>% 
#              mutate(status = url.exists(url, timeout(500))) %>%
#              ungroup()
#        tabela_urls$status <- fontes$status

#resolver com for
fontes <- tabela_urls
for (i in 1:nrow(tabela_urls) ){
  fontes$status[i] <- url.exists(tabela_urls$url[i], timeout(500))
  cat('Url ', i, '/',nrow(tabela_urls), ' testada. \n')
}
fontes$baixado <- FALSE
tabela_urls$baixado <- fontes$baixado
  

### teste do script
###--------
#fontes <- fontes %>% filter(extension == '.zip')
#fontes <- fontes[1:4, ]
#testFile <- fontes[2, ]

#crashTest <- fontes[1:4, ]
#crashTest[1,1:4] <- c('arquivo.zebra',
#'http://www.mateoz.hpg.com.br/files',
#'/files/arquivo.zebra',
#'.zebra')

#for (i in 1:4){
#  crashTest$status[i] <- url.exists(crashTest$url[i])
#  downIbge(crashTest, i)
#}

###-------

### função para baixar e descompactar arquivos
downIbge <- function(df, y){
  url       <- df$url[y]
  nome      <- df$file[y]
  path      <- df$path[y]
  status    <- df$status[y]
  baixado   <- df$baixado[y]
  extension <- df$extension[y]

  #criar pasta
  folder    <- str_sub(path, 1, str_length(path) - str_length(nome))
  folder    <- unlist(str_split(folder, '/'), use.names = F)
  folder    <- folder[folder != '']
  dir.create(do.call(file.path, as.list(folder)), recursive = TRUE)

  #download do arquivo
  ifelse(status, download.file(url, paste('.', path, sep='', collapse=''), quiet = TRUE), unlink(do.call(file.path, as.list(folder)), recursive = TRUE))

  #descompactação do arquivo    
  if(extension == '.zip' && status == TRUE){
    zipFile <- str_sub(path, 2, str_length(path))
    zipFolder <- str_sub(zipFile, 1, str_length(zipFile)-4)
    unzip(zipFile, exdir=zipFolder) 
  }
}

### Baixar todos os arquivos
### -----------------------


  #baixar os 100 primeiros, depois, fazer para nrow(fontes)
  for(i in 1:nrow(fontes)){
    if(isFALSE(fontes$baixado[i])){
      if(fontes$status[i]){
        file_init_down <- Sys.time()  
        try(downIbge(fontes, i))
        file_term_down <- Sys.time()
        cat('Baixada arquivo de url número ', i, '/', nrow(fontes), '. \n')
        
        #informações para relatório
        #fontes$size[i] <- file.size(paste('.', fontes$path[i], sep='', collapse='')) #pegar o size no final
        fontes$initDown[i] <- file_init_down
        fontes$termDown[i] <- file_term_down
        fontes$baixado[i] <- TRUE
        tabela_urls[tabela_urls$ID == fontes$ID[i],]$baixado <- TRUE
      }
    }
  }
  
    
    # relatórios de horário de download dos arquivos
    total_size <- sum(fontes$size, rm.na = TRUE)		# Tamanho dos arquivos
    write_csv(tabela_urls, paste('./00_Download/dados_tcc_atualizados_', Sys.time(), '.csv', sep='', collapse=''))
    relatorio <- file(paste("00_relatorio_", Sys.time(), ".txt", sep='', collapse=''))
    writeLines(
        c("Relatório de download de dados do IBGE para TCC",
        "Celso Mattheus",
        paste("Início dos downloads: ", inicio_down, sep ='', collapse =''), 
        paste("Término dos downloads: ", termino_down, sep ='', collapse =''),
        paste("Tamanho total dos arquivos baixados: ", total_size, "bytes", sep ='', collapse =''))
        , relatorio)
    close(relatorio)

