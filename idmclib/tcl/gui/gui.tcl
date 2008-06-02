#!/bin/sh
#\
exec wish "$0" ${1+"$@"}
source "init.tcl"

set ::buffer ""
set ::modelFileName ""
set ::model ""
set ::modelName ""
set ::modelVariables ""
set ::modelParameters ""

proc myfread {fname} {
	set fin [open $fname r]
	set ans [read $fin]
	close $fin
	return $ans
}

proc setModelTxt {txt} {
	.m.modelTxtLbl configure -state normal
	.m.modelTxtLbl delete  1.0 end
	.m.modelTxtLbl insert end $txt
	.m.modelTxtLbl configure -state disabled
}

wm title . "iDMC"

option add *tearOff 0
menu .mbar
. config -menu .mbar

#The Main Buttons
.mbar add cascade -label "File" -underline 0 -menu [menu .mbar.file]
.mbar add cascade -label "Model" -underline 0 -menu [menu .mbar.model]
.mbar add cascade -label "Help" -underline 0 -menu [menu .mbar.help]

## File Menu ##
set m .mbar.file
$m add command -label "Open" -underline 0 -command onOpen
$m add separator
$m add command -label "Quit" -underline 0 -command onQuit

## Model Menu ##
set m .mbar.model
$m add command -label "Trajectory" -underline 0 -command onTrajectory

## Help Menu ##
set m .mbar.help
$m add command -label "About" -underline 0 -command onAbout

##Layout
ttk::frame .m
ttk::frame .m.topFrame
grid [ttk::label .m.topFrame.mNameLabel -text "Name:"] -column 0 -row 0 -sticky w -padx 5 -pady 5
grid [ttk::entry .m.topFrame.mNameEntry -textvariable ::modelName -state readonly] -column 1 -row 0 -sticky w \
	-padx 5 -pady 5
grid [ttk::label .m.topFrame.mVariablesLabel -text "Variables:"] -column 0 -row 1 -sticky w -padx 5 -pady 5
grid [ttk::entry .m.topFrame.mVariablesEntry -textvariable ::modelVariables -state readonly] -column 1 -row 1 -sticky w \
	-padx 5 -pady 5
grid [ttk::label .m.topFrame.mParametersLabel -text "Parameters:"] -column 0 -row 2 -sticky w -padx 5 -pady 5
grid [ttk::entry .m.topFrame.modelParametersLbl -textvariable ::modelParameters -state readonly] -column 1 -row 2 -sticky w \
	-padx 5 -pady 5

grid .m -sticky nwse
grid .m.topFrame -column 0 -row 0 -sticky nwse
grid columnconfigure . 0 -weight 1; grid rowconfigure . 0 -weight 1
grid columnconfigure .m 0 -weight 1; grid rowconfigure .m 1 -weight 1
grid [text .m.modelTxtLbl] -column 0 -row 1 -sticky nwse
grid [ttk::scrollbar .m.sbv -command [list .m.modelTxtLbl yview] \
	-orient vertical] -column 1 -row 1 -sticky ns
grid [ttk::scrollbar .m.sbh -command [list .m.modelTxtLbl xview] -orient horizontal] \
	-column 0 -row 2 -sticky we
.m.modelTxtLbl configure -state disabled -wrap none \
	-xscrollcommand [list .m.sbh set] -yscrollcommand [list .m.sbv set]
grid [ttk::sizegrip .m.sz] -column 1 -row 2 -sticky se

##Event procedures
proc onOpen {} {
	set ::modelFileName [tk_getOpenFile]
	if {$::modelFileName != ""} {
		set ::buffer [myfread $::modelFileName]
		set ::model [model_alloc $::buffer]
		set ::modelName [idmc_model_name_get $::model]
		set ::modelVariables ""
		wm title . "iDMC - $::modelName"
		setModelTxt $::buffer
		for { set i 0 } { $i < [idmc_model_var_len_get $::model] } { incr i } {
			set ::modelVariables "$::modelVariables [stringArray_getitem [idmc_model_var_get $::model] $i]"
		}
		set ::modelParameters ""
		for { set i 0 } { $i < [idmc_model_par_len_get $::model] } { incr i } {
			set ::modelParameters "$::modelParameters [stringArray_getitem [idmc_model_par_get $::model] $i]"
		}
		trans_noModel_model
	}
}

proc onQuit {} {
	exit
}

proc onTrajectory {} {
	[interp create] eval "
	package require Tk
	set argv $::modelFileName
	source trajectory.tcl "
}

proc onAbout {} {
	tk_messageBox -message "idmclib\
 [idmc_version_major].[idmc_version_minor].[idmc_version_micro]\n\
 Tcl/Tk GUI" -type ok -icon info
}

proc trans_init {} {
	.mbar.model entryconfigure Trajectory -state disabled
}

proc trans_noModel_model {} {
	.mbar.model entryconfigure Trajectory -state active
}

##INIT
trans_init
