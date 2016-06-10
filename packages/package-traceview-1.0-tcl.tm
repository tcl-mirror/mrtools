# ACTIVESTATE TEAPOT-PKG BEGIN TM -*- tcl -*-
# -- Tcl Module

# @@ Meta Begin
# Package traceview 1.0
# Meta category    Widget
# Meta description This package contains a TclOO class that is instanciates
# Meta description a widget to show state machine traces.
# Meta platform    tcl
# Meta require     {Tcl 8.6}
# Meta require     {Tk 8.6}
# Meta require     eventTrace
# Meta summary     Trace View -- widget to show state machine traces
# @@ Meta End


# ACTIVESTATE TEAPOT-PKG BEGIN REQUIREMENTS

package require Tcl 8.6
package require Tk 8.6
package require eventTrace

# ACTIVESTATE TEAPOT-PKG END REQUIREMENTS

# ACTIVESTATE TEAPOT-PKG BEGIN DECLARE

package provide traceview 1.0

# ACTIVESTATE TEAPOT-PKG END DECLARE
# ACTIVESTATE TEAPOT-PKG END TM
#
# Copyright 2013, InCube Labs, LLC.
# All rights reserved.  This file contains unpublished work that is
# confidential and proprietary to InCube Labs.  This document may not, in
# whole or in part, be duplicated, disclosed or used for any purposes,
# whatsoever, without written permission from InCube Labs.
#
#*++
# PROJECT:
#   Tools
#
# MODULE:
#   traceview.tcl -- tack trace display widget
#
# ABSTRACT:
#   This file contains a TclOO class that creates the necessary widgets to
#   display "tack" trace messages that arrive from the stub channel of
#   a "tack" generated test harness.
#*--
#

package require Tcl 8.6
package require Tk 8.6
package require eventTrace
package require miscutils

namespace eval ::traceview {
    namespace export tacktrace
    namespace ensemble create

    variable revision 1.0
}

::oo::class create ::traceview::tacktrace {
    variable hull

    constructor {w args} {
        # Parse arguments
        foreach {arg value} $args {
            switch -exact -- $arg {
                -mapfile {
                    set mapfile $value
                }
                -ralfile {
                    set ralfile $value
                }
                default {
                    throw {LOGVIEW BADOPT {bad option}}\
                        "bad option name, \"$arg\""
                }
            }
        }

        if {![info exists mapfile]} {
            set msg "-mapfile is a required option"
            throw [list LOGVIEW REQOPT $msg] $msg
        }
        if {![info exists ralfile]} {
            set msg "-ralfile is a required option"
            throw [list LOGVIEW REQOPT $msg] $msg
        }

        # Set up for state machine event tracing
        eventTrace setTracePlatform ELF
        eventTrace traceInit $mapfile $ralfile

        my variable saveDir
        set saveDir [pwd]
        my variable saveName
        set saveName tracelog.log

        # Now create all the Tk widgets

        # Create the inner frame that will hold the other widgets
        set hull [ttk::frame $w.hull]
        grid $hull\
            -sticky nsew
        grid rowconfigure $hull 1 -weight 1
        grid columnconfigure $hull 0 -weight 1

        # Add traces to clean up. Destroy the hull window if the object
        # is deleted. Destroy the object if the widget is destroyed.
        trace add command [self] delete [list catch [list destroy $hull]]
        trace add command $hull delete [namespace code {catch {my destroy}}]

        # We use three frames to hold the selection controls and trace output
        set selframe [ttk::labelframe $hull.selframe\
            -text "Source Selection"\
        ]
        set outframe [ttk::frame $hull.outframe]
        set ctrlframe [ttk::labelframe $hull.ctrlframe\
            -text "Output Control"\
        ]

        grid $selframe\
            -sticky nsew
        grid $outframe\
            -sticky nsew
        grid rowconfigure $outframe 0 -weight 1
        grid columnconfigure $outframe 0 -weight 1
        grid $ctrlframe\
            -sticky nsew

        my variable traceColors ; array set traceColors [list\
            stub     [miscutils hashcolor stub]\
            trace    [miscutils hashcolor trace]\
            instr    [miscutils hashcolor instr]\
            error    [miscutils hashcolor error]\
        ]

        # Selection controls determine which parts of the trace data are shown.
        my variable select_stub
        set select_stub 1
        checkbutton $selframe.stub\
            -background $traceColors(stub)\
            -text Stubs\
            -command [namespace code {my SelectTrace stub}]\
            -variable [my varname select_stub]
        my variable select_trace
        set select_trace 1
        checkbutton $selframe.trace\
            -background $traceColors(trace)\
            -text Events\
            -command [namespace code {my SelectTrace trace}]\
            -variable [my varname select_trace]
        my variable select_instr
        set select_instr 1
        checkbutton $selframe.instr\
            -background $traceColors(instr)\
            -text Instrumentation\
            -command [namespace code {my SelectTrace instr}]\
            -variable [my varname select_instr]
        ttk::button $selframe.mark\
            -text Mark\
            -command [namespace code {my DisplayMark}]
        ttk::entry $selframe.comment
        bind $selframe.comment <Key-Return> [namespace code {my DisplayMark}]

        grid\
            $selframe.trace\
            $selframe.stub\
            $selframe.instr\
            $selframe.mark\
            -padx 5\
            -pady 5
        grid $selframe.comment\
            -row 0\
            -column 4\
            -padx 5\
            -pady 5\
            -sticky ew
        grid columnconfigure $selframe 4 -weight 1

        # The output is to a text widget with tags to color the various types
        # of output.
        text $outframe.text\
            -wrap none\
            -setgrid true\
            -insertwidth 0\
            -yscrollcommand [list $outframe.vsb set]\
            -xscrollcommand [list $outframe.hsb set]
        $outframe.text tag configure stub -background $traceColors(stub)
        $outframe.text tag configure trace -background $traceColors(trace)
        $outframe.text tag configure instr -background $traceColors(instr)
        $outframe.text tag configure error -background $traceColors(error)
        $outframe.text tag configure mark -background black -foreground white

        ttk::scrollbar $outframe.vsb\
            -orient vertical\
            -command [list $outframe.text yview]

        ttk::scrollbar $outframe.hsb\
            -orient horizontal\
            -command [list $outframe.text xview]

        grid $outframe.text\
            -row 0\
            -column 0\
            -sticky nsew
        grid $outframe.vsb\
            -row 0\
            -column 1\
            -sticky nsew
        grid $outframe.hsb\
            -row 1\
            -column 0\
            -columnspan 2\
            -sticky nsew
        grid rowconfigure $outframe 0 -weight 1
        grid columnconfigure $outframe 0 -weight 1

        # Some controls scrolling and saving.
        ttk::button $ctrlframe.save\
            -text Save\
            -command [namespace code {my SaveTrace false}]
        ttk::button $ctrlframe.saveall\
            -text "Save All"\
            -command [namespace code {my SaveTrace true}]
        ttk::button $ctrlframe.clear\
            -text Clear\
            -command [namespace code {my ClearTrace}]
        my variable trace_freeze
        set trace_freeze 0
        ttk::checkbutton $ctrlframe.freeze\
            -text "Freeze Scrolling"\
            -variable [my varname trace_freeze]
        grid\
            $ctrlframe.save\
            $ctrlframe.saveall\
            $ctrlframe.clear\
            $ctrlframe.freeze\
            -padx 5\
            -pady 5
    }

    # Receive method
    # This method expects a "line" containing the data received from a
    # "tack" stub channel. Callers should arrange to set up the
    # a non-blocking I/O on the stub channel and then call this method
    # with each line received on the channel.
    method receive {line} {
        if {[string length $line] == 0} {
            return
        }

        try {
            lassign $line type content
            switch -exact -- $type {
                stub {
                    my DisplayStub $content
                }

                trace {
                    my DisplayEvent $content
                }

                instrument {
                    my DisplayInstr $content
                }

                fatal {
                    my DisplayError $content
                }

                default {
                    my DisplayLine "unknown message type, \"$type\": $line"
                }
            }
        } on error {result opts} {
            my DisplayLine $result
            my DisplayLine $line
        }

        return
    }

    method SelectTrace {ttype} {
        my variable select_$ttype
        $hull.outframe.text tag configure $ttype\
            -elide [expr {[set select_$ttype] == 0}]
    }

    method DisplayTagged {tagname msg} {
        set t $hull.outframe.text
        $t insert end $msg\n $tagname
        my variable trace_freeze
        if {!$trace_freeze} {
            $t see end
        }
    }

    method DisplayStub {content} {
        if {[dict exists $content time]} {
            append msg [my FmtTime [dict get $content time]]
        }
        append msg "[dict get $content domain]_[dict get $content eop]("
        foreach {name value} [dict get $content parameters] {
            append msg "$value => $name, "
        }
        set msg [string trimright $msg ", "]
        append msg ")"

        my DisplayTagged stub $msg
    }

    method DisplayEvent {content} {
        if {[catch {eventTrace formatTrace $content} result]} {
            set fmttrace [eventTrace ptrace $content]
        } else {
            set fmttrace [eventTrace ptrace $result]
        }
        my DisplayTagged trace $fmttrace
    }

    method DisplayInstr {content} {
        if {[dict exists $content time]} {
            append msg [my FmtTime [dict get $content time]]
        }
        append msg "[dict get $content func]()\
                [dict get $content file]:[dict get $content line]"

        my DisplayTagged instr $msg
    }

    method DisplayError {content} {
        if {[dict exists $content time]} {
            append msg [my FmtTime [dict get $content time]]
        }
        append msg [dict get $content msg]

        my DisplayTagged error "Fatal error: $msg"
    }

    method DisplayMark {} {
        my DisplayTagged mark "[my FmtTime [clock seconds].000] Mark:\
            [$hull.selframe.comment get]"
    }

    method DisplayLine {msg} {
        my DisplayTagged error $msg
    }

    method FmtTime {time} {
        lassign [split $time .] secs msecs
        return "[clock format $secs\
                -format "%Y/%m/%d %T.[format %03u $msecs]"]: "
    }

    method SaveTrace {all} {
        my variable saveDir
        my variable saveName
        set file [tk_getSaveFile\
            -filetypes {{{Log Files} .log} {{All Files} *}}\
            -initialdir $saveDir\
            -initialfile $saveName\
            -parent .\
            -title "Trace Log Save File"\
        ]

        if {$file ne {}} {
            set saveDir [file dirname $file]
            set saveName [file tail $file]

            set f [open $file w]
            try {
                chan puts -nonewline $f\
                        [eval $hull.outframe.text get\
                        [expr {$all ? {} : "-displaychars"}] -- 1.0 end]
            } finally {
                close $f
            }
        }
    }

    method ClearTrace {} {
        $hull.outframe.text delete 1.0 end
    }
}

package provide traceview $::traceview::revision
