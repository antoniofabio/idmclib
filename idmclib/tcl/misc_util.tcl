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
