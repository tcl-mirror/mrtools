source ../src/oomoore.tcl
package require oomoore

# State model
::oo::class create tank {
    superclass ::oomoore::model

    constructor {} {
        next {
            state empty {} {
                my variable count
                chan puts "empty $count"
                incr count
                set ::done 1    ; # used to signal the end of a cycle
            }
            transition empty - pump -> filling

            state filling {} {
                my variable count
                my delayedSignal 500 full   ; # drive my self to the next state
                chan puts "filling $count"
                incr count
            }
            transition filling - full -> full

            state full {} {
                my variable count
                my delayedSignal 500 pump
                chan puts "full $count"
                incr count
            }
            transition full - pump -> emptying

            state emptying {} {
                my variable count
                my delayedSignal 500 empty
                chan puts "emptying $count"
                incr count
            }
            transition emptying - empty -> empty
        }
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
