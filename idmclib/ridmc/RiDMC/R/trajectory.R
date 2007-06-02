CTrajectory <- function(idmc_model, par, var, eps, integrator=0) {
	checkModelParVar(idmc_model, par, var)
	integrator <- as.integer(integrator)
	if((integrator<0)||(integrator>9)) 
		stop('\'integrator\' should be an integer code between 0 and 9')
	if(eps<=0)
		stop('\'eps\' must be a striclty positive real number')
	ans <- list()
	ans$par <- par
	ans$var <- var
	ans$eps <- eps
	ans$model <- idmc_model
	ans$integrator <- integrator
	trajectory <- .Call("ridmc_ctrajectory_alloc", 
		idmc_model$model, as.double(par), as.double(var), 
		as.double(eps), as.integer(integrator), PACKAGE='RiDMC')
	ans$trajectory <- trajectory
	ans$step <- function()
		.Call("ridmc_ctrajectory_step", trajectory, PACKAGE='RiDMC')
	ans$getValue <- function()
		.Call("ridmc_ctrajectory_getValue", trajectory, PACKAGE='RiDMC')
	class(ans) <- "idmc_ctrajectory"
	return(ans)
}

print.idmc_ctrajectory <- function(x, ...) {
	modelInfo <- x$model$infos
	cat('= iDMC model continuous trajectory =\n')
	cat('model: ', modelInfo[[1]]['name'], '\n')
	cat('parameter values: ', paste(x$par, sep=','), '\n')
	cat('starting point: ', paste(x$var, sep=','),'\n')
	cat('step size: ', x$eps, '\n')
	cat('step function: ', x$integrator, '\n')
}
