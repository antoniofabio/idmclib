#!/usr/bin/tclsh
source "./init.tcl"
source "./misc_util.tcl"

set bs [allocBasin basin_test1.lua "1 1 5 5 1 5 4" "-4 9 100" "-4 9 100"\
	1e-4 2 2 20 "0 1" "0 0 0 0"]
llength [set attr_list [find_attractors $bs]]
stopifnot "![string compare $attr_list\
	{{{1.0 1.0 0.0 0.0}} {{1.0 5.0 0.0 0.0}} {{5.0 5.0 0.0 0.0}}}]"
idmc_basin_multi_free $bs

#TEST CASE 2: sensible variables are the 3rd and 4th ones
set bs [allocBasin basin_test2.lua "1 1 5 5 1 5 4" "-4 9 100" "-4 9 100"\
	1e-4 2 2 20 "1 3" "0 0 0 0"]
llength [set attr_list [find_attractors $bs]]
stopifnot "![string compare $attr_list\
	{{{0.0 1.0 0.0 1.0}} {{0.0 1.0 0.0 5.0}} {{0.0 5.0 0.0 5.0}}}]"
idmc_basin_multi_free $bs

#TEST CASE 3: VERIFY BASINS FILLING
set bs [allocBasin basin_test1.lua "1 1 2 2 1 2 0.9" "0 3 6" "0 3 6"\
	1e-4 2 2 20 "0 1" "0 0 0 0"]
llength [set attr_list [find_attractors $bs]]
stopifnot "![string compare $attr_list\
	{{{1.0 1.0 0.0 0.0}} {{1.0 2.0 0.0 0.0}} {{2.0 2.0 0.0 0.0}}}]"

set i 0
while {![idmc_basin_multi_finished $bs]} {
	idmc_basin_multi_step $bs
	stopifnot "($i < 36)"
	incr i
}

set r [idmc_basin_multi_raster_get $bs]
stopifnot "[idmc_raster_getxy $r 1.0 1.0] == 2"
stopifnot "[idmc_raster_getxy $r 1.0 2.0] == 4"
stopifnot "[idmc_raster_getxy $r 2.0 2.0] == 6"
stopifnot "[idmc_raster_getxy $r 1.0 1.4999] == 2"
stopifnot "[idmc_raster_getxy $r 1.0 1.5] == 4"

idmc_basin_multi_free $bs
