library(geobr)
library(sf)
Brasil <- geobr::read_country(year = 2018)
Estados <- geobr::read_state(code_state = "all", year=2018)
Municipios <- geobr::read_municipality(code_muni = "all", year=2018)
geoInfo <- list(brasil = Brasil, estados = Estados, municipios = Municipios)

#teste de plotagem do mapa do Brasil
plot(st_geometry(Brasil))

