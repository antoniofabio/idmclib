/*
ridmc: iDMC->R interface

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
#include <R.h>
#include <Rinternals.h>
#include <idmclib/model.h>
#include <idmclib/lexp.h>

#include "ridmc.h"

SEXP lexp(SEXP m, SEXP par, SEXP startPoint, SEXP iterations) {
	idmc_model *pm = R_ExternalPtrAddr(m);
	SEXP ans;
	PROTECT(ans = allocVector(REALSXP, pm->var_len));
	int ians = idmc_lexp(pm,
		REAL(par),
		REAL(startPoint),
		REAL(ans),
		INTEGER(iterations)[0]);
	UNPROTECT(1);
	if(ians!=IDMC_OK)
		RIDMC_ERROR(ians);
	return ans;
}

SEXP lexp_ode(SEXP m, SEXP par, SEXP startPoint, SEXP time, SEXP step) {
	idmc_model *pm = R_ExternalPtrAddr(m);
	SEXP ans;
	PROTECT(ans = allocVector(REALSXP, pm->var_len));
	int ians = idmc_lexp_ode(pm,
		REAL(par),
		REAL(startPoint),
		REAL(ans),
		REAL(time)[0], REAL(step)[0]);
	UNPROTECT(1);
	if(ians!=IDMC_OK)
		RIDMC_ERROR(ians);
	return ans;
}


/*int idmc_lexp_ode_step(idmc_model* model, const double *parameters, double* result,
						  double* Q, double* y, double* t, double step);
*/