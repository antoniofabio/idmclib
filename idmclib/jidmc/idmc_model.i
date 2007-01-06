%immutable;
#define IDMC_IDENT_NAME "name"
#define IDMC_IDENT_DESC "description"
#define IDMC_IDENT_TYPE "type"
#define IDMC_IDENT_PARAMETERS "parameters"
#define IDMC_IDENT_VARIABLES "variables"
#define IDMC_IDENT_DEFAULTS "defaults"
#define IDMC_IDENT_FUNCTION "f"
#define IDMC_IDENT_JACOBIAN "Jf"
#define IDMC_IDENT_FUNCTION_INVERSE "g"
#define IDMC_IDENT_INVERSE_JACOBIAN "Jg"
%mutable;

typedef struct {
%immutable;	
	lua_State* L;
	int par_len;
	char** par; /*parameter names*/
	int var_len;
	char** var; /*variables names*/

	int has_inverse;
	int has_jacobian;
	
	char* buffer; /*original model code buffer*/
	int buflen;
	
	char* name; /*model name*/
	char* desc; /*model description*/
/*	char* type; /*model type*/
%mutable;
	
	int interrupt; /*generic external interrupt flag*/
	
%extend {
	Model (const char* buffer, const int buffer_len) {
		Model *ans;
		idmc_model_alloc(buffer, buffer_len, &ans);
		return ans;
	}
	~Model() {
		idmc_model_free(self);
	}
	
	Model* Clone() {
		return idmc_model_clone(self);
	}
	char* getPar(int i) {
		return self->par[i];
	}
	char* getVar(int i) {
		return self->var[i];
	}	
	int f(double par[], double var[], double f[]) {
		return idmc_model_f(self, par, var, f);
	}
	int g(double par[], double var[], double f[]) {
		return idmc_model_g(self, par, var, f);
	}
	int Jf(double par[], double var[], double Jf[]) {
		return idmc_model_Jf(self, par, var, Jf);
	}
	int Jg(double par[], double var[], double Jf[]) {
		return idmc_model_Jg(self, par, var, Jf);
	}
	int NumJf(double par[], double var[], double Jf[], double util[], double util2[], double util3[]) {
		return idmc_model_NumJf(self, par, var, Jf, util, util2, util3);
	}
	int getType() {
		return self->type[0];
	}
	int setRngSeed(int seed) {
		return idmc_model_setGslRngSeed(self, seed);
	}
}
} Model;
