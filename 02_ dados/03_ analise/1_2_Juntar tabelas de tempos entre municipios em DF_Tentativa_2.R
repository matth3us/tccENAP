library(tidyverse)
library(geobr)
library(sf)
#tempo_munis <- readRDS("C:/Users/02741207399/Desktop/Escritório de Processos/Git/1_tempo_entre_municipios.rds")
#tester <- tempo_munis[[1]]
#sf::st_coordinates(muni$geometry)


shape_m <- geobr::read_municipality(code_muni = "all", year=2010)



### 1. Converter os Data Frames de Destino e 
### 2. Para cada posição geográfica, usar a função sf::st_within() para saber em que município se localiza
### 3. Confirmar que cada posição do data frame se localiza em apenas um município, e não há municípios repetidos
### 4. Fazer o mesmo para todas os data frames das listas de tempos entre municípios
### 5. juntar todos os dataframes em uma única matrix de ~5500x5500
### 6. Salvar o Data Frame como um RDS
### 7. Aplicar mesmo algoritmo para identificar localização de unidades de atendimento em áreas de ponderação





