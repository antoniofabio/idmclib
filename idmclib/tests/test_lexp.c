#include <stdio.h>
#include <stdlib.h>
#include <idmclib/model.h>
#include <idmclib/traj.h>
#include <idmclib/lexp.h>
#include <gsl/gsl_odeiv.h>
#include "test_common.h"
#include "minunit.h"

int tests_run = 0;

static char * test_continuous() {
	FILE *f;
	char *buffer;
	double par[3];
	double var[3];
	double ans[3];
	int buflen, result;
	idmc_model *model;
	f = fopen("lorenz.lua", "rb");
	mu_assert("can't open file",f);
	buflen = loadFile(f, &buffer);
	fclose(f);
	result = idmc_model_alloc(buffer, buflen, &model);
	mu_assert("can't load model",result==IDMC_OK);
	mu_assert("wrong number of model parameters/variables",	((model->par_len==3) && (model->var_len==3)) );
	par[0] = 10.0;
	par[1] = 28.0;
	par[2] = 2.667;
	var[0] = 1.0;
	var[1] = 2.0;
	var[2] = 1.0;
	result = idmc_lexp_ode(model, par, var, ans, 1000.0, 0.05);
	sprintf(buffer, "error in computing Lyapunov exponents: %s", idmc_err_message[result]);
	mu_assert(buffer, result==IDMC_OK);
	mu_assert("Incorrect lyapunov exponent", abs(ans[0] - 2.498923) < 1e-5);
	mu_assert("Incorrect lyapunov exponent", abs(ans[1] + 1.540331) < 1e-5);
	mu_assert("Incorrect lyapunov exponent", abs(ans[2] + 14.625592) < 1e-5);
	free(buffer);
	idmc_model_free(model);
	return 0;
}

static char * test_discrete() {
	FILE *f;
	char *buffer;
	double par[1];
	double var[1];
	double ans[1];
	int buflen, result;
	idmc_model *model;
	f = fopen("logistic.lua", "rb");
	mu_assert("can't open file",f);
	buflen = loadFile(f, &buffer);
	fclose(f);
	result = idmc_model_alloc(buffer, buflen, &model);
	mu_assert("can't load model",result==IDMC_OK);
	mu_assert("wrong number of model parameters/variables",	((model->par_len==1) && (model->var_len==1)) );
	par[0] = 3.9;
	var[0] = 0.2;
	result = idmc_lexp(model, par, var, ans, 500);
	sprintf(buffer, "error in computing Lyapunov exponents: %s", idmc_err_message[result]);
	mu_assert(buffer, result==IDMC_OK);
	mu_assert("Incorrect lyapunov exponent", abs(ans[0]-0.507382)<1e-5);
	free(buffer);
	idmc_model_free(model);
	return 0;
}

static char * test_model_all() {
	mu_run_test(test_continuous);
	mu_run_test(test_discrete);
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
