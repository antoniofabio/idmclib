
typedef struct {
%immutable;
	lua_State* L;
	char** par;
	int par_len;
	char** var;
	int var_len;
	
	int has_inverse;
	int has_jacobian;
	
	char* buffer; /*original model code buffer*/
	
	char* name;
	char* desc;
	char* type;
	
	char* errorMessage;
} idmc_model;

%inline{
idmc_model* model_alloc(char* buffer) {
	model *ans;
	idmc_model_alloc(buffer, strlen(buffer), &ans);
	return ans;
}
}

void idmc_model_free(idmc_model *s);
/*clones a model object*/
idmc_model* idmc_model_clone(idmc_model *s);
/* Set RNG seed. Shouldn't return any error */
int idmc_model_setGslRngSeed(idmc_model *model, int seed);
/* 
 * evaluate the model functions
 * These can return a runtime error, with relative message string stored in model->errorMessage buffer
 */
int idmc_model_f(idmc_model *model, const double par[], const double var[], double f[]);
int idmc_model_g(idmc_model *model, const double par[], const double var[], double f[]);
int idmc_model_Jf(idmc_model *model, const double par[], const double var[], double Jf[]);
int idmc_model_Jg(idmc_model *model, const double par[], const double var[], double Jf[]);
int idmc_model_NumJf(idmc_model *model, const double par[], const double var[], double Jf[], 
			   double util[], double util2[], double util3[]);
