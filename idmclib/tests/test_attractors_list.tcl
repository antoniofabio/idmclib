#!/bin/sh
# \
exec tclsh "$0" ${1+"$@"}

source attractors_lists_init.tcl

set attr1 [mktraj { { -1 -1 } { 1 1 } { 0 0 } }]
if {!([attractor_length $attr1] == 3)} {error "unexpected attractor length"}

set x [list2array {0 0}]
set y [list2array {-10 10}]
set bool1 [attractor_check_point $attr1 $x 0.1]
if {!$bool1} {error "unexpected attractor_check_point result"}
set bool1 [attractor_check_point $attr1 $y 0.1]
if {$bool1} {error "unexpected attractor_check_point result"}

attractor_free $attr1

set attr1 [mktraj { { -1 -1 } { 1 1 } { 0 0 } }]
set attr2 [mktraj { { -2 -2 } { 2 2 } }]
attractors_list_add $attr1 $attr2
if {[attractors_list_length $attr1] != 2} {error "unexpected attractors list length"}
attractors_list_merge $attr1 0 1
if {[attractors_list_length $attr1] != 1} {error "unexpected attractors list length"}
set attr [attractors_list_get $attr1 0]
if {$attr != $attr1} {error "unexpected merge behaviour"}
if {[attractor_length $attr] != 5} {error "unexpected attractor length"}
attractors_list_free $attr1

set attr1 [mktraj { { -1 -1 } { 1 1 } { 0 0 } }]
set attr2 [mktraj { { -2 -2 } { 2 2 } }]
set id [attractors_list_check_point $attr1 [list2array {2 2}] 0.1]
if {$id != 1} {error "unexpected attractors_list_check_point result"}
set id [attractors_list_check_point $attr1 [list2array {2 2}] 2.1]
if {$id != 0} {error "unexpected attractors_list_check_point result"}
traj2list $attr1
attractors_list_add $attr1 $attr2
attractors_list_add $attr2 [set attr3 [mktraj { { -3 -3 } }] ]
attractors_list_merge $attr1 0 1
if {[attractors_list_length $attr1] != 2} {error "unexpected attractors list length"}
traj2list $attr1
traj2list $attr3
if {[attr_lst_next_get $attr1] != $attr3} {error "unexpected attractors list structure"}
attractors_list_free $attr1
