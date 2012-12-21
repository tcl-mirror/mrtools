# This software is copyrighted 2012 by G. Andrew Mangogna.
# The following terms apply to all files associated with the software unless
# explicitly disclaimed in individual files.
# 
# The authors hereby grant permission to use, copy, modify, distribute,
# and license this software and its documentation for any purpose, provided
# that existing copyright notices are retained in all copies and that this
# notice is included verbatim in any distributions. No written agreement,
# license, or royalty fee is required for any of the authorized uses.
# Modifications to this software may be copyrighted by their authors and
# need not follow the licensing terms described here, provided that the
# new terms are clearly indicated on the first page of each file where
# they apply.
# 
# IN NO EVENT SHALL THE AUTHORS OR DISTRIBUTORS BE LIABLE TO ANY PARTY FOR
# DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING
# OUT OF THE USE OF THIS SOFTWARE, ITS DOCUMENTATION, OR ANY DERIVATIVES
# THEREOF, EVEN IF THE AUTHORS HAVE BEEN ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
# 
# THE AUTHORS AND DISTRIBUTORS SPECIFICALLY DISCLAIM ANY WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT.  THIS SOFTWARE
# IS PROVIDED ON AN "AS IS" BASIS, AND THE AUTHORS AND DISTRIBUTORS HAVE
# NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS,
# OR MODIFICATIONS.
# 
# GOVERNMENT USE: If you are acquiring this software on behalf of the
# U.S. government, the Government shall have only "Restricted Rights"
# in the software and related documentation as defined in the Federal
# Acquisition Regulations (FARs) in Clause 52.227.19 (c) (2).  If you
# are acquiring the software on behalf of the Department of Defense,
# the software shall be classified as "Commercial Computer Software"
# and the Government shall have only "Restricted Rights" as defined in
# Clause 252.227-7013 (c) (1) of DFARs.  Notwithstanding the foregoing,
# the authors grant the U.S. Government and others acting in its behalf
# permission to use and distribute the software in accordance with the
# terms specified in this license.
#
#*++
# PROJECT:
#   mrtools
#
# MODULE:
#   oomoore.tcl -- object oriented state machine definitions and dispatch
#
# ABSTRACT:
#   This file contains a Tcl script extension that allows Moore type
#   state models to be defined, state machine instances to be created
#   and a primative dispatch mechanism all in terms of TclOO.
#
#*--
#
package require Tcl 8.6
package require logger

namespace eval ::oomoore {
    namespace export statemodel
    namespace export generate
    namespace export delayed
    namespace export qwait
    namespace ensemble create

    ::logger::initNamespace [namespace current] info

    variable revision 1.0

    variable eventQueue [list]
}

if {[llength [info procs ::oo::Helpers::classvar]] == 0} {
    proc ::oo::Helpers::classvar {name args} {
        # Get reference to classs namespace
        set ns [info object namespace [uplevel 1 {self class}]]

        # Double up the list of varnames
        set vs [list $name $name]
        foreach v $args {lappend vs $v $v}

        # Link the callers locals to the
        # classs variables
        tailcall namespace upvar $ns {*}$vs
    }
}

# Meta class
::oo::class create ::oomoore::statemodel {
    superclass ::oo::class

    constructor {model} {
        my variable transitions
        array set transitions {}
        my variable states
        set states [list]
        my variable events
        set events [list]
        my variable defaulttrans
        set defaulttrans CH

        my eval $model

        foreach s $states {
            foreach e $events {
                if {![info exists transitions($s,$e)]} {
                    set transitions($s,$e) $defaulttrans
                }
            }
        }
        my variable initialstate
        if {![info exists initialstate]} {
            set initialstate [lindex $states 0]
        }

        define [self] constructor {{startState {}}} {
            my variable currentState
            if {$startState eq {}} {
                classvar initialstate
                set currentState $initialstate
            } else {
                set currentState $startState
            }
            set log [::logger::init oomoore[self]]
            ::logger::import -namespace log oomoore[self]
            ${log}::setlevel info
        }

        define [self] method receive {event args} {
            my variable currentState
            classvar transitions
            set newState $transitions($currentState,$event)
            log::info "Transition: $currentState - $event \{$args\} ->\
                    $newState"
            if {$newState eq "CH"} {
                set msg "can't happen transition: $currentState - $event -> CH"
                log::error $msg
                throw {OOMOORE CH_TRANSITION {can't happen transition}}\
                    $msg
            } elseif {$newState ne "IG"} {
                set currentState $newState
                my STATE_$newState {*}$args
            }
        }

        define [self] method force {state args} {
            my variable currentState
            log::info "Force: $currentState -> $state"
            set currentState $state
            my STATE_$newState {*}$args
        }

        define [self] method generate {event -> target args} {
            ::oomoore::PostEventQueue [dict create\
                Src [self]\
                Target $target\
                Event $event\
                Params $args\
            ]
        }

        define [self] method delayed {time event -> target args} {
            return [::after $time [list ::oomoore::PostEventQueue [dict create\
                Src [self]\
                Target $target\
                Event $event\
                Params $args\
            ]]]
        }
    }

    method State {name argList body} {
        my variable states
        if {$name ni $states} {
            lappend states $name
            oo::define [self] method STATE_$name $argList $body
        } else {
            throw {OOMOORE DUPLICATE_STATE {duplicate state}}\
                "duplicate state, \"$name\""
        }
    }

    method Transition {current - event -> new} {
        my variable events
        if {$event ni $events} {
            lappend events $event
        }
        my variable transitions
        if {[info exists transitions($current,$event)]} {
            throw {OOMOORE DUPLICATE_TRANS {duplicate transition}}\
                "duplicate transition, \"$current - $event -> $new\""
        } else {
            set transitions($current,$event) $new
        }
    }

    method DefaultTrans {trans} {
        if {$trans eq "IG" || $trans eq "CH"} {
            my variable defaulttrans
            set defaulttrans $trans
        } else {
            throw {OOMOORE BAD_DEFAULT_TRANS {unknown transition name}}\
                "unknown transition name, \"$trans\": must be one of\
                    \"IG\" or \"CH\""
        }
    }

    method InitialState {state} {
        my variable initialstate
        set initialstate $state
    }
}

proc ::oomoore::generate {event -> target args} {
    PostEventQueue [dict create\
        Src {}\
        Target [Qualify $target 2]\
        Event $event\
        Params $args\
    ]
    return
}

proc ::oomoore::delayed {time event -> target args} {
    return [::after $time [list ::oomoore::PostEventQueue [dict create\
        Src {}\
        Target [Qualify $target 2]\
        Event $event\
        Params $args\
    ]]]
}

proc ::oomoore::qwait {{to 0} {block true}} {
    set ns [namespace current]
    if {$block} {
        set tmr [after $to ${ns}::Dispatch]
        vwait ${ns}::qsync
        after cancel $tmr
    } else {
        Dispatch
    }
    return
}

###################################
#
# Private namespace procs
#
###################################

proc ::oomoore::Qualify {cmdName level} {
    if {[string range $cmdName 0 1] ne {::}} {
        set ns [uplevel $level namespace current]
        set cmdName [expr {$ns ne {::} ? "${ns}::$cmdName" : "::$cmdName"}]
    }
    return $cmdName
}

proc ::oomoore::PostEventQueue {event} {
    log::info "Generate: [list [dict get $event Src]] -\
            [dict get $event Event] \{[dict get $event Params]\}\
            -> [dict get $event Target]"
    variable eventQueue
    if {[dict get $event Src] ne [dict get $event Target]} {
        # Non-self directed are added to the end of the queue
        lappend eventQueue $event
    } else {
        # Self directed are inserted at the first place in the
        # queue where the source and target are not the same.
        for {set index 0} {$index < [llength $eventQueue]} {incr index} {
            set item [lindex $eventQueue $index]
            dict with item {
                if {$Src ne $Target} {
                    break
                }
            }
        }
        set eventQueue [linsert $eventQueue $index $event]
    }
    if {[llength $eventQueue] == 1} {
        after 0 ::oomoore::Dispatch
    }
    return
}

proc ::oomoore::Dispatch {} {
    variable eventQueue
    while {[llength $eventQueue]} {
        set event [lindex $eventQueue 0]
        set eventQueue [lrange $eventQueue 1 end]
        dict with event {
            try {
                $Target receive $Event {*}$Params
            } on error {result opts} {
                # If we have an error, we do not continue in the dispatch
                # loop and need to make sure that we will go back and look
                # at the event queue at some point.
                after 0 ::oomoore::Dispatch
                return -options $opts $result
            }
        }
    }
    set [namespace current]::qsync 1
    return
}

package provide oomoore $::oomoore::revision
