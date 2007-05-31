\name{Model}
\alias{Model}
\alias{print.idmc_model}
\alias{summary.idmc_model}
\alias{print.summary.idmc_model}
\title{
Load a model
}
\usage{
Model(filename=NULL, text = readLines(filename))
\method{print}{idmc_model}(x, ...)
\method{summary}{idmc_model}(object, ...)
\method{print}{summary.idmc_model}(x, ...)
}
\arguments{
\item{filename}{file name to be opened}
\item{text}{char vector containing lua model specification}
\item{x, object}{\code{idmc_model} object}
}
\description{
Loads a new model from its LUA description
}
\value{
An \code{idmc_model} object.
}
\author{
Antonio, Fabio Di Narzo
}
\keyword{ misc }
\seealso{
\code{\link{exModelFile}}
}
\examples{
model <- Model(exModelFile('logistic'))
model
summary(model)
}
