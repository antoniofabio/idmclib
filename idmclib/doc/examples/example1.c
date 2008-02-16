#include <stdio.h>
#include <string.h>
#include <idmclib/model.h>

/*model text*/
char model_txt[] =
"name = \"example1\"\n"
"description = \"a sample model\"\n"
"type = \"D\"\n"
"parameters = {\"a\"}\n"
"variables = {\"x\"}\n"
"\n"
"function f(a, x)\n"
"	x = a*runif()\n"
"	return x\n"
"end\n";

int main(int argc, char* argv) {
	idmc_model *m;
	/*load the model*/
	int s = idmc_model_alloc(model_txt, strlen(model_txt), &m);
	/*check if all has gone right*/
	if(s!=IDMC_OK)
		printf("cannot load model\n");
	else
		printf("model correctly loaded\n");
	/*release memory*/
	idmc_model_free(m);
	return 0;
}

