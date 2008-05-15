#!/bin/sh
#\
exec tclsh "$0" ${1+"$@"}

source "init.tcl"

if { ![info exists argv0] } { set argv0 "trajectory.tcl" }

if {$argc < 4} { puts "
usage:
	$argv0 modelFilePath \"parameters\" \"startingValues\" timeSpan transientSpan integrationStep
	
The last 2 arguments are optional and defaults to 0 and 0.1, respectively.
The last argument is ignored if the model is a discrete time model.
"
	return 1
}

proc safe_model_alloc {buffer} {
	set m [model_alloc $buffer]
	set msg [idmc_model_errorMessage_get $m]
	if { $msg != "" } {
		error $msg
	}
	return $m
}

##TESTING CODE
if {0} {
	set argv "logistic.lua 0.5 0.5 10"
	set argc 4
}

########################
##COLLECT ARGUMENTS#####
########################
set modelFileName [lindex $argv 0]
set in_par [lindex $argv 1]
set in_var [lindex $argv 2]
set in_timeSpan [lindex $argv 3]
if { $argc < 5 } {
	set in_transientSpan 0
} else {
	set in_transientSpan [lindex $argv 4]
}
if { $argc < 6 } {
	set in_eps 0.1
} else {
	set in_eps [lindex $argv 5]
}

##LOAD FILE
set fin [open $modelFileName r]
set buffer [read $fin]
close $fin

##LOAD MODEL
set m [safe_model_alloc $buffer]
set nvar [idmc_model_var_len_get $m]
set var [new_doubleArray $nvar]
set npar [idmc_model_par_len_get $m]
set par [new_doubleArray $npar]
set type [idmc_model_type_get $m]
if {$type == "D"} { set eps 1 } \
else { set eps $in_eps }

#############################
##LOAD user input in memory##
#############################
##Parameters
for {set i 0} {$i < $npar} {incr i} {
	doubleArray_setitem $par $i [lindex $in_par $i]
}
##Starting values
for {set i 0} {$i < $nvar} {incr i} {
	doubleArray_setitem $var $i [lindex $in_var $i]
}
#Set number of iterations
set n_transient [expr $in_transientSpan / $eps]
set n [expr $in_timeSpan / $eps]

######################
##COMPUTE TRAJECTORY##
######################
if {$type == "D"} {
	set tr [traj_alloc $m $par $var]
	set currValue [idmc_traj_trajectory_var_get $tr]
	proc do_step {} "idmc_traj_trajectory_step $tr"
	proc free_traj {} "idmc_traj_trajectory_free $tr"
} else {
	set tr [ctraj_alloc $m $par $var $eps $gsl_odeiv_step_rk2]
	set currValue [idmc_traj_ctrajectory_var_get $tr]
	proc do_step {} "idmc_traj_ctrajectory_step $tr"
	proc free_traj {} "idmc_traj_ctrajectory_free $tr"
}

for {set i 0} {$i < $n_transient} {incr i} {
	do_step
}

set header "time"
set varNames [idmc_model_var_get $m]
for {set i 0} {$i < $nvar} {incr i} {
	lappend header [stringArray_getitem $varNames $i]
}
puts [join $header ", "]
for {set i 0} {$i < $n} {incr i} {
	do_step
	set tmp [expr $i + $n_transient]
	for {set j 0} {$j < $nvar} {incr j} {
		lappend tmp [doubleArray_getitem $currValue $j]
	}
	puts [join $tmp ", "]
	flush stdout
}

free_traj
