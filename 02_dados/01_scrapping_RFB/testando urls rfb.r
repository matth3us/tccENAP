library(RSelenium)
library(XML)
library(RCurl)
library(tidyverse)

#acessar firefox e Selenium instalados num container Docker, ativo em servidor local
remDr <- remoteDriver(port = 4445L)
remDr$open()
    
#------------
#Script para obtenção de unidades de atendimento da RFB

#criar data frame com todas as variações de página possíveis
unids <- data.frame(unid = 0:99999, status = NA) %>% 
  mutate(
    url = str_c('http://www.receita.fazenda.gov.br/Aplicacoes/ATBHE/UnidadesAtendimento/Unidades/InformacoesDasUnidades.aspx?unidade=', str_pad(unid, 5, side=c('left'), '0')),
    unid = NULL
  ) %>% 
  select(url, status)

# declarar url de erro, retornada nas páginas que não guardam nenhuma informação de unidade de atendimento
urlErro <- 'http://www.receita.fazenda.gov.br/Aplicacoes/ATBHE/UnidadesAtendimento/Unidades/Erro.htm'

#declaração de lista de dataframes das URLs testadas positivo
infoUnids <- list()


#teste das URL, comparando a URL devolvida após o acesso da URl gerada com a URL de erro
for(i in 1:nrow(unids)){
  remDr$navigate(unids$url[i])
  if(remDr$getCurrentUrl()[[1]] == urlErro){
    unids$status[i] <- FALSE
  } else {
    #quando o retorno do status é True, já pega as informações da página e joga na lista infoUnids
    unids$status[i] <- TRUE
    dfUnid <- readHTMLTable(htmlParse(remDr$getPageSource()[[1]], encoding = 'UTF-8')) [[1]] %>% 
                        spread(key = V1, value = V2) %>% 
                        select(Unidade, Estado, Cidade, Bairro, CEP, Logradouro, Atendimento, Titular, 'Telefone(s)', Observações)
    infoUnids <- c(infoUnids, dfUnid)
  }
  cat(paste('url num. ', i, '/', nrow(unids), ' testada.', '\n', sep='', collapse=''))
}

#unlisting das informações e data wrangling das informações das unidades de atendimento da RFB




#------------
#Script para obtenção de serviços de atendimento para pessoa física

#testar obtençao de informações dessa página
urlAtt <- 'http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/aduana/colecao'
remDr$navigate(urlAtt)
remDr$screenshot(display = TRUE)
tbl <- readHTMLTable(htmlParse(remDr$getPageSource()[[1]], encoding = 'UTF-8'))
tblAtts <- tbl[[1]] %>% spread(key = V1, value = V2)
for(i in 2:length(tbl)){
  currTbl <- tbl[[i]] %>% spread(key = V1, value = V2)
  tblAtts <- tblAtts %>% bind_rows(currTbl)
}

#problema para corrigir: não está pegando nenhuma informação das imagens das tabelas; como resolver?
#após resolver esse problema, só vai faltar pegar as urls de todos os tipos de atendimento oferecidos, e depois fazer um data wrangling do output

#Pegar tabelas na raça, usando elementos CSS, scrapping old school
#Fazer uma lista para todas as tabelas; pra cada tabela um elemento da lista
#Elementos para extrair:
#  Nome
#  Nome popular
#  Descrição
#  Público Alvo
#  Formas de atendimento (imgs)

test <- remDr$findElements(using='css selector', value='td > a > img')
test[[1]]$getElementAttribute('src')
test[[1]]$get
