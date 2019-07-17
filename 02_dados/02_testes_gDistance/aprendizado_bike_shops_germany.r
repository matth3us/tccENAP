#Tutorial de exemplo de análise de dados com raster
#https://geocompr.robinlovelace.net/location.html

library(raster)
library(sp)
library(sf)
library(lattice)
library(latticeExtra)
library(grid)
library(gridExtra)
library(classInt)
library(mapview)
library(tidyverse)
library(htmlwidgets)
library(leaflet)
library(revgeo)


download.file("https://tinyurl.com/ybtpkwxz", 
              destfile = "census.zip", mode = "wb")
unzip("census.zip") # unzip the files
census_de = readr::read_csv2(list.files(pattern = "Gitter.csv"))  
input <- census_de %>% 
            dplyr::select(
              x = 'x_mp_1km', 
              y = 'y_mp_1km',
              pop = 'Einwohner',
              women = 'Frauen_A',
              mean_age = 'Alter_D',
              hh_size = 'HHGroesse_D'
            ) %>% 
            mutate_all(
              list(~ifelse(. %in% c(-1, -9), NA, .))
            )
input_ras <- rasterFromXYZ(input, crs = st_crs(3035)$proj4string)

#os dados do censo estão em categorias; as matrizes abaixo vão ajudar a traduzir essas categorias em dados úteis
rcl_pop <- matrix(c(1, 1, 127, 2, 2, 375, 3, 3, 1250, 
                   4, 4, 3000, 5, 5, 6000, 6, 6, 8000), 
                 ncol = 3, byrow = TRUE)
rcl_women <- matrix(c(1, 1, 3, 2, 2, 2, 3, 3, 1, 4, 5, 0), 
                   ncol = 3, byrow = TRUE)
rcl_age <- matrix(c(1, 1, 3, 2, 2, 0, 3, 5, 0),
                 ncol = 3, byrow = TRUE)
rcl_hh <- rcl_women
rcl <- list(rcl_pop, rcl_women, rcl_age, rcl_hh)

#efetuando a reclassificação
reclass <- input_ras
for(i in seq_len(nlayers(reclass))){
  reclass[[i]] <- reclassify(x = reclass[[i]], rcl = rcl[[i]], right =NA)
}
names(reclass) <- names(input_ras)

#Definir as áreas metropolitanas
# áreas metropolitanas: pixels de 20km² com mais de 500.000 habitantes

pop_agg <- aggregate(reclass$pop, fact = 20, fun = sum)
pop_agg <- pop_agg[pop_agg > 500000, drop = FALSE]
polys <- pop_agg %>% 
          clump() %>% 
          rasterToPolygons() %>% 
          st_as_sf()
metros <- polys %>% 
            group_by(clumps) %>% 
            summarize()

metros_wgs <- st_transform(metros, 4326)
coords <- st_centroid(metros_wgs) %>% 
            st_coordinates() %>% 
            round(4)

#usar latitudes e longitudes no mapa raster para pegar nomes de cidades no OpenStreetMap, via pacote revgeo
metro_names <- revgeo(longitude = coords[,1], latitude = coords[,2], output = 'frame')
metro_names <- pull(metro_names, city) %>% 
                  as.character() %>% 
                  ifelse(. == 'Wülfrath', 'Duesseldorf', .)

#baixar dados de lojas já existentes de bicicletas restritas às áreas metropolitanas 
#para não ter que baixar todso so dados, pegar no pacote spDataLarge
#O código original itera sobre cada uma das regiões metropolitanas separadas, tentando baixar shops no openestreetmap e convertendo os dados OSM para de classe sf (objetos espaciais)
data('shops', package='spDataLarge')
shops <- st_transform(shops, proj4string(reclass))

#poi: points of interest
poi <- rasterize(x = shops, y = reclass, field='osm_id', fun='count')

#construir matriz de reclassificação
int <- classInt::classIntervals(values(poi), n=4, style='fisher')
int <- round(int$brks)
rcl_poi = matrix(c(int[1], rep(int[-c(1, length(int))], each = 2), 
                   int[length(int)] + 1), ncol = 2, byrow = TRUE)
rcl_poi = cbind(rcl_poi, 0:3)
poi <- reclassify(poi, rcl = rcl_poi, right=NA)
names(poi) <- 'poi'
reclass <- addLayer(reclass, poi)
reclass <- dropLayer(reclass, 'pop')
result <- sum(reclass)
plot(result)
