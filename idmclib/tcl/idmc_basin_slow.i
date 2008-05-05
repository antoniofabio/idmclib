#define OVERLAP_FACTOR 0.1

typedef struct {
	idmc_model* model; /*model object*/
	double *parameters; /*model parameters*/
	idmc_raster* raster; /*raster data*/
	int attractorLimit; /*no. iterations for transient*/
	int attractorIterations; /*no. iterations for describing an attractor*/
	int ntries; /*no. tries for finding attractors*/
	int nAttractors; /*how many attractors were found*/
} idmc_basin_slow;

%inline{
idmc_basin_slow* basin_slow_alloc(idmc_model *m, double *parameters,
	double xmin, double xmax, int xres,
	double ymin, double ymax, int yres,
	int attractorLimit, int attractorIterations, int ntries) {
	idmc_basin_slow* ans;
	idmc_basin_slow_alloc(m, parameters, xmin, xmax, xres,
		ymin, ymax, yres, attractorLimit, attractorIterations, ntries,
		&ans);
	return ans;
}
}

/*deallocates an idmc_basin object*/
void idmc_basin_slow_free(idmc_basin_slow* p);
/*init basin (find attractors)*/
int idmc_basin_slow_init(idmc_basin_slow* p);
/*do one algorithm step*/
int idmc_basin_slow_step(idmc_basin_slow* p);
/*check if algorithm finished*/
int idmc_basin_slow_finished(idmc_basin_slow* p);
