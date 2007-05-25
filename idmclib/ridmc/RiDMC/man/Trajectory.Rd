\name{Trajectory}
\alias{Trajectory}
\alias{CTrajectory}
\title{
Continuous model trajectory
}
\usage{
CTrajectory(idmc_model, par, var, eps, integrator=0)
}
\description{
Computes continuous time model trajectory.
}
\details{
}
\author{
Antonio, Fabio Di Narzo
}
\keyword{ misc }
\seealso{
}
\examples{
modelFileName <- system.file(file.path('models','lorenz.lua'),
  package='RiDMC')
model <- Model(modelFileName)
trajectory <- CTrajectory(model, 
	c(10, 28, 2.667), c(1.0, 2.0, 1.0), 
	0.005, 0 )

for(i in 1:1000)
	trajectory$step()

mat <- matrix(, 20000, 3)
for(j in 1:NROW(mat)) {
	trajectory$step()
	mat[j,] <- trajectory$getValue()
}

plot(mat[,c(1,3)], type="l", main='Lorenz system trajectory')

}

