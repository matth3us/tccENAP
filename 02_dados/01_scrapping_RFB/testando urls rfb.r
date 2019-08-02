library(RSelenium)
library(XML)
library(RCurl)
library(tidyverse)

#ativar o Docker para rodar o Selenium
# sudo docker run -d -p 4445:4444 selenium/standalone-firefox
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
for(i in 1:20){ #nrow(continue_unids)
  remDr$navigate(continue_unids$url[i])
  if(remDr$getCurrentUrl()[[1]] == urlErro){
    continue_unids$status[i] <- FALSE
  } else {
    #quando o retorno do status é True, já pega as informações da página e joga na lista infoUnids
    continue_unids$status[i] <- TRUE
  }
  cat(paste('url num. ', i, '/', nrow(unids), ' testada.', '\n', sep='', collapse=''))
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

#Pegar informações dos urls sem problemas
#dfUnid <- readHTMLTable(htmlParse(remDr$getPageSource()[[1]], encoding = 'UTF-8')) [[1]] %>% 
#  spread(key = V1, value = V2) %>% 
#  select(Unidade, Estado, Cidade, Bairro, CEP, Logradouro, Atendimento, Titular, 'Telefone(s)', Observações)
#infoUnids <- c(infoUnids, dfUnid)

#salvar como RDS e fazer unlisting depois, no RDS

#------------
#Script para obtenção de serviços de atendimento para pessoa física

#testar obtençao de informações dessa página
urlAtt <- 'http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/aduana/colecao'

atends <- data.frame(url = c(
  'http://receita.economia.gov.br/interface/lista-de-servicos/publico/cidadao/aduana/colecao',
  
))

#funcionando, inserir outras urls de atendimentos de pessoa física

remDr$navigate(urlAtt)
remDr$screenshot(display = TRUE) #mostrar imagem só para testar conexão
outputTables <- list()
#esse output será onde ficarão guardadas as informações do atendimento
tables <-remDr$findElements(using='css selector', value='table > tbody')
for(i in 1:length(tables)){
  lTest[[i]] <- list(
            nome = tables[[i]]$findChildElements(using='css selector', value='tr:nth-child(1) > td:nth-child(2)')[[1]]$getElementText(), 
            imagens = tables[[i]]$findChildElements(using='css selector', value='tr:nth-child(5) > td:nth-child(2) > a > img'), 
            urls = NA, #urls das imagens
            nome_popular = tables[[i]]$findChildElements(using='css selector', value='tr:nth-child(2) > td:nth-child(2)')[[1]]$getElementText(), 
            descricao = tables[[i]]$findChildElements(using='css selector', value='tr:nth-child(3) > td:nth-child(2)')[[1]]$getElementText(), 
            publico_alvo = tables[[i]]$findChildElements(using='css selector', value='tr:nth-child(4) > td:nth-child(2)')[[1]]$getElementText(), 
            )
  for(y in 1:length(lTest[[i]]$imagens)){
    lTest[[i]]$urls[[y]] <- lTest[[i]]$imagens[[y]]$getElementAttribute('src')
  }
}

#salvar como RDS e fazer unlisting depois, no RDS