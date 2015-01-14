# This software is copyrighted 2013-2015 by G. Andrew Mangogna.
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
#   aweb.tcl -- asciidoc literate programming
#
# ABSTRACT:
#   This file contains a Tcl script that will parse source code contained
#   within an "asciidoc" document to extract literate programming chunks.
#   Input documents are assumed to be valid asciidoc documents that contain
#   source code within source blocks as defined by asciidoc syntax. This
#   program will look within source blocks for program chunk definitions. We
#   use "noweb" syntax, namely:
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
package require logger
package require oomoore 1.0
package require struct::stack

namespace eval ::aweb {
    namespace export parser
    namespace ensemble create

    logger::initNamespace [namespace current]
}

# We define a state model to parse the asciidoc source.
::oo::class create ::aweb::parser {
    # Create the state model directly in line. We give it a name so that we can
    # refer to it later in case we wish to "draw" the model, etc.
    #
    # There is an ambiguity associated with dashes and one form of title
    # markup. We examine the previous line and if it is a command or the number
    # of dashes is more than two off from the length of the title text, then we
    # assume the dashes mark a source boundary.  This is to handle cases such
    # as:
    #
    # My Title
    # --------
    #
    # and allow cases such as:
    #
    # .Paragraph Title
    # ----
    #
    superclass [::oomoore model create ::aweb::parserSM {
        # While in the InDocument state we are processing ordinary
        # source lines
        state InDocument {line num} {
            my variable lineLength
            set lineLength [string length $line]
        }
        transition InDocument - NewLine -> InDocument
        transition InDocument - CtrlLine -> GotControlLine
        transition InDocument - BlockMarker -> CheckingForTitle
        transition InDocument - ChunkMarker -> IG

        # We get to the CheckingForTitle state if we see something that looks
        # like a source block marker, but it has been preceded by an ordinary
        # line. In this case, we see if the number of dashes is approximately
        # the same as the length of the preceding line.  If so, then we
        # conclude we say a two line title. Otherwise, we think we have seen a
        # source block marker.
        state CheckingForTitle {line num} {
            my variable lineLength
            set markerLength [string length $line]
            if {abs($lineLength - $markerLength) > 2} {
                my receive BlockMarker $line $num
            }
        }
        transition CheckingForTitle - NewLine -> InDocument
        transition CheckingForTitle - CtrlLine -> GotControlLine
        transition CheckingForTitle - BlockMarker -> InSourceBlock
        transition CheckingForTitle - ChunkMarker -> InDocument

        # If a source block marker is preceded by some directive, then it is
        # not a candidate for being a title. The GotControlLine state remembers
        # that we have seen such a line while scanning.
        state GotControlLine {line num} {
        }
        transition GotControlLine - NewLine -> InDocument
        transition GotControlLine - CtrlLine -> GotControlLine
        transition GotControlLine - BlockMarker -> InSourceBlock
        transition GotControlLine - ChunkMarker -> InDocument

        # We enter the InSourceBlock state when we have determined that we are
        # at the beginning of an asciidoc source block.
        state InSourceBlock {line num} {
            my StartBlock $num
        }
        transition InSourceBlock - NewLine -> IG
        transition InSourceBlock - CtrlLine -> IG
        transition InSourceBlock - BlockMarker -> InDocument
        transition InSourceBlock - ChunkMarker -> InChunk

        # If we are in a source block and see a chunk definition then we enter
        # the InChunk state.
        state InChunk {line num} {
            my StartChunk $line $num
            my variable refOffset
            set refOffset 0
        }
        transition InChunk - NewLine -> GatheringChunk
        transition InChunk - CtrlLine -> GatheringChunk
        transition InChunk - BlockMarker -> EndSourceBlock
        transition InChunk - ChunkMarker -> EndChunk

        # At the end of a chunk, we enter the EndChunk state. Chunks are ended
        # either by the end of the source block or the beginning of a new chunk
        # definition.
        state EndChunk {line num} {
            my EndChunk
            my StartChunk $line $num
            my variable refOffset
            set refOffset 0
        }
        transition EndChunk - NewLine -> GatheringChunk
        transition EndChunk - CtrlLine -> GatheringChunk
        transition EndChunk - BlockMarker -> EndSourceBlock
        transition EndChunk - ChunkMarker -> EndChunk

        # In the GatheringChunk state we accumulate the content of the chunk
        # and record any chunk references that we encounter.
        state GatheringChunk {line num} {
            my variable chunkContents refOffset
            lappend chunkContents $line

            # Check if the line is a chunk reference
            if {[regexp -- {^(\s*)<<([^>]+)>>\s*$} $line match ind ref]} {
                my variable chunkName chunkOffset blockBeginNum
                relvar insert ChunkRef [list\
                    ChunkLineNum    $blockBeginNum\
                    ChunkOffset     $chunkOffset\
                    RefOffset       $refOffset\
                    RefToChunk      $ref\
                    Indent          $ind\
                ]
            }
            incr refOffset
        }
        transition GatheringChunk - NewLine -> GatheringChunk
        transition GatheringChunk - CtrlLine -> GatheringChunk
        transition GatheringChunk - BlockMarker -> EndSourceBlock
        transition GatheringChunk - ChunkMarker -> EndChunk

        # After entering a source block, another block marker will take us to
        # the EndSourceBlock state.
        state EndSourceBlock {line num} {
            my EndChunk
            my EndBlock $num
        }
        transition EndSourceBlock - NewLine -> InDocument
        transition EndSourceBlock - CtrlLine -> GotControlLine
        transition EndSourceBlock - BlockMarker -> InSourceBlock
        transition EndSourceBlock - ChunkMarker -> InDocument
    }]

    #########################
    #
    # Methods used in the state actions
    #
    #########################

    method StartBlock {num} {
        log::debug "Block start @ $num"
        my variable blockBeginNum
        set blockBeginNum $num
        return
    }

    method EndBlock {num} {
        log::debug "Block end @ $num"
        my variable blockBeginNum
        relvar insert ChunkBlock [list\
            BeginLineNum    $blockBeginNum\
            EndLineNum      $num\
        ]
        return
    }

    method StartChunk {line num} {
        regexp -- {^<<([^>]+)>>=$} $line match name
        log::debug "Chunk start @ $num: \"$line\", name = $name"
        my variable chunkName chunkOffset chunkContents blockBeginNum
        set chunkName $name
        set chunkOffset [expr {$num - $blockBeginNum}]
        set chunkContents [list]
        return
    }

    method EndChunk {} {
        log::debug "Chunk end"
        my variable chunkName chunkOffset chunkContents blockBeginNum
        relvar insert Chunk [list\
            Name            $chunkName\
            Content         $chunkContents\
            BlockLineNum    $blockBeginNum\
            Offset          $chunkOffset\
        ]
        return
    }

    constructor {{path {}}} {
        next

        my variable incPath $path

        namespace import ::ral::*
        namespace import ::ralutil::*

        # Define a set of relvars that will hold the parsed chunks and their
        # references.

        # Asciidoc source code occurs in blocks. Blocks that contain literate
        # program chunks are deemed to be ChunkBlocks.  In order to weave
        # properly, we need to know the boundaries of the asciidoc block that
        # holds the chunk.  There may be multiple chunk definition in one
        # asciidoc block.  Knowing the block boundaries allows us to insert
        # anchors and cross references during the weaving process.  Those
        # insertions must happen before and after the source block itself.

        relvar create ChunkBlock {
            BeginLineNum    int
            EndLineNum      int
        } BeginLineNum EndLineNum

        # A Chunk is the literate program text.
        # "Offset" is the line offset in the ChunkBlock where the chunk
        # defintion begins. "Content" contains all the chunk defintion
        # without the chunk marker that signifies the start of the chunk.
        relvar create Chunk {
            Name            string
            Content         list
            BlockLineNum    int
            Offset          int
        } {BlockLineNum Offset}

        # Chunks must occur in ChunkBlocks. A ChunkBlock must contain
        # at least on Chunk. Source blocks that do not contain chunks
        # are ignored during the parsing.
        relvar association R1\
            Chunk BlockLineNum +\
            ChunkBlock BeginLineNum 1

        # Chunks may contain references to other Chunks
        # "RefOffset" is the offset in lines within the Chunk Content
        # where the reference  begins.
        relvar create ChunkRef {
            ChunkLineNum    int
            ChunkOffset     int
            RefOffset       int
            RefToChunk      string
            Indent          string
        } {ChunkLineNum ChunkOffset RefOffset}

        # A ChunkRef must be contained withing a Chunk but Chunks may 
        # make no references.
        relvar association R2\
            ChunkRef {ChunkLineNum ChunkOffset} *\
            Chunk {BlockLineNum Offset} 1

        # Define a stack to use for included files
        my variable chanStack
        set chanStack [::struct::stack]
    }

    destructor {
        next

        my variable chanStack
        $chanStack destroy
    }

    # Parse a file and build up the chunk information.
    method parse {infilename} {
        my variable infile
        my variable chanStack
        if {$infilename eq "-"} {
            set infile stdin
            set ichan stdin
        } else {
            set infile $infilename
            set ichan [open $infilename r]
        }
        try {
            set lineno 1
            relvar eval {
                # We read the file, line by line so that we can count the
                # lines for diagnostic purposes.
                while {true} {
                    set lcnt [chan gets $ichan line]
                    if {$lcnt < 0} {
                        chan close $ichan
                        if {[$chanStack size] == 0} {
                            # We are finished when there is nothing
                            # pushed onto the channel stack.
                            break
                        } else {
                            lassign [$chanStack pop] ichan infile
                            continue
                        }
                    }
                    log::debug "$lineno: $line"
                    # Check for an "include" directive. We will filter those
                    # out here and push them on the open channel stack.
                    if {[regexp -- {^include::([^\[]+)\[[^\]]*\]} $line\
                            match incfile]} {
                        try {
                            log::debug "found include file, \"$incfile\""
                            set newchan [::open $incfile r]
                            $chanStack push [list $ichan $infile]
                            set ichan $newchan
                            set infile $incfile
                        } on error {result} {
                            log::error $result
                        }
                        continue
                    }
                    # Some simple lexical analysis to determine the type
                    # of event we need to generate.
                    set first [string index $line 0]
                    if {[regexp -- {^-{4,}\s*$} $line]} {
                        my receive BlockMarker $line $lineno
                    } elseif {[regexp -- {^<<([^>]+)>>=\s*$} $line]} {
                        my receive ChunkMarker $line $lineno
                    } elseif {![string is alnum -strict $first] ||\
                            [regexp -- {^[[:alpha:]]+::} $line]} {
                        my receive CtrlLine $line $lineno
                    } else {
                        my receive NewLine $line $lineno
                    }
                    incr lineno
                }
            }
        } on error {result opts} {
            chan puts stderr $result
            return -options $opts
        } finally {
            while {[$chanStack size] != 0} {
                chan close [$chanStack pop]
            }
        }
        log::debug \n[relformat [relvar set ChunkBlock] ChunkBlock]
        log::debug \n[relformat [relvar set Chunk] Chunk]
        log::debug \n[relformat [relvar set ChunkRef] ChunkRef]
    }

    # Report any references to undefined chunks
    method reportUndefined {} {
        set undefs [pipe {
            relvar set ChunkRef |
            relation semiminus [relvar set Chunk] ~ -using {Name RefToChunk}
        }]
        log::debug \n[relformat $undefs undefs]

        my variable infile
        relation foreach undef $undefs -ascending\
                {ChunkLineNum ChunkOffset RefOffset} {
            relation assign $undef
            log::notice "$infile: line:\
                [expr {$ChunkLineNum + $ChunkOffset + $RefOffset + 1}],\
                reference to chunk, <<$RefToChunk>>, that does not exist"
        }
    }

    # Generate a report on the chunks found, missing, etc.
    method reportChunks {chan root} {
        chan puts $chan "Chunk Report"
        chan puts $chan =======================================\n

        chan puts $chan "Chunk Definitions"
        set chunks [pipe {
            relvar set Chunk |
            relation extend ~ chk LineNo int {\
                [tuple extract $chk BlockLineNum] +\
                [tuple extract $chk Offset]} |
            relation project ~ Name LineNo |
            relation group ~ LineNos LineNo |
            relation extend ~ cp Lines list {
                [relation list [tuple extract $cp LineNos]\
                    LineNo -ascending LineNo]} |
            relation project ~ Name Lines |
            relation rename ~ Name "Chunk Name" Lines "Defined On Line(s)"
        }]
        chan puts $chan [relformat $chunks {} {{Chunk Name}}]

        set missing [pipe {
            relvar set Chunk |
            relation restrictwith ~ {$Name ne $root} |
            relation semiminus ~ [relvar set ChunkRef]\
                    -using {Name RefToChunk} |
            relation extend ~ rf "Referenced At Line" int {\
                [tuple extract $rf ChunkLineNum] +\
                [tuple extract $rf ChunkOffset] +\
                [tuple extract $rf RefOffset] + 1} |
            relation project ~ RefToChunk "Referenced At Line" |
            relation rename ~ RefToChunk "Chunk Name"
        }]
        chan puts $chan =======================================\n
        chan puts $chan "Chunks Referenced but not Defined"
        chan puts $chan [relformat $missing {} {{Chunk Name}}]

        set orphans [pipe {
            relvar set Chunk |
            relation restrictwith ~ {$Name ne $root} |
            relation rename ~ Name RefToChunk |
            rvajoin ~ [relvar set ChunkRef] Refs |
            relation restrict ~ r {[relation isempty [tuple extract $r Refs]]} |
            relation project ~ RefToChunk |
            relation semijoin ~ [relvar set Chunk] -using {RefToChunk Name} |
            relation extend ~ def "Defined on Line" int {\
                [tuple extract $def BlockLineNum] +\
                [tuple extract $def Offset]} |
            relation project ~ Name "Defined on Line" |
            relation rename ~ Name "Chunk Name"
        }]
        chan puts $chan =======================================\n
        chan puts $chan "Chunks Defined but not Referenced"
        chan puts $chan [relformat $orphans {} {{Chunk Name}}]
    }
}
