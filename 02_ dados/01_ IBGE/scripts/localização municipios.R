library(sf)
library(tidyverse)
library(viridis)
shape <- read_sf("./02_ dados/01_ IBGE/dados_brutos/BR_Localidades_2010_v1.shp")

municipios <- shape %>% filter(NM_CATEGOR == "CIDADE") %>% mutate(NM_UF = as.factor(NM_UF))
paleta_estados <- data.frame(uf = levels(municipios$NM_UF), color = as.factor(viridis(nlevels(municipios$NM_UF))))

plot_muni <- municipios %>% select(ID, NM_MUNICIP, NM_UF) %>% left_join(paleta_estados, by = c("NM_UF" =  "uf"))
plot(plot_muni$geometry, pch = 4, col = plot_muni$color)


