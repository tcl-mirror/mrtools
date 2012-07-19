# ACTIVESTATE TEAPOT-PKG BEGIN TM -*- tcl -*-
# -- Tcl Module

# @@ Meta Begin
# Package moore 1.9
# Meta as::author  {Andrew Mangogna}
# Meta as::origin  chiselapp.com/user/mangoa01/repository/mrtools
# Meta category    Moore State Machine
# Meta description Moore State Models and Event Dispatch
# Meta license     BSD
# Meta platform    tcl
# Meta require     {Tcl 8.5}
# Meta require     logger
# Meta require     ral
# Meta require     ralutil
# Meta subject     {State machine} {Moore Machine} Events Automata
# Meta subject     {Finite Automata}
# Meta summary     Moore type state machines
# @@ Meta End


# ACTIVESTATE TEAPOT-PKG BEGIN REQUIREMENTS

package require Tcl 8.5
package require logger
package require ral
package require ralutil

# ACTIVESTATE TEAPOT-PKG END REQUIREMENTS

# ACTIVESTATE TEAPOT-PKG BEGIN DECLARE

package provide moore 1.9

# ACTIVESTATE TEAPOT-PKG END DECLARE
# ACTIVESTATE TEAPOT-PKG END TM
# This software is copyrighted 2010 - 2012 by G. Andrew Mangogna.
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
#   moore.tcl -- simple state machine definitions and dispatch
#
# ABSTRACT:
#   This file contains a Tcl script extension that allows Moore type
#   state models to be defined, state machine instances to be created
#   and primative dispatch mechanism.
#
#*--
#

package require Tcl 8.5
package require ral
package require ralutil
package require logger
package require textutil::adjust

namespace eval ::moore {
    variable revision 1.9

    namespace export model
    namespace export generate
    namespace export delay
    namespace export cancel
    namespace export remaining
    namespace export qwait
    namespace ensemble create

    namespace import ::ral::*
    namespace import ::ralutil::*

    relvar create StateModel {
        ModelName       string
        DefaultTrans    string
        InitialState    string
    } ModelName

    relvar create State {
        ModelName       string
        StateName       string
        ActionBody      string
        IsFinal         boolean
    } {ModelName StateName}

    relvar create Transition {
        ModelName       string
        CurrState       string
        EventName       string
        NewState        string
    } {ModelName CurrState EventName}

    relvar create StateMachine {
        MachineId       string
        ModelName       string
        CurrState       string
        Options         dict
    } MachineId

    # State models must have at least one state
    relvar association R1\
        State ModelName +\
        StateModel ModelName 1

    # The current state of a transition must refer to a state, however we do
    # not insist that the transition instance describe the entire transition
    # matrix. We will fill in the empty transitions with
    # StateModel.DefaultTrans when the transition is computed.
    relvar association R2\
        Transition {ModelName CurrState} *\
        State {ModelName StateName} 1

    # The new state of a transition must refer to a state. It would be nice to
    # make this unconditional, but that requires more metamodel since it is
    # allowable for an initial state to have no inbound transitions.  We also
    # can't prohibit isolated states by referential constraint alone with this
    # meta-model (i.e. those states where traversing both R2 and R3 is empty.
    # We do that in code.
    relvar association R3\
        Transition {ModelName NewState} *\
        State {ModelName StateName} 1

    # The initial state of a model must refer to a state.
    relvar association R4\
        StateModel {ModelName InitialState} ?\
        State {ModelName StateName} 1

    # State machines must refer to a state model.
    relvar association R5\
        StateMachine ModelName *\
        StateModel ModelName 1

    # The current state of a state machine must refer to a state.
    # Since there may be multiple state machine instances of a state model,
    # this association must be "*" rather than "?".
    relvar association R6\
        StateMachine {ModelName CurrState} *\
        State {ModelName StateName} 1

    # State models must have at least one transition
    relvar association R7\
        Transition ModelName +\
        StateModel ModelName 1

    # Use relvar tracing to clean up any commands that have been associated
    # with a state model or state machine
    relvar trace add variable StateModel\
            delete [namespace current]::RemoveModelCmd
    relvar trace add variable StateMachine\
            delete [namespace current]::RemoveMachineCmd

    # Event queuing variables.
    variable eventQueue [list]
    variable delayedQueue [list]
    variable delayTimerId {}
    variable qsync

    ::logger::initNamespace [namespace current] ; #debug
}

proc ::moore::model {modelName body} {
    set modelCmd [Qualify $modelName 2]
    relvar eval {
        relvar insert StateModel [list\
            ModelName       $modelCmd\
            DefaultTrans    CH\
            InitialState    {}\
        ]
        relvar insert State [list\
            ModelName       $modelCmd\
            StateName       IG\
            ActionBody      {}\
            IsFinal         false\
        ] [list\
            ModelName       $modelCmd\
            StateName       CH\
            ActionBody      {}\
            IsFinal         false\
        ]

        variable currModel $modelCmd
        eval $body
    }

    # check for isolated states
    variable State
    # States in this model minus IG and CH
    set modelstates [pipe {
        relvar restrictone StateModel ModelName $modelCmd |
        relation semijoin ~ $State |
        relation restrictwith ~ {$StateName ne "IG" && $StateName ne "CH"}
    }]
    # States with no inbound transitions
    set noinbound [pipe {
        relvar set Transition |
        relation semiminus ~ $modelstates\
                -using {ModelName ModelName CurrState StateName}
    }]
    # States with no outbound transitions and noinbound are isolated
    set isolated [pipe {
        relvar set Transition |
        relation semiminus ~ $modelstates\
                -using {ModelName ModelName NewState StateName} |
        relation intersect ~ $noinbound |
        relation project ~ StateName
    }]
    if {[relation isnotempty $isolated]} {
        # Wish we had cascading delete!
        relvar eval {
            relvar deleteone StateModel ModelName $modelCmd
            relvar delete State st {
                [tuple extract $st ModelName] eq $modelCmd
            }
            relvar delete Transition tr {
                [tuple extract $tr ModelName] eq $modelCmd
            }
        }
        return -code error -errorcode {MOORE ISOLATED}\
                "isolated states: [join [relation list $isolated] {, }]"
    }

    namespace ensemble create\
        -command $modelCmd\
        -map [dict create\
            machine [list [namespace current]::Machine $modelCmd]\
            instances [list [namespace current]::Instances $modelCmd]\
            states [list [namespace current]::States $modelCmd]\
            events [list [namespace current]::Events $modelCmd]\
            dot [list [namespace current]::Dot $modelCmd]\
            dotfile [list [namespace current]::Dotfile $modelCmd]\
            draw [list [namespace current]::Draw $modelCmd]\
            destroy [list [namespace current]::ModelDestroy $modelCmd]\
        ]

    return $modelCmd
}

proc ::moore::generate {srcCmd - eventName -> targetCmd args} {
    set srcCmd [QualifySrc $srcCmd]
    set targetCmd [QualifyTarget $targetCmd]
    PostEventQueue [dict create\
        Src $srcCmd\
        Target $targetCmd\
        Event $eventName\
        Params $args\
    ]
    return
}

proc ::moore::delay {time srcCmd - eventName -> targetCmd args} {
    set srcCmd [QualifySrc $srcCmd]
    set targetCmd [QualifyTarget $targetCmd]

    if {$time == 0} {
        PostEventQueue [dict create\
            Src $srcCmd\
            Target $targetCmd\
            Event $eventName\
            Params $args\
        ]
        return
    }

    StopDelayedTiming
    set existing [FindEvent delayedQueue $srcCmd $eventName $targetCmd]
    if {$existing >= 0} {
        RemoveFromDelayedQueue $existing
    }

    variable delayedQueue
    for {set i 0} {$i < [llength $delayedQueue]} {incr i} {
        set item [lindex $delayedQueue $i]
        set eventDelay [dict get $item Delay]
        if {$time < $eventDelay} {
            dict incr item Delay -$time
            set delayedQueue [lreplace $delayedQueue $i $i $item]
            break
        } else {
            incr time -$eventDelay
        }
    }
    log::debug "adding $time @ [list $srcCmd] - $eventName -> $targetCmd to\
            delayedQueue at $i"
    set delayedQueue [linsert $delayedQueue $i [dict create\
            Src $srcCmd\
            Target $targetCmd\
            Event $eventName\
            Params $args\
            Delay $time\
        ]]

    StartDelayedTiming

    return
}

proc ::moore::cancel {srcCmd - eventName -> targetCmd} {
    set srcCmd [QualifySrc $srcCmd]
    set targetCmd [QualifyTarget $targetCmd]

    StopDelayedTiming
    set existing [FindEvent delayedQueue $srcCmd $eventName $targetCmd]
    if {$existing >= 0} {
        RemoveFromDelayedQueue $existing
    } else {
        set existing [FindEvent eventQueue $srcCmd $eventName $targetCmd]
        if {$existing >= 0} {
            RemoveFromQueue eventQueue $existing
        }
    }
    StartDelayedTiming

    return
}

proc ::moore::remaining {srcCmd - eventName -> targetCmd} {
    set remainTime 0
    StopDelayedTiming
    variable delayedQueue
    foreach entry $delayedQueue {
        dict with entry {
            incr remainTime $Delay
            if {$Src eq $srcCmd && $Event eq $eventName &&\
                    $Target eq $targetCmd} {
                break
            }
        }
    }
    StartDelayedTiming

    return $remainTime
}

proc ::moore::qwait {{block true}} {
    set ns [namespace current]
    if {$block} {
        after 0 ${ns}::Dispatch
        vwait ${ns}::qsync
    } else {
        Dispatch
    }
    return
}

proc ::moore::StartDelayedTiming {} {
    variable delayedQueue
    variable delayTimerId
    variable expireTime

    if {[llength $delayedQueue]} {
        set expire [UpdateQueueHeadDelay 0]
        set delayTimerId\
                [after $expire [namespace current]::ServiceDelayedTiming]
        set expireTime [expr {[clock milliseconds] + $expire}]
    }

    return
}

# N.B. stopping the delayed event queue can cause events to be dispatched
# off of it.
proc ::moore::StopDelayedTiming {} {
    variable delayedQueue
    variable delayTimerId
    variable expireTime

    if {$delayTimerId ne {}} {
        after cancel $delayTimerId
        set delayTimerId {}
        UpdateQueueHeadDelay [expr {max(0, $expireTime - [clock milliseconds])}]
        PostExpiredEvents
    }

    return
}

proc ::moore::ServiceDelayedTiming {} {
    variable delayTimerId
    set delayTimerId {}
    PostExpiredEvents
    StartDelayedTiming
    return
}

proc ::moore::UpdateQueueHeadDelay {delay} {
    variable delayedQueue

    set firstEvent [lindex $delayedQueue 0]
    dict with firstEvent {
        set oldDelay $Delay
        set Delay $delay
    }
    set delayedQueue [lreplace $delayedQueue 0 0 $firstEvent]
    return $oldDelay
}

proc ::moore::RemoveFromDelayedQueue {index} {
    variable delayedQueue

    # Check that we are not trying to remove the very last entry in
    # the queue. If we are removing the last entry, then we do not
    # have to account for the remaining time of the event.
    if {$index < [llength $delayedQueue] - 1} {
        set nextIndex [expr {$index + 1}]
        set nextEntry [lindex $delayedQueue $nextIndex]
        # Add the time of the entry to delete to its next neighbor so
        # as to preserve the relative timing values.
        dict incr nextEntry Delay [dict get [lindex $delayedQueue $index] Delay]
        lset delayedQueue $nextIndex $nextEntry
    }
    RemoveFromQueue delayedQueue $index
    return
}

proc ::moore::RemoveFromQueue {queueVarName index} {
    namespace upvar [namespace current] $queueVarName queue
    log::debug "removing [lindex $queue $index] from $queueVarName"
    set queue [lreplace $queue $index $index]
    return
}

proc ::moore::FindEvent {queueVarName src event target} {
    namespace upvar [namespace current] $queueVarName queue
    set index 0
    foreach entry $queue {
        dict with entry {
            if {$Src eq $src && $Event eq $event && $Target eq $target} {
                return $index
            } else {
                incr index
            }
        }
    }

    return -1
}

proc ::moore::SelectEventByTarget {queueVarName target} {
    namespace upvar [namespace current] $queueVarName queue
    set index 0
    foreach entry $queue {
        dict with entry {
            if {$Target eq $target} {
                return $index
            } else {
                incr index
            }
        }
    }

    return -1
}

proc ::moore::PostExpiredEvents {} {
    variable delayedQueue

    while {[llength $delayedQueue]} {
        set expired [lindex $delayedQueue 0]
        if {[dict get $expired Delay] != 0} {
            break
        }
        dict unset expired Delay
        PostEventQueue $expired
        set delayedQueue [lrange $delayedQueue 1 end]
    }

    return
}

proc ::moore::Dispatch {} {
    variable eventQueue
    while {[llength $eventQueue]} {
        set event [lindex $eventQueue 0]
        set eventQueue [lrange $eventQueue 1 end]
        dict with event {
            set srcName [expr {$Src eq {} ? "NULL" : $Src}]
            set msg "$srcName - $Event -> $Target \{[join $Params { }]\}"
            set machine [relvar restrictone StateMachine MachineId $Target]
            if {[relation isempty $machine]} {
                return -code error -errorcode {MOORE INFLIGHT}\
                        "event in flight error: $Target not found: $msg"
            }
            Trace $machine "Dispatch: $msg"
            if {[catch {$Target receive $Event {*}$Params} result retopts]} {
                # If we have an error, we do not continue in the dispatch
                # loop and need to make sure that we will go back and look
                # at the event queue at some point.
                after 0 ::moore::Dispatch
                return -options $retopts $result
            }
        }
    }
    set [namespace current]::qsync 1
    return
}

proc ::moore::PostEventQueue {event} {
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
        after 0 ::moore::Dispatch
    }
    return
}

proc ::moore::Qualify {cmdName level} {
    if {[string range $cmdName 0 1] ne {::}} {
        set ns [uplevel $level namespace current]
        set cmdName [expr {$ns ne {::} ? "${ns}::$cmdName" : "::$cmdName"}]
    }
    return $cmdName
}

proc ::moore::QualifySrc {srcCmd} {
    if {$srcCmd ne {}} {
        set srcCmd [Qualify $srcCmd 3]
        set srcExists [pipe {
            relvar restrictone StateMachine MachineId $srcCmd |
            relation isnotempty
        }]
        if {!$srcExists} {
            return -code error -errorcode {MOORE UNKNOWN_MACHINE}\
                    "unknown state machine, \"$srcCmd\""
        }
    }
    return $srcCmd
}

proc ::moore::QualifyTarget {targetCmd} {
    set targetCmd [Qualify $targetCmd 3]
    set targetExists [pipe {
        relvar restrictone StateMachine MachineId $targetCmd |
        relation isnotempty
    }]
    if {!$targetExists} {
        return -code error -errorcode {MOORE UNKNOWN_MACHINE}\
                "unknown state machine, \"$targetCmd\""
    }
    return $targetCmd
}

proc ::moore::Machine {modelCmd machineCmd {initialState {}}} {
    set machineCmd [Qualify $machineCmd 2]
    set model [relvar restrictone StateModel ModelName $modelCmd]
    if {$initialState eq {}} {
        set initialState [relation extract $model InitialState]
    } else {
        set possStates [pipe {
            relvar set State |
            relation semijoin $model ~ |
            relation project ~ StateName |
            relation list
        }]
        if {$initialState ni $possStates} {
            return -code error -errorcode {MOORE UNKNOWN_INITAL}\
                    "initial state, \"$initialState\" is not among the\
                    states of $modelCmd, [join $possStates {, }]"
        }
    }
    relvar insert StateMachine [list\
        MachineId       $machineCmd\
        ModelName       $modelCmd\
        CurrState       $initialState\
        Options         [dict create]
    ]
    namespace ensemble create\
        -command $machineCmd\
        -map [dict create\
            receive [list [namespace current]::Receive $machineCmd]\
            force [list [namespace current]::Force $machineCmd]\
            configure [list [namespace current]::Configure $machineCmd]\
            cget [list [namespace current]::Cget $machineCmd]\
            destroy [list [namespace current]::MachineDestroy $machineCmd]\
        ]

    return $machineCmd
}

proc ::moore::Instances {modelCmd} {
    return [pipe {
        relvar set StateMachine |
        relation restrictwith ~ {$ModelName eq $modelCmd} |
        relation list ~ MachineId
    }]
}

proc ::moore::States {modelCmd} {
    variable State

    return [pipe {
        relvar restrictone StateModel ModelName $modelCmd |
        relation semijoin ~ $State |
        relation restrictwith ~ {$StateName ne "CH" && $StateName ne "IG"} |
        relation project ~ StateName |
        relation list ~
    }]
}

proc ::moore::Events {modelCmd} {
    variable Transition

    return [pipe {
        relvar restrictone StateModel ModelName $modelCmd |
        relation semijoin ~ $Transition |
        relation project ~ EventName |
        relation list ~
    }]
}

# Draw state model graph with "dot"
proc ::moore::Dot {modelCmd} {
    set model [relvar restrictone StateModel ModelName $modelCmd]
    set basename [namespace tail $modelCmd]

    relation assign $model
    set states [pipe {
        relvar set State |
        relation semijoin $model ~ |
        relation restrictwith ~ {$StateName ne "CH" && $StateName ne "IG"}
    }]
    log::debug \n[relformat $states State]
    set transitions [pipe {
        relvar set Transition |
        relation semijoin $model ~
    }]
    log::debug \n[relformat $transitions Transition]

    set finalStates [pipe {
        relation restrictwith $states {$IsFinal == "true"} |
        relation project ~ StateName |
        relation list ~
    }]

    set result {}
    append result "digraph $basename \{" \n
    append result "    node\[shape=\"box\"]" \n

    relation foreach st $states {
        relation assign $st StateName ActionBody
        set labelCode {}
        set code "$StateName \{[lrange [lindex $ActionBody 0] 1 end]\} \{\n"
        set body [string trim [lindex $ActionBody 1] \n]
        append code [textutil::indent [textutil::adjust::undent $body] "    "]
        append code "\n\}"
        log::debug "code = \"$code\""
        foreach line [split $code \n] {
            # We need to escape certain characters to keep "dot"
            # away from them.
            set quoted {}
            foreach c [split $line {}] {
                if {$c eq "\\" || $c eq "\""} {
                    append quoted "\\"
                }
                append quoted $c
            }
            append labelCode $quoted "\\l"
        }
        log::debug "labelCode = \"$labelCode\""
        set stProps "label=\"$labelCode\""

        if {$StateName eq $InitialState} {
            append stProps ",style=\"bold\""
        }
        append result "    \"$StateName\"\[$stProps]" \n
    }

    if {[llength $finalStates] != 0} {
        append result\
            "    \t\"__final\"\[label=\"\",shape=\"circle\",style=\"filled\"]"\
            \n
    }

    relation foreach tr $transitions {
        relation assign $tr CurrState EventName NewState
        if {!($NewState eq "IG" || $NewState eq "CH")} {
            append result "    \"$CurrState\" -> \"$NewState\"\
                    \[label=\"$EventName\"]" \n
        }
    }

    foreach fs $finalStates {
        append result "    \"$fs\" -> \"__final\"" \n
    }

    append result "\}"

    return $result
}

proc ::moore::Dotfile {modelCmd filename} {
    set chan [open $filename w]
    chan puts $chan [Dot $modelCmd]
    chan close $chan
    return
}

proc ::moore::Draw {modelCmd {dotopts {-Gsize=7.5,10 -Tps -o%s.ps}}} {
    set basename [namespace tail $modelCmd]
    set dotexec [auto_execok dot]
    if {$dotexec eq {}} {
        error "Cannot find \"dot\" executable"
    }
    set dotopts [string map [list %s $basename] $dotopts]
    set chan [open "| $dotexec -Gcenter=1 -Gratio=auto $dotopts" w]
    chan puts $chan [Dot $modelCmd]
    chan close $chan
    return
}

proc ::moore::State {stateName arglist body {final false}} {
    set arglist [linsert $arglist 0 self]
    variable currModel
    relvar insert State [list\
        ModelName       $currModel\
        StateName       $stateName\
        ActionBody      [list $arglist $body [namespace qualifier $currModel]]\
        IsFinal         $final\
    ]
    relvar updateone StateModel sm [list\
        ModelName $currModel\
    ] {
        expr {[tuple extract $sm InitialState] eq {} ?\
            [tuple update $sm InitialState $stateName] : $sm}
    }
    return
}

proc ::moore::Transition {curr - event -> new} {
    variable currModel
    relvar insert Transition [list\
        ModelName       $currModel\
        CurrState       $curr\
        EventName       $event\
        NewState        $new\
    ]
    return
}

proc ::moore::DefaultTrans {trans} {
    variable currModel
    if {!($trans eq "IG" || $trans eq "CH")} {
        return -code error -errorcode {MOORE BAD_DEFAULT}\
                "bad default transition, \"$trans\":\
                must be one of \"IG\" or \"CH\""
    }
    relvar updateone StateModel sm [list\
        ModelName $currModel\
    ] {
        tuple update $sm DefaultTrans $trans
    }
    return
}

proc ::moore::InitialState {stateName} {
    variable currModel
    relvar updateone StateModel sm [list\
        ModelName $currModel\
    ] {
        tuple update $sm InitialState $stateName
    }
    return
}

proc ::moore::Receive {machineCmd eventName args} {
    set machine [relvar restrictone StateMachine MachineId $machineCmd]
    if {[relation isempty $machine]} {
        return -code error -errorcode {MOORE UNKNOWN_MACHINE}\
                "unknown state machine, \"$machine\""
    }
    # By semijoining using only the ModelName we get the set of all possible
    # transitions in the given model.  The restriction of that by EventName
    # serves to check that we didn't get a garbage event name argument.
    set possTrans [pipe {
        relvar set Transition |
        relation semijoin $machine ~ -using {ModelName ModelName} |
        relation restrictwith ~ {$EventName eq $eventName}
    }]
    if {[relation isempty $possTrans]} {
        return -code error -errorcode {MOORE UNKNOWN_EVENT}\
                "unknown event, \"$eventName\""
    }

    set newTrans [relation semijoin $machine $possTrans]
    set newState [expr {[relation isnotempty $newTrans] ?\
            [relation extract $newTrans NewState] :\
            [pipe {
                relvar set StateModel |
                relation semijoin $machine ~ |
                relation extract ~ DefaultTrans
            }]}]
    set currState [relation extract $machine CurrState]
    Trace $machine "Transition: $machineCmd - $currState -> $newState"
    if {$newState eq "CH"} {
        return -code error -errorcode {MOORE CANTHAPPEN}\
                "CH transition for $machineCmd: $currState - $eventName -> CH"
    } elseif {$newState ne "IG"} {
        ExecTrans $machineCmd $machine $newState $args
    }
    return
}

proc ::moore::ExecTrans {machineCmd machine newState argList} {
    set newstate [pipe {
        relvar set State |
        relation semijoin $machine ~ |
        relation restrictwith ~ {$StateName eq $newState}
    }]
    # We update the current state before executing the action.
    # This helps in synchronous dispatch.
    relvar updateone StateMachine sm [list\
            MachineId $machineCmd\
        ] {
            tuple update $sm CurrState $newState
        }
    if {[catch {apply [relation extract $newstate ActionBody] $machineCmd\
            {*}$argList} result opts]} {
        log::error $result
        dict set opts -errorcode [list MOORE ACTIONFAILED $machineCmd]
        return -options $opts $result
    }
    # Check for final states
    if {[relation extract $newstate IsFinal]} {
        MachineDestroy $machineCmd
    }
}

proc ::moore::Force {machineCmd stateName args} {
    set machine [relvar restrictone StateMachine MachineId $machineCmd]
    set possStates [pipe {
        relvar set State |
        relation semijoin $machine ~ |
        relation project ~ StateName |
        relation list
    }]
    if {$stateName ni $possStates} {
        return -code error -errorcode {MOORE UNKNOWN_STATE}\
                "state, \"$stateName\" is not among the
                states of [relation extract $machine ModelName]:\
                [join $possStates {, }]"
    }

    ExecTrans $machineCmd $machine $stateName $args
    return
}

proc ::moore::Configure {machineCmd args} {
    if {[llength $args] == 0} {
        return [pipe {
            relvar restrictone StateMachine MachineId $machineCmd |
            relation extract ~ Options |
            dict keys ~
        }]
    } elseif {[llength $args] == 1} {
        set option [lindex $args 0]
        return [dict create $option [Cget $machineCmd $option]]
    } elseif {[llength $args] % 2 != 0} {
        return -code error -errorcode {MOORE BAD_PARAM}\
                "option / value parameters must be in pairs"
    } else {
        set options [pipe {
            relvar restrictone StateMachine MachineId $machineCmd |
            relation extract ~ Options
        }]
        foreach {opt value} $args {
            dict set options $opt $value
        }
        relvar updateone StateMachine sm [list\
            MachineId $machineCmd] {
            tuple update $sm Options $options
        }
        return
    }
}

proc ::moore::Cget {machineCmd option} {
    return [pipe {
        relvar restrictone StateMachine MachineId $machineCmd |
        relation extract ~ Options |
        dict get ~ $option
    }]
}

proc ::moore::ModelDestroy {modelCmd} {
    # Wish we had cascading delete!
    relvar eval {
        relvar deleteone StateModel ModelName $modelCmd
        relvar delete State st {
            [tuple extract $st ModelName] eq $modelCmd
        }
        relvar delete Transition tr {
            [tuple extract $tr ModelName] eq $modelCmd
        }
        relvar delete StateMachine sm {
            [tuple extract $sm ModelName] eq $modelCmd
        }
    }
}

proc ::moore::Trace {machine msg} {
    set opts [relation extract $machine Options]
    if {[dict exists $opts trace] && [dict get $opts trace] != false} {
        log::info $msg
    }
    return
}

proc ::moore::MachineDestroy {machineCmd} {
    relvar deleteone StateMachine MachineId $machineCmd
    # Check the event queues and remove any events that are targeted
    # at the deleted machine.
    StopDelayedTiming
    for {set existing [SelectEventByTarget delayedQueue $machineCmd]}\
            {$existing >= 0}\
            {set existing [SelectEventByTarget delayedQueue $machineCmd]} {
        RemoveFromDelayedQueue $existing
    }
    StartDelayedTiming
    for {set existing [SelectEventByTarget eventQueue $machineCmd]}\
            {$existing >= 0}\
            {set existing [SelectEventByTarget eventQueue $machineCmd]} {
        RemoveFromQueue eventQueue $existing
    }
    return
}

proc ::moore::RemoveModelCmd {op relvarName tupleValue} {
    catch {::rename [tuple extract $tupleValue ModelName] {}}
    return
}

proc ::moore::RemoveMachineCmd {op relvarName tupleValue} {
    catch {::rename [tuple extract $tupleValue MachineId] {}}
    return
}

package provide moore $::moore::revision
