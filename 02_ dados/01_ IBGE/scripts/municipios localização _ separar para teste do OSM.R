library(sf)
library(tidyverse)
municipios <- read_sf("./02_ dados/01_ IBGE/dados_brutos/BR_Localidades_2010_v1.shp") %>% 
                filter(NM_CATEGOR == "CIDADE") %>% 
                select(CD_GEOCODM, NM_MUNICIP, NM_UF, LONG, LAT, ALT) %>% 
                mutate_if(is.character, .funs = function(x){return(`Encoding<-`(x, "latin1"))}) %>% 
                mutate(NM_UF = as.factor(NM_UF))

#municipios para teste
paraTestes <- municipios %>% filter(NM_MUNICIP %in% c("BRASÍLIA", "SÃO PAULO", "SÃO JOSÉ DOS CAMPOS", "SÃO LUÍS", "PARINTINS"))
library(osrm)
testTable <- osrm::osrmTable(paraTestes, measure = c("duration", "distance"))

saveRDS(testTable, "testTable.rds")
