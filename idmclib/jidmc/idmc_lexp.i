int idmc_lexp(Model* model, const double par[], double startPoint[], double result[], int iterations);

int idmc_lexp_ode(Model* model, const double parameters[], double startPoint[], double result[], double time, double step);

int idmc_lexp_ode_step(Model* model, const double parameters[], double result[], double Q[], double y[], double t[], double step);
