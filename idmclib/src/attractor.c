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
#include "attractor.h"

attractor_point *attractor_point_new(double* x, int n) {
	attractor_point *ans = (attractor_point*) malloc(sizeof(attractor_point));
	ans->x = (double*) malloc(n * sizeof(double));
	memcpy(ans->x, x, n * sizeof(double));
	ans->next = NULL;
	return ans;
}

void attractor_point_free(attractor_point* p) {
	attractor_point *n;
	while(p) {
		n = p->next;
		free(p->x);
		free(p);
		p = n;
	}
}

attractor_point* attractor_point_add(attractor_point* last, attractor_point* p) {
	last->next = p;
	return p;
}

attractor_point* attractor_point_last(attractor_point* head) {
	while(head->next)
		head = head->next;
	return head;
}

attractor_point* attractor_point_clone(attractor_point* head, int dim) {
	attractor_point* ans = attractor_point_new(head->x, dim);
	attractor_point* p = ans;
	while(head->next) {
		head = head->next;
		p->next = attractor_point_new(head->x, dim);
		p = p->next;
	}
	return ans;
}

attractor* attractor_new(int dim) {
	attractor* ans = (attractor*) malloc(sizeof(attractor));
	ans->hd = NULL;
	ans->dim = dim;
	ans->next = NULL;
	ans->previous = NULL;
	return ans;
}

void attractor_free(attractor* p) {
	attractor_point_free(p->hd);
	free(p);
}

int attractor_length(attractor* p) {
	int i=0;
	attractor_point* hd = p->hd;
	while(hd) {
		i++;
		hd = hd->next;
	}
	return i;
}

static int check_points(double *a, double *b, int dim, double eps) {
	int i;
	double dst = 0.0;
	for(i=0; i<dim; i++)
		dst += (a[i] - b[i])*(a[i] - b[i]);
	return ( dst < eps );
}

/*returns true if point lies on the attractor*/
int attractor_check_point(attractor* p, double* x, double eps) {
	attractor_point *ap = p->hd;
	while(ap) {
		if(check_points(ap->x, x, p->dim, eps))
			return 1;
		ap = ap->next;
	}
	return 0;
}

void attractor_hd_set(attractor* p, attractor_point* head) {
	p->hd = head;
}
