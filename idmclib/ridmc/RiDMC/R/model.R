
Model <- function(filename=NULL, text = paste(readLines(filename), collapse="\n")) {
	model <- .Call("ridmc_model_alloc", buffer, PACKAGE='RiDMC')
	ans <- list()
	ans$model <- model
	infos <- .Call("ridmc_model_getInfos", model, PACKAGE='RiDMC')
	names(infos[[1]]) <- c("name","description","type")
	names(infos[[2]]) <- c("has_inverse","has_jacobian")
	names(infos[[3]]) <- c("n.pars","n.vars")
	ans$infos <- infos
	ans$buffer <- buffer
	ans$f <- function(par, var)
		.Call("ridmc_model_f", model, as.double(par), as.double(var), PACKAGE='RiDMC')
	ans$g <- function(par, var)
		.Call("ridmc_model_g", model, as.double(par), as.double(var), PACKAGE='RiDMC')
	ans$Jf <- function(par, var)
		.Call("ridmc_model_Jf", model, as.double(par), as.double(var), PACKAGE='RiDMC')
	ans$NumJf <- function(par, var)
		.Call("ridmc_model_NumJf", model, as.double(par), as.double(var), PACKAGE='RiDMC')
	ans$set.seed <- function(seed)
		invisible(.Call("ridmc_model_setGslRngSeed", model, as.integer(seed), PACKAGE='RiDMC'))
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
