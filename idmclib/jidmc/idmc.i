/* example.i */
%module idmc

%include "typemaps.i"
%include "arrays_java.i"
%include "carrays.i"
%include "various.i"

%array_functions(double, doubleArray);
%{
/* Put header files here or function declarations like below */
#include <stdio.h>
#include <gsl/gsl_odeiv.h>
#include <idmclib/model.h>
#include <idmclib/traj.h>
#include <idmclib/cycles.h>
#include <idmclib/lexp.h>

typedef idmc_model Model;
typedef idmc_traj_trajectory Trajectory;
typedef idmc_traj_ctrajectory CTrajectory;
%}

%array_functions(char *, stringArray);
%include "idmc_model.i"
%include "idmc_traj.i"
%include "idmc_cycles.i"
%include "idmc_lexp.i"
