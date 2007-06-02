\name{Lyapunov exponents}
\alias{lexp}
\alias{lexp_ode}
\title{
Lyapunov exponents for continuous and discrete-time dynamical systems
}
\usage{
lexp_ode(idmc_model, par, var, time, eps)
lexp(idmc_model, par, var, iterations)
}
\arguments{
\item{idmc_model}{idmc\_model object as returned by \code{\link{Model}}}
\item{par}{model parameters values}
\item{var}{model variables values}
\item{time}{(continuous) time span}
\item{eps}{integration step}
\item{iterations}{(discrete) time span}
}
\description{
Lyapunov exponents for continuous and discrete-time dynamical systems
}
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
ly <- lexp_ode(model, c(10, 28, 2.667), c(1.0, 2.0, 1.0), 2000.0, 0.005)
}

