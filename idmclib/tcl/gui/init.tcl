switch $::tcl_platform(platform) {
    unix {load ../tclidmclib.so}
    windows {load ../tclidmclib.dll}
}

proc myfread {fname} {
	set fin [open $fname r]
	set ans [read $fin]
	close $fin
	return $ans
}

source "./attractor_util.tcl"
