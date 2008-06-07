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
