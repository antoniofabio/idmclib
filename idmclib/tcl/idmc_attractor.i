struct attractor_pt {
	double *x;
	struct attractor_pt* next;
};
typedef struct attractor_pt idmc_attractor_point;

struct attr_lst {
	idmc_attractor_point *hd; /*head of points list*/
	int dim; /*points dimension*/
	struct attr_lst* next;
	struct attr_lst* previous;
};
typedef struct attr_lst idmc_attractor;

idmc_attractor_point *idmc_attractor_point_new(double* x, int n);

void idmc_attractor_point_free(idmc_attractor_point* p);

idmc_attractor_point* idmc_attractor_point_add(idmc_attractor_point* last,
	idmc_attractor_point* p);

idmc_attractor_point* idmc_attractor_point_last(idmc_attractor_point* head);

idmc_attractor* idmc_attractor_new(int dim);

void idmc_attractor_free(idmc_attractor* p);

int idmc_attractor_length(idmc_attractor* p);

/*returns true if point lies on the attractor*/
int idmc_attractor_check_point(idmc_attractor* p, double* x, double eps);

void idmc_attractor_hd_set(idmc_attractor* p, idmc_attractor_point* head);

idmc_attractor* idmc_attractor_list_add(idmc_attractor* last, idmc_attractor* i);

void idmc_attractor_list_free(idmc_attractor* head);

int idmc_attractor_list_length(idmc_attractor* head);

void idmc_attractor_list_merge(idmc_attractor* head, int a, int b);

int idmc_attractor_list_check_point(idmc_attractor* head, double* x, double eps);

idmc_attractor* idmc_attractor_list_get(idmc_attractor* head, int id);

void idmc_attractor_list_drop(idmc_attractor* p);
