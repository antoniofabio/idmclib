/*
idmc C library
Adapted from iDMC, Copyright (C) 2004-2006 Marji Lines and Alfredo Medio, written by Daniele Pizzoni

Antonio, Fabio Di Narzo
Last modified: 05/11/2006
*/
#ifndef CYCLES_H
#define CYCLES_H
#include "model.h"

int idmc_cycles_find(idmc_model* model, double *parameters, double *start_point, 
	int power, double epsilon, int max_iterations, double* result, double *eigvals);
int idmc_cycles_powf(idmc_model *model, int pow, double* par, double* var, double* ans);
int idmc_cycles_powNumJac(idmc_model *model, int pow, double* par, double* var, double* Jf, double *util);
int idmc_cycles_eigval(double *mat, int dim, double *ans);
#endif
