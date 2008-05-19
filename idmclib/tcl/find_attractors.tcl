#!/bin/sh
#\
exec tclsh "$0" ${1+"$@"}

source "./init.tcl"

set argv [list]
#model file name
lappend argv "BH-cobweb-async.lua"
#parameters
lappend argv "2.75 0 0.5 1.35 1 0 0"
#x range and resolution
lappend argv "-1.5 1.5 100"
#y range and resolution
lappend argv "0.0 1.0 100"
#eps
lappend argv 0.001
#transient
lappend argv 10000
#attractor max length
lappend argv 1000
#number of tries
lappend argv 1
#x variable
lappend argv 0
#y variable
lappend argv 1
#starting point
lappend argv "2 0.5 0.5 0 0"

#SET ARGUMENTS
set fname [lindex $argv 0]
set parameters [list2array [lindex $argv 1]]
set xmin [lindex [lindex $argv 2] 0]
set xmax [lindex [lindex $argv 2] 1]
set xres [lindex [lindex $argv 2] 2]
set ymin [lindex [lindex $argv 3] 0]
set ymax [lindex [lindex $argv 3] 1]
set yres [lindex [lindex $argv 3] 2]
set eps [lindex $argv 4]
set attractorLimit [lindex $argv 5]
set attractorIterations [lindex $argv 6]
set ntries [lindex $argv 7]
set xvar [lindex $argv 8]
set yvar [lindex $argv 9]
set startValues [list2array [lindex $argv 10]]
##

set buffer [myfread $fname]
set m [model_alloc $buffer]
set bs [basin_multi_alloc $m $parameters $xmin $xmax $xres $ymin $ymax $yres\
	$eps $attractorLimit $attractorIterations $ntries\
	$xvar $yvar $startValues]
idmc_model_free $m

idmc_basin_multi_find_next_attractor $bs
set al [idmc_basin_multi_attr_head_get $bs]
if {$al == "NULL"} {error "unexpected attractors list null pointer"}
set attr1 [traj2list $al]
if {[idmc_attractor_list_length $al] != 1} {error "expecting a list of length 1"}
if {[llength $attr1] != 4} {error "expecting an attractor of length 4"}

idmc_basin_multi_find_next_attractor $bs
if {$al != [idmc_basin_multi_attr_head_get $bs]} {error "unexpected list head pointer value"}
idmc_attractor_list_length $al

idmc_basin_multi_find_next_attractor $bs
if {$al != [idmc_basin_multi_attr_head_get $bs]} {error "unexpected list head pointer value"}
idmc_attractor_list_length $al
set attr2 [idmc_attractor_list_get $al 1]
set attr2 [traj2list $attr2]
llength $attr2

idmc_basin_multi_free $bs
