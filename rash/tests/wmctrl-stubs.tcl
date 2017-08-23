namespace eval ::wmctrl::Motor::MOTOR {
    ::logger::initNamespace [namespace current] info
    proc start {motor} {
        log::info "starting motor, \"$motor\""
    }
    proc stop {motor} {
        log::info "stopping motor, \"$motor\""
    }
}

namespace eval ::wmctrl::WaterValve::VALVE {
    ::logger::initNamespace [namespace current] info
    proc open {valve} {
        log::info "opening valve, \"$valve\""
    }
    proc close {valve} {
        log::info "closing valve, \"$valve\""
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
            [expr {$sensorState eq "TubEmpty" ? "TubFull" : "TubEmpty"}]
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
