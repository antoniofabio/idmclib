typedef struct {
%immutable;
	idmc_model* model; /*model object*/
	double *parameters; /*model parameters*/
	raster* raster; /*raster data*/
	int attractorLimit; /*no. iterations for transient*/
	int attractorIterations; /*no. iterations for describing an attractor*/
	/*Internal data: */
	int dataLength; /*total number of cells*/
	int currId; /*current cell pointer*/
	int index; /*iteration index*/
%mutable;
%extend {
	basin(model *m, double *parameters,
		double xmin, double xmax, int xres,
		double ymin, double ymax, int yres, 
		int attractorLimit, int attractorIterations) {
		basin* ans;
		int ians = idmc_basin_alloc(m, parameters, xmin, xmax, xres, ymin, ymax, yres,
			attractorLimit, attractorIterations, &ans);
		return ans;
	}
	~basin() {
		idmc_basin_free(self);
	}
	int step() {
		return idmc_basin_step(self);
	}
	int finished() {
		return idmc_basin_finished(self);
	}
}
} basin;
