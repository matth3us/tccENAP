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

unidsRFB <- readRDS("C:/Users/02741207399/Desktop/Escritório de Processos/Git/tccENAP/02_ dados/02_ RFB/dados_modificados/unidades atendimento 2019-08-11.rds") %>% 
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

saveRDS(unidsRFB, "C:/Users/02741207399/Desktop/Escritório de Processos/Git/tccENAP/02_ dados/02_ RFB/dados_modificados/unidades atendimento 2019-08-22.rds")
              
  

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








