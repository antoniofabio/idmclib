/* example.i */
%module idmc

%include "typemaps.i"
%include "arrays_java.i"
%include "carrays.i"
%include "various.i"

%array_functions(double, doubleArray);
%array_functions(char *, stringArray);
%array_functions(int, intArray);
%{
/* Put header files here or function declarations like below */
#include <stdio.h>
#include <gsl/gsl_odeiv.h>
#include <idmclib/model.h>
#include <idmclib/traj.h>
#include <idmclib/cycles.h>
#include <idmclib/lexp.h>
#include <idmclib/raster.h>
#include <idmclib/basin.h>
#include <idmclib/attractor.h>
#include <idmclib/version.h>

typedef idmc_model Model;
typedef idmc_raster Raster;
typedef idmc_basin Basin;
typedef idmc_traj_trajectory Trajectory;
typedef idmc_traj_ctrajectory CTrajectory;
%}

%immutable;
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
%mutable;

%include "idmc_model.i"
%include "idmc_traj.i"
%include "idmc_cycles.i"
%include "idmc_lexp.i"
%include "idmc_raster.i"
%include "idmc_basin.i"
%include "idmc_attractor.i"
%include "idmc_version.i"
