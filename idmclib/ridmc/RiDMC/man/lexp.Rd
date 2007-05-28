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
\description{
Lyapunov exponents for continuous and discrete-time dynamical systems
}
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
model <- Model(exModelFile('lorenz'))
ly <- lexp_ode(model, c(10, 28, 2.667), c(1.0, 2.0, 1.0), 2000.0, 0.005)
}

}

