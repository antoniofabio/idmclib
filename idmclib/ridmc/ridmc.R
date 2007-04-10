dyn.load(paste("libridmc", .Platform$dynlib.ext, sep=""))

Model <- function(filename=NULL, buffer = paste(readLines(filename), collapse="\n")) {
	model <- .Call("model_alloc", buffer)
	ans <- list()
	ans$model <- model
	infos <- .Call("model_getInfos", model)
	names(infos[[1]]) <- c("name","description","type")
	names(infos[[2]]) <- c("has_inverse","has_jacobian")
	names(infos[[3]]) <- c("n.pars","n.vars")
	ans$infos <- infos
	ans$buffer <- buffer
	ans$f <- function(par, var)
		.Call("model_f", model, as.double(par), as.double(var))
	ans$g <- function(par, var)
		.Call("model_g", model, as.double(par), as.double(var))
	ans$Jf <- function(par, var)
		.Call("model_Jf", model, as.double(par), as.double(var))
	ans$NumJf <- function(par, var)
		.Call("model_NumJf", model, as.double(par), as.double(var))
	ans$set.seed <- function(seed)
		invisible(.Call("model_setGslRngSeed", model, as.integer(seed)))
	class(ans) <- "idmc_model"
	return(ans)
}

print.idmc_model <- function(x, ...) {
	infos <- x$infos
	cat('= iDMC model =\n')
	cat('Name: ', infos[[1]]["name"],'\n')
	cat('Description: ', infos[[1]]["description"],'\n')
	cat('Type: ', if(infos[[1]]["type"]=="D") "discrete" 
		else if(infos[[1]]["type"]=="C") "continue"
		else "invalid model type", '\n')
	cat('Parameters: ', paste(infos[[4]], collapse=", "),'\n')
	cat('Variables: ', paste(infos[[5]], collapse=", "),'\n')
	cat('Has inverse: ', infos[[2]]["has_inverse"]!=0,'\n')
	cat('Has jacobian: ', infos[[2]]["has_jacobian"]!=0,'\n')
}

CTrajectory <- function(idmc_model, par, var, eps, integrator=0) {
	if(!inherits(idmc_model,"idmc_model"))
		stop("'idmc_model' should be an idmc_model object")
	trajectory <- .Call("ctrajectory_alloc", 
		idmc_model$model, as.double(par), as.double(var), 
		as.double(eps), as.integer(integrator))
	ans <- list()
	ans$trajectory <- trajectory
	ans$step <- function()
		.Call("ctrajectory_step", trajectory)
	ans$getValue <- function()
		.Call("ctrajectory_getValue", trajectory)
	class(ans) <- "idmc_ctrajectory"
	return(ans)
}

lexp_ode <- function(idmc_model, par, var, time, eps) {
	if(!inherits(idmc_model, "idmc_model"))
		stop("'idmc_model' should be and idmc_model object")
	.Call("lexp_ode", idmc_model$model, as.double(par), as.double(var), as.double(time), as.double(eps))
}

lexp <- function(idmc_model, par, var, iterations) {
	if(!inherits(idmc_model, "idmc_model"))
		stop("'idmc_model' should be and idmc_model object")
	.Call("lexp", idmc_model$model, as.double(par), as.double(var), as.integer(iterations))
}

cycles_find <- function(idmc_model, par, var, period, eps, max.iter=100) {
	if(!inherits(idmc_model, "idmc_model"))
		stop("'idmc_model' should be and idmc_model object")
	.Call("cycles_find", idmc_model$model, as.double(par), as.double(var), 
		as.integer(period), as.double(eps), as.integer(max.iter))
}

Basin <- function(model, parms, xlim, xres=100, ylim, yres=100, attractorLimit, attractorIterations) {
	if(!inherits(model, "idmc_model"))
		stop("'model' should be and idmc_model object")
	basin <- .Call("basin_alloc", model$model, as.double(parms),
		as.double(xlim[1]), as.double(xlim[2]), as.integer(xres),
		as.double(ylim[1]), as.double(ylim[2]), as.integer(yres),
		as.integer(attractorLimit), as.integer(attractorIterations) )
	ans <- list()
	ans$basin <- basin
	ans$step <- function()
		.Call("basin_step", basin)
	ans$finished <- function()
		.Call("basin_finished", basin)!=0
	ans$getData <- function()
		.Call("basin_getData", basin)
	class(ans) <- "idmc_basin"
	return(ans)
}


