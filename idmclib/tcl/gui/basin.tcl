#!/bin/sh
#\
exec wish "$0" ${1+"$@"}
source "init.tcl"

#SET ARGUMENTS
set ::fname [lindex $argv 0]

#missing on cmd line: set default values
if {[llength $argv] == 1} {
	lappend argv \"\"
	lappend argv "\"0 1 100\""
	lappend argv "\"0 1 100\""
	lappend argv [list 1e-4 100 100 10 0 1]
	lappend argv "\" \""
	set argv [join $argv " "]
	puts $argv
}

array set ::pEntry [list]
for {set i 0} {$i < [llength [lindex $argv 1]]} {incr i} {set ::pEntry($i) [lindex [lindex $argv 1] $i]}
set ::xrange(0) [lindex [lindex $argv 2] 0]
set ::xrange(1) [lindex [lindex $argv 2] 1]
set ::xrange(2) [lindex [lindex $argv 2] 2]
set ::yrange(0) [lindex [lindex $argv 3] 0]
set ::yrange(1) [lindex [lindex $argv 3] 1]
set ::yrange(2) [lindex [lindex $argv 3] 2]
set ::eps [lindex $argv 4]
set ::ntr [lindex $argv 5]
set ::nit [lindex $argv 6]
set ::ntries [lindex $argv 7]
set ::xvar [lindex $argv 8]
set ::yvar [lindex $argv 9]
array set ::vEntry [list]
for {set i 0} {$i < [llength [lindex $argv 1]]} {incr i} {set ::vEntry($i) [lindex [lindex $argv 10] $i]}
##

set ::fname [lindex $argv 0]
set fin [open $::fname r]
set ::buffer [read $fin]
close $fin

set ::model [set model [model_alloc $::buffer]]
wm title . "Basins of attraction - [idmc_model_name_get $model]"

set ::nvar [idmc_model_var_len_get $model]
set ::npar [idmc_model_par_len_get $model]
set ::varnames [idmc_model_var_get $model]
set ::vnlist [list]
array set ::vids [list]
for {set i 0} {$i < $::nvar} {incr i} {
	lappend ::vnlist [stringArray_getitem  $::varnames $i]
	set ::vids([stringArray_getitem  $::varnames $i]) $i
}

##Init input variables
##

#root: root pane
#m: loaded model object
proc make_left_pane {root m} {
	set tmp root
	set r [ttk::frame $root$tmp]
	grid $r -row 0 -column 0 -sticky nsew
	grid columnconfigure $root 1 -weight 1; grid rowconfigure $root 0 -weight 1
	set sv "$r.sv"
	set c "$r.c"
	set fr "$r.fr"
	set $sv [ttk::scrollbar $sv -orient vertical -command [list $c yview] ]
	set $c [canvas $c -yscrollcommand [list $sv set]]
	grid $c -column 0 -row 0 -sticky nsew
	grid columnconfigure $r 0 -weight 1; grid rowconfigure $r 0 -weight 1
	grid $sv -column 999 -row 0 -sticky ns

	ttk::frame $fr

	grid [ttk::labelframe "$fr.varfr" -text "variables"] -padx 5 -pady 5 -column 0 -row 0 -sticky nsew

	for {set i 0} {$i < $::nvar} {incr i} {
		grid [ttk::label "$fr.varfr.lb$i" -text [lindex $::vnlist $i]] \
			-column 0 -row $i -sticky ew -padx 5 -pady 5
		grid [ttk::entry "$fr.varfr.entry$i" -textvariable ::vEntry($i)] \
			-column 1 -row $i -sticky e -padx 5 -pady 5
	}

	grid [ttk::labelframe $fr.parfr -text "parameters"] -padx 5 -pady 5 -column 0 -row 1 -sticky nsew
	set parnames [idmc_model_par_get $m]
	for {set i 0} {$i < $::npar} {incr i} {
		grid [ttk::label "$fr.parfr.lb$i" -text [stringArray_getitem  $parnames $i]] \
			-column 0 -row $i -sticky ew -padx 5 -pady 5
		grid [ttk::entry "$fr.parfr.entry$i" -textvariable ::pEntry($i)] \
			-column 1 -row $i -sticky e -padx 5 -pady 5
	}

	$c create window 10 10 -window $fr -anchor nw

	update
	$c configure -scrollregion [$c bbox all]
	set tmp [$c bbox all]
	$c configure -width [expr [lindex $tmp 2] - [lindex $tmp 0] ]
}

proc make_right_pane {root m} {
	set tmp root-right
	set r [ttk::frame $root$tmp]
	grid $r -row 0 -column 1 -sticky nsew
	set sv "$r.sv"
	set c "$r.c"
	set fr "$r.fr"
	set $sv [ttk::scrollbar $sv -orient vertical -command [list $c yview] ]
	set $c [canvas $c -yscrollcommand [list $sv set]]
	grid $c -column 0 -row 0 -sticky nsew
	grid columnconfigure $r 0 -weight 1; grid rowconfigure $r 0 -weight 1
	grid $sv -column 999 -row 0 -sticky ns

	ttk::frame $fr

	grid [ttk::labelframe "$fr.axfr" -text "axes"] -padx 5 -pady 5 -column 0 -row 2 -sticky nsew
	set ::xvarDisplay [lindex $::vnlist 0]
	grid [ttk::label "$fr.axfr.lbxv" -text "x axis"] \
		-column 0 -row 2 -sticky ew -padx 5 -pady 5
	grid [ttk::combobox "$fr.axfr.entryXv" -state readonly -textvariable ::xvarDisplay] \
		-column 1 -row 2 -sticky e -padx 5 -pady 5
	"$fr.axfr.entryXv" configure -values $::vnlist
	bind "$fr.axfr.entryXv" <<ComboboxSelected>> {
		if {$::xvarDisplay == $::yvarDisplay} {
			set ::xvarDisplay [lindex $::vnlist [expr $::vids($::xvarDisplay) + 1]]
		}
		if {$::xvarDisplay == "" } {set ::xvarDisplay [lindex $::vnlist 0]}
	}

	grid [ttk::label "$fr.axfr.lbxmin" -text "x min"] \
		-column 0 -row 3 -sticky ew -padx 5 -pady 5
	grid [ttk::entry "$fr.axfr.entryXmin" -textvariable ::xrange(0)] \
		-column 1 -row 3 -sticky e -padx 5 -pady 5
	grid [ttk::label "$fr.axfr.lbxmax" -text "x max"] \
		-column 0 -row 4 -sticky ew -padx 5 -pady 5
	grid [ttk::entry "$fr.axfr.entryXmax" -textvariable ::xrange(1)] \
		-column 1 -row 4 -sticky e -padx 5 -pady 5
	grid [ttk::label "$fr.axfr.lbxres" -text "x resolution"] \
		-column 0 -row 5 -sticky ew -padx 5 -pady 5
	grid [ttk::entry "$fr.axfr.entryXres" -textvariable ::xrange(2)] \
		-column 1 -row 5 -sticky e -padx 5 -pady 5

	set ::yvarDisplay [lindex $::vnlist 1]
	grid [ttk::label "$fr.axfr.lbyv" -text "y axis"] \
		-column 0 -row 6 -sticky ew -padx 5 -pady 5
	grid [ttk::combobox "$fr.axfr.entryYv" -state readonly -textvariable ::yvarDisplay] \
		-column 1 -row 6 -sticky e -padx 5 -pady 5
	"$fr.axfr.entryYv" configure -values $::vnlist
	bind "$fr.axfr.entryYv" <<ComboboxSelected>> {
		if {$::xvarDisplay == $::yvarDisplay} {
			set ::yvarDisplay [lindex $::vnlist [expr $::vids($::yvarDisplay) + 1]]
		}
		if {$::yvarDisplay == "" } {set ::yvarDisplay [lindex $::vnlist 0]}
	}

	grid [ttk::label "$fr.axfr.lbymin" -text "y min"] \
		-column 0 -row 7 -sticky ew -padx 5 -pady 5
	grid [ttk::entry "$fr.axfr.entryYmin" -textvariable ::yrange(0)] \
		-column 1 -row 7 -sticky e -padx 5 -pady 5
	grid [ttk::label "$fr.axfr.lbymax" -text "y max"] \
		-column 0 -row 8 -sticky ew -padx 5 -pady 5
	grid [ttk::entry "$fr.axfr.entryYmax" -textvariable ::yrange(1)] \
		-column 1 -row 8 -sticky e -padx 5 -pady 5
	grid [ttk::label "$fr.axfr.lbyres" -text "y resolution"] \
		-column 0 -row 9 -sticky ew -padx 5 -pady 5
	grid [ttk::entry "$fr.axfr.entryYres" -textvariable ::yrange(2)] \
		-column 1 -row 9 -sticky e -padx 5 -pady 5

	grid [ttk::labelframe "$fr.algfr" -text "algorithm"] -padx 5 -pady 5 -column 0 -row 3 -sticky nsew
	grid [ttk::label "$fr.algfr.lbNit" -text "iterations"] \
		-column 0 -row 0 -sticky ew -padx 5 -pady 5
	grid [ttk::entry "$fr.algfr.entryNit" -textvariable ::nit] \
		-column 1 -row 0 -sticky e -padx 5 -pady 5
	grid [ttk::label "$fr.algfr.lbTr" -text "transient"] \
		-column 0 -row 1 -sticky ew -padx 5 -pady 5
	grid [ttk::entry "$fr.algfr.entryTr" -textvariable ::ntr] \
		-column 1 -row 1 -sticky e -padx 5 -pady 5
	grid [ttk::label "$fr.algfr.lbNtries" -text "num. tries"] \
		-column 0 -row 2 -sticky ew -padx 5 -pady 5
	grid [ttk::entry "$fr.algfr.entryNtries" -textvariable ::ntries] \
		-column 1 -row 2 -sticky e -padx 5 -pady 5
	grid [ttk::label "$fr.algfr.lbEps" -text "epsilon"] \
		-column 0 -row 3 -sticky ew -padx 5 -pady 5
	grid [ttk::entry "$fr.algfr.entryEps" -textvariable ::eps] \
		-column 1 -row 3 -sticky e -padx 5 -pady 5

	$c create window 10 10 -window $fr -anchor nw

	update
	$c configure -scrollregion [$c bbox all]
	set tmp [$c bbox all]
	$c configure -width [expr [lindex $tmp 2] - [lindex $tmp 0] ]
}

make_left_pane . $model
make_right_pane . $model
grid [ttk::frame .frmBttns] -row 1 -column 0 -columnspan 2 -sticky sew
grid [ttk::button .frmBttns.bttnDraw -text Draw -command onDraw] -row 0 -column 0 -padx 5 -pady 5 -sticky e
grid columnconfigure .frmBttns 0 -weight 1; grid columnconfigure .frmBttns 1 -weight 1
grid rowconfigure .frmBttns 0 -weight 1

#call find_attractors, plot results by gnuplot
proc onDraw {} {
	#pack command line arguments in one list
	lappend faargs $::fname
	lappend faargs tmpimg.dat
	set tmp [list]
	for {set i 0} {$i < $::npar} {incr i} {
		lappend tmp $::pEntry($i)
	}
	lappend faargs "\"[join $tmp " "]\""
	lappend faargs "\"$::xrange(0) $::xrange(1) $::xrange(2)\""
	lappend faargs "\"$::yrange(0) $::yrange(1) $::yrange(2)\""
	lappend faargs $::eps
	lappend faargs $::ntr
	lappend faargs $::nit
	lappend faargs $::ntries
	lappend faargs $::vids($::xvarDisplay)
	lappend faargs $::vids($::yvarDisplay)
	set tmp [list]
	for {set i 0} {$i < $::nvar} {incr i} {
		lappend tmp $::vEntry($i)
	}
	lappend faargs "\"[join $tmp " "]\""
	##

##execute '../basin.tcl' script, get results
	set faargs [join $faargs " "]
	puts $faargs
	set ::fa [open "|tclsh ./basin_multi.tcl $faargs" r+]
	set ans [gets $::fa]
	puts "[llength $ans] attractors found"
#	tk_messageBox -icon info -message "Found [llength $ans] attractors"

##write attractors data in tmp files
	set cmdlst [list]
	for {set i 0} {$i < [llength $ans]} {incr i} {
		set ca [lindex $ans $i]
		set tf [open tmp$i.dat w]
		for {set j 0} {$j < [llength $ca]} {incr j} {
			puts $tf [join [lindex $ca $j]]
		}
		close $tf
		lappend cmdlist "\"tmp$i.dat\" using [expr $::xvar + 1] : [expr $::yvar + 1]"
	}
##
#Write attractors cmd data in tmp file
	set cmdf [open tmp.gp w]
	puts $cmdf "set nokey"
	puts $cmdf "set xlabel \"[lindex $::vnlist $::xvar]\""
	puts $cmdf "set ylabel \"[lindex $::vnlist $::yvar]\""
	puts $cmdf "set title \"[idmc_model_name_get $::model]\""
	puts $cmdf "set xrange \[$::xrange(0):$::xrange(1)\]"
	puts $cmdf "set yrange \[$::yrange(0):$::yrange(1)\]"
	puts $cmdf "plot [join $cmdlist {, }]"
	close $cmdf
##
#Plot attractors
	exec gnuplot -persist tmp.gp &
##

#Whait for attractors computation to be complete
	doOneStep
##
}

proc doOneStep {} {
	if { ![eof $::fa] } {
			##TODO: Dialog with progress bar
			puts [gets $::fa]
			after idle [list after 0 doOneStep]
	} else {
		#FIXME: convert code numbers into r,g,b triplets
		set tf [open tmpimg.dat r]
		while {![eof $tf]} {gets $tf}
		close $tf
	#Write image cmd data in tmp file
		set cmdf [open tmp.gp w]
		puts $cmdf "set nokey"
		puts $cmdf "set xlabel \"[lindex $::vnlist $::xvar]\""
		puts $cmdf "set ylabel \"[lindex $::vnlist $::yvar]\""
		puts $cmdf "set title \"[idmc_model_name_get $::model]\""
		puts $cmdf "set xrange \[$::xrange(0):$::xrange(1)\]"
		puts $cmdf "set yrange \[$::yrange(0):$::yrange(1)\]"
		puts $cmdf "plot \"tmpimg.dat\" with image"
		close $cmdf
	##
	#Plot image
		exec gnuplot -persist tmp.gp &
	##
	}
	return
}
