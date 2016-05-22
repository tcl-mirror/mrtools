# This software is copyrighted 2011-2016 by G. Andrew Mangogna.  The following
# terms apply to all files associated with the software unless explicitly
# disclaimed in individual files.
# 
# The author hereby grants permission to use, copy, modify, distribute,
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
#*--

package require tcltest
package require ral
package require ralutil
package require logger

namespace eval ::validateutils {
    namespace export indexFiles
    namespace export forgetFiles
    namespace export matchLines
    namespace export genMiccaFile
    namespace export compileFiles
    namespace ensemble create

    namespace import ::tcltest::*
    namespace import ::ral::*
    namespace import ::ralutil::*

    relvar create ContentMap {
        FileName    string
        LineNo      int
        Line        string
    } {FileName LineNo}

    variable keepTemps false
    variable version 1.0

    ::logger::initNamespace [namespace current] ; # debug
}

# Create an index to a file so we may search it later.
proc ::validateutils::indexFiles {args} {
    foreach fname $args {
        set lineno 0
        set file [open $fname r]
        try {
            while {[gets $file line] >= 0} {
                incr lineno
                relvar insert ContentMap [list\
                    FileName    $fname\
                    LineNo      $lineno\
                    Line        [string trim $line]\
                ]
            }
        } on error {result opts} {
            return -options $opts $result
        } finally {
            close $file
        }
    }
    # log::debug \n[relformat [relvar set ContentMap] ContentMap]
}

proc ::validateutils::forgetFiles {} {
    relvar set ContentMap [relation emptyof [relvar set ContentMap]]
    return
}

# Returns a list of line numbers where "matchString" occurs in "fname".
# "matchString" is assumed to contain ASCII records.
proc ::validateutils::matchLines {fname matchString} {
    # We assume the empty sting matches nothing.
    if {[string length $matchString] == 0} {
        return [list]
    }
    # Strip any leading or trailing whitespace
    set matchString [string trim $matchString]
    # Split the matching lines and remove any leading or trailing
    # whitespace on each line.
    set matchLines [list]
    foreach line [split $matchString \n] {
        lappend matchLines [string trim $line]
    }
    set matchString [join $matchLines \n]
    set nlines [llength $matchLines]
    set first [lindex $matchLines 0]

    variable ContentMap
    # This query is:
    # 1. Find all the lines in the given file that match the first line
    # 2. Extend that result with a relation valued attribute that consists
    #    of the matching line and all the subsequent lines for the same
    #    number of lines as in "matchString"
    # 3. Further restrict the result so that the sequence of lines actually
    #    matches "matchString". We do this by extracting the relation valued
    #    attribute, obtaining a list of the Line data in order of LineNo,
    #    joining that back into ASCII records and comparing against the
    #    value of "matchString".
    # 4. Obtain the list of line number for those tuples that match above.
    set possible [pipe {
        relation restrictwith $ContentMap {\
            $FileName eq $fname && $Line eq $first} |
        relation extend ~ ls\
            LineSeq {Relation {FileName string LineNo int Line string}} {\
            [relation restrict $ContentMap cm {\
                [tuple extract $cm FileName] eq $fname &&\
                [tuple extract $cm LineNo] >= [tuple extract $ls LineNo]\
                && [tuple extract $cm LineNo] < [expr {\
                    [tuple extract $ls LineNo] + $nlines}]}]}
    }]
    # log::debug \n[relformat $possible possible]
    set seqs [pipe {
        relation restrict $possible mh {\
            [join [relation list [tuple extract $mh LineSeq] Line\
                -ascending LineNo] \n] eq $matchString} |
        relation list ~ LineNo
    }]

    # log::debug "seqs = $seqs"
    return [expr {[llength $seqs] != 0}]
}

proc ::validateutils::genMiccaFile {domain content args} {
    variable keepTemps
    if {!$keepTemps} {
        makeFile {} $domain.c
        makeFile {} $domain.h
    }

    micca configure $content
    micca generate {*}$args
    indexFiles $domain.c $domain.h
}

proc ::validateutils::compileFiles {args} {
    set osuffix [expr {$::tcl_platform(os) eq "Windows" ? "obj" : "o"}]
    foreach fname $args {
        puts -nonewline [exec -keepnewline -- cc -c -std=c11 -Wall $fname 2>@1]
        file delete [file rootname $fname].$osuffix
    }
}

package provide validateutils $::validateutils::version
