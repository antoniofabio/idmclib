int idmc_lexp(Model* model, double par[], double startPoint[], double result[], int iterations);

int idmc_lexp_ode(Model* model, double parameters[], double startPoint[], double result[], double time, double step);

int idmc_lexp_ode_step(Model* model, double parameters[], double result[], double Q[], double y[], double t[], double step);
