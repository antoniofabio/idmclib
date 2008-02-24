
%inline %{
	PyObject *find(model* model, const double *par, double *startPoint, int power, 
		double epsilon, int max_iterations) {
		PyObject *pyans, *pyeigvals;
		double *ans = (double*) malloc(model->var_len * sizeof(double));
		double *eigvals = (double*) malloc(model->var_len * sizeof(double));
		idmc_cycles_find(model, par, startPoint, power, epsilon, max_iterations, ans, eigvals);
		/*TODO: check for return code, end eventually raise a Python exception*/
		pyans = dC2PySeq(ans, model->var_len);
		pyeigvals = dC2PySeq(eigvals, model->var_len);
		free(ans);
		free(eigvals);
		return Py_BuildValue("OO", pyans, pyeigvals);
	}
	
	PyObject *powF(model *model, int pow, double* par, double* var) {
		PyObject *pyans;
		double *ans = (double*) malloc( model->var_len * sizeof(double) );
		idmc_cycles_powf(model, pow, par, var, ans);
		pyans = dC2PySeq(ans, model->var_len);
		free(ans);
		return pyans;
	}
	
	PyObject *powNumJac(model *model, int pow, double* par, double* var) {
		PyObject *pyans;
		double *ans = (double*) malloc(model->var_len * model->var_len * sizeof(double));
		double *util = (double*) malloc(3 * model->var_len * sizeof(double));
		idmc_cycles_powNumJac(model, pow, par, var, ans, util);
		free(util);
		pyans = dC2PySeqSeq(ans, model->var_len, model->var_len);
		free(ans);
		return pyans;
	}
	
	PyObject *eigval(double *mat, int dim) {
		PyObject *pyans;
		double *ans = (double*) malloc(dim * sizeof(double));
		idmc_cycles_eigval(mat, dim, ans);
		/*TODO: check for return code, end eventually raise a Python exception*/
		pyans = dC2PySeq(ans, dim);
		free(ans);
		return pyans;
	}
%}
