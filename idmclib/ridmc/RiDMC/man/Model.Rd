\name{Model}
\alias{Model}
\alias{print.idmc_model}
\title{
Load a model
}
\usage{
Model(filename=NULL, text = readLines(filename))
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
model <- Model(exModelFile('logistic'))
model
}

