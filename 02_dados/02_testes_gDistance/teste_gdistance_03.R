library('gdistance')
set.seed(123)
r <- raster(ncol = 3, nrow = 3)
r[] <- 1:ncell(r)

plot(r, main='r')
r[] <- 1
tr1 <- transition(r, transitionFunction = mean, directions = 8)
tr1
image(transitionMatrix(tr1))
tr3 <- sqrt(tr1)

plot(raster(tr3))
