#!/bin/sh
#\
exec tclsh "$0" ${1+"$@"}

source "./init.tcl"

if {$argc < 11} {
	puts "only $argc arguments passed"
	puts "expected: modelFileName imageDataFileName \"parameters\" \"xmin xmax xres\" \
	\"ymin ymax yres\"eps attractorLimit attractorIterations ntries xvar yvar \"startValues\""
	return 1
}

#SET ARGUMENTS
set fname [lindex $argv 0]
set imgfname [lindex $argv 1]
set parameters [list2array [lindex $argv 2]]
set xmin [lindex [lindex $argv 3] 0]
set xmax [lindex [lindex $argv 3] 1]
set xres [lindex [lindex $argv 3] 2]
set ymin [lindex [lindex $argv 4] 0]
set ymax [lindex [lindex $argv 4] 1]
set yres [lindex [lindex $argv 4] 2]
set eps [lindex $argv 5]
set attractorLimit [lindex $argv 6]
set attractorIterations [lindex $argv 7]
set ntries [lindex $argv 8]
set xvar [lindex $argv 9]
set yvar [lindex $argv 10]
set startValues [list2array [lindex $argv 11]]
##

#LOAD MODEL, ALLOCATE RESOURCES
set buffer [myfread $fname]
set m [model_alloc $buffer]
idmc_model_setGslRngSeed $m 123
set bs [basin_multi_alloc $m $parameters $xmin $xmax $xres $ymin $ymax $yres\
	$eps $attractorLimit $attractorIterations $ntries\
	$xvar $yvar $startValues]
idmc_model_free $m
##

#SCAN FOR ATTRACTORS (AND STORE THEM)
for {set i 0} {$i < $ntries} {incr i} {
	idmc_basin_multi_find_next_attractor $bs
}
set ans [list]
set al [idmc_basin_multi_attr_head_get $bs]
for {set i 0} {$i < [idmc_attractor_list_length $al]} {incr i} {
	lappend ans [traj2list [idmc_attractor_list_get $al $i]]
}
##

#PRINT OUT ATTRACTORS
puts $ans
#

#ITERATE THROUGH IMAGE CELLS
set i 0
set necho [expr max($xres * $yres / 500, 1)]
while {![idmc_basin_multi_finished $bs]} {
	idmc_basin_multi_step $bs
	incr i
	if {!fmod($i, $necho)} {
		if {[catch {puts [idmc_basin_multi_currId_get $bs]} errmsg]} {
			exit
		}
	}
}
##

proc X2x {X xmin xmax xres} {
	expr $xmin + ( (double($X) + 0.5) / double($xres) ) * ($xmax - $xmin)
}

#SAVE IMAGE DATA
set imgf [open $imgfname w]
set r [idmc_basin_multi_raster_get $bs]
for {set i 0} {$i < $xres} {incr i} {
	for {set j 0} {$j < $yres} {incr j} {
		set x [X2x $i $xmin $xmax $xres]
		set y [X2x $j $ymin $ymax $yres]
		set num [idmc_raster_getxy $r $x $y]
		puts $imgf "$x, $y, $num"
	}
}
close $imgf
##

#FREE ALLOCATED RESOURCES
idmc_basin_multi_free $bs
##
