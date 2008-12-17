#!/bin/sh
# \
exec tclsh "$0" ${1+"$@"}

source "./init.tcl"

set buffer [myfread "olg4doublecorretto.lua"]
set m [model_alloc $buffer]

set par [list2array "0.46 -7 1"]
set var [list2array "0.8 0.9 0 0 0"]
set tr [traj_alloc $m $par $var]
set ans [idmc_traj_trajectory_var_get $tr]

for {set i 0} {$i < 1000} {incr i} {
	idmc_traj_trajectory_step $tr
}
stopifne [array2list $ans 5] "1.149432550086277 0.9497304287308597 1.0533240795128194 1.7264942102126053 0.6731701306997859"
