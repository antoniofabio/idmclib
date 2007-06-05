\name{Trajectory}
\alias{Trajectory}
\alias{CTrajectory}
\alias{DTrajectory}
\alias{print.idmc_ctrajectory}
\alias{print.idmc_dtrajectory}
\alias{as.matrix.idmc_trajectory}
\alias{stepTrajectory}
\alias{as.ts.idmc_trajectory}
\alias{plot.idmc_trajectory}
\title{
Continuous and discrete model trajectory
}
\usage{
CTrajectory(idmc_model, par, var, eps, integrator=0, nsteps=0, transient=0)
DTrajectory(idmc_model, par, var, nsteps=0, transient=0)
stepTrajectory(idmc_trajectory, nsteps=1, transient)
\method{print}{idmc_ctrajectory}(x, ...)
\method{print}{idmc_dtrajectory}(x, ...)
\method{as.matrix}{idmc_trajectory}(x, ...)
\method{as.ts}{idmc_trajectory}(x, ...)
\method{plot}{idmc_trajectory}(x, y, vars=1:2, type='l', main, xlab, ylab, ...)
}
\arguments{
 \item{idmc_model}{a model object, as returned by \code{\link{Model}}}
 \item{idmc_ctrajectory}{an already created \code{idmc_ctrajectory} object}
 \item{idmc_trajectory}{an already created \code{idmc_trajectory} object}
 \item{par, var}{model parameters values and starting point value}
 \item{eps}{integration step}
 \item{integrator}{an integer code between 0 and 9 indicating what integrator to use}
 \item{nsteps}{number of steps (after transient)}
 \item{transient}{transient length}
 \item{x}{an \code{idmc_trajectory} object}
 \item{vars}{variables to be plotted}
 \item{type, main, xlab, ylab}{usual plot options}
 \item{y,...}{arguments to and from other methods}
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
##Load model:
model <- Model(exModelFile('lorenz'))

##Compute trajectory:
trajectory <- CTrajectory(model, 
	c(10, 28, 2.667), c(1.0, 2.0, 1.0), 
	0.005, 0, nsteps=20000, transient=1000 )
##See basic informations:
trajectory

##Plot trajectory:
plot(trajectory)
}

