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
package require ral
package require ralutil
package require cmdline
package require logger
package require oomoore

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

    ::logger::setlevel $options(level)

    # First scan the input asciidoc file finding the chunks.
    set infilename [lindex $argv 0]
    if {$infilename eq {}} {
        chan puts stderr [cmdline::usage $optlist "<options> <file>\noptions:"]
        exit 1
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

# We define a state model to parse the asciidoc source.
::oo::class create ::atangle::tangler {
    superclass [::oomoore model new {
        state InDocument {line num} {
            my variable prevline
            if {[my IsSourceMarker $line]} {
                # There is an ambiguity associated with dashes and one form of
                # title markup. We examine the previous line and if it is a
                # command or the number of dashes is more than two off from the
                # length of the title text, then we assume the dashes mark a
                # source boundary.  This is to handle cases such as:
                #
                # My Title
                # --------
                #
                # and allow cases such as:
                #
                # .Paragraph Title
                # ----
                #
                set prevlen [string length $prevline]
                set linelen [string length $line]
                set first [string index $prevline 0]
                set iscmd [expr {$first in {. [}}]
                if {$iscmd || abs($prevlen - $linelen) > 2} {
                    log::debug "line = \"$line\", num = \"$num\""
                    set prevline {}
                    my receive SourceMark
                    return
                }
            }
            set prevline $line
        }
        transition InDocument - NewLine -> InDocument
        transition InDocument - SourceMark -> InSource

        state InSource {} {
        }
        transition InSource - NewLine -> BeginSource

        state BeginSource {line num} {
            log::debug "line = \"$line\", num = \"$num\""
            if {[regexp -- {^<<([^>]+)>>=$} $line match name]} {
                my StartChunk $name $line $num
                my receive ChunkMark
            } elseif {[my IsSourceMarker $line]} {
                my receive SourceMark
            }
        }
        transition BeginSource - ChunkMark -> InChunk
        transition BeginSource - SourceMark -> OutSource
        transition BeginSource - NewLine -> BeginSource

        state InChunk {} {
        }
        transition InChunk - NewLine -> GatherChunk

        state GatherChunk {line num} {
            log::debug "line = \"$line\", num = \"$num\""
            if {[my IsSourceMarker $line]} {
                my EndChunk $num
                my receive SourceMark
            } elseif {[regexp -- {^<<([^>]+)>>=$} $line match chname]} {
                # We allow for multiple chunks to be defined within the same
                # source block.
                my EndChunk $num
                my StartChunk $chname $line $num
                my receive ChunkMark
            } else {
                my variable chunk
                lappend chunk $line

                my variable offset name lineno
                if {[regexp -- {^(\s*)<<([^>]+)>>\s*$} $line match ind ref]} {
                    relvar insert ChunkRef [list\
                        Name        $name\
                        LineNo      $lineno\
                        Offset      $offset\
                        RefChunk    $ref\
                        Indent      $ind\
                    ]
                }
                incr offset
            }
        }
        transition GatherChunk - NewLine -> GatherChunk
        transition GatherChunk - SourceMark -> OutSource
        transition GatherChunk - ChunkMark -> InChunk

        state OutSource {} {
            my variable prevline
            set prevline {}
        }
        transition OutSource - NewLine -> InDocument
    }]

    constructor {} {
        next

        namespace import ::ral::*
        namespace import ::ralutil::*
        # Define a set of relvars that will hold the parsed chunks and their
        # references.
        relvar create Chunk {
            Name        string
        } Name

        relvar create ChunkPart {
            Name        string
            BeginLineNo int
            EndLineNo   int
            Content     string
        } {Name BeginLineNo}

        relvar association R1\
            ChunkPart Name +\
            Chunk Name 1

        relvar create ChunkRef {
            Name        string
            LineNo      int
            Offset      int
            RefChunk    string
            Indent      string
        } {Name LineNo Offset}

        # This is a weak association on the "Chunk" side to allow for the
        # creation of references to non-existent chunks. We catch that in code,
        # but it is convenient to allow such references.
        relvar association R2\
            ChunkRef RefChunk *\
            Chunk Name ?

        relvar association R3\
            ChunkRef {Name LineNo} *\
            ChunkPart {Name BeginLineNo} 1

        my variable prevline
        set prevline {}
    }

    method parse {infilename} {
        my variable infile
        set infile $infilename
        set ichan [open $infilename r]
        try {
            set lineno 1
            relvar eval {
                # We read the file, line by line so that we can count the
                # lines for diagnostic purposes.
                for {set lcnt [chan gets $ichan line]} {$lcnt >= 0}\
                        {set lcnt [chan gets $ichan line]} {
                    # Simple synchronous push of events to the parsing state
                    # model.
                    my receive NewLine $line $lineno
                    incr lineno
                }
            }
        } on error {result opts} {
            chan puts stderr $result
            return -options $opts
        } finally {
            chan close $ichan
        }
        log::debug \n[relformat [relvar set Chunk] Chunk]
        log::debug \n[relformat [relvar set ChunkPart] ChunkPart]
        log::debug \n[relformat [relvar set ChunkRef] ChunkRef]
    }

    method reportUndefined {} {
        # Report any references to undefined chunks
        set undefs [pipe {
            relvar set ChunkRef |
            relation semiminus [relvar set Chunk] ~ -using {Name RefChunk}
        }]
        log::debug \n[relformat $undefs undefs]

        my variable infile
        relation foreach undef $undefs -ascending LineNo {
            relation assign $undef
            # +1 to go from offsets to line numbers
            log::notice "$infile: line: [expr {$LineNo + $Offset + 1}],\
                in chunk \"$Name\": reference to chunk, <<$RefChunk>>,\
                that does not exist"
        }
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

    method reportChunks {chan root} {
        chan puts $chan "Tangle Report"
        chan puts $chan =======================================\n

        chan puts $chan "Chunk Definitions"
        set chunks [pipe {
            relvar set ChunkPart |
            relation project ~ Name BeginLineNo |
            relation group ~ LineNos BeginLineNo |
            relation extend ~ cp Lines list {
                [relation list [tuple extract $cp LineNos]\
                    BeginLineNo -ascending BeginLineNo]} |
            relation project ~ Name Lines |
            relation rename ~ Name "Chunk Name" Lines "Defined On Line(s)"
        }]
        chan puts $chan [relformat $chunks {} {{Chunk Name}}]

        set missing [pipe {
            relvar set Chunk |
            relation restrictwith ~ {$Name ne $root} |
            relation semiminus ~ [relvar set ChunkRef] -using {Name RefChunk} |
            relation extend ~ rf "Referenced At" int {
                [tuple extract $rf LineNo] + [tuple extract $rf Offset] + 1
            } |
            relation project ~ RefChunk "Referenced At" |
            relation rename ~ RefChunk "Chunk Name"
        }]
        chan puts $chan =======================================\n
        chan puts $chan "Chunks Referenced but not Defined"
        chan puts $chan [relformat $missing {} {{Chunk Name}}]

        set orphans [pipe {
            relvar set Chunk |
            relation restrictwith ~ {$Name ne $root} |
            relation rename ~ Name RefChunk |
            rvajoin ~ [relvar set ChunkRef] Refs |
            relation restrict ~ r {[relation isempty [tuple extract $r Refs]]} |
            relation project ~ RefChunk |
            relation semijoin ~ [relvar set ChunkPart] -using {RefChunk Name} |
            relation project ~ Name BeginLineNo |
            relation rename ~ Name "Chunk Name" BeginLineNo "Defined on Line"
        }]
        chan puts $chan =======================================\n
        chan puts $chan "Chunks Defined but not Referenced"
        chan puts $chan [relformat $orphans {} {{Chunk Name}}]
    }

    # asciidoc markup requires at least 4 dashes to indicate the start or
    # end of a source block.
    method IsSourceMarker {line} {
        return [regexp -- {^-{4,}\s*$} $line]
    }

    method StartChunk {chname chline chnum} {
        log::debug "Chunk start @ $chnum: \"$chline\", name = $chname"
        my variable name lineno chunk offset
        set name $chname
        set lineno $chnum
        set chunk [list]
        set offset 0
        relvar uinsert Chunk [list\
            Name $name\
        ]
        return
    }

    method EndChunk {endline} {
        my variable name lineno chunk
        relvar insert ChunkPart [list\
            Name        $name\
            BeginLineNo $lineno\
            EndLineNo   $endline\
            Content     $chunk\
        ]
        return
    }

    method GatherChunk {chunk} {
        set parts [pipe {
            relvar set ChunkPart |
            relation restrictwith ~ {$Name eq $chunk}
        }]
        set gathered [list]
        if {[relation isempty $parts]} {
            log::notice "elided output for reference to unknown chunk,\
                    <<$chunk>>"
        }
        relation foreach part $parts -ascending BeginLineNo {
            set content [relation extract $part Content]
            set refs [pipe {
                relvar set ChunkRef |
                relation semijoin $part ~ -using {Name Name BeginLineNo LineNo}
            }]
            if {[relation isempty $refs]} {
                lappend gathered {*}$content
            } else {
                set prevOffset 0
                relation foreach ref $refs -ascending Offset {
                    relation assign $ref Offset RefChunk Indent
                    log::debug "prevOffset = $prevOffset, Offset = $Offset"
                    lappend gathered {*}[lrange $content $prevOffset $Offset-1]
                    set prevOffset [expr {$Offset + 1}]

                    set reflines [my GatherChunk $RefChunk]
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
