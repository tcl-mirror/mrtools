source ./roseaTestUtil.tcl

roseaTestUtil call 50000

roseaTestUtil sendCmd rosea trace control on
roseaTestUtil sendCmd rosea trace control logon
roseaTestUtil sendCmd rosea trace control loglevel info

set door [roseaTestUtil sendCmd elevator::Door findById Shaft S1]
roseaTestUtil sendCmd [list rosea tunnel $door signal Unlock]

roseaTestUtil syncToState Door CLOSED
roseaTestUtil sendCmd [list rosea tunnel $door signal Passenger_open]

roseaTestUtil syncToState Door OPEN_DELAY
roseaTestUtil sendCmd [list rosea tunnel $door signal Passenger_close]

roseaTestUtil syncToState Door CLOSED
roseaTestUtil sendCmd [list rosea tunnel $door signal Unlock]

roseaTestUtil syncToState Door CLOSED

puts [roseaTestUtil sendCmd {rosea trace format [rosea trace decode all]}]

# roseaTestUtil sendCmd {rosea trace diagram all door_test.seq}

roseaTestUtil sendCmd set ::forever 1
