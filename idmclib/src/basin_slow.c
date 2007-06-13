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

SLOW BASINS ALGORITHM
*/
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>
#include "defines.h"
#include "gsl_rng_lualib.h"
#include "raster.h"
#include "model.h"
#include "basin_slow.h"

#define getAttractorIndex(color) ((color)-2)/2
#define getAttractorColor(index) (index)*2+2

int idmc_basin_slow_alloc(idmc_model *m, double *parameters,
	double xmin, double xmax, int xres,
	double ymin, double ymax, int yres,
	int attractorLimit, int attractorIterations, int ntries,
	idmc_basin_slow** out_basin)
{
	int i;
	idmc_basin_slow* ans;
	idmc_raster* raster;
	ans = (idmc_basin_slow*) malloc( sizeof(idmc_basin_slow) );
	if(ans==NULL)
		return IDMC_EMEM;
	ans->model = idmc_model_clone(m);
	if(ans->model==NULL) {
		idmc_basin_slow_free(ans);
		return IDMC_EMEM;
	}
	ans->parameters = (double*) malloc( m->par_len * sizeof(double));
	if(ans->parameters==NULL) {
		idmc_basin_slow_free(ans);
		return IDMC_EMEM;
	}
	memcpy(ans->parameters, parameters, m->par_len * sizeof(double));
	i = idmc_raster_alloc(xmin, xmax, xres, ymin, ymax, yres, &raster);
	if(i != IDMC_OK) {
		idmc_basin_slow_free(ans);
		return i;
	}
	idmc_raster_set(raster, 0);
	ans->raster = raster;

	ans->currentPoint = (double*) malloc(2*sizeof(double));
	if(ans->currentPoint==NULL) {
		idmc_basin_slow_free(ans);
		return IDMC_EMEM;
	}
	ans->startPoint = (double*) malloc(2*sizeof(double));
	if(ans->startPoint==NULL) {
		idmc_basin_slow_free(ans);
		return IDMC_EMEM;
	}
	ans->work = (double*) malloc(2*sizeof(double));
	if(ans->work==NULL) {
		idmc_basin_slow_free(ans);
		return IDMC_EMEM;
	}
	ans->attractorsSamplePoints = (int*) malloc(ntries*sizeof(int));
	if(ans->attractorsSamplePoints == NULL){
		idmc_basin_slow_free(ans);
		return IDMC_EMEM;
	}
	ans->attractorsCoincidence = (int*) malloc(ntries*sizeof(int));
	if(ans->attractorsCoincidence == NULL){
		idmc_basin_slow_free(ans);
		return IDMC_EMEM;
	}
	ans->nAttractors = 0;
	ans->dataLength = ans->raster->xres * ans->raster->yres;
	ans->attractorLimit = attractorLimit;
	ans->attractorIterations = attractorIterations;
	ans->ntries = ntries;

	ans->currId = 0;
        ans->attractorColor = 2;
        ans->basinColor = 3;
	ans->index = 0;

	*out_basin = ans;
	return IDMC_OK;
}

void idmc_basin_slow_free(idmc_basin_slow* p) {
	if(p->model!=NULL)
		idmc_model_free(MODEL(p));
	if(p->parameters!=NULL)
		free(p->parameters);
	if(p->raster!=NULL)
		idmc_raster_free(RASTER(p));
	if(p->currentPoint!=NULL)
		free(p->currentPoint);
	if(p->startPoint!=NULL)
		free(p->startPoint);
	if(p->work!=NULL)
		free(p->work);
	if(p->attractorsSamplePoints!=NULL)
		free(p->attractorsSamplePoints);
	if(p->attractorsCoincidence!=NULL)
		free(p->attractorsCoincidence);
	free(p);
}

static void fillBasinSlowTrack(idmc_basin_slow* p, double *startPoint, int iterations, int value);

#define STEP(ans) idmc_model_f(m, p->parameters, (ans), (ans))
/*
Init basin_slow object: find attractors
*/
int idmc_basin_slow_init(idmc_basin_slow* p) {
	idmc_model *m = MODEL(p);
	idmc_raster *r = RASTER(p);
	gsl_rng* rng = getGslRngState(m->L);
	int try, xres, yres;
	int x,y;
	double xy[2];
	int i, attractorColor, attractorIndex, gs, isInfinite, isNewAttractor;
	int *attractorsCoincidence = p->attractorsCoincidence;
	xres = r->xres;
	yres = r->yres;
	attractorIndex=0;
	/*for each try...*/
	for(try = p->ntries; try>0; try--) {
		/*some initialization code:*/
		attractorColor = getAttractorColor(attractorIndex);
		memset(attractorsCoincidence, 0, (p->ntries)*sizeof(int));
		isInfinite=0;
		isNewAttractor=1;
		/*set random starting point*/
		x = (int)(gsl_rng_uniform(rng) * (double)xres);
		y = (int)(gsl_rng_uniform(rng) * (double)yres);
		xy[0] = idmc_raster_XY2x(r, x, y);
		xy[1] = idmc_raster_XY2x(r, x, y);
		/*start map iterations*/
		for(i = p->attractorLimit + p->attractorIterations; i>0; i--) {
			STEP(xy);
			if(isPointInfinite(xy)) {
				isInfinite=1;
				break;
			}
			if (i> (p->attractorLimit) && isPointInsideBounds(p, xy)){
				gs = getValue(p, xy);
				if (!gs){
					if (gs!=INFINITY){
						attractorColor = gs;
						attractorsCoincidence[getAttractorIndex(attractorColor)]++;
					}
				}
			}
		}/*end map iterations*/
		if (!isInfinite){
			for (int ii=0;ii<attractorIndex;ii++){
				if (attractorsCoincidence[ii]>OVERLAP_FACTOR*(p->attractorIterations)){
					isNewAttractor=0;
					break;
				}
			}
		}
		else
			isNewAttractor=0;
		if (!isInfinite){
			if (isNewAttractor) {
				fillBasinSlowTrack(p,
					xy,
					p->attractorIterations,
					getAttractorColor(attractorIndex));
				p->attractorsSamplePoints[attractorIndex] = idmc_raster_xy2I(
					r, xy[0], xy[1]);
				attractorIndex++;
			}
		}
	}/*end for each try*/
	p->nAttractors = attractorIndex;
	return IDMC_OK;
}
#undef STEP

static void fillBasinSlowTrack(idmc_basin_slow* p, double *startPoint, int iterations, int value) {
	memcpy(p->work, startPoint, 2 * sizeof(double));
	setValue(p, p->work, value);
	for(int i=0; i<iterations; i++) {
		idmc_model_f(MODEL(p), p->parameters, p->work, p->work);
		if(!isPointInsideBounds(p, p->work))
			continue;
		setValue(p, p->work, value);
	}
}

int idmc_basin_slow_finished(idmc_basin_slow *p) {
	return basin_finished(p);
}
