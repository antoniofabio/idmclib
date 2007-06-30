#ifndef __IDMC_VERSION_H__
#define __IDMC_VERSION_H__

#define IDMC_VERSION_MAJOR @CPACK_PACKAGE_VERSION_MAJOR@
#define IDMC_VERSION_MINOR @CPACK_PACKAGE_VERSION_MINOR@
#define IDMC_VERSION_MICRO @CPACK_PACKAGE_VERSION_PATCH@

int idmc_version_major();
int idmc_version_minor();
int idmc_version_micro();

#endif
