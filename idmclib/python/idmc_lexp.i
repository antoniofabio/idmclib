
%inline %{
PyObject* idmc_lexp_new(model* model, const double *par, double *startPoint, int iterations) {
	PyObject *pyans;
	double *ans = (double*) malloc(model->var_len * sizeof(double));
	idmc_lexp(model, par, startPoint, ans, iterations);
	pyans = dC2PySeq(ans, model->var_len);
	free(ans);
	return pyans;
}

PyObject* lexp_ode(model* model, const double *par, double *startPoint,
					 double time, double step) {
	PyObject *pyans;
	double *ans = (double*) malloc(model->var_len * sizeof(double));
	idmc_lexp_ode(model, par, startPoint, ans, time, step);
	pyans = dC2PySeq(ans, model->var_len);
	free(ans);
	return pyans;
}

%}
