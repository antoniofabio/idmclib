proc safe_model_alloc {buffer} {
	set m [model_alloc $buffer]
	set msg [idmc_model_errorMessage_get $m]
	if { $msg != "" } {
		error $msg
	}
	return $m
}

#LOAD MODEL, ALLOCATE RESOURCES
proc allocBasin {modelFileName pars xrange yrange eps ntrans nattr ntries xyvar startValues} {
	set buffer [myfread $modelFileName]
	set m [safe_model_alloc $buffer]
	idmc_model_setGslRngSeed $m 123
	set bs [basin_multi_alloc $m [list2array $pars] \
		[lindex $xrange 0] [lindex $xrange 1] [lindex $xrange 2]\
		[lindex $yrange 0] [lindex $yrange 1] [lindex $yrange 2]\
		$eps $ntrans $nattr $ntries\
		[lindex $xyvar 0] [lindex $xyvar 1] [list2array $startValues]]
	idmc_model_free $m
	return $bs
}

proc find_attractors {basin} {
	for {set i 0} {$i < [idmc_basin_multi_ntries_get $basin]} {incr i} {
		idmc_basin_multi_find_next_attractor $basin
	}
	set ans [list]
	set al [idmc_basin_multi_attr_head_get $basin]
	for {set i 0} {$i < [idmc_attractor_list_length $al]} {incr i} {
		lappend ans [traj2list [idmc_attractor_list_get $al $i]]
	}
	return $ans
}

proc stopifnot {condition} {
	if "!($condition)" {
		error "error: `$condition' is false"
	}
}

proc X2x {X range} {
	set xm [lindex $range 0]
	set xM [expr $xm + [lindex $range 1]]
	set n [lindex $range 2]
	set xl [expr $xM - $xm]
	set xe [expr $xl / $n]
	return [expr (($X + 1.0) / $n) * $xl + $xm - ($xl / $n) ]
}

proc basin2stringmatrix {b} {
	set r [idmc_basin_multi_raster_get $b]
	set xrange [list\
		[idmc_raster_xmin_get $r]\
		[idmc_raster_xrange_get $r]\
		[idmc_raster_xres_get $r]]
	set yrange [list\
		[idmc_raster_ymin_get $r]\
		[idmc_raster_yrange_get $r]\
		[idmc_raster_yres_get $r]]
	set rc [list]
	for {set i 0} {$i < 8} {incr i} {
		set row [list]
		for {set j 0} {$j < 8} {incr j} {
			lappend row [idmc_raster_getxy $r [X2x $i $xrange] [X2x $j $yrange]]
		}
		lappend rc [join $row " "]
	}
	return [join $rc "\n"]
}
