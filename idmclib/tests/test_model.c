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
	idmc_model *a;
	FILE *f;
	int buflen, result;
	char *buffer;
	f = fopen("test1.lua", "rb");
	mu_assert("can't open file 'test1.lua'", f);
	buflen = loadFile(f, &buffer);
	fclose(f);
	result = idmc_model_alloc(buffer, buflen, &a);
	free(buffer);
	mu_assert("cannot load model", result==IDMC_OK);
	idmc_model_free(a);
	return 0;
}
 
static char * test_2() {
	idmc_model *a;
	FILE *f;
	int buflen, result;
	char *buffer;
	f = fopen("test2.lua", "rb");
	mu_assert("can't open file 'test2.lua'", f);
	buflen = loadFile(f, &buffer);
	fclose(f);
	result = idmc_model_alloc(buffer, buflen, &a);
	free(buffer);
	mu_assert("cannot load model", result==IDMC_OK);
	idmc_model_free(a);
	return 0;
}

static char * test_clone() {
	idmc_model *a, *a1;
	FILE *f;
	int buflen, result;
	char *buffer;
	f = fopen("test1.lua", "rb");
	mu_assert("can't open model file", f);
	buflen = loadFile(f, &buffer);
	fclose(f);
	result = idmc_model_alloc(buffer, buflen, &a);	
	free(buffer);
	mu_assert("can't load model", result==IDMC_OK);
	a1 = idmc_model_clone(a);
	mu_assert("can't clone model", a1);
	idmc_model_free(a);
	idmc_model_free(a1);
	return 0;
}

/*empty description field should not cause troubles*/
static char * test_emptyDesc() {
  idmc_model *a;
  FILE *f;
  int buflen, result;
  char *buffer;
  f = fopen("testEmptyDesc.lua", "rb");
  mu_assert("can't open model file", f);
  buflen = loadFile(f, &buffer);
  fclose(f);
  result = idmc_model_alloc(buffer, buflen, &a);
  free(buffer);
  mu_assert("can't load model", result==IDMC_OK);
  mu_assert("invalid 'description' field length", strlen(a->desc) == 0);
  idmc_model_free(a);
  return 0;
}

static char * test_model_all() {
  mu_run_test(test_1);
  mu_run_test(test_2);
  mu_run_test(test_clone);
  mu_run_test(test_emptyDesc);
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
