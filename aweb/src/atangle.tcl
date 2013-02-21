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
    }
    variable options ; array set options {}

    logger::initNamespace [namespace current]

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

    relvar association R2\
        ChunkRef RefChunk *\
        Chunk Name ?

    relvar association R3\
        ChunkRef {Name LineNo} *\
        ChunkPart {Name LineNo} 1

    moore model tangle {
        State InDocument {line num} {
            if {[isSourceMarker $line]} {
                # Check if the dashes are the same length as the
                # previous line. If so then the dashes mark a
                # title. Othewise they mark a source block boundary.
                set prevlen [string length [$self cget prevline]]
                set linelen [string length $line]
                set first [string index $line 0]
                set iscmd [expr {$first in ".\["}]
                if {$linelen > 0 && (!$iscmd || abs($prevlen - $linelen) > 2)} {
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

proc ::atangle::isSourceMarker {line} {
    return [regexp -- {^-{4,}\s*$} $line]
}

proc ::atangle::main {} {
    variable optlist
    variable options
    global argv

    array set options [::cmdline::getoptions argv $optlist]
    ::logger::setlevel $options(level)

    set infilename [lindex $argv 0]
    if {$infilename eq {}} {
        usage
    }
    log::debug "infilename = \"$infilename\""
    set ichan [open $infilename r]

    # First scan the file finding the chunks.
    try {
        tangle machine t
        t configure prevline {}
        t configure trace true
        set lineno 1
        relvar eval {
            for {set lcnt [chan gets $ichan line]} {$lcnt >= 0}\
                    {set lcnt [chan gets $ichan line]} {
                t receive NewLine $line $lineno
                incr lineno
            }
        }
        log::debug \n[relformat $::atangle::Chunk Chunk]
        log::debug \n[relformat $::atangle::ChunkPart ChunkPart]
        log::debug \n[relformat $::atangle::ChunkRef ChunkRef]
        t destroy
    } on error {result opts} {
        puts stderr $result
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

    relation foreach undef $undefs {
        relation assign $undef
        # +1 to go from offsets to line numbers
        log::notice "$infilename: line: [expr {$LineNo + $Offset + 1}],\
            in chunk \"$Name\": reference to chunk, \"$RefChunk\",\
            that does not exist"
    }

    if {$options(output) ne "-"} {
        set ochan [file open $options(output) w]
    } else {
        set ochan stdout
    }
    # Emit the tangled code
    try {
        set root [pipe {
            relvar set Chunk |
            relation restrictwith ~ {$Name eq $options(root)}
        }]
        if {[relation isempty $root]} {
            error "no chunk named, \"$options(root)\", was found"
        }
        foreach line [gatherChunk $options(root)] {
            puts $ochan $line
        }
    } on error {result opts} {
        puts stderr $result
        return -options $opts
    } finally {
        chan close $ochan
    }
}

proc ::atangle::gatherChunk {chunk} {
    log::debug [info level 0]
    set parts [pipe {
        relvar set ChunkPart |
        relation restrictwith ~ {$Name eq $chunk}
    }]
    set gathered [list]
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
    puts stderr [cmdline::usage $optlist\
        "<options> <file>\noptions:"]
    exit 1
}

atangle main
