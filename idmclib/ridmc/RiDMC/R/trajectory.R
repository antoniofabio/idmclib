CTrajectory <- function(idmc_model, par, var, eps, integrator=0) {
	if(!inherits(idmc_model,"idmc_model"))
		stop("'idmc_model' should be an idmc_model object")
	trajectory <- .Call("ridmc_ctrajectory_alloc", 
		idmc_model$model, as.double(par), as.double(var), 
		as.double(eps), as.integer(integrator), PACKAGE='RiDMC')
	ans <- list()
	ans$trajectory <- trajectory
	ans$step <- function()
		.Call("ridmc_ctrajectory_step", trajectory, PACKAGE='RiDMC')
	ans$getValue <- function()
		.Call("ridmc_ctrajectory_getValue", trajectory, PACKAGE='RiDMC')
	class(ans) <- "idmc_ctrajectory"
	return(ans)
}
