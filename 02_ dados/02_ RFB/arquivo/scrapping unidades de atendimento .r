library(RSelenium)
library(XML)
library(tidyverse)
remDr <- remoteDriver(
  port = 4445L
)
remDr$open()
url <- "http://www.receita.fazenda.gov.br/Aplicacoes/ATBHE/UnidadesAtendimento/Unidades/InformacoesDasUnidades.aspx?unidade=06032"
remDr$navigate(url)
remDr$getTitle() #pegar título da página para confirmar que foi atingida
remDr$screenshot(display = TRUE) #mostrar página no Viewer do RStudio

#pega o HTML da página obtido pelo Selenium, faz o parse com encondigo UTF 8 e depois pega todas a tabelas da página, separando a primeira (e única), que tem as informações da unidade
infoUnid <- readHTMLTable(htmlParse(remDr$getPageSource()[[1]], encoding = 'UTF-8')) [[1]]
                  
test <- infoUnid %>% spread(key = V1, value = V2) %>% select(Unidade, Estado, Cidade, Bairro, CEP, Logradouro, Atendimento, Titular, 'Telefone(s)', Observações)


url2 <- 'http://www.receita.fazenda.gov.br/Aplicacoes/ATBHE/UnidadesAtendimento/Unidades/InformacoesDasUnidades.aspx?unidade=00000'

remDr$navigate(url2)
remDr$screenshot(display=TRUE)

infoUnid2 <- htmlParse(remDr$getPageSource()[[1]], encoding = 'UTF-8')
test <- xmlToList(infoUnid2)

#unds <- read_csv('und_att.csv') %>% 
#  mutate(
#   ID = NULL, 
#    Estado = as.factor(Estado)
#  )

       