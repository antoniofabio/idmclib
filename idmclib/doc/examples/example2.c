#include <stdio.h>
#include <string.h>
#include <idmclib/model.h>
#include <idmclib/traj.h>

/*model text*/
char model_txt[] = 
"name=\"a\"\n"
"description=\"\"\n"
"type=\"D\"\n"
"variables= {\"x\"}\n"
"parameters= {\"p\"}\n"
"\n"
"function f(p, x)\n"
"	x = p * x\n"
"	return x\n"
"end";

int main(int argc, char* argv[]) {
	idmc_model *m;			/*model object*/
	idmc_traj_trajectory *t;	/*trajectory object*/
	double start = 1.0;		/*starting point*/
	double par = 0.5;		/*parameter value*/
	int steps = 4;			/*number of steps*/
	int i;

	/*load model*/
	idmc_model_alloc(model_txt, strlen(model_txt), &m);
	/*load a new trajectory object*/
	idmc_traj_trajectory_alloc(m, &par, &start, &t);
	for(i=1; i<=steps; i++){
		idmc_traj_trajectory_step(t); /*compute 1 trajectory step*/
		/*current point is stored in array t->var:*/
		printf("step %d: %f\n", i, t->var[0]);
	}
	/*free resources*/
	idmc_traj_trajectory_free(t);
	idmc_model_free(m);
	return 0;
}
