
typedef struct {
%immutable;
	lua_State* L;
	int par_len;
	int var_len;
	
	int has_inverse;
	int has_jacobian;
	
	char* buffer; /*original model code buffer*/
	
	char* name;
	char* desc;
	char* type;
%mutable;
	
	%extend {
		model(char *buffer, int buffer_len) {
			model *ans;
			idmc_model_alloc(buffer, buffer_len, &ans);
			return ans;
		}
		~model() {
			idmc_model_free(self);
		}
		model* clone() {
			return idmc_model_clone(self);
		}
		PyObject *var() {
			return sC2PySeq(self->var, self->var_len);
		}
		PyObject *par() {
			return sC2PySeq(self->par, self->par_len);
		}
		PyObject *f(double *par, double *var) {
			PyObject *pyans;
			double *ans = malloc(self->var_len * sizeof(double));
			idmc_model_f(self, par, var, ans);
			pyans = dC2PySeq(ans, self->var_len);
			free(ans);
			return pyans;
		}
		PyObject *g(double *par, double *var) {
			PyObject *pyans;
			double *ans = malloc(self->var_len * sizeof(double));
			idmc_model_g(self, par, var, ans);
			pyans = dC2PySeq(ans, self->var_len);
			free(ans);
			return pyans;
		}
		PyObject *Jf(double *par, double *var) {
			PyObject *pyans;
			double *ans = malloc(self->var_len * self->var_len * sizeof(double));
			idmc_model_Jf(self, par, var, ans);
			pyans = dC2PySeqSeq(ans, self->var_len, self->var_len);
			free(ans);
			return pyans;
		}
		PyObject *Jg(double *par, double *var) {
			PyObject *pyans;
			double *ans = malloc(self->var_len * self->var_len * sizeof(double));
			idmc_model_Jg(self, par, var, ans);
			pyans = dC2PySeqSeq(ans, self->var_len, self->var_len);
			free(ans);
			return pyans;
		}		
		PyObject *NumJf(double *par, double *var) {
			PyObject *pyans;
			double *ans = malloc(self->var_len * self->var_len * sizeof(double));
			double *util = malloc(self->var_len * sizeof(double));
			double *util2 = malloc(self->var_len * sizeof(double));
			double *util3 = malloc(self->var_len * sizeof(double));
			idmc_model_NumJf(self, par, var, ans, util, util2, util3);
			pyans = dC2PySeqSeq(ans, self->var_len, self->var_len);
			free(ans);
			free(util);
			free(util2);
			free(util3);
			return pyans;
		}
	}
} model;
