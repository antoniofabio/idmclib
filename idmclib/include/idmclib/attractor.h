/*
iDMC C library

Copyright (C) 2008 Marji Lines and Alfredo Medio.

Written by Antonio, Fabio Di Narzo <antonio.fabio@gmail.com>.

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or any
later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

ATTRACTORS HANDLING FUNCTIONS
*/
#ifndef __ATTRACTOR_H__
#define __ATTRACTOR_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <memory.h>
#include <stdlib.h>

struct attractor_pt {
	double *x;
	struct attractor_pt* next;
};
typedef struct attractor_pt attractor_point;

struct attr_lst {
	attractor_point *hd; /*head of points list*/
	int dim; /*points dimension*/
	struct attr_lst* next;
	struct attr_lst* previous;
};
typedef struct attr_lst attractor;

attractor_point *attractor_point_new(double* x, int n);
attractor_point* attractor_point_clone(attractor_point* head, int dim);
void attractor_point_free(attractor_point* p);
attractor_point* attractor_point_add(attractor_point* last, attractor_point* p);
attractor_point* attractor_point_last(attractor_point* head);

attractor* attractor_new(int dim);
void attractor_free(attractor* p);
int attractor_length(attractor* p);
/*returns true if point lies on the attractor*/
int attractor_check_point(attractor* p, double* x, double eps);
void attractor_hd_set(attractor* p, attractor_point* head);

void attractors_list_free(attractor* head);
attractor* attractors_list_add(attractor* last, attractor* i);
int attractors_list_length(attractor* head);
/*return the index of the first attractor in the list containing point 'x'*/
int attractors_list_check_point(attractor* head, double* x, double eps);
attractor* attractors_list_get(attractor* head, int id);
void attractors_list_drop(attractor* p);
/*merge 2 attractors into 1 attractor*/
void attractors_list_merge(attractor* head, int a, int b);

#ifdef __cplusplus
}
#endif

#endif
