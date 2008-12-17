#!/bin/sh
# \
exec tclsh "$0" ${1+"$@"}

source "./init.tcl"

set buffer [myfread "test1.lua"]
set m [safe_model_alloc $buffer]
set par [list2array 1.0]
set var [list2array "1 2 3 4 5 6 7 8 9"]
set ans [list2array "1 2 3 4 5 6 7 8 9"]

for {set i 0} {$i < 1000} {incr i} {
	idmc_model_setGslRngSeed $m 123
	idmc_model_f $m $par $var $ans
	stopifne [array2list $ans 9] "0.6335290032438934 1.0416814025536334 3.0 -1.060974674386749 1.3596270116146407 0.4230486538392224 39.54387606845883 2.1193675889803747 -9.257081853478832"
}
