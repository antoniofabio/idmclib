typedef struct {
%immutable;
	model *model;
%mutable;
	
	%extend {
		trajectory(model *model, double *parValues, double *varValues) {
			trajectory *ans;
			idmc_traj_trajectory_alloc(model, parValues, varValues, &ans);
			return ans;
		}
		~trajectory() {
			idmc_traj_trajectory_free(self);
		}
		PyObject* dostep() {
			idmc_traj_trajectory_step(self);
			Py_INCREF(Py_None);
			return Py_None;
		}
		PyObject *var() {
			return dC2PySeq(self->var, self->model->var_len);
		}
		PyObject *par() {
			return dC2PySeq(self->par, self->model->par_len);
		}
	}
} trajectory;

%immutable;
const gsl_odeiv_step_type *gsl_odeiv_step_rk2;
const gsl_odeiv_step_type *gsl_odeiv_step_rk4;
const gsl_odeiv_step_type *gsl_odeiv_step_rkf45;
const gsl_odeiv_step_type *gsl_odeiv_step_rkck;
const gsl_odeiv_step_type *gsl_odeiv_step_rk8pd;
const gsl_odeiv_step_type *gsl_odeiv_step_rk2imp;
const gsl_odeiv_step_type *gsl_odeiv_step_rk4imp;
const gsl_odeiv_step_type *gsl_odeiv_step_bsimp;
const gsl_odeiv_step_type *gsl_odeiv_step_gear1;
const gsl_odeiv_step_type *gsl_odeiv_step_gear2;
%mutable;

typedef struct {
%immutable;	
	model *model;
	double *error;
	double step_size;
	gsl_odeiv_step_type *step_function_code;
%mutable;
	
	%extend{
		ctrajectory(model *model, double *parValues, double *varValues, 
						  double step_size, gsl_odeiv_step_type *step_function_code) {
			idmc_traj_ctrajectory *ans;
			idmc_traj_ctrajectory_alloc(model, parValues, varValues, step_size, step_function_code, &ans);
			return ans;
		}
		~ctrajectory() {
			idmc_traj_ctrajectory_free(self);
		}
		void dostep() {
			idmc_traj_ctrajectory_step(self);
		}
		PyObject *var() {
			return dC2PySeq(self->var, self->model->var_len);
		}
		PyObject *par() {
			return dC2PySeq(self->par, self->model->par_len);
		}
	}
} ctrajectory;
