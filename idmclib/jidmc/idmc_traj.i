
typedef struct {
%immutable;
	Model *model;
	double *par;
	double *var;
%mutable;
	
	%extend {
		Trajectory(Model *model, double parValues[], double varValues[]) {
			Trajectory *ans;
			idmc_traj_trajectory_alloc(model, parValues, varValues, &ans);
			return ans;
		}
		~Trajectory() {
			idmc_traj_trajectory_free(self);
		}
		void dostep() {
			idmc_traj_trajectory_step(self);
		}
	}
} Trajectory;

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
	Model *model;
	double *error;
	double step_size;
	gsl_odeiv_step_type *step_function_code;
	double *par;
	double *var;
%mutable;
	
	%extend{
		CTrajectory(Model *model, double parValues[], double varValues[], 
						  double step_size, gsl_odeiv_step_type *step_function_code) {
			CTrajectory *ans;
			idmc_traj_ctrajectory_alloc(model, parValues, varValues, step_size, step_function_code, &ans);
			return ans;
		}
		~CTrajectory() {
			idmc_traj_ctrajectory_free(self);
		}
		void dostep() {
			idmc_traj_ctrajectory_step(self);
		}
	}
} CTrajectory;
