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
		1000, 100, 30, &basin);
	idmc_model_free(model);
	mu_assert("can't create basin object", i==IDMC_OK);

	i = idmc_basin_slow_init(basin);
	mu_assert("can't init basin object", i==IDMC_OK);
	//idmc_basin_slow_free(basin);
	return 0;
}

static char * test_basin_slow_all() {
	mu_run_test(test_create);
	mu_run_test(test_init);
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
