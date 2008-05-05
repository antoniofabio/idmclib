int idmc_cycles_find(idmc_model* model, double* parameters, double* start_point, int power, double epsilon,
	int max_iterations, double* result, double* eigvals);

int idmc_cycles_powf (idmc_model* model, int pow,   double* par, double* var, double* ans);
int idmc_cycles_powNumJac (idmc_model* model, int pow, double* par,   double* var, double* Jf, double* util);
int idmc_cycles_eigval (double* mat, int dim, double* ans);
