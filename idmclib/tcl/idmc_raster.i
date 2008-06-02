typedef struct {
	void *g_data; /*currently unused*/
	int *data; /*main data block*/
	double xmin; double xrange; double xeps; int xres;/*x axis settings*/
	double ymin; double yrange; double yeps; int yres; /*y axis settings*/
} idmc_raster;

void idmc_raster_setxy(idmc_raster* p, double x, double y, int value);
int idmc_raster_getxy(idmc_raster* p, double x, double y); 
void idmc_raster_setXY(idmc_raster* p, int X, int Y, int value);
int idmc_raster_getXY(idmc_raster* p, int X, int Y);
void idmc_raster_set(idmc_raster* p, int value);

int idmc_raster_isxyInsideBounds(idmc_raster *p, double x, double y);
int idmc_raster_isXYInsideBounds(idmc_raster *p, int x, int y);
