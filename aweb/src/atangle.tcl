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
package require moore

namespace eval ::atangle {
    namespace export main
    namespace ensemble create

    namespace import ::ral::*
    namespace import ::ralutil::*

    variable optlist {
        {level.arg warn {Log debug level}}
        {output.arg - {Output file name}}
        {root.arg * {Root chunk to output}}
        {report {Issue chuck report}}
    }
    variable options ; array set options {}

    logger::initNamespace [namespace current]

    # Define a set of relvars that will hold the parsed chunks and their
    # references.
    relvar create Chunk {
        Name        string
    } Name

    relvar create ChunkPart {
        Name        string
        LineNo      int
        Content     string
    } {Name LineNo}

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

    # This is a weak association on the "Chunk" side to allow for the creation
    # of references to non-existent chunks. We catch that in code, but it is
    # convenient to allow such references.
    relvar association R2\
        ChunkRef RefChunk *\
        Chunk Name ?

    relvar association R3\
        ChunkRef {Name LineNo} *\
        ChunkPart {Name LineNo} 1

    # We define a state model to parse the asciidoc source.
    moore model tangle {
        State InDocument {line num} {
            if {[isSourceMarker $line]} {
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
                set prevline [$self cget prevline]
                set prevlen [string length $prevline]
                set linelen [string length $line]
                set first [string index $prevline 0]
                set iscmd [expr {$first in {. [}}]
                if {$iscmd || abs($prevlen - $linelen) > 2} {
                    log::debug "line = \"$line\", num = \"$num\""
                    $self configure prevline {}
                    $self receive SourceMark
                    return
                }
            }
            $self configure prevline $line
        }
        Transition InDocument - NewLine -> InDocument
        Transition InDocument - SourceMark -> InSource

        State InSource {} {
        }
        Transition InSource - NewLine -> BeginSource

        State BeginSource {line num} {
            log::debug "line = \"$line\", num = \"$num\""
            if {[regexp -- {^<<([^>]+)>>=$} $line match name]} {
                startChunk $self $name $line $num
                $self receive ChunkMark
            } elseif {[isSourceMarker $line]} {
                $self receive SourceMark
            }
        }
        Transition BeginSource - ChunkMark -> InChunk
        Transition BeginSource - SourceMark -> OutSource
        Transition BeginSource - NewLine -> BeginSource

        State InChunk {} {
        }
        Transition InChunk - NewLine -> GatherChunk

        State GatherChunk {line num} {
            log::debug "line = \"$line\", num = \"$num\""
            if {[isSourceMarker $line]} {
                endChunk $self
                $self receive SourceMark
            } elseif {[regexp -- {^<<([^>]+)>>=$} $line match name]} {
                # We allow for multiple chunks to be defined within the same
                # source block.
                endChunk $self
                startChunk $self $name $line $num
                $self receive ChunkMark
            } else {
                set chunk [$self cget chunk]
                $self configure chunk [lappend chunk $line]

                set offset [$self cget offset]
                if {[regexp -- {^(\s*)<<([^>]+)>>\s*$} $line match ind ref]} {
                    relvar insert ChunkRef [list\
                        Name        [$self cget name]\
                        LineNo      [$self cget lineno]\
                        Offset      $offset\
                        RefChunk    $ref\
                        Indent      $ind\
                    ]
                }
                $self configure offset [incr offset]
            }
        }
        Transition GatherChunk - NewLine -> GatherChunk
        Transition GatherChunk - SourceMark -> OutSource
        Transition GatherChunk - ChunkMark -> InChunk

        State OutSource {} {
            $self configure prevline {}
        }
        Transition OutSource - NewLine -> InDocument
    }
}

proc ::atangle::startChunk {self name line num} {
    log::debug "Chunk start @ $num: \"$line\", name = $name"
    $self configure name $name
    $self configure lineno $num
    $self configure chunk [list]
    $self configure offset 0
    relvar uinsert Chunk [list\
        Name $name\
    ]
    return
}

proc ::atangle::endChunk {self} {
    relvar insert ChunkPart [list\
        Name    [$self cget name]\
        LineNo  [$self cget lineno]\
        Content [$self cget chunk]\
    ]
    return
}

# asciidoc markup requires at least 4 dashes to indicate the start or
# end of a source block.
proc ::atangle::isSourceMarker {line} {
    return [regexp -- {^-{4,}\s*$} $line]
}

proc ::atangle::main {} {
    variable optlist
    variable options
    global argv

    # Parse options
    array set options [::cmdline::getoptions argv $optlist]
    ::logger::setlevel $options(level)

    # First scan the input asciidoc file finding the chunks.
    set infilename [lindex $argv 0]
    if {$infilename eq {}} {
        usage
    }
    log::debug "infilename = \"$infilename\""
    set ichan [open $infilename r]

    try {
        tangle machine t
        t configure prevline {}
        t configure trace true
        set lineno 1
        relvar eval {
            # We read the file, line by line so that we can count the
            # lines for diagnostic purposes.
            for {set lcnt [chan gets $ichan line]} {$lcnt >= 0}\
                    {set lcnt [chan gets $ichan line]} {
                # Simple synchronous push of events to the parsing state model.
                t receive NewLine $line $lineno
                incr lineno
            }
        }
        log::debug \n[relformat $::atangle::Chunk Chunk]
        log::debug \n[relformat $::atangle::ChunkPart ChunkPart]
        log::debug \n[relformat $::atangle::ChunkRef ChunkRef]
        t destroy
    } on error {result opts} {
        chan puts stderr $result
        return -options $opts
    } finally {
        chan close $ichan
    }

    # Report any references to undefined chunks
    variable Chunk
    variable ChunkRef
    set undefs [pipe {
        relvar set ChunkRef |
        relation semiminus $Chunk ~ -using {Name RefChunk}
    }]
    log::debug \n[relformat $undefs undefs]

    relation foreach undef $undefs -ascending LineNo {
        relation assign $undef
        # +1 to go from offsets to line numbers
        log::notice "$infilename: line: [expr {$LineNo + $Offset + 1}],\
            in chunk \"$Name\": reference to chunk, <<$RefChunk>>,\
            that does not exist"
    }

    # Emit the tangled code
    if {$options(output) ne "-"} {
        set ochan [open $options(output) w]
    } else {
        set ochan stdout
    }
    try {
        set root [pipe {
            relvar set Chunk |
            relation restrictwith ~ {$Name eq $options(root)}
        }]
        if {[relation isempty $root]} {
            error "no root chunk named, <<$options(root)>>, was found"
        }
        foreach line [gatherChunk $options(root)] {
            chan puts $ochan $line
        }
    } on error {result opts} {
        chan puts stderr $result
        return -options $opts
    } finally {
        chan close $ochan
    }

    # Output a report if requested.
    if {$options(report)} {
        chan puts stderr "Tangle Report"
        chan puts stderr =======================================\n

        chan puts stderr "Chunk Definitions"
        set chunks [pipe {
            relvar set ChunkPart |
            relation eliminate ~ Content |
            relation group ~ LineNos LineNo |
            relation extend ~ cp Lines list {
                [relation list [tuple extract $cp LineNos]\
                    LineNo -ascending LineNo]} |
            relation project ~ Name Lines |
            relation rename ~ Name "Chunk Name" Lines "Defined On Line(s)"
        }]
        chan puts stderr [relformat $chunks {} {{Chunk Name}}]

        set missing [pipe {
            relvar set Chunk |
            relation restrictwith ~ {$Name ne $options(root)} |
            relation semiminus ~ [relvar set ChunkRef] -using {Name RefChunk} |
            relation extend ~ rf "Referenced At" int {
                [tuple extract $rf LineNo] + [tuple extract $rf Offset] + 1
            } |
            relation project ~ RefChunk "Referenced At" |
            relation rename ~ RefChunk "Chunk Name"
        }]
        chan puts stderr =======================================\n
        chan puts stderr "Chunks Referenced but not Defined"
        chan puts stderr [relformat $missing {} {{Chunk Name}}]

        set orphans [pipe {
            relvar set Chunk |
            relation restrictwith ~ {$Name ne $options(root)} |
            relation rename ~ Name RefChunk |
            rvajoin ~ [relvar set ChunkRef] Refs |
            relation restrict ~ r {[relation isempty [tuple extract $r Refs]]} |
            relation project ~ RefChunk |
            relation semijoin ~ [relvar set ChunkPart] -using {RefChunk Name} |
            relation project ~ Name LineNo |
            relation rename ~ Name "Chunk Name" LineNo "Defined on Line"
        }]
        chan puts stderr =======================================\n
        chan puts stderr "Chunks Defined but not Referenced"
        chan puts stderr [relformat $orphans {} {{Chunk Name}}]
    }

    exit 0
}

proc ::atangle::gatherChunk {chunk} {
    log::debug [info level 0]
    set parts [pipe {
        relvar set ChunkPart |
        relation restrictwith ~ {$Name eq $chunk}
    }]
    set gathered [list]
    if {[relation isempty $parts]} {
        log::notice "elided output for reference to unknown chunk, <<$chunk>>"
    }
    relation foreach part $parts -ascending LineNo {
        set content [relation extract $part Content]
        set refs [pipe {
            relvar set ChunkRef |
            relation semijoin $part ~
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

                set reflines [gatherChunk $RefChunk]
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

proc ::atangle::usage {} {
    variable optlist
    chan puts stderr [cmdline::usage $optlist\
        "<options> <file>\noptions:"]
    exit 1
}

atangle main
