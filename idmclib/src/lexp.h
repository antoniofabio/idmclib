/*
idmc C library
Adapted from iDMC, Copyright (C) 2004-2006 Marji Lines and Alfredo Medio, written by Daniele Pizzoni

Antonio, Fabio Di Narzo
Last modified: 22/11/2006
*/
#ifndef LEXP_H
#define LEXP_H
#include "model.h"

int idmc_lexp(idmc_model* model, const double *par, double *startPoint, double *result, int iterations);

int idmc_lexp_ode(idmc_model* model, const double *parameters, double *startPoint,
					 double *result, double time, double step);

int idmc_lexp_ode_step(idmc_model* model, const double *parameters, double* result,
						  double* Q, double* y, double* t, double step);

#endif
