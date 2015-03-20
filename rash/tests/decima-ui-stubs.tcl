namespace eval ::decima::ui::CAL {
    logger::initNamespace [namespace current] info

    proc NewTarget {appid type number} {
        log::info [info level 0]
    }

    proc DeleteTarget {appid} {
        log::info [info level 0]
    }

    proc StartCalibration {appid} {
        log::info [info level 0]
    }

    proc StopCalibration {appid} {
        log::info [info level 0]
    }

    proc SaveData {appid} {
        log::info [info level 0]
    }

    proc DiscardData {appid} {
        log::info [info level 0]
    }

    proc Select {appid procs} {
        log::info [info level 0]
    }

    proc Deselect {appid procs} {
        log::info [info level 0]
    }

    proc GetCalibProcs {appid} {
        log::info [info level 0]
    }
}

namespace eval ::decima::ui::DEV {
    logger::initNamespace [namespace current] info

    proc Connect {appid port} {
        log::info [info level 0]
    }

    proc Disconnect {appid} {
        log::info [info level 0]
    }

    proc GetValue {appid valueid} {
        log::info [info level 0]
    }
}
