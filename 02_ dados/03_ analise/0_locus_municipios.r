library(geobr)
library(sf)
Brasil <- geobr::read_country(year = 2018)
Estados <- geobr::read_state(code_state = "all", year=2018)
shape_m <- geobr::read_municipality(code_muni = "all", year=2018)
locus_m <- readRDS("./02_ dados/01_ IBGE/dados_modificados/locus_municipios.rds")
geoInfo <- list(brasil = Brasil, estados = Estados, shape_muni = shape_m, locus_muni = locus_m)


#teste de plotagem do mapa do Brasil
#plot(st_geometry(Brasil))

