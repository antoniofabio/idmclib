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
#include <stdlib.h>
#include <idmclib/defines.h>
#include <idmclib/basin.h>
#include "test_common.h"
#include "minunit.h"

int tests_run = 0;

static char * test_create() {
	idmc_basin* basin;
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

	i= idmc_basin_alloc(model, &parms,
		-1.5, 1.5, 300,
		-1.5, 1.5, 300,
		1000, 100, &basin);
	idmc_model_free(model);
	mu_assert("can't create basin object", i==IDMC_OK);
	idmc_basin_free(basin);
	return 0;
}

static char * test_oneStep() {
	idmc_basin* basin;
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

	i = idmc_basin_alloc(model, &parms,
		-1.5, 1.5, 300,
		-1.5, 1.5, 300,
		1000, 100, &basin);
	idmc_model_free(model);
	mu_assert("can't create basin object", i==IDMC_OK);

	i = idmc_basin_step(basin);
	mu_assert("can't step basin object", i==IDMC_OK);
	idmc_basin_free(basin);
	return 0;
}

static char * test_fullSteps() {
	idmc_basin* basin;
	idmc_model* model;
	int i,j;
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

	i = idmc_basin_alloc(model, &parms,
		-1.5, 1.5, 100,
		-1.5, 1.5, 100,
		100, 20, &basin);
	idmc_model_free(model);
	mu_assert("can't create basin object", i==IDMC_OK);
	j=0;
	while(!idmc_basin_finished(basin)) {
		i=idmc_basin_step(basin);
		mu_assert("can't step basin object", i==IDMC_OK);
		j++;
		mu_assert("more iterations than cells!", j<=(100*100));
	}
	printf("%d iterations done\n", j);
	
	idmc_basin_free(basin);
	return 0;
}

static char * test_basin_all() {
	mu_run_test(test_create);
	mu_run_test(test_oneStep);
	mu_run_test(test_fullSteps);
	return 0;
}

int main(int argc, char **argv) {
	char *result = test_basin_all();
	if (result != 0) {
		printf("%s\n", result);
	}
	else {
		printf("ALL TESTS PASSED\n");
	}
	printf("Tests run: %d\n", tests_run); 
	return result != 0;
}
