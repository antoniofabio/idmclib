typedef struct {
%immutable;
	void *g_data; /*currently unused*/
	int *data; /*main data block*/
	double xmin; double xrange; double xeps; int xres;/*x axis settings*/
	double ymin; double yrange; double yeps; int yres; /*y axis settings*/
%mutable;
%extend {
	raster(double xmin, double xmax, int xres,
		double ymin, double ymax, int yres) {
		raster *ans;
		int ians = idmc_raster_alloc(xmin, xmax, xres,
			ymin, ymax, yres, &ans);
		return ans;
	}
	~raster() {
		idmc_raster_free(self);
	}
}
} raster;
