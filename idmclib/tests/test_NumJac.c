#include <stdio.h>
#include <stdlib.h>
#include <idmclib/model.h>
#include "test_common.h"
#include "minunit.h"

int tests_run = 0;

static char * test_1() {
	idmc_model *a;
	FILE *f;
	int buflen, result;
	char *buffer;
	double *par, *var, *Jf, *util, *util2, *util3, *Jf1;
	f = fopen("henon.lua", "rb");
	mu_assert("can't open file 'henon.lua'", f);
	buflen = loadFile(f, &buffer);
	fclose(f);
	result = idmc_model_alloc(buffer, buflen, &a);
	free(buffer);
	mu_assert("cannot load model", result==IDMC_OK);
	par = (double*) malloc(a->par_len * sizeof(double));
	par[0] = par[1] = 2.0;
	var = (double*) malloc(a->var_len * sizeof(double));
	var[0] = var[1] = 1.0;
	Jf = (double*) malloc(a->var_len * a->var_len * sizeof(double));
	Jf1 = (double*) malloc(a->var_len * a->var_len * sizeof(double));
	util = (double*) malloc(a->var_len * sizeof(double));;
	util2 = (double*) malloc(a->var_len * sizeof(double));;
	util3 = (double*) malloc(a->var_len * sizeof(double));;
	result = idmc_model_NumJf(a, par, var, Jf, util, util2, util3);
	result = idmc_model_Jf(a, par, var, Jf1);
	result = 1;
	for(int i=0; i<4; i++)
		result = result & (abs(Jf[i] - Jf1[i]) < 1e-6);
	mu_assert("wrong numerical jacobian evaluation", result);
	free(par);
	free(var);
	free(Jf);
	free(Jf1);
	free(util);
	free(util2);
	free(util3);
	idmc_model_free(a);
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
