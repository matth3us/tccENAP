library(RSelenium)
library(XML)
library(RCurl)
library(tidyverse)

#ativar o Docker para rodar o Selenium
# sudo docker run -d -p 4445:4444  --shm-size 2g selenium/standalone-firefox
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
continue_unids <- unids %>% filter(is.na(status))
for(i in 1:nrow(continue_unids)){
  remDr$navigate(continue_unids$url[i])
  if(remDr$getCurrentUrl()[[1]] == urlErro){
    continue_unids$status[i] <- FALSE
  } else {
    #quando o retorno do status é True, já pega as informações da página e joga na lista infoUnids
    continue_unids$status[i] <- TRUE
  }
  cat(paste('url num. ', i, '/', nrow(continue_unids), ' testada.', '\n', sep='', collapse=''))
}
unids <- unids %>% left_join(continue_unids, by = c('url' = 'url')) %>% 
                rowwise() %>% 
                mutate(
                  status = ifelse((is.na(status.x) && is.na(status.y)), NA, 0),
                  status = ifelse(!is.na(status) && !is.na(status.x), status.x, status.y)
                ) %>% 
                ungroup() %>% 
                mutate(
                  status.x = NULL,
                  status.y = NULL
                )
saveRDS(unids, 'unids_2019_08_07.rds')
#Pegar informações dos urls sem problemas
#dfUnid <- readHTMLTable(htmlParse(remDr$getPageSource()[[1]], encoding = 'UTF-8')) [[1]] %>% 
#  spread(key = V1, value = V2) %>% 
#  select(Unidade, Estado, Cidade, Bairro, CEP, Logradouro, Atendimento, Titular, 'Telefone(s)', Observações)
#infoUnids <- c(infoUnids, dfUnid)

#salvar como RDS e fazer unlisting depois, no RDS

#------------
#Script para obtenção de serviços de atendimento para pessoa física

#lista de urls com serviços de atendimento ao cidadão prestados pela RFB
atends <- data.frame(url = c(
  'http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/aduana/colecao',
  'http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/cadastros/colecao',
  'http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/certidoes-e-situacao-fiscal/colecao',
  'http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/cobranca-e-fiscalizacao/colecao',
'  http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/declaracoes-e-demonstrativos/colecao-1',
  'http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/dau/colecao',
  'http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/isencao/colecao',
  'http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/legislacao/colecao',
  'http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/pagamentos-e-parcelamentos/colecao',
  'http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/processo/colecao',
  'http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/procuracao/colecao',
  'http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/restituicao-e-compensacao/colecao',
  'http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/senhas/colecao'
))

#lista de resultado final
outputTables <- list()

#extração programática das informações das páginas web
for(x in 1:nrow(atends)){
  urlAtt <- atends$url[x]
  remDr$navigate(urlAtt)
  tables <- remDr$findElements(using='css selector', value='table > tbody')
  currOutput <- list()

  for(y in 1:length(tables)){
    currOutput[[y]] <- list(
      nome = tables[[y]]$findChildElements(using='css selector', value='tr:nth-child(1) > td:nth-child(2)')[[1]]$getElementText(), 
      imagens = tables[[y]]$findChildElements(using='css selector', value='a > img'), 
      urls_imagens = lapply(tables[[y]]$findChildElements(using='css selector', value='a > img'), function(el){return(el$getElementAttribute('src'))}),
      nome_popular = tables[[y]]$findChildElements(using='css selector', value='tr:nth-child(2) > td:nth-child(2)')[[1]]$getElementText(), 
      descricao = tables[[y]]$findChildElements(using='css selector', value='tr:nth-child(3) > td:nth-child(2)')[[1]]$getElementText(), 
      publico_alvo = tables[[y]]$findChildElements(using='css selector', value='tr:nth-child(4) > td:nth-child(2)')[[1]]$getElementText()
    )
  }
  outputTables <- append(outputTables, currOutput)
}

#salvamento como RDS das informações extraídas
saveRDS(outputTables, paste('servicos_atendimento_', Sys.Date(), '.rds', sep='', collapse=''))
