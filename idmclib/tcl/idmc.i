/* example.i */
%module tclidmclib

%include "typemaps.i"
%include "carrays.i"

%array_functions(double, doubleArray);
%array_functions(char *, stringArray);
%array_functions(int, intArray);
%{
/* Put header files here or function declarations like below */
#include <stdio.h>
#include <string.h>
#include <gsl/gsl_odeiv.h>
#include <idmclib/model.h>
#include <idmclib/traj.h>
#include <idmclib/cycles.h>
#include <idmclib/lexp.h>
#include <idmclib/raster.h>
#include <idmclib/basin.h>
#include <idmclib/basin_slow.h>
#include <idmclib/basin_multi.h>
#include <idmclib/version.h>
#include <idmclib/attractor.h>

typedef idmc_model model;
typedef idmc_raster Raster;
typedef idmc_basin Basin;
typedef idmc_traj_trajectory Trajectory;
typedef idmc_traj_ctrajectory CTrajectory;
%}

/* eps value for numerical derivative computation */
#define IDMC_EPS_VALUE 2e-8
/* normal operation */
#define IDMC_OK 0
/* memory allocation */
#define IDMC_EMEM 1
/* syntax error from lua itself */
#define IDMC_ELUASYNTAX 2
/* lua runtime error */
#define IDMC_ERUN 3
/* malformed model */
#define IDMC_EMODEL 4
/* inconsistent state (disaster) */
#define IDMC_EERROR 5
/* algorithm failed */
#define IDMC_EMATH 6
/* interrupted by request */
#define IDMC_EINT 7

%include "idmc_model.i"
%include "idmc_traj.i"
%include "idmc_lexp.i"
%include "idmc_version.i"
%include "idmc_cycles.i"
%include "idmc_basin.i"
%include "idmc_basin_slow.i"
%include "idmc_basin_multi.i"
%include "idmc_attractor.i"

