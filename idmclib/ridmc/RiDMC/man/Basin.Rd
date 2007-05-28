\name{Basin}
\alias{Basin}
\title{
Computes basins of attraction for a 2-dim. discrete dynamical system
}
\usage{
Basin(model, parms, xlim, xres=100, ylim, yres=100, attractorLimit, attractorIterations)
}
\description{
Computes basins of attraction for a 2-dim. discrete dynamical system
}
\details{
Computes basins of attraction for a 2-dim. discrete dynamical system
}
\author{
Antonio, Fabio Di Narzo
}
\keyword{ misc }
\seealso{
}
\examples{
m <- Model(exModelFile('rossler'))
b <- Basin(m, c(1,2), c(0,1), 200, c(0, 1), 200, 300, 150)
system.time( while(!b$finished()) b$step() )
mat <- b$getData()
image(mat[,200:1], breaks=c(1:8-0.5) , col=rainbow(7) )
}
