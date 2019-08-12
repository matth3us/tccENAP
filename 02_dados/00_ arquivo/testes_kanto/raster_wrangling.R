#data wrangling dos rasters

#------------------------
#library(raster)  
#library(gdistance)
## Create a matrix with random data & use image()
#xy <- matrix(rnorm(400),20,20)
#image(xy)

# Turn the matrix into a raster
#rast <- raster(xy)
# Give it lat/lon coords for 36-37°E, 3-2°S
#extent(rast) <- c(36,37,-3,-2)
# ... and assign a projection
#projection(rast) <- CRS("+proj=longlat +datum=WGS84")
#plot(rast)
#rast
#rast$value2 <- 1
#rast
#plot(rast)


#------------------------

library(raster)
library(tidyverse)
library(RColorBrewer)

#Fatores de tipo de terreno
kanto_info <- read.csv('dataframe_kanto.csv', sep=';', header=F)
terrain <- data.frame(
  num_factor = c(0,1,2,3,4,5,6,7),
  terrain = c('SE','LD','CT','RM','RC','RG','RF','SH'),
  speed = c(6.5,0.55,5,1.65,15,4.5,3.5,20)
)
kanto_terrain <- kanto_info %>% 
  mutate(V1 = as.character(V1)) %>% 
  left_join(., terrain, by=c('V1' = 'terrain')) %>% 
  dplyr::select(num_factor) %>% 
  rename(terrain = num_factor) %>% 
  as.matrix(.)
dim(kanto_terrain) <- c(17, 20)

#fatores de velocidade
kanto_speed <- kanto_info %>% 
  mutate(V1 = as.character(V1)) %>% 
  left_join(., terrain, by=c('V1' = 'terrain')) %>% 
  dplyr::select(speed) %>% 
  as.matrix(.)
dim(kanto_speed) <- c(17, 20)

#raster de terreno
kanto <- raster(kanto_speed, 
                xmn=139.81,
                xmx=140.18,
                ymn=34.81,
                ymx=35.19,
                crs=CRS("+proj=longlat +datum=WGS84")
)

#matriz de transição: custo de velocidade de cada tipo de terreno
custoMov <- transition(kanto, function(x) 1/mean(x), 8)
custoMov <- geoCorrection(custoMov)

#localização dos pokécenters
kanto_centers <- cbind(
  c(3,3),
  c(5,4),
  c(5,16),
  c(8,4),
  c(10,6),
  c(11,14),
  c(13,3),
  c(13,6),
  c(13,10),
  c(17,6))

rm(kanto_info, kanto_speed, kanto_terrain, terrain)
