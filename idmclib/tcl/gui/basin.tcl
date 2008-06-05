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

set ::inputCtrls [list]
set ::comboCtrls [list]

#root: root pane
#m: loaded model object
proc make_right_pane {root m} {
	set tmp root
	set r [ttk::frame $root$tmp]
	grid $r -row 0 -column 1 -sticky nsew
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
		lappend ::inputCtrls [ttk::entry "$fr.varfr.entry$i" -textvariable ::vEntry($i)]
		grid  [lindex $::inputCtrls end] \
			-column 1 -row $i -sticky e -padx 5 -pady 5
	}

	grid [ttk::labelframe $fr.parfr -text "parameters"] -padx 5 -pady 5 -column 0 -row 1 -sticky nsew
	set parnames [idmc_model_par_get $m]
	for {set i 0} {$i < $::npar} {incr i} {
		grid [ttk::label "$fr.parfr.lb$i" -text [stringArray_getitem  $parnames $i]] \
			-column 0 -row $i -sticky ew -padx 5 -pady 5
		lappend ::inputCtrls [ttk::entry "$fr.parfr.entry$i" -textvariable ::pEntry($i)]
		grid [lindex $::inputCtrls end] \
			-column 1 -row $i -sticky e -padx 5 -pady 5
	}

	$c create window 10 10 -window $fr -anchor nw

	update
	$c configure -scrollregion [$c bbox all]
	set tmp [$c bbox all]
	$c configure -width [expr [lindex $tmp 2] - [lindex $tmp 0] ]
}

proc make_left_pane {root m} {
	set tmp root-right
	set r [ttk::frame $root$tmp]
	grid $r -row 0 -column 0 -sticky nsew
	set sv "$r.sv"
	set c "$r.c"
	set fr "$r.fr"
	set $sv [ttk::scrollbar $sv -orient vertical -command [list $c yview] ]
	set $c [canvas $c -yscrollcommand [list $sv set]]
	grid $c -column 0 -row 0 -sticky nsew
	grid columnconfigure $r 0 -weight 1; grid rowconfigure $r 0 -weight 1
	grid $sv -column 999 -row 0 -sticky ns

	ttk::frame $fr

	grid [ttk::labelframe "$fr.algfr" -text "algorithm"] -padx 5 -pady 5 -column 0 -row 0 -sticky nsew
	grid [ttk::label "$fr.algfr.lbNit" -text "iterations"] \
		-column 0 -row 0 -sticky ew -padx 5 -pady 5
	lappend ::inputCtrls [ttk::entry "$fr.algfr.entryNit" -textvariable ::nit]
	grid [lindex $::inputCtrls end] \
		-column 1 -row 0 -sticky e -padx 5 -pady 5
	grid [ttk::label "$fr.algfr.lbTr" -text "transient"] \
		-column 0 -row 1 -sticky ew -padx 5 -pady 5
	lappend ::inputCtrls [ttk::entry "$fr.algfr.entryTr" -textvariable ::ntr]
	grid [lindex $::inputCtrls end] \
		-column 1 -row 1 -sticky e -padx 5 -pady 5
	grid [ttk::label "$fr.algfr.lbNtries" -text "num. tries"] \
		-column 0 -row 2 -sticky ew -padx 5 -pady 5
	lappend ::inputCtrls [ttk::entry "$fr.algfr.entryNtries" -textvariable ::ntries]
	grid [lindex $::inputCtrls end] \
		-column 1 -row 2 -sticky e -padx 5 -pady 5
	grid [ttk::label "$fr.algfr.lbEps" -text "epsilon"] \
		-column 0 -row 3 -sticky ew -padx 5 -pady 5
	lappend ::inputCtrls [ttk::entry "$fr.algfr.entryEps" -textvariable ::eps]
	grid [lindex $::inputCtrls end] \
		-column 1 -row 3 -sticky e -padx 5 -pady 5

	grid [ttk::labelframe "$fr.axfr" -text "axes"] -padx 5 -pady 5 -column 0 -row 1 -sticky nsew
	set ::xvarDisplay [lindex $::vnlist 0]
	grid [ttk::label "$fr.axfr.lbxv" -text "x axis"] \
		-column 0 -row 2 -sticky ew -padx 5 -pady 5
	lappend ::comboCtrls [ttk::combobox "$fr.axfr.entryXv" \
		-state readonly -textvariable ::xvarDisplay]
	grid [lindex $::comboCtrls end] \
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
	lappend ::inputCtrls [ttk::entry "$fr.axfr.entryXmin" -textvariable ::xrange(0)]
	grid [lindex $::inputCtrls end] \
		-column 1 -row 3 -sticky e -padx 5 -pady 5
	grid [ttk::label "$fr.axfr.lbxmax" -text "x max"] \
		-column 0 -row 4 -sticky ew -padx 5 -pady 5
	lappend ::inputCtrls [ttk::entry "$fr.axfr.entryXmax" -textvariable ::xrange(1)]
	grid [lindex $::inputCtrls end] \
		-column 1 -row 4 -sticky e -padx 5 -pady 5
	grid [ttk::label "$fr.axfr.lbxres" -text "x resolution"] \
		-column 0 -row 5 -sticky ew -padx 5 -pady 5
	lappend ::inputCtrls [ttk::entry "$fr.axfr.entryXres" -textvariable ::xrange(2)]
	grid [lindex $::inputCtrls end] \
		-column 1 -row 5 -sticky e -padx 5 -pady 5

	set ::yvarDisplay [lindex $::vnlist 1]
	grid [ttk::label "$fr.axfr.lbyv" -text "y axis"] \
		-column 0 -row 6 -sticky ew -padx 5 -pady 5
	lappend ::comboCtrls [ttk::combobox "$fr.axfr.entryYv" \
		-state readonly -textvariable ::yvarDisplay]
	grid [lindex $::comboCtrls end] \
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
	lappend ::inputCtrls [ttk::entry "$fr.axfr.entryYmin" -textvariable ::yrange(0)]
	grid [lindex $::inputCtrls end] \
		-column 1 -row 7 -sticky e -padx 5 -pady 5
	grid [ttk::label "$fr.axfr.lbymax" -text "y max"] \
		-column 0 -row 8 -sticky ew -padx 5 -pady 5
	lappend ::inputCtrls [ttk::entry "$fr.axfr.entryYmax" -textvariable ::yrange(1)]
	grid  [lindex $::inputCtrls end] \
		-column 1 -row 8 -sticky e -padx 5 -pady 5
	grid [ttk::label "$fr.axfr.lbyres" -text "y resolution"] \
		-column 0 -row 9 -sticky ew -padx 5 -pady 5
	lappend ::inputCtrls [ttk::entry "$fr.axfr.entryYres" -textvariable ::yrange(2)]
	grid  [lindex $::inputCtrls end] \
		-column 1 -row 9 -sticky e -padx 5 -pady 5

	$c create window 10 10 -window $fr -anchor nw

	update
	$c configure -scrollregion [$c bbox all]
	set tmp [$c bbox all]
	$c configure -width [expr [lindex $tmp 2] - [lindex $tmp 0] ]
}

make_left_pane . $model
make_right_pane . $model
grid [ttk::frame .frmBttns] -row 1 -column 0 -columnspan 2 -sticky sew
grid [ttk::button .frmBttns.bttnDraw -text Start -command onStart] -row 0 -column 0 -padx 5 -pady 5 -sticky w
grid [ttk::button .frmBttns.bttnStop -text Stop -command onStop] -row 0 -column 1 -padx 5 -pady 5 -sticky w
grid [ttk::progressbar .frmBttns.progress -orient horizontal -length 150 -mode determinate] -row 0 -column 2 -padx 5 -pady 5 -sticky e
grid [ttk::frame .statusbar -borderwidth 2 -relief groove] -row 2 -column 0 -columnspan 2 -sticky sew
grid [ttk::label .statusbar.label -borderwidth 1 -relief sunken -width 1 -anchor w] -row 0 -column 0 -sticky nsew
.statusbar.label configure -width [expr [winfo width .statusbar] - 4]
grid columnconfigure .frmBttns 0 -weight 1; grid columnconfigure .frmBttns 1 -weight 1
grid rowconfigure .frmBttns 0 -weight 1

proc onStop {} {
	set ::stop 1
	catch [close $::fa] errmsg
	status_ready2start
}

proc status_ready2start {} {
	set ::stop 0
	foreach wdg $::inputCtrls { $wdg configure -state enabled }
	foreach wdg $::comboCtrls { $wdg configure -state readonly }
	.frmBttns.progress configure -value 0
	.frmBttns.bttnDraw configure -state enabled
	.frmBttns.bttnStop configure -state disabled
	.statusbar.label configure -text "ready"
}

proc status_running {} {
	foreach wdg $::inputCtrls { $wdg configure -state disabled }
	foreach wdg $::comboCtrls { $wdg configure -state disabled }
	.frmBttns.bttnDraw configure -state disabled
	.frmBttns.bttnStop configure -state enabled
	.statusbar.label configure -text "running..."
}

status_ready2start

#call find_attractors, tell how many attractors were found
proc onStart {} {
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

##execute './basin_multi.tcl' script, get attractors
##FIXME: keep GUI alive during this process
	set faargs [join $faargs " "]
	puts $faargs
	set ::fa [open "|tclsh ./basin_multi.tcl $faargs" r+]
	set ans [gets $::fa]
	puts "[llength $ans] attractors found"
#	tk_messageBox -icon info -message "Found [llength $ans] attractors"

##write attractors data in tmp files
	set ::cmdlst [list]
	for {set i 0} {$i < [llength $ans]} {incr i} {
		set ca [lindex $ans $i]
		set tf [open tmp$i.dat w]
		for {set j 0} {$j < [llength $ca]} {incr j} {
			puts $tf [join [lindex $ca $j]]
		}
		close $tf
		lappend ::cmdlist "\"tmp$i.dat\" using [expr $::xvar + 1] : [expr $::yvar + 1]"
	}
##

#Whait for attractors computation to be complete
	status_running
	fileevent $::fa readable doStepB
##
}

##Update basins filling progress indicator
proc doStepB {} {
	if {$::stop} {
		#close $::fa
		status_ready2start
		return
	}
	set line [gets $::fa]
	if { ![eof $::fa] } {
			.frmBttns.progress configure -value [expr 100.0 * $line / ($::xrange(2) * $::yrange(2))]
	} else {
		close $::fa
		set ::imgdatafile [open tmpimg.dat r]
		doStepC
	}
	return
}

##Read back basins data and plot it
proc doStepC {} {
	if {$::stop} {
		status_ready2start
		return
	}
	set line [gets $::imgdatafile]
	#FIXME: convert code numbers into r,g,b triplets
	if {![eof $::imgdatafile]} {
		after idle [list after 0 doStepC]
	} else {
		close $::imgdatafile
		#Write image cmd data in tmp file
		set cmdf [open tmp.gp w]
		puts $cmdf "unset key"
		puts $cmdf "unset colorbox"
		puts $cmdf "set xlabel \"$::xvarDisplay\""
		puts $cmdf "set ylabel \"$::yvarDisplay\""
		puts $cmdf "set title \"[idmc_model_name_get $::model]\""
		puts $cmdf "set xrange \[$::xrange(0):$::xrange(1)\]"
		puts $cmdf "set yrange \[$::yrange(0):$::yrange(1)\]"
		puts $cmdf "plot \"tmpimg.dat\" with image, [join $::cmdlist {, }]"
		close $cmdf
		##
		#Plot image
		exec gnuplot -persist tmp.gp &
		##
		status_ready2start
	}
	return
}
