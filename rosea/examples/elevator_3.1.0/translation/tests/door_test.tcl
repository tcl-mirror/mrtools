source ./roseaTestUtil.tcl

proc signalDoor {shaft signal} {
    set door [roseaTestUtil sendCmd elevator::Door findById Shaft $shaft]
    after 1000 [list roseaTestUtil sendCmd\
        [list rosea tunnel $door signal $signal]]
}

proc simOpenDoor {domain class state} {
    chan puts "opening door for $domain/$class/$state"
    signalDoor S1 Door_opened
}

proc simCloseDoor {domain class state} {
    chan puts "closing door for $domain/$class/$state"
    signalDoor S1 Door_closed
}

roseaTestUtil call 50000

roseaTestUtil sendCmd rosea trace control on
roseaTestUtil sendCmd rosea trace control logon
roseaTestUtil sendCmd rosea trace control loglevel info

roseaTestUtil breakAtState elevator Door CLOSED
roseaTestUtil breakAtState elevator Door OPENING simOpenDoor
roseaTestUtil breakAtState elevator Door CLOSING simCloseDoor
roseaTestUtil enableBreaks

roseaTestUtil showClass elevator Shaft

set door [roseaTestUtil sendCmd elevator::Door findById Shaft 1]
roseaTestUtil sendCmd [list rosea tunnel $door signal Unlock]
chan puts [roseaTestUtil waitForBreak]

roseaTestUtil breakAtState elevator Door OPEN_DELAY
roseaTestUtil sendCmd [list rosea tunnel $door signal Passenger_open]
chan puts [roseaTestUtil waitForBreak]
roseaTestUtil deleteBreak elevator Door OPEN_DELAY

roseaTestUtil sendCmd [list rosea tunnel $door signal Passenger_close]
chan puts [roseaTestUtil waitForBreak]

roseaTestUtil sendCmd [list rosea tunnel $door signal Unlock]
chan puts [roseaTestUtil waitForBreak]

roseaTestUtil disableBreaks

puts [roseaTestUtil sendCmd {rosea trace format [rosea trace decode all]}]

# roseaTestUtil sendCmd {rosea trace diagram all door_test.seq}

roseaTestUtil sendCmd set ::forever 1
