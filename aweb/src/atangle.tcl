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
#   atangle.tcl -- asciidoc literate programming
#
# ABSTRACT:
#   This file contains a Tcl script that will tangle source code contained
#   within an "asciidoc" document. It is a literate programming tool. Input
#   documents are assumed to be valid asciidoc documents that contain source
#   code within source blocks as defined by asciidoc syntax. This program will
#   look within source blocks for program chunk definitions. We use "noweb"
#   syntax, namely:
#
#   <<chunk name>>=
#
#   defines a chunk and within a chunk definition:
#
#   <<chunk name>>
#
#   refers to a chunk.
#
#*--
#

package require Tcl 8.6
package require cmdline
package require logger

set iswrapped [expr {[lindex [file system [info script]] 0] ne "native"}]
if {$iswrapped} {
    set top [file join $::starkit::topdir lib application]
} else {
    set top [file dirname [info script]]
}

source [file join $top aweb.tcl]

namespace eval ::atangle {
    namespace export main
    namespace ensemble create

    namespace import ::ral::*
    namespace import ::ralutil::*

    variable version 1.1

    variable optlist {
        {version {Print version and license, then exit}}
        {level.arg warn {Log debug level}}
        {output.arg - {Output file name}}
        {root.arg * {Root chunk to output}}
        {report {Issue chuck report}}
    }
    variable options ; array set options {}

    logger::initNamespace [namespace current]
}

proc ::atangle::main {} {
    variable optlist
    variable options
    global argv

    # Parse options
    array set options [::cmdline::getoptions ::argv $optlist]
    if {$options(version)} {
        versionInfo
        exit
    }

    # First scan the input asciidoc file finding the chunks.
    set infilename [lindex $argv 0]
    if {$infilename eq {}} {
        set infilename -
    }

    tangler create t
    t loglevel $options(level)
    t parse $infilename
    t reportUndefined

    # Emit the tangled code
    if {$options(output) ne "-"} {
        set ochan [open $options(output) w]
    } else {
        set ochan stdout
    }
    try {
        t tangle $ochan $options(root)
    } on error {result opts} {
        chan puts stderr $result
        return -options $opts
    } finally {
        if {$ochan ne "stdout"} {
            chan close $ochan
        }
    }

    # Output a report if requested.
    if {$options(report)} {
        t reportChunks stderr $options(root)
    }

    t destroy
    exit 0
}

proc ::atangle::versionInfo {} {
    variable version
    puts "atangle: version: $version"
    puts {
This software is copyrighted 2013 by G. Andrew Mangogna.
The following terms apply to all files associated with the software unless
explicitly disclaimed in individual files.

The authors hereby grant permission to use, copy, modify, distribute,
and license this software and its documentation for any purpose, provided
that existing copyright notices are retained in all copies and that this
notice is included verbatim in any distributions. No written agreement,
license, or royalty fee is required for any of the authorized uses.
Modifications to this software may be copyrighted by their authors and
need not follow the licensing terms described here, provided that the
new terms are clearly indicated on the first page of each file where
they apply.

IN NO EVENT SHALL THE AUTHORS OR DISTRIBUTORS BE LIABLE TO ANY PARTY FOR
DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING
OUT OF THE USE OF THIS SOFTWARE, ITS DOCUMENTATION, OR ANY DERIVATIVES
THEREOF, EVEN IF THE AUTHORS HAVE BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGE.

THE AUTHORS AND DISTRIBUTORS SPECIFICALLY DISCLAIM ANY WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT.  THIS SOFTWARE
IS PROVIDED ON AN "AS IS" BASIS, AND THE AUTHORS AND DISTRIBUTORS HAVE
NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS,
OR MODIFICATIONS.

GOVERNMENT USE: If you are acquiring this software on behalf of the
U.S. government, the Government shall have only "Restricted Rights"
in the software and related documentation as defined in the Federal
Acquisition Regulations (FARs) in Clause 52.227.19 (c) (2).  If you
are acquiring the software on behalf of the Department of Defense,
the software shall be classified as "Commercial Computer Software"
and the Government shall have only "Restricted Rights" as defined in
Clause 252.227-7013 (c) (1) of DFARs.  Notwithstanding the foregoing,
the authors grant the U.S. Government and others acting in its behalf
permission to use and distribute the software in accordance with the
terms specified in this license.
}
}

::oo::class create ::atangle::tangler {
    superclass ::aweb::parser

    constructor {} {
        next
    }

    destructor {
        next
    }

    method tangle {ochan root} {
        set exists [pipe {
            relvar set Chunk |
            relation restrictwith ~ {$Name eq $root} |
            relation isnotempty
        }]
        if {$exists} {
            foreach line [my GatherChunk $root] {
                chan puts $ochan $line
            }
        } else {
            error "no root chunk named, <<$root>>, was found"
        }
    }

    method GatherChunk {chunk} {
        set parts [pipe {
            relvar set Chunk |
            relation restrictwith ~ {$Name eq $chunk}
        }]
        set gathered [list]
        if {[relation isempty $parts]} {
            log::notice "elided output for reference to unknown chunk,\
                    <<$chunk>>"
        }
        relation foreach part $parts -ascending {BlockLineNum Offset} {
            set content [relation extract $part Content]
            set refs [pipe {
                relvar set ChunkRef |
                relation semijoin $part ~\
                    -using {BlockLineNum ChunkLineNum Offset ChunkOffset}
            }]
            #log::debug "\n[relformat $refs "Refs in $chunk"]"
            if {[relation isempty $refs]} {
                lappend gathered {*}$content
            } else {
                set prevOffset 0
                relation foreach ref $refs -ascending RefOffset {
                    relation assign $ref RefOffset RefToChunk Indent
                    log::debug "prevOffset = $prevOffset,\
                            RefOffset = $RefOffset"
                    lappend gathered\
                        {*}[lrange $content $prevOffset $RefOffset-1]
                    set prevOffset [expr {$RefOffset + 1}]

                    set reflines [my GatherChunk $RefToChunk]
                    set indentlines [list]
                    foreach refline $reflines {
                        lappend indentlines ${Indent}$refline
                    }
                    lappend gathered {*}$indentlines
                }
                lappend gathered {*}[lrange $content $prevOffset end]
            }
        }
        return $gathered
    }
}

atangle main
