#include <stdio.h>
#include <stdlib.h>
#include <idmclib/model.h>
#include <idmclib/traj.h>
#include <idmclib/cycles.h>
#include <gsl/gsl_odeiv.h>
#include "test_common.h"
#include "minunit.h"

int tests_run = 0;

static char* test_discrete() {
	FILE *f;
	char *buffer;
	int buflen, result;
	double *par;
	double *startVal;
	idmc_model *model;
	idmc_traj_trajectory *trajectory;
	f = fopen("test1.lua","rb");
	mu_assert("can't open model file",f);
	buflen = loadFile(f, &buffer);
	fclose(f);
	result = idmc_model_alloc(buffer, buflen, &model);
	free(buffer);
	mu_assert("error loading model", result==IDMC_OK);
	par = (double*) malloc( model->par_len * sizeof(double) );
	for(int j=0; j<model->par_len; j++)
		par[j] = 1.0f;
	startVal = (double*) malloc( model->var_len * sizeof(double) );
	for(int j=0; j<model->var_len; j++)
		startVal[j] = 0.9f;
	result = idmc_model_f(model, par, startVal, startVal);
	mu_assert("can't compute model map",result==IDMC_OK);
	result = idmc_traj_trajectory_alloc(model, par, startVal, &trajectory);
	free(par);
	free(startVal);
	idmc_model_free(model);
	mu_assert("can't allocate discrete trajectory",result==IDMC_OK);
	for(int i=0; i<10; i++) {
		result = idmc_traj_trajectory_step(trajectory);
		mu_assert("can't step discrete trajectory",result==IDMC_OK);
	}
	idmc_traj_trajectory_free(trajectory);
	return 0;
}

static char* test_continue() { /*uses lorenz model*/
	FILE *f;
	char *buffer;
	int buflen, result, i, j;
	double par[3];
	double startVal[3];
	idmc_model *model;
	idmc_traj_ctrajectory *trajectory;
	f = fopen("lorenz.lua", "rb");
	buflen = loadFile(f, &buffer);
	fclose(f);
	result = idmc_model_alloc(buffer, buflen, &model);
	free(buffer);
	mu_assert("can't load model",result==IDMC_OK);
	mu_assert("wrong number of model parameters" , ((model->par_len==3) && (model->var_len==3)) );
	par[0] = 10;
	par[1] = 28;
	par[2] = 4;
	startVal[0] = 15;
	startVal[1] = 15;
	startVal[2] = 10;
	result = idmc_traj_ctrajectory_alloc(model, par, startVal, 0.005, gsl_odeiv_step_rk2, &trajectory);
	idmc_model_free(model);
	mu_assert("can't alloc continue trajectory", result==IDMC_OK);
	for(i=0; i<20; i++) {
		result = idmc_traj_ctrajectory_step(trajectory);
		mu_assert("can't step continue trajectory", result==IDMC_OK);
	}
	idmc_traj_ctrajectory_free(trajectory);
	return 0;
}

static char * test_model_all() {
	mu_run_test(test_discrete);
	mu_run_test(test_continue);
	return 0;
}

int main(int argc, char **argv) {
	char *result = test_model_all();
	if (result != 0) {
		printf("%s\n", result);
	}
	else {
		printf("ALL TESTS PASSED\n");
	}
	printf("Tests run: %d\n", tests_run);
 
	return result != 0;
}
