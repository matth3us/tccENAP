library(geobr)
library(sf)
Brasil <- geobr::read_country(year = 2018)
Estados <- geobr::read_state(code_state = "all", year=2018)
shape_m <- geobr::read_municipality(code_muni = "all", year=2018)
locus_m <- read_sf("./02_ dados/01_ IBGE/dados_brutos/BR_Localidades_2010_v1.shp") %>% filter(NM_CATEGOR == "CIDADE") %>% mutate(NM_UF = as.factor(NM_UF))
geoInfo <- list(brasil = Brasil, estados = Estados, shape_muni = shape_m, locus_muni = locus_m)


#teste de plotagem do mapa do Brasil
plot(st_geometry(Brasil))

