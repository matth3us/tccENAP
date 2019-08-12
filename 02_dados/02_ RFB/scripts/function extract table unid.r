tabularUnid <- function(url){
  remDr$navigate(url)
  df <- readHTMLTable(htmlParse(remDr$getPageSource()[[1]], encoding = 'UTF-8')) [[1]] %>% 
          spread(key = V1, value = V2) %>% 
          select(Unidade, Estado, Cidade, Bairro, CEP, Logradouro, Atendimento, Titular, 'Telefone(s)', Observações)
  return(df)
}
