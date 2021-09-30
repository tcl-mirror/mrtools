#!/usr/bin/env tclsh
package require dbif

puts stderr "test server starting"

dbif connect -bus session -noqueue -replace com.modelrealization.test

dbif method /com/modelrealization/test Quit {
    dbif return $msgid {}
    puts stderr "test server exiting"
    exit
}

dbif method /com/modelrealization/test AddToCounter {cnt} {i} {
    incr ::Counter $cnt
    dbif return $msgid $::Counter
}

dbif method /com/modelrealization/test Trigger {
    dbif generate $::AttnSigId
}
dbif property -attributes {Property.EmitsChangedSignal true}\
        /com/modelrealization/test Counter:i Counter
set ::Counter 0

dbif property /com/modelrealization/test Name:s Name
set ::Name "Test Server"

dbif property -access read\
        /com/modelrealization/test Source:s Source
set ::Source "Model Realization"
set ::AttnSigId [dbif signal /com/modelrealization/test Attention\
        {Count:i Identity:s} {} {
    return [list $::Counter $::Source]
}]

vwait forever
