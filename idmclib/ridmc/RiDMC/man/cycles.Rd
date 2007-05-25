\name{Periodic cycles}
\alias{cycles}
\alias{cycles_find}
\title{
Periodic cycles
}
\usage{
cycles_find(idmc_model, par, var, period, eps, max.iter=100)
}
\description{
Find periodic cycles
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
modelFileName <- system.file(file.path('models','logistic.lua'),
  package='RiDMC')
model <- Model(modelFileName)
res <- cycles_find(model, 3.25, 0.5, 2, 1e-6)
res
}

