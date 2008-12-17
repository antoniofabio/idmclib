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
#include <idmclib/defines.h>
#include <idmclib/raster.h>
#include "test_common.h"
#include "minunit.h"

int tests_run = 0;

static char * test_create() {
	idmc_raster* raster;
	int i = idmc_raster_alloc(0.0, 10.0, 10, 
		0.0, 5.0, 5, &raster);
	mu_assert("can't create raster object", i==IDMC_OK);
	idmc_raster_free(raster);
	return 0;
}

static char * test_setGet() {
	idmc_raster* raster;
	int i = idmc_raster_alloc(0.0, 10.0, 10, 
		0.0, 5.0, 5, &raster);
	int value;
	mu_assert("can't create raster object", i==IDMC_OK);
	idmc_raster_setxy(raster, 5.5, 2.5, 3);
	value = idmc_raster_getxy(raster, 5.1, 2.9);
	mu_assert("incorrect value retrieved", value==3);
	value = idmc_raster_getXY(raster, 5, 2);
	mu_assert("incorrect value retrieved", value==3);
	idmc_raster_setXY(raster, 5, 2, -3);
	value = idmc_raster_getXY(raster, 5, 2);
	mu_assert("incorrect value retrieved", value==-3);
	idmc_raster_free(raster);
	return 0;
}

static char * test_bounds() {
	idmc_raster* raster;
	int i = idmc_raster_alloc(0.0, 10.0, 10, 
		0.0, 5.0, 5, &raster);
	mu_assert("can't create raster object", i==IDMC_OK);

	mu_assert("incorrect bound detected", idmc_raster_isxyInsideBounds(raster, 0.1, 4.9));
	mu_assert("incorrect bound detected", idmc_raster_isxyInsideBounds(raster, 9.9, 0.1));

	mu_assert("incorrect bound detected", !idmc_raster_isxyInsideBounds(raster, 0.1, 5.1));
	mu_assert("incorrect bound detected", !idmc_raster_isxyInsideBounds(raster, 10.1, 0.1));
	mu_assert("incorrect bound detected", !idmc_raster_isxyInsideBounds(raster, 10.1, 5.1));

	mu_assert("incorrect bound detected", idmc_raster_isXYInsideBounds(raster, 0, 4));
	mu_assert("incorrect bound detected", idmc_raster_isXYInsideBounds(raster, 9, 0));

	mu_assert("incorrect bound detected", !idmc_raster_isXYInsideBounds(raster, 0, 5));
	mu_assert("incorrect bound detected", !idmc_raster_isXYInsideBounds(raster, 10, 0));
	mu_assert("incorrect bound detected", !idmc_raster_isXYInsideBounds(raster, 10, 5));
	idmc_raster_free(raster);
	return 0;
}

static char * test_conversion() {
	idmc_raster* raster;
	int i = idmc_raster_alloc(0.0, 10.0, 10, 
		0.0, 5.0, 5, &raster);
	int id;
	double x,y;
	mu_assert("can't create raster object", i==IDMC_OK);
	//printf("0-> (%f, %f)\n", idmc_raster_I2x(raster, 0), idmc_raster_I2y(raster, 0));
	mu_assert("invalid I2x conversion", idmc_raster_I2x(raster, 0) == 0.5 );
	mu_assert("invalid I2y conversion", idmc_raster_I2y(raster, 0) == 4.5 );
	//printf("1-> (%f, %f)\n", idmc_raster_I2x(raster, 1), idmc_raster_I2y(raster, 1));
	mu_assert("invalid I2x conversion", idmc_raster_I2x(raster, 1) == 1.5 );
	mu_assert("invalid I2y conversion", idmc_raster_I2y(raster, 1) == 4.5 );

	mu_assert("invalid I2x conversion", idmc_raster_I2x(raster, 11) == 1.5 );
	mu_assert("invalid I2y conversion", idmc_raster_I2y(raster, 11) == 3.5 );

	id=3;
	x = idmc_raster_I2x(raster, id);
	y = idmc_raster_I2y(raster, id);
	mu_assert("invalid (I2x,I2y)<->xy2I conversion", idmc_raster_xy2I(raster, x, y) == id );

	idmc_raster_free(raster);
	return 0;
}

static char * test_raster_all() {
	mu_run_test(test_create);
	mu_run_test(test_setGet);
	mu_run_test(test_bounds);
	mu_run_test(test_conversion);
	return 0;
}

int main(int argc, char **argv) {
	char *result = test_raster_all();
	if (result != 0) {
		printf("%s\n", result);
	}
	else {
		printf("ALL TESTS PASSED\n");
	}
	printf("Tests run: %d\n", tests_run); 
	return result != 0;
}
