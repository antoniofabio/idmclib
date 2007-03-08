name = "test model 1"
description = "test model 1: rng"
type = "D"
parameters = {"a"}
variables = {"unif", "norm", "pois", "laplace", "exponential", "beta", "lognormal", "logistic", "pareto"}

function f (a, unif, norm, pois, laplace, exponential, beta, lognormal, logistic, pareto)
		unif = runif()
		norm = rnorm()
		pois = rpois(5)
		laplace = rlaplace(1)
		exponential = rexponential(2)
		beta = rbeta(1, 2)
		lognormal = rlognormal(1, 2)
		logistic = rlogistic(2)
		pareto = rpareto(3,4)
		return unif, norm, pois, laplace, exponential, beta, lognormal, logistic, pareto
end
