cd ../src
source ./wmctrl.tcl

namespace import ::ral::*
namespace import ::ralutil::*

namespace eval ::wmctrl::Motor::MOTOR {
    ::logger::initNamespace [namespace current] debug
    proc start {motor} {
        log::debug "starting motor, \"$motor\""
    }
    proc stop {motor} {
        log::debug "stopping motor, \"$motor\""
    }
}

namespace eval ::wmctrl::WaterValve::VALVE {
    ::logger::initNamespace [namespace current] debug
    proc open {valve} {
        log::debug "opening valve, \"$valve\""
    }
    proc close {valve} {
        log::debug "closing valve, \"$valve\""
    }
}
namespace eval ::wmctrl::WaterLevelSensor::SENSOR {
    namespace import ::ral::*
    namespace import ::ralutil::*

    ::logger::initNamespace [namespace current] debug

    relvar create SensorState {
        MachineID   string
        State       string
        TimerID     string
    } MachineID

    proc enable {machine} {
        log::debug "enable sensor on machine, \"$machine\""

        set ss [relvar restrictone SensorState MachineID $machine]
        if {[relation isempty $ss]} {
            set ss [relvar insert SensorState [list\
                MachineID $machine State TubEmpty TimerID None]]
        }
        set sensorState [relation extract $ss State]

        set newState\
            [expr {$sensorState eq "TubEmpty" ? "TubFull" : "TubEmpty"}] ; # <1>
        set tid [after 3000 [namespace code [list trigger $machine $newState]]]
        relvar updateone SensorState sstate [list MachineID $machine] {
            tuple update $sstate State $newState TimerID $tid
        }
    }

    proc disable {machine} {
        log::debug "disable sensor on machine, \"$machine\""
        set ss [relvar restrictone SensorState MachineID $machine]
        if {[relation isnotempty $ss]} {
            after cancel [relation extract $ss TimerID]
        }
    }
    proc trigger {machine value} {
        set ct [::wmctrl::ClothesTub findWhere {
            $MachineID eq $machine
        }]
        rosea tunnel $ct signal $value
        relvar updateone SensorState sstate [list MachineID $machine] {
            tuple update $sstate State $value
        }
    }
}

proc pqueue {q} {
    set counter 1
    foreach entry $q {
        puts "$counter: [dict get $entry event] -> [dict get $entry dst]"
        incr counter
    }
}

proc syncToState {cmd code result op} {
    puts "*** event queue ***"
    pqueue $::rosea::Dispatch::event_queue
    puts "*** toc queue ***"
    pqueue $::rosea::Dispatch::toc_queue
    puts "delayed = [relation cardinality $::rosea::Dispatch::DelayedSignal]"
    puts [relformat $::wmctrl::__WashingMachine__STATEINST]
}
if 0 {
trace add execution ::wmctrl::WashingMachine::__Activity::Stopped\
        leave syncToState
trace add execution ::wmctrl::WashingMachine::__Activity::FillingToWash\
        leave syncToState
trace add execution ::wmctrl::WashingMachine::__Activity::Washing\
        leave syncToState
trace add execution ::wmctrl::WashingMachine::__Activity::DrainingWash\
        leave syncToState
trace add execution ::wmctrl::WashingMachine::__Activity::FillingToRinse\
        leave syncToState
trace add execution ::wmctrl::WashingMachine::__Activity::Rinsing\
        leave syncToState
trace add execution ::wmctrl::WashingMachine::__Activity::DrainingRinse\
        leave syncToState
trace add execution ::wmctrl::WashingMachine::__Activity::Spinning\
        leave syncToState
}

set totalcount [lindex $argv 0]

proc syncToStop {cmd code result op} {
    set ref [lindex $cmd 1]
    set inst [lindex $ref 1]
    set wid [relation extract $inst MachineID]
    ::wmctrl deleteWasher $wid
    incr ::washercount
    #puts "****  $::washercount *****"
    if {$::washercount >= $::totalcount} {
        set ::done 1
    }
}

trace add execution ::wmctrl::ClothesTub::__Activity::StoppingSpin\
        leave syncToStop

for {set i 0} {$i < $::totalcount} {incr i} {
    ::wmctrl createWasher $i
    after [expr {round(rand() * 1000.)}] [list ::wmctrl startWasher $i]
    #::wmctrl startWasher $i
}
puts "event queue = [llength $::rosea::Dispatch::event_queue]"
puts "toc queue = [llength $::rosea::Dispatch::toc_queue]"
puts "WM instances = [relation cardinality\
        [relvar set ::wmctrl::WashingMachine]]"
#puts [relformat [relvar set ::wmctrl::__WashingMachine__STATEINST]]

logger::setlevel info
#rosea trace control on
#rosea trace control logon
#rosea trace control loglevel info

vwait ::done

puts "WM instances = [relation cardinality\
        [relvar set ::wmctrl::WashingMachine]]"

#rosea trace control off
