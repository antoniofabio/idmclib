lexp_ode <- function(idmc_model, par, var, time, eps) {
	if(!inherits(idmc_model, "idmc_model"))
		stop("'idmc_model' should be and idmc_model object")
	.Call("ridmc_lexp_ode", idmc_model$model, as.double(par), as.double(var), as.double(time), as.double(eps), PACKAGE='RiDMC')
}

lexp <- function(idmc_model, par, var, iterations) {
	if(!inherits(idmc_model, "idmc_model"))
		stop("'idmc_model' should be and idmc_model object")
	.Call("ridmc_lexp", idmc_model$model, 
		as.double(par), as.double(var), as.integer(iterations), PACKAGE='RiDMC')
}
