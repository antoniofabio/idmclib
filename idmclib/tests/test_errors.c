#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <idmclib/model.h>
#include "test_common.h"
#include "minunit.h"

int tests_run = 0;
 
static char * test_runtime() {
	idmc_model *a;
	FILE *f;
	int buflen, result;
	char *buffer;
        double *par, *var;
	f = fopen("test_error.lua", "rb");
	mu_assert("can't open file 'test_error.lua'", f);
	buflen = loadFile(f, &buffer);
	fclose(f);
	result = idmc_model_alloc(buffer, buflen, &a);
	free(buffer);
	mu_assert("cannot load model", result==IDMC_OK);
	par = (double*) malloc( a->par_len * sizeof(double) );
	var = (double*) malloc( a->var_len * sizeof(double) );
	strcpy(a->errorMessage, "empty");
	result = idmc_model_f(a, par, var, var);
	mu_assert("expected runtime error", result==IDMC_ERUN);
	mu_assert("expected meaningful runtime error message", strcmp(a->errorMessage, "empty"));
	strcpy(a->errorMessage, "empty");
	result = idmc_model_g(a, par, var, var);
	mu_assert("expected runtime error", result==IDMC_ERUN);
	mu_assert("expected meaningful runtime error message", strcmp(a->errorMessage, "empty"));
	free(par);
	free(var);
	idmc_model_free(a);
	return 0;
}

static char * test_syntax() {
	idmc_model *a;
	FILE *f;
	int buflen, result;
	char *buffer;
        double *par, *var;
	f = fopen("test_synt_error.lua", "rb");
	mu_assert("can't open file 'test_synt_error.lua'", f);
	buflen = loadFile(f, &buffer);
	fclose(f);
	result = idmc_model_alloc(buffer, buflen, &a);
	mu_assert("expected syntax error", result==IDMC_ELUASYNTAX);
	mu_assert("expected a non-null idmc_model pointer", a!=NULL);
	mu_assert("expected a meaningful error message", !strcmp(a->errorMessage, "8: unexpected symbol near `,'"));
	free(buffer);
	idmc_model_free(a);
	return 0;
}

static char * test_model_all() {
	mu_run_test(test_runtime);
	mu_run_test(test_syntax);
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
