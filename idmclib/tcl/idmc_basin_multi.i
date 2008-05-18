#define OVERLAP_FACTOR 0.1

typedef struct {
	idmc_model* model; /*model object*/
	double *parameters; /*model parameters*/
	double *startValues; /*starting values ('xvar' and 'yvar' elemtents are ignored)*/
	int xvar, yvar; /*x and y axes variables*/
	idmc_raster* raster; /*raster data*/
	double eps; /*neighborhood treshold used for attractor identification*/
	int attractorLimit; /*no. iterations for transient*/
	int attractorIterations; /*no. iterations for describing an attractor*/
	int ntries; /*no. tries for finding attractors*/
	int nAttractors; /*how many attractors were found*/
	idmc_attractor* attr_head; /*pointer to the head of found attractors list*/
} idmc_basin_multi;

%inline{
idmc_basin_multi* basin_multi_alloc(idmc_model *m, double *parameters,
	double xmin, double xmax, int xres,
	double ymin, double ymax, int yres,
	double eps, int attractorLimit, int attractorIterations, int ntries,
	int xvar, int yvar, double *startValues) {
	idmc_basin_multi* ans;
	idmc_basin_multi_alloc(m, parameters, xmin, xmax, xres,
	ymin, ymax, yres, eps, attractorLimit, attractorIterations, ntries,
	xvar, yvar, startValues, &ans);
	return ans;
}
}

/*deallocates an idmc_basin_multi object*/
void idmc_basin_multi_free(idmc_basin_multi* p);
/*init basin_multi (find attractors)*/
int idmc_basin_multi_init(idmc_basin_multi* p);
/*do one algorithm step*/
int idmc_basin_multi_step(idmc_basin_multi* p);
/*check if algorithm finished*/
int idmc_basin_multi_finished(idmc_basin_multi* p);

int idmc_basin_multi_find_next_attractor(idmc_basin_multi *b);
