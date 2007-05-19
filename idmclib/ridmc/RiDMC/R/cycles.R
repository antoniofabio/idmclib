cycles_find <- function(idmc_model, par, var, period, eps, max.iter=100) {
	if(!inherits(idmc_model, "idmc_model"))
		stop("'idmc_model' should be and idmc_model object")
	.Call("ridmc_cycles_find", idmc_model$model, as.double(par), as.double(var), 
		as.integer(period), as.double(eps), as.integer(max.iter))
}
