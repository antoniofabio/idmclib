\name{Model}
\alias{Model}
\alias{print.idmc_model}
\title{
Load a model
}
\usage{
Model(filename=NULL, text = paste(readLines(filename), collapse="\n"))
\method{print}{idmc_model}(x, ...)
}
\description{
Loads a new model from its LUA description
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
model
}

