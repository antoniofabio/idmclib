
typedef struct {
%immutable;
	void *g_data; /*currently unused*/
	int *data; /*main data block*/
	double xmin; double xrange; double xeps; int xres;/*x axis settings*/
	double ymin; double yrange; double yeps; int yres; /*y axis settings*/
%mutable;
%extend{
	Raster(double xmin, double xmax, int xres,
		double ymin, double ymax, int yres) {
		Raster *ans;
		int ians = idmc_raster_alloc(xmin, xmax, xres,
			ymin, ymax, yres, &ans);
		return ans;
	}
	~Raster() {
		idmc_raster_free(self);
	}

	void setxy(double x, double y, int value) {
		idmc_raster_setxy(self, x, y, value);
	}
	int getxy(double x, double y) {
		return idmc_raster_getxy(self, x, y);
	}
	void setXY(int X, int Y, int value) {
		idmc_raster_setXY(self, X, Y, value);
	}
	int getXY(int X, int Y) {
		return idmc_raster_getXY(self, X, Y);
	}
	void set(int value) {
		idmc_raster_set(self, value);
	}
	int isxyInsideBounds(double x, double y) {
		return idmc_raster_isxyInsideBounds(self, x, y);
	}
	int isXYInsideBounds(int X, int Y) {
		return idmc_raster_isXYInsideBounds(self, X, Y);
	}
}
} Raster;
