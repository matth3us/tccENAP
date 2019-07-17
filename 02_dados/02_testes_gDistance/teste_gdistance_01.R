library(gdistance)
r <- raster(system.file('external/maungawhau.grd', package='gdistance'))

altDiff <- function(x) {x[2] - x[1]}

slope <- geoCorrection(transition(r, altDiff, 8, symm = FALSE))
adj <- adjacent(r, cells = 1:ncell(r), pairs = TRUE, directions = 8)
speed <- slope
speed[adj] <- 6 * exp(-3.5 * abs(slope[adj] + 0.05))
Conductance <- geoCorrection(speed)

A <- c(2667670, 6479000)
B <- c(2667800, 6479400)
AtoB <- shortestPath(Conductance, A, B, output = 'SpatialLines')
BtoA <- shortestPath(Conductance, B, A, output = 'SpatialLines')

plot(r, xlab='x coordinate (m)', ylab = 'y coordinate (m)', legend.lab = 'Altitude (masl)')
lines(AtoB, col='red', lwd = 2)
lines(BtoA, col = 'blue')
text(A[1] - 10, A[2] - 10, "A")
text(B[1] + 10, B[2]+10, "B")