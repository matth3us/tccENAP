library(sf)
library(tidyverse)
municipios <- read_sf("./02_ dados/01_ IBGE/dados_brutos/BR_Localidades_2010_v1.shp") %>% 
                filter(NM_CATEGOR == "CIDADE") %>% 
                select(CD_GEOCODM, NM_MUNICIP, NM_UF, LONG, LAT, ALT) %>% 
                mutate_if(is.character, .funs = function(x){return(`Encoding<-`(x, "latin1"))}) %>% 
                mutate(NM_UF = as.factor(NM_UF))

#municipios para teste
paraTestes <- municipios %>% filter(NM_MUNICIP %in% c("BRASÍLIA", "SÃO PAULO", "SÃO JOSÉ DOS CAMPOS", "SÃO LUÍS"))
library(osrm)
options(osrm.server = "http://127.0.0.1:9966/")
testTable <- osrm::osrmTable(paraTestes, measure = c("duration", "distance"))

saveRDS

#sudo docker run -p 9966:9966 osrm/osrm-frontend
#sudo xdg-open 'http://127.0.0.1:9966'
