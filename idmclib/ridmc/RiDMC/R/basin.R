Basin <- function(model, parms, xlim, xres=100, ylim, 
	yres=100, attractorLimit, attractorIterations) {
	if(!inherits(model, "idmc_model"))
		stop("'model' should be and idmc_model object")
	basin <- .Call("ridmc_basin_alloc", model$model, as.double(parms),
		as.double(xlim[1]), as.double(xlim[2]), as.integer(xres),
		as.double(ylim[1]), as.double(ylim[2]), as.integer(yres),
		as.integer(attractorLimit), as.integer(attractorIterations) , PACKAGE='RiDMC')
	ans <- list()
	ans$basin <- basin
	ans$step <- function()
		.Call("ridmc_basin_step", basin, PACKAGE='RiDMC')
	ans$finished <- function()
		.Call("ridmc_basin_finished", basin, PACKAGE='RiDMC')!=0
	ans$getData <- function()
		.Call("ridmc_basin_getData", basin, PACKAGE='RiDMC')
	class(ans) <- "idmc_basin"
	return(ans)
}
