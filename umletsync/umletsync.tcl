# This software is copyrighted 2013 by G. Andrew Mangogna.
# The following terms apply to all files associated with the software unless
# explicitly disclaimed in individual files.
# 
# The authors hereby grant permission to use, copy, modify, distribute,
# and license this software and its documentation for any purpose, provided
# that existing copyright notices are retained in all copies and that this
# notice is included verbatim in any distributions. No written agreement,
# license, or royalty fee is required for any of the authorized uses.
# Modifications to this software may be copyrighted by their authors and
# need not follow the licensing terms described here, provided that the
# new terms are clearly indicated on the first page of each file where
# they apply.
# 
# IN NO EVENT SHALL THE AUTHORS OR DISTRIBUTORS BE LIABLE TO ANY PARTY FOR
# DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING
# OUT OF THE USE OF THIS SOFTWARE, ITS DOCUMENTATION, OR ANY DERIVATIVES
# THEREOF, EVEN IF THE AUTHORS HAVE BEEN ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
# 
# THE AUTHORS AND DISTRIBUTORS SPECIFICALLY DISCLAIM ANY WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT.  THIS SOFTWARE
# IS PROVIDED ON AN "AS IS" BASIS, AND THE AUTHORS AND DISTRIBUTORS HAVE
# NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS,
# OR MODIFICATIONS.
# 
# GOVERNMENT USE: If you are acquiring this software on behalf of the
# U.S. government, the Government shall have only "Restricted Rights"
# in the software and related documentation as defined in the Federal
# Acquisition Regulations (FARs) in Clause 52.227.19 (c) (2).  If you
# are acquiring the software on behalf of the Department of Defense,
# the software shall be classified as "Commercial Computer Software"
# and the Government shall have only "Restricted Rights" as defined in
# Clause 252.227-7013 (c) (1) of DFARs.  Notwithstanding the foregoing,
# the authors grant the U.S. Government and others acting in its behalf
# permission to use and distribute the software in accordance with the
# terms specified in this license.
#
#*++
# PROJECT:
#   mrtools
#
# MODULE:
#   umletsync.tcl -- sync UMLet state model diagrams to asciidoc documents
#
# ABSTRACT:
#   This file contains a Tcl script that will extract state actions from
#   an UMLet diagram and insert them into an asciidoc document.
#
#*--

set iswrapped [expr {[lindex [file system [info script]] 0] ne "native"}]
if {$iswrapped} {
    set pdir [file join $::starkit::topdir lib P-[::platform::identify]]
    if {$pdir ni $::auto_path} {
        lappend ::auto_path $pdir
    }
}

package require Tcl 8.6
package require tdom
package require ral
package require ralutil
package require struct::list
package require logger
package require oomoore
package require cmdline

namespace eval ::umletsync {
    namespace export substAsciidocFile
    namespace ensemble create

    variable version 1.1
}

# All the work is done here.
proc ::umletsync::substAsciidocFile {ifile level report nodiffs} {
    set parser [ActionSync new [expr {!$nodiffs}]]
    namespace eval [info object namespace $parser] [list log::setlevel $level]
    try {
        set ichan [open $ifile r]
        try {
            set ochan [file tempfile ofilename]
            try {
                $parser parse $ichan $ochan
                if {$report} {
                    chan puts stderr [$parser report]
                }
            } finally {
                chan close $ochan
            }
        } finally {
            chan close $ichan
        }
    } finally {
        $parser destroy
    }
    file rename -force -- $ifile $ifile.bak
    file rename -- $ofilename $ifile
}

# We use an oomoore state model to keep track of where we are in the
# asciidoc document. Lines in the asciidoc file
# are "lexically analyzed" and used to generate one of the following events.
#   NewLine -- ordinary line, just passed through.
#   BlockMarker -- a line of four or more hyphens
#   ActionRequest -- a line of the form, "// %Action <class> <state>%, that
#       will cause the next source block to be substituted.

::oomoore model create ::umletsync::DocParser {
    # In a document. Here we just output lines unchanged.
    state InDocument {line} {
        my variable ochan
        chan puts $ochan $line
    }
    transition InDocument - NewLine -> InDocument
    transition InDocument - BlockMarker -> InDocument
    transition InDocument - ActionRequest -> ActionRequested

    # An action substitution has been seen
    # so we store away the action and start looking
    # for the next source block.
    state ActionRequested {line smact} {
        my variable ochan
        chan puts $ochan $line
        my variable action
        set action $smact
    }
    transition ActionRequested - NewLine -> LookingForActionBlock
    transition ActionRequested - BlockMarker -> FoundActionBlock
    transition ActionRequested - ActionRequest -> ActionRequested

    # Waiting for the source block marker. Just output the lines.
    state LookingForActionBlock {line} {
        my variable ochan
        chan puts $ochan $line
    }
    transition LookingForActionBlock - NewLine -> LookingForActionBlock
    transition LookingForActionBlock - BlockMarker -> FoundActionBlock
    transition LookingForActionBlock - ActionRequest -> ActionRequested

    # Found the marker block that occurs after the action request.
    # Insert the action into the output and prepare to save away the
    # old action.
    state FoundActionBlock {line} {
        my variable ochan
        chan puts $ochan $line
        my variable action
        chan puts $ochan [join $action \n]
        my variable oldaction
        set oldaction [list]
    }
    transition FoundActionBlock - NewLine -> AccumOldAction
    transition FoundActionBlock - BlockMarker -> ActionDone
    # Action requests in the middle of the source block are just
    # passed through to the output.
    transition FoundActionBlock - ActionRequest -> AccumOldAction

    # Save each line of the old action so we can compute any difference later.
    state AccumOldAction {line} {
        my variable oldaction
        lappend oldaction $line
    }
    transition AccumOldAction - NewLine -> AccumOldAction
    transition AccumOldAction - BlockMarker -> ActionDone
    transition AccumOldAction - ActionRequest -> AccumOldAction

    # At the end of the substituted action, compute the difference between what
    # was extracted from the UMLet diagram and what was already there.  This
    # will clue you into any potential changes that need to be made in the "C"
    # code that implements the action.
    state ActionDone {line} {
        my variable ochan
        chan puts $ochan $line
        my variable action
        my variable oldaction
        my variable insertDiffs
        if {$insertDiffs} {
            # diff the old and new actions and place into the output
            # in the form of a comment block.
            set diffs [my DiffActions $oldaction $action]
            if {$diffs ne {}} {
                chan puts $ochan ////////
                chan puts $ochan "***** ACTION DIFFERENCE BEGIN *****"
                chan puts $ochan $diffs
                chan puts $ochan "***** ACTION DIFFERENCE END *****"
                chan puts $ochan ////////
            }
        }
    }
    transition ActionDone - NewLine -> InDocument
    transition ActionDone - BlockMarker -> InDocument
    transition ActionDone - ActionRequest -> ActionRequested
}

# This class uses the above state model as its supertype and then
# performs the "lexical analysis" and feeds the results as a
# series of events into the state machine.

::oo::class create ::umletsync::ActionSync {
    superclass ::umletsync::DocParser

    constructor {doDiffs} {
        next

        my variable insertDiffs
        set insertDiffs $doDiffs

        namespace import ::ral::*
        namespace import ::ralutil::*

        relvar create SMFile {
            File        string
            Class       string
        } File Class

        relvar create SMAction {
            Class       string
            State       string
            Action      string
            Accessed    int
        } {Class State}

        relvar association R1\
            SMAction Class *\
            SMFile Class 1
    }

    destructor {
        next
    }

    # This method reads the input line by line and determines the event to
    # generate to the parsing state model. Each generated event is given the
    # "line" as a parameter. Here we also deal with the requests that interact
    # with the UMLet diagram.
    method parse {ichan outc} {
        my variable ochan
        set ochan $outc
        set lineno 1
        while {[gets $ichan line] >= 0} {
            if {[regexp -- {^//\s*%(.*)$} $line match cmd]} {
                # Check if this is a request.
                set cmd [string trim $cmd]
                set first [lindex $cmd 0]
                # We recognize two kinds of requests. One to specify the UMLet
                # file that contains the state model for a given class and one
                # to request the action for a class be inserted into the next
                # source block. These two requests are mapped to internal
                # methods to fulfill.
                switch -exact -- $first {
                    States {
                        try {
                            my {*}$cmd
                        } on error {result} {
                            set errmsg "States command failed:\
                                    line ${lineno}: $result"
                            log::error $errmsg
                            append line \n\
                                "////////\n"\
                                "***** STATES ERROR *****\n"\
                                $errmsg\n\
                                "////////"
                            return -level 0
                        }
                        my receive NewLine $line
                    }
                    Action {
                        try {
                            set actiontext [my {*}$cmd]
                        } on error {result} {
                            set errmsg "Action command failed:\
                                    line ${lineno}: $result"
                            log::error $errmsg
                            # If the action fails, then we push the error
                            # message and the specification line into the state
                            # machine as if it was an ordinary piece of text.
                            append line \n\
                                "////////\n"\
                                "***** ACTION ERROR *****\n"\
                                $errmsg\n\
                                "////////"
                            my receive NewLine $line
                            return -level 0 -code continue
                        }
                        my receive ActionRequest $line $actiontext
                    }
                    default {
                        log::error "ignoring unknown substitution command,\
                                \"$cmd\", on line $lineno"
                    }
                }
            } elseif {[regexp -- {^-{4,}\s*$} $line]} {
                # Otherwise look for a block marker.
                my receive BlockMarker $line
            } else {
                # Finally, just an ordinary line.
                my receive NewLine $line
            }
            incr lineno
        }
    }

    # This method generates a report of the details of the substitution
    # performed. It should be invoked after the "parse" method is invoked.
    method report {} {
        append result\
            "State models for the following classes were specified:\n"\
            [relformat [relvar set SMFile]] \n\
            "The following state actions were NOT ACCESSED:\n"\
            [pipe {
                relvar set SMAction |
                relation restrictwith ~ {$Accessed == 0} |
                relation project ~ Class State Accessed |
                relformat ~
            }] \n\
            "The following state actions were ACCESSED MULTIPLE TIMES:\n"\
            [pipe {
                relvar set SMAction |
                relation restrictwith ~ {$Accessed > 1} |
                relation project ~ Class State Accessed |
                relformat ~
            }]

        return $result
    }

    # Fetch the state actions from an UMLet diagram file. The file is XML. It
    # is read and the interesting contents are inserted into relvars for later
    # query.
    method States {uxffile class} {
        relvar insert SMFile [list\
            File        $uxffile\
            Class       $class\
        ]
        log::debug \n[relformat [relvar set SMFile] SMFile]

        # Parse the UMLet XML file.
        set xchan [open $uxffile r]
        try {
            set doc [dom parse -channel $xchan]
            try {
                # Select the nodes that hold a State. The "panel_attributes"
                # element contains the text shown in the state node.
                set selected [$doc selectNodes\
                    {/diagram[@program='umlet']/element[type='com.umlet.element.custom.State']/panel_attributes}]

                foreach pa $selected {
                    # The text of the node has be parsed to separate the name
                    # of the state from the action statements.
                    lassign [my ParseActionText [$pa asText]] state action
                    relvar insert SMAction [list\
                        Class       $class\
                        State       $state\
                        Action      $action\
                        Accessed    0\
                    ]
                }
                log::debug \n[relformat [relvar set SMAction] SMAction]
            } on error {result opts} {
                log::error $result
                return -options $opts
            } finally {
                $doc delete
            }
        } on error {result opts} {
            log::error $result
            return -options $opts
        } finally {
            chan close $xchan
        }
    }

    # Fetch the action for a given class and state and return it.
    method Action {class state} {
        set actrel [relvar restrictone SMAction Class $class State $state]
        if {[relation isempty $actrel]} {
            error "cannot find state action for class, \"$class\",  and\
                state, \"$state\""
        } else {
            relvar updateone SMAction sma [list Class $class State $state] {
                tuple update $sma Accessed\
                        [expr {[tuple extract $sma Accessed] + 1}]
            }
        }
        return [relation extract $actrel Action]
    }

    # The text of the state action in the UMLet file is of the following form:
    #
    # attr=value
    # ...
    # <state name>
    # __
    # <state action>
    #
    # where there are optionally some attribute/value pairs at the beginning
    # followed by the state name on a line by itself followed by a line
    # consisting of two underscores (__) followed by the action body.
    # The two underscores are rendered graphically by a horizontal line
    # and we will insist that the state name appear on the previous line.
    #
    # This proc returns a list of state name / action body. The action
    # body is in turn a list of the lines of text of the state action.
    method ParseActionText {text} {
        set lines [split [string trim $text] \n]
        set div [lsearch -exact $lines --]
        if {$div < 1} {
            error "cannot find underscore divider in \"$text\""
        }
        return [list [string trim [lindex $lines $div-1]]\
            [lrange $lines $div+1 end]]
    }

    # Compute the difference between two strings (that are presumably
    # state actions) and return a printable string of that difference.
    method DiffActions {old new} {
        set lcsdata  [::struct::list longestCommonSubsequence $old $new ]
        set diffdata [::struct::list lcsInvertMerge $lcsdata\
            [llength $old] [llength $new]]

        # format the result
        set result {}
        foreach item $diffdata {
            lassign $item kind idx1 idx2
            switch -exact $kind {
                added {
                    append result "@@ [lindex $idx2 0] add" \n
                    foreach line [lrange $new {*}$idx2] {
                        append result "+$line" \n
                    }
                    append result \n
                }
                deleted {
                    append result "@@ [lindex $idx1 0] delete" \n
                    foreach line [lrange $old {*}$idx1] {
                        append result "-$line" \n
                    }
                    append result \n
                }
                changed {
                    append result "@@ [lindex $idx1 0] change" \n
                    foreach line [lrange $old {*}$idx1] {
                        append result "-$line" \n
                    }
                    foreach line [lrange $new {*}$idx2] {
                        append result "+$line" \n
                    }
                    append result \n
                }
            }
        }
        return [string trimright $result]
    }
}

variable optlist {
    {version {Version number}}
    {report {Report on action substitution}}
    {nodiffs {Do not insert action differences}}
    {level.arg warn {Debug level}}
}
set usage "\[options] filename\noptions:"
array set options [::cmdline::getoptions ::argv $optlist $usage]

if {$options(version)} {
    chan puts "[::cmdline::getArgv0] version: $::umletsync::version"
    exit 0
}

set filename [lindex $argv 0]
if {$filename eq {}} {
    ::cmdline::usage $optlist $usage
}

umletsync substAsciidocFile $filename $options(level) $options(report)\
        $options(nodiffs)
