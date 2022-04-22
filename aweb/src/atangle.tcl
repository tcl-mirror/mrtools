# This software is copyrighted 2013 - 2021 by G. Andrew Mangogna.
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

set iswrapped [expr {[lindex [file system [info script]] 0] ne "native"}]
if {$iswrapped} {
    set libdir [file join $::starkit::topdir lib]
    set appdir [file join $libdir application]
    set libs [list]
    if {$::tcl_platform(os) eq "Linux"} {
        set libs [glob -nocomplain -directory $libdir P-linux*]
    } elseif {$::tcl_platform(os) eq "Darwin"} {
        set libs [glob -nocomplain -directory $libdir P-macosx*]
    }
    foreach lib $libs {
        lappend ::auto_path $lib
    }
} else {
    set appdir [file dirname [info script]]
}

package require Tcl 8.6
package require cmdline
package require logger

source [file join $appdir aweb.tcl]

namespace eval ::atangle {
    namespace export main
    namespace ensemble create

    namespace import ::ral::*
    namespace import ::ralutil::*

    variable version 1.3.3

    variable optlist {
        {version {Print version and license, then exit}}
        {level.arg warn {Log debug level}}
        {output.arg - {Output file name or directory}}
        {root.arg * {Comma separated list of root chunks to output}}
        {line.arg {} {Emit line markers}}
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
    try {
        array set options [::cmdline::getoptions ::argv $optlist]
    } on error {result} {
        puts stderr $result
        exit 1
    }

    if {$options(version)} {
        versionInfo
        exit
    }

    variable infilename [lindex $argv 0]
    if {$infilename eq {}} {
        set infilename -
    }

    # Emit the tangled code
    # If the "-root" argument is a list, then interpret
    # the "-output" as a directory and create distinct
    # files for each requested root.
    # Otherwise, "-output" is interpreted as a file name

    set roots [lmap r [split\
            [string trim $options(root) ", "] ,] {string trim $r}]

    if {[llength $roots] > 1} {
        if {$options(output) eq "-"} {
            chan puts stderr "-output option must be supplied for\
                multiple roots: got, \"$options(output)\""
            exit 1 ;
        }
        if {[file exists $options(output)]} {
            if {![file isdirectory $options(output)]} {
                chan puts stderr "when tangling multiple rootrs,\
                    $options(output), must be a directory"
                exit 1 ;
            }
        } else {
            file mkdir $options(output)
        }
    }

    # First scan the input asciidoc file finding the chunks.
    tangler create t
    t loglevel $options(level)
    t parse $infilename
    t reportUndefined

    if {[llength $roots] > 1} {
        try {
            foreach root $roots {
                set ochan [open [file join $options(output) $root] w]
                t tangle $ochan $root
                chan close $ochan
            }
        } on error {result opts} {
            chan close $ochan
            chan puts stderr $result
            return -options $opts $result
        }
    } else {
        if {$options(output) ne "-"} {
            set ochan [open $options(output) w]
        } else {
            set ochan stdout
        }
        try {
            t tangle $ochan [lindex $roots 0]
        } on error {result opts} {
            chan puts stderr $result
            return -options $opts $result
        } finally {
            if {$ochan ne "stdout"} {
                chan close $ochan
            }
        }
    }

    # Output a report if requested.
    if {$options(report)} {
        foreach root $roots {
            t reportChunks stderr $root
        }
    }

    t destroy
    exit 0
}

proc ::atangle::versionInfo {} {
    variable version
    puts "atangle: version: $version"
    puts {
This software is copyrighted 2013-2021 by G. Andrew Mangogna.
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
            error "no root chunk definition of, <<$root>>=, was found"
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
            # log::debug "\n[relformat $part "Chunk Parts"]"
            relation assign $part Content BlockLineNum Offset FileName
            set refs [pipe {
                relvar set ChunkRef |
                relation semijoin $part ~\
                    -using {FileName FileName BlockLineNum ChunkLineNum Offset ChunkOffset}
            }]
            # log::debug "\n[relformat $refs "Refs in $chunk"]"
            set linectrl [my LineDirective\
                [expr {$BlockLineNum + $Offset +1}] $FileName]
            if {$linectrl ne {}} {
                lappend gathered $linectrl
            }
            if {[relation isempty $refs]} {
                lappend gathered {*}$Content
            } else {
                set prevOffset 0
                relation foreach ref $refs -ascending RefOffset {
                    relation assign $ref RefOffset RefToChunk Indent
                    log::debug "prevOffset = $prevOffset,\
                            RefOffset = $RefOffset"
                    lappend gathered\
                        {*}[lrange $Content $prevOffset $RefOffset-1]
                    set prevOffset [expr {$RefOffset + 1}]

                    set reflines [my GatherChunk $RefToChunk]
                    set indentlines [list]
                    foreach refline $reflines {
                        lappend indentlines ${Indent}$refline
                    }
                    lappend gathered {*}$indentlines
                }
                lappend gathered {*}[lrange $Content $prevOffset end]
            }
        }
        return $gathered
    }

    method LineDirective {linenum filename} {
        namespace upvar ::atangle options(line) linedir
        set result [regsub -all -- {%f%} $linedir $filename]
        set result [regsub -all -- {%l%} $result $linenum]
        return $result
    }
}

atangle main
