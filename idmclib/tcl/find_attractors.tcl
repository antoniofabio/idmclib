#!/bin/sh
#\
exec tclsh "$0" ${1+"$@"}

source "./init.tcl"

if {[lindex $argv 0] == "test"} {
	set test 1
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
	lappend argv 10
	#x variable
	lappend argv 0
	#y variable
	lappend argv 1
	#starting point
	lappend argv "2 0.5 0.5 0 0"
} else {
	set test 0
	if {$argc < 11} {
		puts "expected: fname \"parameters\" \"xmin xmax xres\" \"ymin ymax yres\"\
 eps attractorLimit attractorIterations ntries xvar yvar \"startValues\""
		return 1
	}
}

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
idmc_model_setGslRngSeed $m 123
set bs [basin_multi_alloc $m $parameters $xmin $xmax $xres $ymin $ymax $yres\
	$eps $attractorLimit $attractorIterations $ntries\
	$xvar $yvar $startValues]
idmc_model_free $m

for {set i 0} {$i < $ntries} {incr i} {
	idmc_basin_multi_find_next_attractor $bs
}
set ans [list]
set al [idmc_basin_multi_attr_head_get $bs]
for {set i 0} {$i < [idmc_attractor_list_length $al]} {incr i} {
	lappend ans [join [traj2list [idmc_attractor_list_get $al $i]] "\n"]
}

if {$test} {
	puts "Attractors found: [idmc_attractor_list_length $al]"
}

puts [join $ans "\n\n"]

idmc_basin_multi_free $bs
