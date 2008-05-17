load ../tcl/tclidmclib.so

#convert a list (of doubles) into a C doubleArray
proc list2array {xy} {
	set dim [llength $xy]
	set ans [new_doubleArray $dim]
	for {set i 0} {$i < $dim} {incr i} {
		doubleArray_setitem $ans $i [lindex $xy $i]
	}
	return $ans
}

proc array2list {xy dim} {
	set ans [list]
	for {set i 0} {$i < $dim} {incr i} {
		lappend ans [doubleArray_getitem $xy $i]
	}
	return ans
}

#builds a trajectory out of a list of points coordinates
proc mktraj {pts_list} {
	set n [llength $pts_list]
	set dim [llength [lindex $pts_list 0]]
	set attr [attractor_new $dim]
	set hd [attractor_point_new [list2array [lindex $pts_list 0]] $dim]
	attractor_hd_set $attr $hd
	for {set i 1} {$i < $n} {incr i} {
		set pt [attractor_point_new [list2array [lindex $pts_list $i]] $dim]
		set hd [attractor_point_add $hd $pt]
	}
	return $attr
}

#converts a trajectory back into a list
proc traj2list {traj} {
	set ans [list]
	set hd [attr_lst_hd_get $traj]
	set dim [attr_lst_dim_get $traj]
	set len [attractor_length $traj]
	for {set i 0} {$i < $len} {incr i} {
		set pt [list]
		set tmp [attractor_pt_x_get $hd]
		for {set j 0} {$j < $dim} {incr j} {
			lappend pt [doubleArray_getitem $tmp $j]
		}
		lappend ans $pt
		set hd [attractor_pt_next_get $hd]
	}
	return $ans
}
