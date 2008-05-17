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

void attractors_list_free(attractor* head) {
	attractor *n;
	while(head) {
		n = head->next;
		attractor_free(head);
		head = n;
	}
}

attractor* attractors_list_add(attractor* last, attractor* i) {
	i->previous = last;
	last->next = i;
	return i;
}

int attractors_list_length(attractor* head) {
	int i=0;
	while(head) {
		i++;
		head = head->next;
	}
	return i;
}

/*return the index of the first attractor in the list containing point 'x'*/
int attractors_list_check_point(attractor* head, double* x, double eps) {
	int i=0;
	while(head) {
		if( attractor_check_point(head, x, eps) )
			return i;
		head = head->next;
		i++;
	}
	return i;
}

attractor* attractors_list_get(attractor* head, int id) {
	int i;
	attractor* ans = head;
	for(i=0; i<id; i++)
		ans = ans->next;
	return ans;
}

void attractors_list_drop(attractor* p) {
	if(p->previous)
		(p->previous)->next = p->next;
	if(p->next)
		(p->next)->previous = p->previous;
	attractor_free(p);
}

/*merge 2 attractors into 1 attractor*/
void attractors_list_merge(attractor* head, int a, int b) {
	int tmp;
	if(a>b) {
		tmp=a;
		a=b;
		b=tmp;
	}
	attractor* a1 = attractors_list_get(head, a);
	attractor* a2 = attractors_list_get(head, b);
	attractor_point* tail1 = attractor_point_last( a1->hd );
	attractor_point* head2 = a2->hd;
	tail1->next = attractor_point_clone(head2, head->dim);
	attractors_list_drop(a2);
}
