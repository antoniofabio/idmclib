#Change PROJECT_NAME to the name of your project
PROJECT(idmclib)

 doc      jidmc  Makefile      Makefile.inc.win  ridmc  tests
CMakeLists.txt  include  lib    Makefile.inc  pyidmc            src 
add_subdirectory (doc)
add_subdirectory (jidmc)
add_subdirectory (ridmc)
add_subdirectory (tests)
add_subdirectory (pyidmc)
add_subdirectory (src)
