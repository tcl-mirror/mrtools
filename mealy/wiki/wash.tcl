#!/usr/bin/env tclsh

package require mealy

# The model command specifies the characterististics of the state model
mealy model wmachine {
    # The state model is defined by executing commands to specify the
    # states and transitions of the model.

    # The "State" command defines a state and the Tcl code that is run when the
    # state is entered.
    State Idle {
        # The "Transition" command defines what happens when an event is
        # received in a state. Notice that there is no command to define the
        # events to which the model responds. The events are simply gleened
        # from the "Transition" commands. The "-" and "->" arguments are simply
        # syntactic sugar to suggest the transition from current state to new
        # state that the event causes.
        Transition Run {} {
            # Open water valve
            puts "$self: Opening water valve"

            # At this point we need the washing tub sensor to tell us that the
            # tub is full. For simplicity, we will simulate the sensor by
            # means of the Tcl "after" command.
            # SIMULATING THE TUB SENSOR
            after 5000 [list mealy generate {} - Full -> $self]
        } -> FillingForWashing
    }

    State FillingForWashing {
        Transition Full {} {
            # Close water value
            puts "$self: Closing water valve"
            # Set motor to agitate
            puts "$self: Setting motor to agitate"
            # Generate "Done" to self delayed by the wash time.
            mealy delay [$self cget wash] $self - Done -> $self
        } -> Agitating
    }

    State Agitating {
        Transition Done {} {
            # Stop motor
            puts "$self: Stopping motor"
            # Start pump
            puts "$self: Starting pump"

            # SIMULATING THE TUB SENSOR
            after 5000 [list mealy generate {} - Empty -> $self]
        } -> EmptyingWashWater
    }

    State EmptyingWashWater {
        Transition Empty {} {
            # Stop pump
            puts "$self: Stopping pump"
            # Open water valve
            puts "$self: Opening water valve"


            # SIMULATING THE TUB SENSOR
            after 5000 [list mealy generate {} - Full -> $self]
        } -> FillingForRinse
    }

    State FillingForRinse {
        Transition Full {} {
            # Close water valve
            puts "$self: Closing water valve"
            # Set motor to agitate
            puts "$self: Setting motor to agitate"
            # Generate Done to self delayed by the rinse time
            mealy delay [$self cget rinse] $self - Done -> $self
        } -> Rinsing
    }

    State Rinsing {
        Transition Done {} {
            # Stop motor
            puts "$self: Stopping motor"
            # Start pump
            puts "$self: Starting pump"

            # SIMULATING THE TUB SENSOR
            after 5000 [list mealy generate {} - Empty -> $self]
        } -> EmptyingRinseWater
    }

    State EmptyingRinseWater {
        Transition Empty {} {
            # Stop pump
            puts "$self: Stopping pump"
            # Set motor to spin
            puts "$self: Setting motor to spin"
            # Generate Done to self delayed by the spin time
            mealy delay [$self cget spin] $self - Done -> $self
        } -> Spinning
    }

    State Spinning {
        Transition Done {} {
            # Stop motor
            puts "$self: Stopping motor"

            # For testing purpose, we want to be able to run the Tcl event loop
            # and when we are done with the cycle we will use "vwait" to
            # determine that we have finished.
            set ::wmachine($self) Idle
        } -> Idle
    }
}

# Draw the "as implemented" model
wmachine draw {-Tsvg -o%s.svg -Gsize=7.5,10}
# Create a state machine from the model
wmachine machine wm1
# Set up the parameters for the state machine.
wm1 configure wash 3000 rinse 3000 spin 4000
# Turn on tracing
wm1 configure trace true
mealy::log::setlevel info
# Kick things off
mealy generate {} - Run -> wm1
# Wait until the cycle is complete
vwait ::wmachine(::wm1)
# Clean up
wm1 destroy
