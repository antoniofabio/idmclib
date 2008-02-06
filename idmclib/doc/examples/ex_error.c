#include <stdio.h>
#include <string.h>
#include <idmclib/model.h>

char model_txt[] =
"name = \"sample errors\"\n"
"description = \"sample runtime errors\"\n"
"type = \"D\"\n"
"parameters = {\"p\"}\n"
"variables = {\"x\"}\n"
"function f(p, x)\n"
"	return p * x + \"something\"\n"
"end\n";

int main(int argc, char* argv) {
	idmc_model *m;
	double p, x;
	int result;
	idmc_model_alloc(model_txt, strlen(model_txt), &m);
	result = idmc_model_f(m, &p, &x, &x);
	if(result == IDMC_ERUN) {
		printf("runtime error: %s\n", m->errorMessage);
	}
	idmc_model_free(m);
	return 0;
}
