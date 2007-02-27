/*
iDMC C library

Adapted from iDMC, Copyright (C) 2004-2006 Marji Lines and Alfredo Medio
Copyright (C) 2006,2007 Marji Lines and Alfredo Medio.

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
#ifndef MODEL_H
#define MODEL_H
#include <lua.h>

#include "defines.h"

extern char *idmc_err_message[];

/* identifiers used in model files */
#define IDMC_IDENT_NAME "name"
#define IDMC_IDENT_DESC "description"
#define IDMC_IDENT_TYPE "type"
#define IDMC_IDENT_PARAMETERS "parameters"
#define IDMC_IDENT_VARIABLES "variables"
#define IDMC_IDENT_DEFAULTS "defaults"
#define IDMC_IDENT_FUNCTION "f"
#define IDMC_IDENT_JACOBIAN "Jf"
#define IDMC_IDENT_FUNCTION_INVERSE "g"
#define IDMC_IDENT_INVERSE_JACOBIAN "Jg"

#define IDMC_MAXSTRLEN 1024


typedef struct {
	lua_State* L;
	int par_len;
	char** par; /*parameter names*/
	int var_len;
	char** var; /*variables names*/

	int has_inverse;
	int has_jacobian;
	
	char* buffer; /*original model code buffer*/
	int buflen;
	
	char* name; /*model name*/
	char* desc; /*model description*/
	char* type; /*model type*/
	
	int interrupt; /*generic external interrupt flag*/

	char* errorMessage; /*last error message buffer*/
} idmc_model;

int idmc_model_alloc(const char* buffer, const int buffer_len, idmc_model **s);
void idmc_model_free(idmc_model *s);
idmc_model* idmc_model_clone(idmc_model *s);
int idmc_model_f(idmc_model *model, const double par[], const double var[], double f[]);
int idmc_model_g(idmc_model *model, const double par[], const double var[], double f[]);
int idmc_model_Jf(idmc_model *model, const double par[], const double var[], double Jf[]);
int idmc_model_Jg(idmc_model *model, const double par[], const double var[], double Jf[]);
int idmc_model_NumJf(idmc_model *model, const double par[], const double var[], double Jf[], 
			   double util[], double util2[], double util3[]);
int idmc_model_setGslRngSeed(idmc_model *model, int seed);
#endif
