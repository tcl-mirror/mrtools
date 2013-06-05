source ../src/oomoore.tcl
package require oomoore

# State model
::oomoore model create tank_operation {
    state empty {} {
        my variable count
        chan puts "empty $count"
        incr count
        set ::done 1    ; # used to signal the end of a cycle
    }
    transition empty - pump -> filling

    state filling {} {
        my delayedSignal 500 full   ; # drive my self to the next state
        my variable count
        chan puts "filling $count"
        incr count
    }
    transition filling - full -> full

    state full {} {
        my delayedSignal 500 pump
        my variable count
        chan puts "full $count"
        incr count
    }
    transition full - pump -> emptying

    state emptying {} {
        my delayedSignal 500 empty
        my variable count
        chan puts "emptying $count"
        incr count
    }
    transition emptying - empty -> empty
}

::oo::class create tank {
    # State machine created as a subclass of the state model.
    superclass ::tank_operation

    constructor {} {
        next
        my variable count
        set count 0
    }
}

# Create a state machine object
tank create mytank
# Log the transitions
mytank loglevel info
# Kick things off
mytank signal pump
# Wait for one cycle to complete
vwait ::done
