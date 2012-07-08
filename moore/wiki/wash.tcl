#!/usr/bin/env tclsh

package require moore

# The model command specifies the characterististics of the state model
moore model wmachine {
    # The state model is defined by executing commands to specify the
    # states and transitions of the model.

    # The "State" command defines a state and the Tcl code that is run when the
    # state is entered.
    State Idle {} {
        # Stop motor
        puts "$self: Stopping motor"

        # For testing purpose, we want to be able to run the Tcl event loop and
        # when we are done with the cycle we will use "vwait" to determine that
        # we have finished.
        set ::wmachine($self) Idle
    }

    # The "Transition" command defines what happens when an event is received
    # in a state. Notice that there is no command to define the events to which
    # the model responds. The events are simply gleened from the "Transition"
    # commands. The "-" and "->" arguments are simply syntactic sugar to
    # suggest the transition from current state to new state that the event
    # causes.
    Transition Idle - Run -> FillingForWashing

    State FillingForWashing {} {
        # Open water valve
        puts "$self: Opening water valve"

        # At this point we need the washing tub sensor to tell us that the
        # tub is full. For simplicity, we will simulate the sensor by
        # means of the Tcl "after" command.
        # SIMULATING THE TUB SENSOR
        after 5000 [list moore generate {} - Full -> $self]
    }
    Transition FillingForWashing - Full -> Agitating

    State Agitating {} {
        # Close water value
        puts "$self: Closing water valve"
        # Set motor to agitate
        puts "$self: Setting motor to agitate"
        # Generate "Done" to self delayed by the wash time.
        moore delay [$self cget wash] $self - Done -> $self
    }
    Transition Agitating - Done -> EmptyingWashWater

    State EmptyingWashWater {} {
        # Stop motor
        puts "$self: Stopping motor"
        # Start pump
        puts "$self: Starting pump"

        # SIMULATING THE TUB SENSOR
        after 5000 [list moore generate {} - Empty -> $self]
    }
    Transition EmptyingWashWater - Empty -> FillingForRinse

    State FillingForRinse {} {
        # Stop pump
        puts "$self: Stopping pump"
        # Open water valve
        puts "$self: Opening water valve"


        # SIMULATING THE TUB SENSOR
        after 5000 [list moore generate {} - Full -> $self]
    }
    Transition FillingForRinse - Full -> Rinsing

    State Rinsing {} {
        # Close water valve
        puts "$self: Closing water valve"
        # Set motor to agitate
        puts "$self: Setting motor to agitate"
        # Generate Done to self delayed by the rinse time
        moore delay [$self cget rinse] $self - Done -> $self
    }
    Transition Rinsing - Done -> EmptyingRinseWater

    State EmptyingRinseWater {} {
        # Stop motor
        puts "$self: Stopping motor"
        # Start pump
        puts "$self: Starting pump"

        # SIMULATING THE TUB SENSOR
        after 5000 [list moore generate {} - Empty -> $self]
    }
    Transition EmptyingRinseWater - Empty -> Spinning

    State Spinning {} {
        # Stop pump
        puts "$self: Stopping pump"
        # Set motor to spin
        puts "$self: Setting motor to spin"
        # Generate Done to self delayed by the spin time
        moore delay [$self cget spin] $self - Done -> $self
    }
    Transition Spinning - Done -> Idle
}

# Draw the "as implemented" model
wmachine draw
# Create a state machine from the model
wmachine machine wm1
# Set up the parameters for the state machine.
wm1 configure wash 3000 rinse 3000 spin 4000
# Turn on tracing
wm1 configure trace true
moore::log::setlevel info
# Kick things off
moore generate {} - Run -> wm1
# Wait until the cycle is complete
vwait ::wmachine(::wm1)
# Clean up
wm1 destroy
