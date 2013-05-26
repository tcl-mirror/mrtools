# This software is copyrighted 2013 by G. Andrew Mangogna.
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
#   and an event dispatch mechanism all in terms of TclOO.
#
#*--
#
package require Tcl 8.6
# The tcllib uevent package is used to generate events to the state
# machines.
package require uevent
# Transitions are logged with the logger package at the info level.
package require logger

package require oo::util
# The mixin of "oo::class.Delegate", interacts badly with meta-classes that
# have constructor arguments. So we eliminate the oo::class mixins here. This
# will mean that you can't define class methods.
::oo::define oo::class self mixin

namespace eval ::oomoore {
    namespace export model
    namespace ensemble create

    ::logger::initNamespace [namespace current]

    variable revision 1.0
}

# The ::oomoore::model class is a meta-class. The intended use is to
# create a model class, define the states, transitions, etc and then
# use that class as a superclass to add state behavior to a class.
::oo::class create ::oomoore::model {
    superclass ::oo::class

    constructor {model} {
        # Class level variables. These hold the states, events and
        # transitions, etc. All objects of an ::oomoore::model class
        # have the same state behavior.
        my variable transitions
        array set transitions {}
        my variable states
        set states [list]
        my variable events
        set events [list]
        my variable defaulttrans
        set defaulttrans CH

        # Link the unexported methods to ordinary commands. This forms
        # the model configuration mini-language.
        link\
            {state State}\
            {transition Transition}\
            {defaultTrans DefaultTrans}\
            {initialState InitialState}

        # Build the data structures needed for the event dispatch.
        my eval $model

        # Check that the model was defined correctly and consistently.
        foreach s $states {
            foreach e $events {
                if {[info exists transitions($s,$e)]} {
                    if {$transitions($s,$e) ni $states} {
                        throw [list OOMOORE UNKNOWN_STATE $transitions($s,$e)]\
                            "unknown destination state in transition,\
                            \"$s - $e -> $transitions($s,$e)\""
                    }
                } else {
                    set transitions($s,$e) $defaulttrans
                }
            }
        }
        # Define the inital state or check the definition provided.
        my variable initialstate
        if {[info exists initialstate]} {
            if {$initialstate ni $states} {
                throw [list OOMOORE UNKNOWN_STATE $initialstate]\
                        "unknown initial state, \"$initialstate\""
            }
        } else {
            set initialstate [lindex $states 0]
        }

        # Now define the methods that the instances will have.
        define [self] constructor {{startState {}}} {
            my variable currentState
            classvariable states
            if {$startState eq {}} {
                classvariable initialstate
                set currentState $initialstate
            } elseif {$startState ni $states} {
                set msg "unknown initial state, \"$startState\""
                log::error $msg
                throw [list OOMOORE UNKNOWN_STATE $startState] $msg
            } else {
                set currentState $startState
            }

            my variable evttoken
            set evttoken [::uevent bind [self] dispatch [mymethod Dispatch]]

            set log [::logger::init oomoore[self]]
            ::logger::import -all -namespace log oomoore[self]
            log::setlevel warn
        }

        define [self] destructor {
            my variable evttoken
            ::uevent unbind $evttoken
        }

        # Receive an event synchronously.
        define [self] method receive {event args} {
            my ValidateEvent $event

            my variable currentState
            classvariable transitions
            set newState $transitions($currentState,$event)

            log::info "Transition: [self]: $currentState - $event \{$args\} ->\
                    $newState"
            if {$newState eq "CH"} {
                set msg "can't happen transition: $currentState - $event -> CH"
                log::error $msg
                throw [list OOMOORE CH_TRANSITION $currentState $event] $msg
            } elseif {$newState ne "IG"} {
                set currentState $newState
                my STATE_$newState {*}$args
            }
        }

        # Force a machine to a given state, executing its action.
        define [self] method force {state args} {
            my variable currentState
            log::info "Force: $currentState -> $state"
            set currentState $state
            my STATE_$newState {*}$args
        }

        # Signal an event.
        define [self] method signal {event args} {
            my ValidateEvent $event
            ::uevent generate [self] dispatch [list $event $args]
        }

        # Signal an event after some time.
        define [self] method delayedSignal {time event args} {
            my ValidateEvent $event
            return [::after $time [list ::uevent generate [self] dispatch\
                    [list $event $args]]]
        }

        # Control the logging level.
        define [self] method loglevel {{level {}}} {
            set currlevel [log::currentloglevel]
            if {$level ne {}} {
                log::setlevel $level
                set currlevel $level
            }
            return $currlevel
        }

        # All signal dispatch comes here.
        # All the real work is done in the receive method.
        define [self] method Dispatch {obj event details} {
            lassign $details event params
            log::info "Dispatch: $event -> [self]"
            my receive $event {*}$params
        }

        define [self] method ValidateEvent {event} {
            classvariable events
            if {$event ni $events} {
                set msg "unknown event, \"$event\""
                log::error $msg
                throw [list OOMOORE UNKNOWN_EVENT $event] $msg
            }
        }
    }

    # Define a state model state.
    method State {name argList body} {
        my variable states
        if {$name ni $states} {
            lappend states $name
            oo::define [self] method STATE_$name $argList $body
        } else {
            throw [list OOMOORE DUPLICATE_STATE $name]\
                "duplicate state, \"$name\""
        }
    }

    # Define a state model transition
    # The "-" and "->" parameters are syntactic sugar.
    method Transition {current - event -> new} {
        my variable events
        if {$event ni $events} {
            lappend events $event
        }
        my variable transitions
        if {[info exists transitions($current,$event)]} {
            throw [list OOMOORE DUPLICATE_TRANS $current $event]\
                "duplicate transition, \"$current - $event\""
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

package provide oomoore $::oomoore::revision
