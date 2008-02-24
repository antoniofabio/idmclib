 %module idmc
 %include "typemaps.i"
 %{
#include <stdio.h>
#include <idmclib/model.h>
#include <idmclib/traj.h>
#include <idmclib/lexp.h>
#include <idmclib/cycles.h>
#include <idmclib/raster.h>
#include <idmclib/basin.h>

typedef idmc_model model;
typedef idmc_traj_trajectory trajectory;
typedef idmc_traj_ctrajectory ctrajectory;
typedef idmc_raster raster;
typedef idmc_basin basin;

/*Convert an array of strings of size 'int' to a python list*/
static PyObject *sC2PySeq(char **array, int length){
	PyObject *pylist, *item;
	int i;
	pylist = PyList_New(length);
	for (i=0; i<length; i++) {
		item = PyString_FromString(array[i]);
		PyList_SetItem(pylist, i, item);
	}
	return pylist;
}
	
/*Convert an array of doubles of size 'int' to a python list*/
static PyObject *dC2PySeq(double *array, int length){
	PyObject *pylist, *item;
	int i;
	pylist = PyList_New(length);
	for (i=0; i<length; i++) {
		item = PyFloat_FromDouble(array[i]);
		PyList_SetItem(pylist, i, item);
	}
	return pylist;
}

/*Convert an array of doubles of size 'a*b' to a python list of 'b' lists
(something like a matrix...)
*/
static PyObject *dC2PySeqSeq(double *array, int nr, int nc){
	PyObject *pylist, *pyrow, *item;
	int i, j, ci;
	pylist = PyList_New(nr);
	ci = 0;
	for (i=0; i<nr; i++) {
		pyrow = PyList_New(nc);
		for(j=0; j<nc; j++) {
			item = PyFloat_FromDouble(array[ci]);
			PyList_SetItem(pyrow, j, item);
			ci++;
		}
		PyList_SetItem(pylist, i, pyrow);
	}
	return pylist;
}


/*Convert a python list to an array of doubles of length 'length'*/
static double* pySeqTodC(PyObject *sequence, int *length) {
	double *array;
	int i;
	PyObject *item;
	*length = PySequence_Length(sequence);
	array = (double*) malloc((*length) * sizeof(double));
	for(i=0; i< *length; i++) {
		item = PySequence_GetItem(sequence, i);
		array[i] = PyFloat_AsDouble(item);
	}
	return array;
}
%}

/*Convert python string to a (char*, int) arguments pair*/
%typemap(in) (char *buffer, int buffer_len) {
	$1 = PyString_AsString($input);   /* char *str */
	$2 = PyString_Size($input);       /* int len   */
}

/*Convert python list in a double array*/
%typemap(in) double* {
	int ignore;
	$1 = pySeqTodC($input, &ignore);
}

%include idmc_model.i
%include idmc_traj.i
%include idmc_lexp.i
%include idmc_cycles.i
%include idmc_raster.i
%include idmc_basin.i
