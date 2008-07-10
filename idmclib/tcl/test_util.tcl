proc safe_model_alloc {buffer} {
	set m [model_alloc $buffer]
	set msg [idmc_model_errorMessage_get $m]
	if { $msg != "" } {
		error $msg
	}
	return $m
}

proc stopifnot {condition} {
	if "!($condition)" {
		error "error: `$condition' is false"
	}
}

proc stopifne {a b} {
	if {[string compare $a $b]} {
		error "error: $a != $b"
	}
}
