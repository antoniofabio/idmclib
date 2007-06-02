lexp_ode <- function(idmc_model, par, var, time, eps) {
	checkModelParVar(idmc_model, par, var)
	checkPositiveScalar(time)
	checkPositiveScalar(eps)
	.Call("ridmc_lexp_ode", idmc_model$model, as.double(par), as.double(var), 
		as.double(time), as.double(eps), PACKAGE='RiDMC')
}

lexp <- function(idmc_model, par, var, iterations) {
	checkModelParVar(idmc_model, par, var)
	checkPositiveScalar(iterations)
	.Call("ridmc_lexp", idmc_model$model, 
		as.double(par), as.double(var), as.integer(iterations), PACKAGE='RiDMC')
}
