#
# This software is copyrighted 2017 by G. Andrew Mangogna.
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

package require Tcl 8.6
package require comm
package require ral
package require ralutil

namespace eval ::roseaTestUtil {
    variable done 0
    variable breakActions ; array set breakActions {}

    proc call {port} {
        variable remoteid $port
        comm::comm connect $remoteid

        setupRemote
    }
    namespace export call

    proc sendCmd {args} {
        variable remoteid
        return [comm::comm send $remoteid {*}$args]
    }
    namespace export sendCmd

    proc setupRemote {} {
        sendCmd [list namespace eval ::rosea::remote {
            variable stateBreaks ; array set stateBreaks {}

            variable areBreaksEnabled false

            proc defineStateBreak {domain class state} {
                variable stateBreaks
                variable areBreaksEnabled

                set brkid $domain,$class,$state
                if {![info exists stateBreaks($brkid)]} {
                    set actproc [rosea info statemodel activityproc\
                            $domain $class $state]
                    set stateBreaks($brkid) $actproc

                    if {$areBreaksEnabled} {
                        trace add execution $actproc leave [list\
                            ::rosea::remote::stateBreakHit $brkid]
                    }
                }
            }
            namespace export defineStateBreak

            proc deleteStateBreak {domain class state} {
                variable stateBreaks
                variable areBreaksEnabled

                set brkid $domain,$class,$state
                if {[info exists stateBreaks($brkid)]} {
                    if {$areBreaksEnabled} {
                        set actproc $stateBreaks($brkid)
                        trace remove execution $actproc leave [list\
                            ::rosea::remote::stateBreakHit $brkid]
                    }
                    unset stateBreaks($brkid)
                }
            }
            namespace export deleteStateBreak

            proc enableStateBreaks {} {
                variable stateBreaks
                variable areBreaksEnabled true

                foreach brkid [array names stateBreaks] {
                    set actproc $stateBreaks($brkid)
                    trace add execution $actproc leave [list\
                        ::rosea::remote::stateBreakHit $brkid]
                }
            }
            namespace export enableStateBreaks

            proc disableStateBreaks {} {
                variable stateBreaks
                variable areBreaksEnabled false

                foreach brkid [array names stateBreaks] {
                    set actproc $stateBreaks($brkid)
                    trace remove execution $actproc leave [list\
                        ::rosea::remote::stateBreakHit $brkid]
                }
            }
            namespace export disableStateBreaks

            namespace ensemble create

            proc stateBreakHit {brkid cmd code result op} {
                variable stateBreaks

                set remoteid [lindex [comm::comm interps] end]
                lassign [split $brkid ,] domain class state
                comm::comm send $remoteid [list set ::roseaTestUtil::done\
                    [dict create Code $code Domain $domain Class $class\
                        State $state]]
            }
        }]
    }

    proc breakAtState {domain class state {action {}}} {
        sendCmd [list ::rosea::remote defineStateBreak $domain $class $state]
        if {$action ne {}} {
            variable breakActions
            set breakActions($domain,$class,$state) $action
        }
    }
    namespace export breakAtState

    proc deleteBreak {domain class state} {
        sendCmd [list ::rosea::remote deleteStateBreak $domain $class $state]
        variable breakActions
        unset -nocomplain breakActions($domain,$class,$state)
    }
    namespace export deleteBreak

    proc enableBreaks {} {
        sendCmd [list ::rosea::remote enableStateBreaks]
    }
    namespace export enableBreaks

    proc disableBreaks {} {
        sendCmd [list ::rosea::remote disableStateBreaks]
    }
    namespace export disableBreaks

    proc waitForBreak {{timeout 0}} {
        for {set waiting true} {$waiting} {} {
            if {$timeout > 0} {
                set timer [after $timeout set [namespace current]::done TIMEOUT]
            } else {
                set timer {}
            }

            vwait [namespace current]::done

            if {$timer ne {}} {
                after cancel $timer
            }

            set result [set [namespace current]::done]
            if {$result eq "TIMEOUT"} {
                error "timed out on state break point"
            } elseif {[dict get $result Code] != 0} {
                error "state activity for [dict get $result Domain]\
                    [dict get $result Class] / [dict get $result State]\
                    had result code \"[dict get $result Code]\""
            } else {
                dict with result {
                    set brkid $Domain,$Class,$State
                    variable breakActions
                    if {[info exist breakActions($brkid)]} {
                        try {
                            set breakCmd $breakActions($brkid)
                            lappend breakCmd $Domain $Class $State
                            eval $breakCmd
                        } on error {result opts} {
                            chan puts "error executing \"$breakCmd\""
                            return -options $opts $result
                            set waiting false
                        }
                    } else {
                        set waiting false
                    }
                }
            }
        }

        return $result
    }
    namespace export waitForBreak

    proc showClass {domain class} {
        set insts [sendCmd ::rosea::InstCmds::deRef "\[::${domain}::${class} findAll\]"]
        chan puts [ral relformat $insts]
    }
    namespace export showClass

    namespace ensemble create
}
