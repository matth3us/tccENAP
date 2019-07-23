library(tidyverse)

install.packages('RSelenium')

#dados para teste 
setwd("~/Área de Trabalho/tccENAP/02_dados")
unids <- readRDS('unidades_atendimento.rds')
rdmTest <- unids[[163]]
url <- rdmTest$url
  
#Scrapping
library(RSelenium)
drive <- rsDriver(browser = c('phantomjs'))
