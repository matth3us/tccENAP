#cidades + unidades
library(geobr)
library(sf)

demog <- readRDS("./02_ dados/03_ analise/2_demografia_municipios.rds") %>% rename(Cod_ibge = codigo)
rfb <- readRDS("./02_ dados/03_ analise/0_unidades_atendimento.rds") %>% 
        select(Unidade, Tipo, categ, Estado, Cidade, Bairro, Logradouro) %>% 
        rename(Categoria = categ)
cidades <- geobr::read_municipality(code_muni = "all", year=2010) %>% 
              select(-code_state) %>% 
              rename(
                Cod_ibge = code_muni, 
                Cidade = name_muni, 
                Estado = abbrev_state
              ) %>% 
              full_join(rfb, by=c("Cidade", "Estado")) %>% 
              mutate(Cod_ibge = as.character(Cod_ibge)) %>% 
              left_join(demog, by=c("Cod_ibge = codigo"))
rm(rfb, demog)
saveRDS(cidades, "03_cidades&unidades.rds")


