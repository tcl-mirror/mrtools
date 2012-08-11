# ACTIVESTATE TEAPOT-PKG BEGIN TM -*- tcl -*-
# -- Tcl Module

# @@ Meta Begin
# Package mealy 1.4
# Meta as::author  {Andrew Mangogna}
# Meta as::origin  chiselapp.com/user/mangoa01/repository/mrtools
# Meta description This package is the counter part to the moore package.
# Meta description It implements a mealy type state machine definition and
# Meta description execution environment.
# Meta platform    tcl
# Meta require     {Tcl 8.5}
# Meta require     logger
# Meta require     textutil::adjust
# Meta require     ral
# Meta require     ralutil
# Meta summary     Mealy type state machines
# @@ Meta End


# ACTIVESTATE TEAPOT-PKG BEGIN REQUIREMENTS

package require Tcl 8.5
package require logger
package require textutil::adjust
package require ral
package require ralutil

# ACTIVESTATE TEAPOT-PKG END REQUIREMENTS

# ACTIVESTATE TEAPOT-PKG BEGIN DECLARE

package provide mealy 1.4

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
#   mealy.tcl -- simple state machine definitions and dispatch
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

namespace eval ::mealy {
    variable revision 1.4

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
        IsFinal         boolean
    } {ModelName StateName}

    relvar create Transition {
        ModelName       string
        CurrState       string
        EventName       string
        NewState        string
        ActionBody      string
    } {ModelName CurrState EventName}

    relvar create StateMachine {
        MachineId       string
        ModelName       string
        CurrState       string
        Options         dict
    } MachineId

    # state models must have at least one state
    relvar association R1\
        State ModelName +\
        StateModel ModelName 1

    # state models must have at least one transition
    relvar association R7\
        Transition ModelName +\
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
    # allowable for an initial state to have no outbound transitions.  We also
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
    relvar association R6\
        StateMachine {ModelName CurrState} *\
        State {ModelName StateName} 1

    # Use relvar tracing to clean up any commands that have been associated
    # with a state model or state machine
    relvar trace add variable StateModel\
            delete [namespace current]::RemoveModelCmd
    relvar trace add variable StateMachine\
            delete [namespace current]::RemoveMachineCmd

    variable eventQueue [list]
    variable delayedQueue [list]
    variable delayTimerId {}
    variable qsync

    ::logger::initNamespace [namespace current] ; #debug
}

proc ::mealy::model {modelName body} {
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
            IsFinal         false\
        ] [list\
            ModelName       $modelCmd\
            StateName       CH\
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
        error "isolated states: [join [relation list $isolated] {, }]"
    }

    namespace ensemble create\
        -command $modelCmd\
        -map [dict create\
            machine [list [namespace current]::Machine $modelCmd]\
            dot [list [namespace current]::Dot $modelCmd]\
            dotfile [list [namespace current]::Dotfile $modelCmd]\
            draw [list [namespace current]::Draw $modelCmd]\
            destroy [list [namespace current]::ModelDestroy $modelCmd]\
        ]

    return $modelCmd
}

proc ::mealy::generate {srcCmd - eventName -> targetCmd args} {
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

proc ::mealy::delay {time srcCmd - eventName -> targetCmd args} {
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

proc ::mealy::cancel {srcCmd - eventName -> targetCmd} {
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

proc ::mealy::remaining {srcCmd - eventName -> targetCmd} {
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

proc ::mealy::qwait {{block true}} {
    set ns [namespace current]
    if {$block} {
        after 0 ${ns}::Dispatch
        vwait ${ns}::qsync
    } else {
        Dispatch
    }
    return
}

proc ::mealy::StartDelayedTiming {} {
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

proc ::mealy::StopDelayedTiming {} {
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

proc ::mealy::ServiceDelayedTiming {} {
    variable delayTimerId
    set delayTimerId {}
    PostExpiredEvents
    StartDelayedTiming
    return
}

proc ::mealy::UpdateQueueHeadDelay {delay} {
    variable delayedQueue

    set firstEvent [lindex $delayedQueue 0]
    dict with firstEvent {
        set oldDelay $Delay
        set Delay $delay
    }
    set delayedQueue [lreplace $delayedQueue 0 0 $firstEvent]
    return $oldDelay
}

proc ::mealy::RemoveFromDelayedQueue {index} {
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

proc ::mealy::RemoveFromQueue {queueVarName index} {
    namespace upvar [namespace current] $queueVarName queue
    log::debug "removing [lindex $queue $index] from $queueVarName"
    set queue [lreplace $queue $index $index]
    return
}

proc ::mealy::FindEvent {queueVarName src event target} {
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

proc ::mealy::SelectEventByTarget {queueVarName target} {
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

proc ::mealy::PostExpiredEvents {} {
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

proc ::mealy::Dispatch {} {
    variable eventQueue
    while {[llength $eventQueue]} {
        set event [lindex $eventQueue 0]
        set eventQueue [lrange $eventQueue 1 end]
        dict with event {
            set srcName [expr {$Src eq {} ? "NULL" : $Src}]
            set msg "$srcName - $Event -> $Target \{[join $Params { }]\}"
            set machine [relvar restrictone StateMachine MachineId $Target]
            if {[relation isempty $machine]} {
                error "event in flight error: $Target not found: $msg"
            }
            Trace $machine "Dispatch: $msg"
            if {[catch {$Target receive $Event {*}$Params} result retopts]} {
                log::error $::errorInfo
                return -options $retopts $result
            }
        }
    }
    set [namespace current]::qsync 1
    return
}

proc ::mealy::PostEventQueue {event} {
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
        after 0 ::mealy::Dispatch
    }
    return
}

proc ::mealy::Qualify {cmdName level} {
    if {[string range $cmdName 0 1] ne {::}} {
        set ns [uplevel $level namespace current]
        set cmdName [expr {$ns ne {::} ? "${ns}::$cmdName" : "::$cmdName"}]
    }
    return $cmdName
}

proc ::mealy::QualifySrc {srcCmd} {
    if {$srcCmd ne {}} {
        set srcCmd [Qualify $srcCmd 3]
        set srcExists [pipe {
            relvar restrictone StateMachine MachineId $srcCmd |
            relation isnotempty
        }]
        if {!$srcExists} {
            error "unknown state machine, \"$srcCmd\""
        }
    }
    return $srcCmd
}

proc ::mealy::QualifyTarget {targetCmd} {
    set targetCmd [Qualify $targetCmd 3]
    set targetExists [pipe {
        relvar restrictone StateMachine MachineId $targetCmd |
        relation isnotempty
    }]
    if {!$targetExists} {
        error "unknown state machine, \"$targetCmd\""
    }
    return $targetCmd
}

proc ::mealy::Machine {modelCmd machineCmd {initialState {}}} {
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
            error "initial state, \"$initialState\" is not among the
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
            configure [list [namespace current]::Configure $machineCmd]\
            cget [list [namespace current]::Cget $machineCmd]\
            destroy [list [namespace current]::MachineDestroy $machineCmd]\
        ]

    return $machineCmd
}

# Draw state model graph with "dot"
proc ::mealy::Dot {modelCmd {includeCode true}} {
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
        relation assign $st StateName
        append result "    \"$StateName\""
        if {$StateName eq $InitialState} {
            append stProps "\[style=\"bold\"\]"
        }
        append result \n
    }

    if {[llength $finalStates] != 0} {
        append result\
            "    \t\"__final\"\[label=\"\",shape=\"circle\",style=\"filled\"]"\
            \n
    }

    relation foreach tr $transitions {
        relation assign $tr
        if {!($NewState eq "IG" || $NewState eq "CH")} {
            if {$includeCode} {
                set labelCode {}
                set code "$EventName \{[lrange [lindex $ActionBody 0] 1 end]\}\
                        \{\n"
                set body [string trim [lindex $ActionBody 1] \n]
                append code [textutil::indent [textutil::adjust::undent $body]\
                        "    "]
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
                set label "\[label=\"$labelCode\"]"
                log::debug $label
            } else {
                set label "\[label=\"$EventName\"]"
            }
            append result "    \"$CurrState\" -> \"$NewState\" $label" \n
        }
    }

    foreach fs $finalStates {
        append result "    \"$fs\" -> \"__final\"" \n
    }

    append result "\}"

    return $result
}

proc ::mealy::Dotfile {modelCmd filename {includeCode true}} {
    set chan [open $filename w]
    chan puts $chan [Dot $modelCmd $includeCode]
    chan close $chan
    return
}

proc ::mealy::Draw {modelCmd {dotopts {-Gsize=7.5,10 -Tps -o%s.ps}}} {
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

proc ::mealy::State {stateName body {final false}} {
    variable currModel
    relvar insert State [list\
        ModelName       $currModel\
        StateName       $stateName\
        IsFinal         $final\
    ]
    relvar updateone StateModel sm [list\
        ModelName $currModel\
    ] {
        expr {[tuple extract $sm InitialState] eq {} ?\
            [tuple update $sm InitialState $stateName] : $sm}
    }
    variable currState $stateName
    eval $body
    return
}

proc ::mealy::Transition {event arglist body -> new} {
    # "self" is a hidden argument
    set arglist [linsert $arglist 0 self]
    variable currModel
    variable currState
    relvar insert Transition [list\
        ModelName       $currModel\
        CurrState       $currState\
        EventName       $event\
        NewState        $new\
        ActionBody      [list $arglist $body [namespace qualifier $currModel]]\
    ]
    return
}

proc ::mealy::DefaultTrans {trans} {
    variable currModel
    if {!($trans eq "IG" || $trans eq "CH")} {
        error "bad default transition, \"$trans\":\
                must be one of \"IG\" or \"CH\""
    }
    relvar updateone StateModel sm [list\
        ModelName $currModel\
    ] {
        tuple update $sm DefaultTrans $trans
    }
    return
}

proc ::mealy::InitialState {stateName} {
    variable currModel
    relvar updateone StateModel sm [list\
        ModelName $currModel\
    ] {
        tuple update $sm InitialState $stateName
    }
    return
}

proc ::mealy::Receive {machineCmd eventName args} {
    set machine [relvar restrictone StateMachine MachineId $machineCmd]
    if {[relation isempty $machine]} {
        error "unknown state machine, \"$machine\""
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
        error "unknown event, \"$eventName\""
    }

    set newTrans [relation semijoin $machine $possTrans]
    set model [pipe {
        relvar set StateModel |
        relation semijoin $machine ~
    }]
    variable State
    set state [expr {[relation isnotempty $newTrans] ?\
            [relation semijoin $newTrans $State\
                    -using {ModelName ModelName NewState StateName}] :
            [relation semijoin $model $State\
                    -using {ModelName ModelName DefaultTrans StateName}]}]

    set currState [relation extract $machine CurrState]
    set newState [relation extract $state StateName]
    set transMsg "Transition: $machineCmd - $currState -> $newState"
    Trace $machine $transMsg

    if {$newState eq "CH"} {
        error "can't happen transition: $transMsg"
    } elseif {$newState ne "IG"} {
        # We update the current state before executing the action.
        # This helps in synchronous dispatch.
        relvar updateone StateMachine sm [list\
                MachineId $machineCmd\
            ] {
                tuple update $sm CurrState $newState
            }
        apply [relation extract $newTrans ActionBody] $machineCmd {*}$args
        # Check for final states
        if {[relation extract $state IsFinal]} {
            MachineDestroy $machineCmd
        }
    }
    return
}

proc ::mealy::Configure {machineCmd args} {
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
        error "option / value parameters must be in pairs"
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

proc ::mealy::Cget {machineCmd option} {
    return [pipe {
        relvar restrictone StateMachine MachineId $machineCmd |
        relation extract ~ Options |
        dict get ~ $option
    }]
}

proc ::mealy::ModelDestroy {modelCmd} {
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

proc ::mealy::Trace {machine msg} {
    set opts [relation extract $machine Options]
    if {[dict exists $opts trace] && [dict get $opts trace] != false} {
        log::info $msg
    }
    return
}

proc ::mealy::MachineDestroy {machineCmd} {
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

proc ::mealy::RemoveModelCmd {op relvarName tupleValue} {
    catch {::rename [tuple extract $tupleValue ModelName] {}}
    return
}

proc ::mealy::RemoveMachineCmd {op relvarName tupleValue} {
    catch {::rename [tuple extract $tupleValue MachineId] {}}
    return
}

package provide mealy $::mealy::revision
