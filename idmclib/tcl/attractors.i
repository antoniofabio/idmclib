struct attractor_pt {
	double *x;
	struct attractor_pt* next;
};
typedef struct attractor_pt attractor_point;

struct attr_lst {
	attractor_point *hd; /*head of points list*/
	int dim; /*points dimension*/
	struct attr_lst* next;
	struct attr_lst* previous;
};
typedef struct attr_lst attractor;

attractor_point *attractor_point_new(double* x, int n);

void attractor_point_free(attractor_point* p);

attractor_point* attractor_point_add(attractor_point* last, attractor_point* p);

attractor_point* attractor_point_last(attractor_point* head);

attractor* attractor_new(int dim);

void attractor_free(attractor* p);

int attractor_length(attractor* p);

/*returns true if point lies on the attractor*/
int attractor_check_point(attractor* p, double* x, double eps);

void attractor_hd_set(attractor* p, attractor_point* head);

attractor* attractors_list_add(attractor* last, attractor* i);

void attractors_list_free(attractor* head);

int attractors_list_length(attractor* head);

void attractors_list_merge(attractor* head, int a, int b);

int attractors_list_check_point(attractor* head, double* x, double eps);

attractor* attractors_list_get(attractor* head, int id);

void attractors_list_drop(attractor* p);
