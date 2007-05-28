exModelFile <- function(modelName) {
	p <- system.file('models', package='RiDMC')
	if(missing(modelName)) {
		fls <- list.files(path=p, pattern = "\\.lua$", all.files = TRUE)
		fls <- gsub("(.)\\.lua$","\\1",fls)
		cat('The following example models are available:\n')
		print(fls)
		return(invisible(NULL))
	}
	fname <- paste(modelName, 'lua', sep='.')
	fname <- file.path(p,fname)
	return(fname)
}
