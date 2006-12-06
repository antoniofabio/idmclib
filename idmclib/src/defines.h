#ifndef _IDMC_DEFINES_H
#define _IDMC_DEFINES_H

/* eps value for numerical derivative computation */
#define IDMC_EPS_VALUE 2e-8

/* normal operation */
#define IDMC_OK 0
/* memory allocation */
#define IDMC_EMEM 1
/* syntax error from lua itself */
#define IDMC_ELUASYNTAX 2
/* lua runtime error */
#define IDMC_ERUN 3
/* malformed model */
#define IDMC_EMODEL 4
/* inconsistent state (disaster) */
#define IDMC_EERROR 5
/* algorithm failed */
#define IDMC_EMATH 6
/* interrupted by request */
#define IDMC_EINT 7

#endif
