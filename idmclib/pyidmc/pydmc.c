#include <Python.h>
#include <stdio.h>
#include <stdlib.h>
#include <model.h>

/*
idmc_model* idmc_clone_model(idmc_model *s);
*/

static PyObject *cC2PySeq(char **strings, int length);
static PyObject *dC2PySeq(double *array, int length);
static double* pySeqTodC(PyObject *sequence, int *length);

static PyObject *pydmc_new_model(PyObject *self, PyObject *args) {
	PyObject *ans;
	char *buffer, *result;
	int buflen;
	idmc_model *model;
	if (!PyArg_ParseTuple(args, "s#", &buffer, &buflen))
		return NULL;
	idmc_new_model(buffer, buflen, &model);
	ans = PyCObject_FromVoidPtr(model, idmc_free_model);
	return ans;
}

static PyObject *pydmc_clone_model(PyObject *self, PyObject *args) {
	PyObject *ans, *sp;
	idmc_model *model;
	if (!PyArg_ParseTuple(args, "O", &sp))
		return NULL;
	model = (idmc_model*) PyCObject_AsVoidPtr(sp);
	ans = PyCObject_FromVoidPtr(idmc_clone_model(model), idmc_free_model);
	return ans;
}

static PyObject *pydmc_desc(PyObject *self, PyObject *args) {
	PyObject *sp, *pyPar, *pyVar;
	int ignore;
	double *par, *var;
	char* ans;
	idmc_model *model;
	PyObject *pyAns;
	if (!PyArg_ParseTuple(args, "O", &sp))
		return NULL;
	model = (idmc_model*) PyCObject_AsVoidPtr(sp);
	idmc_model_desc(model, &ans);
	pyAns = PyString_FromString(ans);
	free(ans);
	return pyAns;
}

static PyObject *pydmc_name(PyObject *self, PyObject *args) {
	PyObject *sp, *pyPar, *pyVar;
	int ignore;
	double *par, *var;
	char* ans;
	idmc_model *model;
	PyObject *pyAns;
	if (!PyArg_ParseTuple(args, "O", &sp))
		return NULL;
	model = (idmc_model*) PyCObject_AsVoidPtr(sp);
	idmc_model_name(model, &ans);
	pyAns = PyString_FromString(ans);
	free(ans);
	return pyAns;
}

static PyObject *pydmc_type(PyObject *self, PyObject *args) {
	PyObject *sp, *pyPar, *pyVar;
	int ignore;
	double *par, *var;
	char* ans;
	idmc_model *model;
	PyObject *pyAns;
	if (!PyArg_ParseTuple(args, "O", &sp))
		return NULL;
	model = (idmc_model*) PyCObject_AsVoidPtr(sp);
	idmc_model_type(model, &ans);
	pyAns = PyString_FromString(ans);
	free(ans);
	return pyAns;
}

static PyObject *pydmc_var(PyObject *self, PyObject *args) {
	PyObject *sp, *pyPar, *pyVar;
	int ignore;
	double *par, *var;
	char* ans;
	idmc_model *model;
	PyObject *pyAns;
	if (!PyArg_ParseTuple(args, "O", &sp))
		return NULL;
	model = (idmc_model*) PyCObject_AsVoidPtr(sp);
	return cC2PySeq(model->var, model->var_len);
}

static PyObject *pydmc_par(PyObject *self, PyObject *args) {
	PyObject *sp, *pyPar, *pyVar;
	int ignore;
	double *par, *var;
	char* ans;
	idmc_model *model;
	PyObject *pyAns;
	if (!PyArg_ParseTuple(args, "O", &sp))
		return NULL;
	model = (idmc_model*) PyCObject_AsVoidPtr(sp);
	return cC2PySeq(model->par, model->par_len);
}

static PyObject *pydmc_f(PyObject *self, PyObject *args) {
	PyObject *sp, *pyPar, *pyVar;
	int ignore;
	double *par, *var, *ans;
	idmc_model *model;
	PyObject *pyAns;
	if (!PyArg_ParseTuple(args, "OOO", &sp, &pyPar, &pyVar))
		return NULL;
	model = (idmc_model*) PyCObject_AsVoidPtr(sp);
	par = pySeqTodC(pyPar, &ignore);
	var = pySeqTodC(pyVar, &ignore);
	ans = (double*) malloc(model->var_len * sizeof(double));
	idmc_f(model, par, var, ans);	
	pyAns = dC2PySeq(ans, model->var_len);
	free(par);
	free(var);
	free(ans);
	return pyAns;
}

static PyObject *pydmc_g(PyObject *self, PyObject *args) {
	PyObject *sp, *pyPar, *pyVar;
	int ignore;
	double *par, *var, *ans;
	idmc_model *model;
	PyObject *pyAns;
	if (!PyArg_ParseTuple(args, "OOO", &sp, &pyPar, &pyVar))
		return NULL;
	model = (idmc_model*) PyCObject_AsVoidPtr(sp);
	par = pySeqTodC(pyPar, &ignore);
	var = pySeqTodC(pyVar, &ignore);
	ans = (double*) malloc(model->var_len * sizeof(double));
	idmc_g(model, par, var, ans);	
	pyAns = dC2PySeq(ans, model->var_len);
	free(par);
	free(var);
	free(ans);
	return pyAns;
}

static PyObject *pydmc_NumJf(PyObject *self, PyObject *args) {
	PyObject *sp, *pyPar, *pyVar;
	int ignore;
	double *par, *var, *ans;
	double *util, *util2, *util3;
	idmc_model *model;
	PyObject *pyAns;
	if (!PyArg_ParseTuple(args, "OOO", &sp, &pyPar, &pyVar))
		return NULL;
	model = (idmc_model*) PyCObject_AsVoidPtr(sp);
	par = pySeqTodC(pyPar, &ignore);
	var = pySeqTodC(pyVar, &ignore);
	ans = (double*) malloc((model->var_len) * (model->var_len) * sizeof(double));
	util = (double*) malloc((model->var_len) * sizeof(double));
	util2 = (double*) malloc((model->var_len) * sizeof(double));
	util3 = (double*) malloc((model->var_len) * sizeof(double));	
	idmc_NumJf(model, par, var, ans, util, util2, util3);
	pyAns = dC2PySeq(ans, (model->var_len) * (model->var_len));
	free(par);
	free(var);
	free(ans);
	free(util);
	free(util2);
	free(util3);
	return pyAns;
}

static PyObject *pydmc_Jg(PyObject *self, PyObject *args) {
	PyObject *sp, *pyPar, *pyVar;
	int ignore;
	double *par, *var, *ans;
	idmc_model *model;
	PyObject *pyAns;
	if (!PyArg_ParseTuple(args, "OOO", &sp, &pyPar, &pyVar))
		return NULL;
	model = (idmc_model*) PyCObject_AsVoidPtr(sp);
	par = pySeqTodC(pyPar, &ignore);
	var = pySeqTodC(pyVar, &ignore);
	ans = (double*) malloc((model->var_len) * (model->var_len) * sizeof(double));
	idmc_Jg(model, par, var, ans);	
	pyAns = dC2PySeq(ans, (model->var_len) * (model->var_len));
	free(par);
	free(var);
	free(ans);
	return pyAns;
}

static PyObject *pydmc_Jf(PyObject *self, PyObject *args) {
	PyObject *sp, *pyPar, *pyVar;
	int ignore;
	double *par, *var, *ans;
	idmc_model *model;
	PyObject *pyAns;
	if (!PyArg_ParseTuple(args, "OOO", &sp, &pyPar, &pyVar))
		return NULL;
	model = (idmc_model*) PyCObject_AsVoidPtr(sp);
	par = pySeqTodC(pyPar, &ignore);
	var = pySeqTodC(pyVar, &ignore);
	ans = (double*) malloc((model->var_len) * (model->var_len) * sizeof(double));
	idmc_Jf(model, par, var, ans);	
	pyAns = dC2PySeq(ans, (model->var_len) * (model->var_len));
	free(par);
	free(var);
	free(ans);
	return pyAns;
}

static PyObject *cC2PySeq(char **strings, int length){
	PyObject *pylist, *item;
	int i;
	pylist = PyList_New(length);
	for (i=0; i<length; i++) {
		item = PyString_FromString(strings[i]);
		PyList_SetItem(pylist, i, item);
	}
	return pylist;
}

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

static PyMethodDef pyDmcMethods[] = {
	{"new_model",  pydmc_new_model, METH_VARARGS, "Creates a new model"},
	{"clone_model",  pydmc_clone_model, METH_VARARGS, "Clones a new model"},
	{"desc",  pydmc_desc, METH_VARARGS, "description"},
	{"name",  pydmc_name, METH_VARARGS, "name"},
	{"type",  pydmc_type, METH_VARARGS, "type"},
	{"par",  pydmc_par, METH_VARARGS, "parameters"},
	{"var",  pydmc_var, METH_VARARGS, "variables"},
	{"f",  pydmc_f, METH_VARARGS, "map"},
	{"g",  pydmc_g, METH_VARARGS, "inverse map"},
	{"Jf",  pydmc_Jf, METH_VARARGS, "jacobian"},
	{"Jg",  pydmc_Jg, METH_VARARGS, "inverse jacobian"},
	{"NumJf",  pydmc_NumJf, METH_VARARGS, "numerical jacobian"},
	{NULL, NULL, 0, NULL}        /* Sentinel */
};

PyMODINIT_FUNC initpydmc(void)
{
	(void) Py_InitModule("pydmc", pyDmcMethods);
}

/*
Of course this can be done, and there are a number of ways to do
it. Based on your implication that there are many more values put in
the array by the C code than will be accessed (or changed) by the
Python code, this method might make sense:

1) have the C function construct a new python object (i.e. the "wrapper")

2) put the real pointer to the C array into the wrapper as instance data

3) register two methods for the object "get()" and "set()", impelemented
in C as Python exported functions.

The get method should take self and the array index as paramaters and
return the values in that slot of the array

The set method should take self, an index, and the values as paramaters
and it should modify the real "C-version" of the array.

4) when you execute your python function, it will be given this
"wrapper" object as a paramater. It can then call into the methods in
the wrapper object to access and change the C-array "in-place" without
converting it at all. Each new value which is set into the array
is converted on the fly.

5) If you like, you can convert get() and set() to __get__() and __set__
so you can use array access syntax to access the array from python.
*/
