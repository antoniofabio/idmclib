typedef struct {
	idmc_model* model; /*model object*/
	double *parameters; /*model parameters*/
	idmc_raster* raster; /*raster data*/
	int attractorLimit; /*no. iterations for transient*/
	int attractorIterations; /*no. iterations for describing an attractor*/
} idmc_basin;

%inline{
idmc_basin* basin_alloc(idmc_model *m, double *parameters,
		double xmin, double xmax, int xres,
		double ymin, double ymax, int yres, 
		int attractorLimit, int attractorIterations) {
	idmc_basin* ans;
	idmc_basin_alloc(m, parameters, xmin, xmax, xres,
		ymin, ymax, yres, attractorLimit, attractorIterations,
		&ans);
	return ans;
}
}

/*deallocates an idmc_basin object*/
void idmc_basin_free(idmc_basin* p);
/*do one algorithm step*/
int idmc_basin_step(idmc_basin* p);
/*check if algorithm finished*/
int idmc_basin_finished(idmc_basin* p);
