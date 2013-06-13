#!/usr/bin/env tclsh

package require oomoore

# The model class is a meta-class. Creating an instance of model creates a new
# class. The constructor accepts a script that configures the state model. The
# resulting class can then be used as a superclass to give state behavior.

oomoore model create wmachine {
    # The state model is defined by executing commands to specify the states
    # and transitions of the model.

    # The "state" command defines a state and the Tcl code that is run when the
    # state is entered.
    state Idle {} {
        # Stop motor
        puts "[self]: Stopping motor"

        # For testing purpose, we want to be able to run the Tcl event loop and
        # when we are done with the cycle we will use "vwait" to determine that
        # we have finished.
        set ::wmachine([self]) Idle
    }

    # The "transition" command defines what happens when an event is received
    # in a state. Notice that there is no command to define the events to which
    # the model responds. The events are simply gleened from the "transition"
    # commands. The "-" and "->" arguments are simply syntactic sugar to
    # suggest the transition from current state to new state that the event
    # causes.
    transition Idle - Run -> FillingForWashing

    state FillingForWashing {} {
        # Open water valve
        puts "[self]: Opening water valve"

        # At this point we need the washing tub sensor to tell us that the
        # tub is full. For simplicity, we will simulate the sensor by
        # signalling a delayed event to ourselves.
        # SIMULATING THE TUB SENSOR
        my delayedSignal 5000 Full
    }
    transition FillingForWashing - Full -> Agitating

    state Agitating {} {
        # Close water value
        puts "[self]: Closing water valve"
        # Set motor to agitate
        puts "[self]: Setting motor to agitate"
        # Signal "Done" to self delayed by the wash time.
        my variable wash
        my delayedSignal $wash Done
    }
    transition Agitating - Done -> EmptyingWashWater

    state EmptyingWashWater {} {
        # Stop motor
        puts "[self]: Stopping motor"
        # Start pump
        puts "[self]: Starting pump"

        # SIMULATING THE TUB SENSOR
        my delayedSignal 5000 Empty
    }
    transition EmptyingWashWater - Empty -> FillingForRinse

    state FillingForRinse {} {
        # Stop pump
        puts "[self]: Stopping pump"
        # Open water valve
        puts "[self]: Opening water valve"

        # SIMULATING THE TUB SENSOR
        my delayedSignal 5000 Full
    }
    transition FillingForRinse - Full -> Rinsing

    state Rinsing {} {
        # Close water valve
        puts "[self]: Closing water valve"
        # Set motor to agitate
        puts "[self]: Setting motor to agitate"
        # Signal Done to self delayed by the rinse time
        my variable rinse
        my delayedSignal $rinse Done
    }
    transition Rinsing - Done -> EmptyingRinseWater

    state EmptyingRinseWater {} {
        # Stop motor
        puts "[self]: Stopping motor"
        # Start pump
        puts "[self]: Starting pump"

        # SIMULATING THE TUB SENSOR
        my delayedSignal 5000 Empty
    }
    transition EmptyingRinseWater - Empty -> Spinning

    state Spinning {} {
        # Stop pump
        puts "[self]: Stopping pump"
        # Set motor to spin
        puts "[self]: Setting motor to spin"
        # Signal Done to self delayed by the spin time
        my variable spin
        my delayedSignal $spin Done
    }
    transition Spinning - Done -> Idle
}

# Draw the "as implemented" model
wmachine draw {-Tsvg -o%s.svg -Gsize=7.5,10}
# Create a state machine from the model
oo::class create wm_model100 {
    superclass wmachine
    constructor {} {
        next

        # Define the variables used in the state actions.
        my variable wash rinse spin 
        set wash 3000
        set rinse 3000
        set spin 4000
    }
}
wm_model100 create wm1
# Turn on tracing
wm1 loglevel info
# Kick things off
wm1 signal Run
# Wait until the cycle is complete
vwait ::wmachine(::wm1)
# Clean up
wm1 destroy
