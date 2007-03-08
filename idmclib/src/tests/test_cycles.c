#include <stdio.h>
#include <stdlib.h>
#include <idmclib/model.h>
#include <idmclib/traj.h>
#include <idmclib/cycles.h>
#include <gsl/gsl_odeiv.h>
#include "test_common.h"
#include "minunit.h"

int tests_run = 0;

static char * test_1() {
	FILE *f;
	char *buffer;
	double par[1];
	double var[1];
	double ans[1];
	double eigmod[1];
	int buflen, result;
	idmc_model *model;
	f = fopen("logistic.lua", "rb");
	mu_assert("can't open file",f);
	buflen = loadFile(f, &buffer);
	fclose(f);
	result = idmc_model_alloc(buffer, buflen, &model);
	mu_assert("can't load model",result==IDMC_OK);
	par[0] = 3.9;
	var[0] = 0.3; 
	mu_assert("wrong number of model parameters/variables",	((model->par_len==1) && (model->var_len==1)) );
	result = idmc_cycles_find(model, par, var, 3, 1e-9, 1000, ans, eigmod);
	sprintf(buffer, "error in computing cycles: %s", idmc_err_message[result]);
	mu_assert(buffer, result==IDMC_OK);
	mu_assert("Incorrect cycle found", (ans[0] - 0.180986) < 1e-5);
	mu_assert("Incorrect cycle modulus reported", (eigmod[0] - 5.334716) < 1e-5);
	free(buffer);
	idmc_model_free(model);
	return 0;
}

static char * test_model_all() {
	mu_run_test(test_1);
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
