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

	/*Internal data: */
	int dataLength; /*total number of cells*/
	int currId; /*current cell pointer*/

%extend{
	BasinMulti(Model *m, double *parameters,
			double xmin, double xmax, int xres,
			double ymin, double ymax, int yres,
			double eps, int attractorLimit, int attractorIterations, int ntries,
			int xvar, int yvar, double *startValues) {
		BasinMulti *ans;
		int ians = idmc_basin_multi_alloc(
			m, parameters,
			xmin, xmax, xres,
			ymin, ymax, yres,
			eps, attractorLimit, attractorIterations, ntries,
			xvar, yvar, startValues,
			&ans);
		return ans;
	}

	~BasinMulti() {
		idmc_basin_multi_free(self);
	}

	int find_next_attractor() {
		return idmc_basin_multi_find_next_attractor(self);
	}

	int step() {
		return idmc_basin_multi_step(self);
	}

	int finished() {
		return idmc_basin_multi_finished(self);
	}
}
} BasinMulti;
