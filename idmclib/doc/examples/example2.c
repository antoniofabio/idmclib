#include <stdio.h>
#include <string.h>
#include <idmclib/model.h>
#include <idmclib/traj.h>

char model_txt[] = 
"name=\"a\"\n"
"description=\"\"\n"
"type=\"D\"\n"
"variables=\"x\"\n"
"parameters=\"p\"\n"
"\n"
"function f(p, x)\n"
"	x = p * x\n"
"	return x\n"
"end";

int main(int argc, char* argv[]) {
	idmc_model *m;
	idmc_traj_trajectory *t;
	double start = 1.0;
	double par = 0.5;
	int steps = 4;
	int i;
	
	idmc_model_alloc(model_txt, strlen(model_txt), &m);
	idmc_traj_trajectory_alloc(m, &par, &start, &t);
	for(i=1; i<=steps; i++){
		idmc_traj_trajectory_step(t);
		printf("step %d: %f\n", i, t->var[0]);
	}
	idmc_traj_trajectory_free(t);
	idmc_model_free(m);
	return 0;
}