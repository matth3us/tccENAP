#ALF Alfândega
#ARF Agência
#CAC Centro de Atendimento ao Contribuinte
#INC Inspetorias (administração e vigilância aduaneira)
#IRF INspetorias (administração e vigilância aduaneira)
#PST Posto

paraAlf <- c(
  "Aeroporto Internacional Do Galeão",
  "Alfândega De São Paulo",
  "Alfândega De Curitiba",
  "Alfândega Aeroporto Pinto Martins",
  "Alfândega De Fortaleza",
  "Alfândega Do Aeroporto Eduardo Gomes",
  "Alfândega Do Porto De Manaus",
  "Alfândega Aeroporto Inter. De Belém",
  "Alfândega Do Porto Belém",
  "Aeroporto Internacional De Brasília",
  "Alfândega Do Aeroporto De Viracopos",
  "Alfândega De Florianópolis",
  "Alfândega Do Aeroporto De Guarulhos",
  "Alfândega Do Porto De Itajaí",
  "Alfândega De Ponta Porã",
  "Alf Recife",
  "Alfândega Do Porto De Rio Grande",
  "Alfândega Do Porto De Salvador",
  "Alfândega Do Porto De Santos",
  "Alfândega Do Porto De Vitória/Es",
  "Alfândega De Corumbá",
  "Alfândega De Dionísio Cerqueira",
  "Alfândega De Foz Do Iguaçu",
  "Alfândega De Santana Do Livramento",
  "Alfândega Do Porto De Paranaguá"
)

library(tidyverse)

unidsRFB <- readRDS("./02_ dados/02_ RFB/dados_modificados/unidades atendimento 2019-08-11.rds") %>% 
              mutate(
                Unidade = str_trim(Unidade),
                Logradouro =  str_trim(str_squish(Logradouro)),
                Estado = as.factor(Estado),
                Bairro = str_trim(Bairro),
                Cidade = str_trim(Cidade),
                Atendimento = str_trim(str_squish(as.character(Atendimento))),
                Tipo = as.character(Tipo),
                Tipo = ifelse(Unidade %in% paraAlf, "ALF", Tipo),
                categ = ifelse(Tipo %in% c('ALF', 'INC', "IRF"), "aduana", "atendimento"),
                Unidade = ifelse(Unidade == "- Zona Norte", "Zona Norte", Unidade)
              ) %>% 
              filter(!(Cidade == "Coronel Fabriciano" & Tipo == 'CAC')) %>% 
              filter(!(Unidade == "São Paulo - Maco - (Suspensa)")) %>% 
              filter(!(Unidade == "São Paulo - Luz" & Atendimento == "De 07:00 às 19:00")) %>% 
              filter(!(Unidade == "São Paulo - Luz" & Atendimento == "Das 07:00 às 19:00")) %>%
              filter(!(Unidade == "Rjo Ii - B. Tijuca Malhas")) %>% 
              filter(!(Unidade == "Itabira" & Atendimento == "Das 10:00 às 16:00")) %>%
              filter(!(Unidade == "Marechal Cândido Rondon" & Atendimento == "")) %>%
              filter(!(Unidade == "Medianeira" & Bairro == "Centro")) %>%
              filter(!(Unidade == "Redenção" & CEP == "")) %>% 
              filter(!(Unidade == "Curitiba - Portão")) %>%
              filter(!(Unidade == "Pelotas" & Tipo == "CAC"));

#saveRDS(unidsRFB, "./02_ dados/02_ RFB/dados_modificados/unidades atendimento 2019-09-01.rds")
              
  

Receita <- unidsRFB %>% filter(categ == "atendimento") 
Aduana <- unidsRFB %>% filter(categ == "aduana")
citiesReceita <- Receita %>% group_by(Cidade, Estado) %>% summarise(n_unids = n()) %>% ungroup() %>% arrange(desc(n_unids)) %>% filter(n_unids > 1)
citiesAduana <- Aduana %>% group_by(Cidade, Estado) %>% summarise(n_unids = n()) %>% ungroup() %>% arrange(desc(n_unids)) %>% filter(n_unids > 1)
ReceitaVarios <- citiesReceita %>% select(-n_unids) %>% left_join(Receita, by = c("Cidade", "Estado"))
ReceitaUnico <- Receita %>% 
                  group_by(Cidade, Estado) %>% 
                  summarise(n_unids = n()) %>% 
                  ungroup() %>% 
                  arrange(desc(n_unids))%>% 
                  filter(n_unids < 2) %>% 
                  select(-n_unids) %>% 
                  left_join(Receita, by = c("Cidade", "Estado"))


### Testes de localização das unidades de atendimento em cidades com mais de um posto
#Teste com Pacote nominatim
#library(nominatim)
#devtools::install_github("hrbrmstr/nominatim")
#test_adr <- paste("Brazil", ReceitaVarios$Estado[16], ReceitaVarios$Cidade[16], ReceitaVarios$Bairro[16], ReceitaVarios$Logradouro[16], sep = ", ")
#test <- osm_geocode("Brazil, São Paulo", key="ALN91qAX2xCpTTdwecBU7lmE1iBPCGh6")


# Teste com Google Maps
#library(ggmap)
#register_google('AIzaSyA0wJ-nawHO4cRv9DqXJ9300V31dBeGlec')
#test <- ggmap::geocode('Brazil, São Paulo, Bela Vista, Rua Avanhadava')




## geocoding function using OSM Nominatim API
## details: http://wiki.openstreetmap.org/wiki/Nominatim
## made by: D.Kisler 
## https://datascienceplus.com/osm-nominatim-with-r-getting-locations-geo-coordinates-by-its-address/

#nominatim_osm <- function(address = NULL)
#{
  #if(suppressWarnings(is.null(address)))
    #return(data.frame())
  #tryCatch(
    #d <- jsonlite::fromJSON( 
      #gsub('\\@addr\\@', gsub('\\s+', '\\%20', address), 
           #'http://nominatim.openstreetmap.org/search/@addr@?format=json&addressdetails=0&limit=1')
    #), error = function(c) return(data.frame())
  #)
  #if(length(d) == 0) return(data.frame())
  #return(data.frame(lon = as.numeric(d$lon), lat = as.numeric(d$lat)))
#}



#conclusão do Teste: google maps funcionou após limitar o endereço apenas até a rua; 
# pacote nominatin não funcionou; testar função sem pacote para endereços no nominatin


#Encontrando as posições geográficas das unidades 

library(ggmap)
register_google('AIzaSyA0wJ-nawHO4cRv9DqXJ9300V31dBeGlec')
enderecos <- ReceitaVarios %>% select(Unidade, Cidade, Estado, Bairro, Logradouro) %>% 
                            mutate(
                              Endereço = stringr::str_split_fixed(Logradouro, ", ", n=2)[,1],
                              Endereço = stringr::str_split_fixed(Endereço, " - ", n=2)[,1],
                              Endereço = str_c(Cidade, Estado, Bairro, Endereço, sep = ", ")
                              ) %>% 
                            #select(Cidade, Estado, Endereço) %>% 
                            #distinct() %>% 
                            bind_cols(do.call(bind_rows, lapply(.$Endereço, ggmap::geocode)))

saveRDS(enderecos, paste("./02_ dados/02_ RFB/dados_modificados/localizacao_unidades_municipios_varias_unidades_", Sys.Date(), ".rds", sep=""))





