library(gdistance)

Europe <- raster(system.file('external/Europe.grd', package='gdistance'))
Europe[is.na(Europe)] <- 0
data("genDist")
data("popCoord")
pC <- as.matrix(popCoord[c('x', 'y')])

geoDist <- as.dist(pointDistance(pC, longlat = TRUE))
Europe <- aggregate(Europe, 3)
tr <- transition(Europe, mean, directions = 8)
trC <- geoCorrection(tr, 'c', scl = TRUE)
trR <- geoCorrection(tr, 'r', scl = TRUE)
cosDist <- costDistance(trC, pC)                     
resDist <- costDistance(trR, pC)

cor(genDist, geoDist)
cor(genDist, cosDist)
cor(genDist, resDist)
