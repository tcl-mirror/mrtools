#!/usr/bin/env tclsh
#  *++
# MODULE:
#	unit test template
# ABSTRACT:
# 
#  *--
package require Tcl 8.6
package require cmdline
package require mecate

set optlist {
    {level.arg warn {Log debug level}}
    {nostart {Don't start test harness program automatically}}
}
array set options [::cmdline::getKnownOptions argv $optlist]

::mecate::log::setlevel $options(level)

set program [lindex $argv 0]
if {$program eq {}} {
    error "no bosal test harness program name was supplied:"
}

mecate rein create ::apptest

apptest configure -timeout 0

if {!$::options(nostart)} {
    apptest start $program
}

apptest connect

apptest trace on
apptest traceNotify puts
apptest instr on
apptest instrNotify puts

apptest domainop sio init
apptest domainop lube init

apptest signal lube Autocycle_Session acs1 Activate 0 2

apptest waitForEventTrace type transition target Injector.in1 newstate SLEEPING

apptest saveTraces lube-sio-traces.sqlite sqlite

apptest seqDiagToFile lube-sio-seq.txt
