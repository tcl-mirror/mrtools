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
package require textutil::adjust
package require struct::set

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
        set svcname ::oomoore[self]
        ::logger::init $svcname
        ::logger::import -all -namespace log $svcname

        # Class level variables. These hold the states, events and transitions,
        # etc. All objects created from an ::oomoore::model object have the
        # same state behavior.
        my variable transitions
        array set transitions {}
        my variable states
        set states [list]
        my variable events
        set events [list]
        my variable defaulttrans
        set defaulttrans CH
        my variable delayedSignals
        array set delayedSignals {}

        # Link the unexported methods required to define the state model to
        # ordinary commands that can be used within the "model" specification.
        # This forms the model configuration mini-language. N.B. "link" is an
        # oo::util command.
        link\
            {state State}\
            {transition Transition}\
            {defaultTrans DefaultTrans}\
            {initialState InitialState}

        # Build the data structures needed for the event dispatch.
        my eval $model

        # Check that the model was defined correctly and consistently.
        #
        # Check for isolated states, i.e. those with no inbound or outbound
        # transition. Here we find all the states with no outbound transitions
        # and all those with no inbound transition. The intersection is then
        # the set of isolated states. We start by accumulating as list of
        # states that have outbound or inbound transitions.
        set outstates [list]
        set instates [list]
        foreach {trans dst} [array get transitions] {
            lassign [split $trans ,] src event
            # While we are iterating across the transitions, check that they
            # are consistent with the set of defined states.
            if {$src ni $states} {
                set errmsg "unknown source state in transition,\
                    \"$src - $event -> $dst\""
                log::error $errmsg
                throw [list OOMOORE UNKNOWN_STATE $src] $errmsg
            }
            ::struct::set include outstates $src
            # Skip the non-transitioning pseudo-states of IG and CH
            if {!($dst eq "IG" || $dst eq "CH")} {
                if {$dst ni $states} {
                    set errmsg "unknown destination state in transition,\
                        \"$src - $event -> $dst\""
                    log::error $errmsg
                    throw [list OOMOORE UNKNOWN_STATE $dst] $errmsg
                } else {
                    ::struct::set include instates $dst
                }
            }
        }
        # The set of states with no inbound transitions is then the difference
        # between the set of all states and those that do have inbound
        # transitions. Similarly for outbound transitions.
        set noincoming [::struct::set difference $states $instates]
        set nooutgoing [::struct::set difference $states $outstates]
        # The intersection then determines those states with neither inbound
        # nor outbound transitions, hence isolated.
        set isostates [::struct::set intersect $noincoming $nooutgoing]
        if {![::struct::set empty $isostates]} {
            set errmsg "state model has isolated state(s):\
                    \"[join $isostates {, }]\""
            log::error $errmsg
            throw [list OOMOORE ISOLATED $isostates] $errmsg
        }
        # Fill out the transition matrix completely using the default
        # transition for those transitions not defined explicitly.  This will
        # save some tests during event dispatch.
        foreach s $states {
            foreach e $events {
                if {![info exists transitions($s,$e)]} {
                    set transitions($s,$e) $defaulttrans
                }
            }
        }
        # If it has been defined, check the initial state. Otherwise,
        # we set it to the first state that was lexically defined.
        my variable initialstate
        if {[info exists initialstate]} {
            if {$initialstate ni $states} {
                set errmsg "unknown initial state, \"$initialstate\""
                log::error $errmsg
                throw [list OOMOORE UNKNOWN_STATE $initialstate] $errmsg
            }
        } else {
            set initialstate [lindex $states 0]
        }

        # Now define the methods that the new class will have.
        define [self] {
            constructor {{startState {}}} {
                ::logger::init ::oomoore[self]
                ::logger::import -all -namespace log ::oomoore[self]

                my variable currentState
                classvariable states
                # Set the initial state to that provided or the default if none
                # is provided.
                if {$startState eq {}} {
                    classvariable initialstate
                    set currentState $initialstate
                } elseif {$startState ni $states} {
                    set errmsg "unknown initial state, \"$startState\""
                    log::error $errmsg
                    throw [list OOMOORE UNKNOWN_STATE $startState] $errmsg
                } else {
                    set currentState $startState
                }

                # Set up the uevent package event bindings. We use two
                # different event bindings depending upon whether the event
                # being dispatched is delayed or not.
                my variable evttoken
                set evttoken [::uevent bind [self] event [mymethod Dispatch]]
                my variable delaytoken
                set delaytoken [::uevent bind [self] delayed\
                        [mymethod DelayedDispatch]]
                # We keep a queue of events as a simple list.
                my variable event_queue
                set event_queue [list]
            }

            destructor {
                # Unbind the events used for asynchronous signal delivery.
                my variable evttoken
                ::uevent unbind $evttoken
                my variable delaytoken
                ::uevent unbind $delaytoken
                # Cancel any outstanding delayed signals.
                my variable delayedSignals
                foreach {sigid sigdetails} [array get delayedSignals] {
                    after cancel [lindex $sigdetails 0]
                }
            }

            # Receive an event synchronously. This causes immediate dispatch of
            # the state action as a synchronous procedure invocation.
            method receive {event args} {
                my ValidateEvent $event

                my variable currentState
                classvariable transitions
                set newState $transitions($currentState,$event)

                log::info "Transition: [self]:\
                        $currentState - $event -> $newState"
                if {$newState eq "CH"} {
                    set errmsg "can't happen transition:\
                            $currentState - $event -> CH"
                    log::error $errmsg
                    throw [list OOMOORE CH_TRANSITION $currentState $event]\
                        $errmsg
                } elseif {$newState ne "IG"} {
                    set currentState $newState
                    my __STATE_$newState {*}$args
                }
            }

            # Force a machine to a given state, executing its action.
            method force {state args} {
                my variable currentState
                log::info "Force: $currentState -> $state \{$args\}"
                set currentState $state
                my __STATE_$newState {*}$args
            }

            # Obtain the current state
            method currentstate {} {
                my variable currentState
                return $currentState
            }

            # Signal an event.
            method signal {event args} {
                my ValidateEvent $event
                # Determine the caller of the method. We use this to determine
                # whether the event is self-directed. "self caller" throws
                # an error if the caller is not a method.
                if {[catch {lindex [self caller] 1} src]} {
                    set src {}
                }
                set details [list $src $event $args]
                my variable event_queue
                # Self directed events are queued to the front.
                if {$src eq [self]} {
                    set event_queue [linsert $event_queue 0 $details]
                } else {
                    lappend event_queue $details
                }
                # Prime the event dispatch if this is the first event queued.
                if {[llength $event_queue] == 1} {
                    ::uevent generate [self] event
                }
            }

            # Signal an event after some time.
            method delayedSignal {time event args} {
                if {[catch {lindex [self caller] 1} src]} {
                    set src {}
                }
                # Cancel any existing delayed signal that might have been in
                # place.
                my CancelDelayedSignal $src $event
                my variable delayedSignals
                set timerid [::after $time\
                        [list ::uevent generate [self] delayed\
                        [list $src $event $args]]]
                set expiretime [expr {[clock milliseconds] + $time}]
                set delayedSignals($src,$event) [list $timerid $expiretime]
                return
            }

            # Cancel a delayed signal.
            method cancel {event} {
                if {[catch {lindex [self caller] 1} src]} {
                    set src {}
                }
                return [my CancelDelayedSignal $src $event]
            }

            # Time remaining for a delayed signal
            method remaining {event} {
                if {[catch {lindex [self caller] 1} src]} {
                    set src {}
                }
                my variable delayedSignals
                if {[info exists delayedSignals($src,$event)]} {
                    set expiretime [lindex $delayedSignals($src,$event) 1]
                    set currtime [clock milliseconds]
                    set remaintime [expr {max($expiretime - $currtime, 0)}]
                } else {
                    set remaintime 0
                }
                return $remaintime
            }

            # Control the logging level.
            method loglevel {{level {}}} {
                set currlevel [log::currentloglevel]
                if {$level ne {}} {
                    log::setlevel $level
                    set currlevel $level
                }
                return $currlevel
            }

            #############################
            #
            # Unexported methods
            #
            #############################

            # Dispatch of non-delayed events comes here.  The event queue is
            # emptied by generating an event after each one is dispatched until
            # the queue goes empty. So when we enter here, if the queue is
            # already not empty, then there must be a pending event.
            method Dispatch {obj event empty} {
                my variable event_queue
                # The event queue should contain something here, but we test
                # anyway.
                if {[llength $event_queue] != 0} {
                    # Pull the event from the front of the queue
                    set details [lindex $event_queue 0]
                    set event_queue [lrange $event_queue 1 end]
                    # Generate another event if we have more events to dispatch.
                    if {[llength $event_queue] != 0} {
                        ::uevent generate [self] event
                    }
                    tailcall my DeliverEvent $details
                }
            }

            # Dispatch of delayed events comes here. For delayed events, we
            # queue them normally, except if the event queue is already empty.
            # Since here we executing out of the event loop anyway, there is no
            # reason to generate another event just to get the already delayed
            # event dispatched. Hence, we deliver the event immediately if
            # there are no other events pending. If other events are pending,
            # the there is a pending ::uevent already in the works.
            method DelayedDispatch {obj delayed details} {
                # Now that the delayed event is delivered, we have to do the
                # bookkeeping on the set of outstanding delayed events.
                my variable delayedSignals
                lassign $details src event
                if {[info exists delayedSignals($src,$event)]} {
                    unset delayedSignals($src,$event)
                } else {
                    # This should never happen. Somehow we got to dispatch the
                    # delayed event but it is not recorded in the outstanding
                    # set.
                    set errmsg "unexpected delayed event,\
                        [list $src] - $event -> [self]"
                    log::error $errmsg
                    throw [list OOMOORE UNKNOWN_DELAYED $src $event] $errmsg
                }
                my variable event_queue
                if {[llength $event_queue] == 0} {
                    tailcall my DeliverEvent $details
                } else {
                    lappend event_queue $details
                }
            }

            # Actually do the event delivery
            method DeliverEvent {details} {
                lassign $details src eventName params
                log::info "Signal:\
                        [list $src] - $eventName \{$params\} -> [self]"
                # All the real work is done in the receive method.
                tailcall my receive $eventName {*}$params
            }

            method CancelDelayedSignal {src event} {
                my ValidateEvent $event
                # Check if we have the delayed signal. It might not exist
                # or have already been dispatched. We return an indication
                # of whether the signal was indeed canceled.
                my variable delayedSignals
                if {[info exists delayedSignals($src,$event)]} {
                    after cancel [lindex $delayedSignals($src,$event) 0]
                    unset delayedSignals($src,$event)
                    set result true
                    log::info "Cancel: [list $src] - $event -> [self]"
                } else {
                    # If the signal has already been delivered, it might be in
                    # the event queue. Iterate across the event queue and
                    # remove the event if we find it.
                    my variable event_queue
                    set queue_index 0
                    foreach event $event_queue {
                        lassign $event eventSrc eventName
                        if {$eventSrc eq $src && $eventName eq $event} {
                            set event_queue [lreplace $event_queue\
                                    $queue_index $queue_index]
                            return true
                        }
                        incr queue_index
                    }
                    set result false
                }
                return $result
            }

            # Make sure we are dealing with a known event.
            method ValidateEvent {event} {
                classvariable events
                if {$event ni $events} {
                    set errmsg "unknown event, \"$event\""
                    log::error $errmsg
                    throw [list OOMOORE UNKNOWN_EVENT $event] $errmsg
                }
            }
        }
    }

    # Remaining methods on the new class itself.
    method states {} {
        my variable states
        return $states
    }

    method events {} {
        my variable events
        return $events
    }

    method transitions {} {
        my variable transitions
        set result [list]
        foreach {key value} [array get transitions] {
            lappend result [list {*}[split $key ,] $value]
        }
        return $result
    }

    method initialstate {} {
        my variable initialstate
        return $initialstate
    }

    method defaulttransition {} {
        my variable defaulttrans
        return $defaulttrans
    }

    # Draw state model graph with "dot"
    method dot {} {
        set result {}
        append result "digraph [namespace tail [self]] \{" \n
        append result "    node\[shape=\"box\"]" \n

        my variable states
        foreach state $states {
            lassign [info class definition [self] __STATE_$state] arguments body
            set code "$state \{$arguments\} \{"
            append code\
                    [textutil::adjust::indent [textutil::adjust::undent $body]\
                    "    "]
            append code "\n\}"
            #puts "code = \"$code\""
            set labelCode {}
            set escapemap [list \\ \\\\ \" \\\"]
            foreach line [split $code \n] {
                # We need to escape certain characters to keep "dot"
                # away from them.
                append labelCode\
                    [string map $escapemap $line]\
                    "\\l"
            }
            #puts "labelCode = \"$labelCode\""
            set stProps "label=\"$labelCode\""

            my variable initialstate
            if {$state eq $initialstate} {
                append stProps ",style=\"bold\""
            }
            append result "    \"$state\"\[$stProps]" \n
        }

        my variable transitions
        foreach {trans dststate} [array get transitions] {
            lassign [split $trans ,] currstate event
            if {!($dststate eq "IG" || $dststate eq "CH")} {
                append result "    \"$currstate\" -> \"$dststate\"\
                        \[label=\"$event\"]" \n
            }
        }

        append result "\}"

        return $result
    }

    method dotfile {filename} {
        set chan [open $filename w]
        try {
            chan puts $chan [my dot]
        } finally {
            chan close $chan
        }
        return
    }

    method draw {{dotopts {-Gsize=7.5,10 -Tps -o%s.ps}}} {
        set basename [namespace tail [self]]
        set dotexec [auto_execok dot]
        if {$dotexec eq {}} {
            error "Cannot find \"dot\" executable"
        }
        set dotopts [string map [list %s $basename] $dotopts]
        set chan [open "| $dotexec -Gcenter=1 -Gratio=auto $dotopts" w]
        try {
            chan puts $chan [my dot]
        } finally {
            chan close $chan
        }
        return
    }

    # The following methods define the mini-language used to specify the
    # state model. They are linked to procedure names that are lower case so
    # that the state model definitions appear more conventional and don't
    # require the use of the "my" command.

    # Define a state model state.
    method State {name argList body} {
        # The "states" variable holds the set of defined states. Order is
        # important here because we may need to use the first defined state
        # as the default initial state.
        my variable states
        if {$name in {IG CH}} {
            set errmsg "states may not be named by the reserved name, \"$name\""
            log::error $errmsg
            throw [list OOMOORE RESERVED_STATE $name] $errmsg
        } elseif {$name in $states} {
            set errmsg "duplicate state, \"$name\""
            log::error $errmsg
            throw [list OOMOORE DUPLICATE_STATE $name] $errmsg
        } else {
            lappend states $name
            oo::define [self] method __STATE_$name $argList $body
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
            set errmsg "duplicate transition, \"$current - $event\""
            log::error $errmsg
            throw [list OOMOORE DUPLICATE_TRANS $current $event] $errmsg
        } else {
            set transitions($current,$event) $new
        }
    }

    method DefaultTrans {trans} {
        if {$trans eq "IG" || $trans eq "CH"} {
            my variable defaulttrans
            set defaulttrans $trans
        } else {
            set errmsg "unknown transition name, \"$trans\": must be one of\
                    \"IG\" or \"CH\""
            log::error $errmsg
            throw {OOMOORE BAD_DEFAULT_TRANS {unknown transition name}} $errmsg
        }
    }

    method InitialState {state} {
        my variable initialstate
        set initialstate $state
    }
}

package provide oomoore $::oomoore::revision
