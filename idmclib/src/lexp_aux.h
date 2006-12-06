/*
idmc C library
Adapted from iDMC, Copyright (C) 2004-2006 Marji Lines and Alfredo Medio, written by Daniele Pizzoni

Antonio, Fabio Di Narzo
Last modified: 22/11/2006
*/
#include "model.h"

#ifndef __idmc_lexp_aux_include__
#define __idmc_lexp_aux_include__

inline int compute_lexp(idmc_model* model, double* par, int dim, double step, 
double* y, double t1, double* l, double* alloc_memory);

inline int time_plot_step(idmc_model* model, int dim, double step, double* t,
double* pars, double* y, double* Q, double* l, double* alloc_memory);

#endif
