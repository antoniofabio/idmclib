/*
iDMC C library

Copyright (C) 2007 Marji Lines and Alfredo Medio.

Written by Antonio, Fabio Di Narzo <antonio.fabio@gmail.com>.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or any
later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

Last modified: $Date$
*/
#include <stdio.h>
#include <stdlib.h>
#include <idmclib/defines.h>
#include <idmclib/basin_slow.h>
#include "test_common.h"
#include "minunit.h"

static int sumVector(int *vals, int nvals);
static int sumVector2(int *vals, int nvals);

int tests_run = 0;

static char * test_create() {
	idmc_basin_slow* basin;
	idmc_model* model;
	int i;
	FILE *f;
	int buflen, result;
	char *buffer;
	static double parms = 1.0;
	f = fopen("test2.lua", "rb");
	mu_assert("can't open file 'test2.lua'", f);
	buflen = loadFile(f, &buffer);
	fclose(f);
	i = idmc_model_alloc(buffer, buflen, &model);
	free(buffer);
	mu_assert("can't create model object", i==IDMC_OK);

	i = idmc_basin_slow_alloc(model, &parms,
		-1.5, 1.5, 300,
		-1.5, 1.5, 300,
		1000, 100, 20, &basin);
	idmc_model_free(model);
	mu_assert("can't create basin object", i==IDMC_OK);
	idmc_basin_slow_free(basin);
	return 0;
}

static char * test_init() {
	idmc_basin_slow* basin;
	idmc_model* model;
	int i;
	FILE *f;
	int buflen, result;
	char *buffer;
	static double parms[2] = {1.42, 0.3};
	f = fopen("henon.lua", "rb");
	mu_assert("can't open file 'henon.lua'", f);
	buflen = loadFile(f, &buffer);
	fclose(f);
	i = idmc_model_alloc(buffer, buflen, &model);
	free(buffer);
	mu_assert("can't create model object", i==IDMC_OK);
	i = idmc_basin_slow_alloc(model, parms,
		-2.0, 2.0, 300,
		-2.0, 2.0, 300,
		1000, 1000, 20, &basin);
	idmc_model_free(model);
	mu_assert("can't create basin object", i==IDMC_OK);
	idmc_model_setGslRngSeed(basin->model, 123);
	i = idmc_basin_slow_init(basin);
	mu_assert("can't init basin object", i==IDMC_OK);
	mu_assert("invalid number of attractors found", basin->nAttractors==3);
	idmc_basin_slow_free(basin);
	return 0;
}

/*Test the result of a full run on the cremona model*/
static char * test_stepAll() {
	idmc_basin_slow* basin;
	idmc_model* model;
	int i;
	FILE *f;
	int buflen, result;
	char *buffer;
	static double parms = 1.33;
	f = fopen("cremona.lua", "rb");
	mu_assert("can't open file 'cremona.lua'", f);
	buflen = loadFile(f, &buffer);
	fclose(f);
	i = idmc_model_alloc(buffer, buflen, &model);
	free(buffer);
	mu_assert("can't create model object", i==IDMC_OK);
	i = idmc_basin_slow_alloc(model, &parms,
		-1.2, 1.2, 20,
		-1.2, 1.2, 20,
		1000, 1000, 100, &basin);
	idmc_model_free(model);
	mu_assert("can't create basin object", i==IDMC_OK);
	idmc_model_setGslRngSeed(basin->model, 123);
	while(!idmc_basin_slow_finished(basin))
		idmc_basin_slow_step(basin);
	mu_assert("unexpected basin final result", 
		sumVector(basin->raster->data, 400) == 1465);
	mu_assert("unexpected basin final result", 
		sumVector2(basin->raster->data, 400) == 10373);
	idmc_basin_slow_free(basin);
	return 0;
}

static int sumVector(int *vals, int nvals) {
	int ans=0;
	while(nvals--) ans+=vals[nvals];
	return ans;
}
static int sumVector2(int *vals, int nvals) {
	int ans=0;
	while(nvals--) ans+=(vals[nvals]*vals[nvals]);
	return ans;
}

static char * test_basin_slow_all() {
	mu_run_test(test_create);
	mu_run_test(test_init);
	mu_run_test(test_stepAll);
	return 0;
}

int main(int argc, char **argv) {
	char *result = test_basin_slow_all();
	if (result != 0) {
		printf("%s\n", result);
	}
	else {
		printf("ALL TESTS PASSED\n");
	}
	printf("Tests run: %d\n", tests_run); 
	return result != 0;
}
