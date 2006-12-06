/*
idmc C library
Adapted from iDMC, Copyright (C) 2004-2006 Marji Lines and Alfredo Medio, written by Daniele Pizzoni

Antonio, Fabio Di Narzo
Last modified: 05/11/2006
*/
#ifndef TRAJ_H
#define TRAJ_H

#include <string.h>
#include <gsl/gsl_odeiv.h>
#include "model.h"

#define ROWCOL(i, j, numcols) (i)*(numcols) + (j)

/*discrete trajectory*/
typedef struct {
	idmc_model *model;
	double *par;  /*parameters vector*/
	double *var; /*current value*/
	int step; /*current step number*/
} idmc_traj_trajectory;

int idmc_traj_trajectory_alloc(idmc_model *model, double *parValues, double *varValues, idmc_traj_trajectory **ans);
void idmc_traj_trajectory_free(idmc_traj_trajectory *traj);
int idmc_traj_trajectory_step(idmc_traj_trajectory *traj);

/*continuous trajectory*/
typedef struct {
	idmc_model *model;
	double *par;  /*parameters vector*/
	double *var; /*current value*/
	double *error;
	double step_size;
	gsl_odeiv_step_type *step_function_code;
	
	gsl_odeiv_step *step_function; /*used internally*/
	gsl_odeiv_system system; /*used internally*/
} idmc_traj_ctrajectory;

int idmc_traj_ctrajectory_alloc(idmc_model *model, double *parValues, double *varValues, 
						  double step_size, gsl_odeiv_step_type *step_function_code,
						  idmc_traj_ctrajectory **ans);
void idmc_traj_ctrajectory_free(idmc_traj_ctrajectory *trajectory);
int idmc_traj_ctrajectory_step(idmc_traj_ctrajectory *trajectory);

#endif
