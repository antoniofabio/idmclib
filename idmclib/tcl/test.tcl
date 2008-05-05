#!/usr/bin/tclsh
switch $::tcl_platform(platform) {
    unix {load ./tclidmclib.so}
    windows {load ./tclidmclib.dll}
}

idmc_version_major
idmc_version_minor
idmc_version_micro

proc myfread {fname} {
	set fin [open $fname r]
	set ans [read $fin]
	close $fin
	return $ans
}

set buffer [myfread logistic.lua]

set m [model_alloc $buffer]
idmc_model_free $m

set m [model_alloc $buffer]

#model introspection
idmc_model_name_get $m
idmc_model_desc_get $m
idmc_model_type_get $m

idmc_model_par_len_get $m
stringArray_getitem [idmc_model_par_get $m] 0
idmc_model_var_len_get $m
stringArray_getitem [idmc_model_var_get $m] 0

#other model methods
set m2 [idmc_model_clone $m]
idmc_model_free $m2

set par [new_doubleArray 1]
doubleArray_setitem $par 0 0.5
set var [new_doubleArray 1]
doubleArray_setitem $var 0 0.5
set out [new_doubleArray 1]
set w1 [new_doubleArray 1]
set w2 [new_doubleArray 1]
set w3 [new_doubleArray 1]

idmc_model_f $m $par $var $var
doubleArray_getitem $var 0

idmc_model_Jf $m $par $var $out
doubleArray_getitem $out 0
idmc_model_NumJf $m $par $var $out $w1 $w2 $w3
doubleArray_getitem $out 0

#trajectories
set m [model_alloc [myfread lorenz.lua]]
set par [new_doubleArray 3]
doubleArray_setitem $par 0 1
doubleArray_setitem $par 1 2
doubleArray_setitem $par 2 3
set var [new_doubleArray 3]
doubleArray_setitem $var 0 1
doubleArray_setitem $var 1 2
doubleArray_setitem $var 2 3
set tr [ctraj_alloc $m $par $var 0.1 $gsl_odeiv_step_rk2]
set currValue [idmc_traj_ctrajectory_var_get $tr]
set compTr ""
for {set i 0} { $i <= 10 } { incr i } {
	idmc_traj_ctrajectory_step $tr
	set compTr "$compTr [doubleArray_getitem $currValue 0]"
}
puts $compTr

#lyap. exponents
set out [new_doubleArray 3]
idmc_lexp_ode $m $par $var $out 100 0.1
doubleArray_getitem $out 0
doubleArray_getitem $out 1
doubleArray_getitem $out 2

#periodic cycles
set m [model_alloc [myfread logistic.lua]]
set out [new_doubleArray 1]
set out_eigvals [new_doubleArray 1]
doubleArray_setitem $par 0 0.5
doubleArray_setitem $var 0 0.5
idmc_cycles_find $m $par $var 2 0.01 1000 $out $out_eigvals
doubleArray_getitem $out 0
doubleArray_getitem $out_eigvals 0
idmc_cycles_powf $m 2 $par $var $out
set out_jac [new_doubleArray 1]
set util [new_doubleArray 3]
idmc_cycles_powNumJac $m 2 $par $var $out_jac $util
doubleArray_getitem $out_jac 0
idmc_cycles_eigval $out_jac 1 $out_eigvals
doubleArray_getitem $out_eigvals 0

#basin
set m [model_alloc [myfread test2.lua]]
set par [new_doubleArray 1]
set bs [basin_alloc $m $par -1.5 1.5 100 -1.5 1.5 100 1000 100]
set ::i 0
while {![idmc_basin_finished $bs]} {
	idmc_basin_step $bs
	incr ::i
}
puts $::i

#basin_slow
set m [model_alloc [myfread test2.lua]]
set par [new_doubleArray 1]
set bs [basin_slow_alloc $m $par -2.0 2.0 100 -2.0 2.0 100 1000 1000 20]

set ::i 0
while {![idmc_basin_slow_finished $bs]} {
	idmc_basin_slow_step $bs
	incr ::i
}
puts $::i
