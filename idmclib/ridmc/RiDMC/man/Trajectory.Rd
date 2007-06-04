\name{Trajectory}
\alias{Trajectory}
\alias{CTrajectory}
\alias{print.idmc_ctrajectory}
\alias{as.matrix.idmc_ctrajectory}
\title{
Continuous model trajectory
}
\usage{
CTrajectory(idmc_model, par, var, eps, integrator=0)
\method{print}{idmc_ctrajectory}(x, ...)
\method{as.matrix}{idmc_ctrajectory}(x, ...)
}
\arguments{
 \item{idmc_model,x}{a model object, as returned by \code{\link{Model}}}
 \item{par, var}{model parameters values and starting point value}
 \item{eps}{integration step}
 \item{integrator}{an integer code between 0 and 9 indicating what integrator to use}
 \item{...}{arguments to and from other methods}
}
\description{
Computes continuous time model trajectories.
}
\details{
TODO
}
\author{
Antonio, Fabio Di Narzo
}
\keyword{ misc }
\seealso{
\code{\link{Model}}
}
\examples{
model <- Model(exModelFile('lorenz'))
trajectory <- CTrajectory(model, 
	c(10, 28, 2.667), c(1.0, 2.0, 1.0), 
	0.005, 0 )
trajectory

for(i in 1:1000)
	trajectory$step()

mat <- matrix(, 20000, 3)
for(j in 1:NROW(mat)) {
	trajectory$step()
	mat[j,] <- trajectory$getValue()
}

plot(mat[,c(1,3)], type="l", main='Lorenz system trajectory')
}
