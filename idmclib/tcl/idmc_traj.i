/*discrete trajectory*/
typedef struct {
	idmc_model *model;
	double *par;  /*parameters vector*/
	double *var; /*current value*/
	int step; /*current step number*/
} idmc_traj_trajectory;

%inline{
idmc_traj_trajectory* traj_alloc(idmc_model *model, double *parValues, double *varValues) {
	idmc_traj_trajectory* ans;
	idmc_traj_trajectory_alloc(model, parValues, varValues, &ans);
	return ans;
}
}

int idmc_traj_trajectory_alloc(idmc_model *model, double *parValues, double *varValues, idmc_traj_trajectory **ans);
void idmc_traj_trajectory_free(idmc_traj_trajectory *traj);
int idmc_traj_trajectory_step(idmc_traj_trajectory *traj);

/*continuous trajectory*/
typedef struct {
	idmc_model *model;
	double *par;  /*parameters vector*/
	double *var; /*current value*/
	double *error;
	double step_size;
	gsl_odeiv_step_type *step_function_code;
	
	gsl_odeiv_step *step_function; /*used internally*/
	gsl_odeiv_system system; /*used internally*/
} idmc_traj_ctrajectory;

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

%inline{
idmc_traj_ctrajectory* ctraj_alloc(idmc_model *model, double *parValues, double *varValues,
	double step_size, gsl_odeiv_step_type *step_function_code) {
	idmc_traj_ctrajectory* ans;
	
	idmc_traj_ctrajectory_alloc(model, parValues, varValues, step_size, step_function_code, &ans);
	return ans;
}
}

void idmc_traj_ctrajectory_free(idmc_traj_ctrajectory *trajectory);
int idmc_traj_ctrajectory_step(idmc_traj_ctrajectory *trajectory);
