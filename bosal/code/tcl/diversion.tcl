package require tcl::chan::events
package require tcl::chan::fifo
package require struct::stack
package require oo::util
package require textutil::adjust

oo::class create diverter {
    variable chan_stack
    constructor {{prefix {    }}} {
        my variable level_prefix
        set level_prefix $prefix
        classvariable stack_counter
        set chan_stack [::struct::stack s_[incr stack_counter]]
        $chan_stack push [::tcl::chan::fifo]
    }
    destructor {
        foreach dchan [$chan_stack get] {
            chan close $dchan
        }
        $chan_stack destroy
    }
    method puts {args} {
        set nargs [llength $args]
        set curr_chan [$chan_stack peek]
        if {$nargs == 1} {
            chan puts $curr_chan [lindex $args 0]
        } elseif {$nargs == 2} {
            lassign $args opt str
            chan puts $opt $curr_chan $str
        } else {
            error "wrong # of arguments: expected, \"puts ?-nonewline? string\""
        }
    }
    method push {} {
        $chan_stack push [::tcl::chan::fifo]
    }
    method pop {} {
        set top_chan [$chan_stack pop]
        chan flush $top_chan

        set curr_chan [$chan_stack peek]
        my variable level_prefix
        set diverted [::textutil::adjust::indent\
                [chan read $top_chan] $level_prefix]
        chan puts $curr_chan $diverted

        chan close $top_chan
    }
    method undivert {} {
        while {[$chan_stack size] > 1} {
            my pop
        }
        set curr_chan [$chan_stack peek]
        chan flush $curr_chan
        return [chan read $curr_chan]
    }
}

diverter create d1

d1 puts "line 1"
d1 push
d1 puts "div 1"
d1 puts "div 1"
d1 push
d1 puts "div 2"
d1 puts "div 2"
d1 pop
d1 pop
d1 puts "line 2"
d1 push
d1 puts "div 3"

puts -nonewline [d1 undivert]

puts "**********"

d1 puts "line 3"
d1 puts "line 4"
puts -nonewline [d1 undivert]

d1 destroy
