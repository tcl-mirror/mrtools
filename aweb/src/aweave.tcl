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
#   aweave.tcl -- asciidoc literate programming
#
# ABSTRACT:
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

# Pull in the common code
source [file join $top aweb.tcl]

namespace eval ::aweave {
    namespace export main
    namespace ensemble create

    namespace import ::ral::*
    namespace import ::ralutil::*

    variable version 1.1

    variable optlist {
        {version {Print version and license, then exit}}
        {output.arg - {Output file name}}
        {level.arg warn {Log debug level}}
    }
    variable options ; array set options {}

    logger::initNamespace [namespace current]
}

proc ::aweave::main {} {
    variable optlist
    variable options
    global argv

    # Parse options
    array set options [::cmdline::getoptions argv $optlist]
    if {$options(version)} {
        versionInfo
        exit
    }

    ::logger::setlevel $options(level)

    # First scan the input asciidoc file finding the chunks.  This will be a
    # two pass undertaking.
    set infilename [lindex $argv 0]
    if {$infilename eq {}} {
        chan puts stderr [cmdline::usage $optlist "<options> <file>\noptions:"]
        exit 1
    }
    log::debug "infilename = \"$infilename\""
    set ichan [open $infilename r]

    weaver create w
    w loglevel $options(level)
    w parse $infilename
    w reportUndefined

    # Now that we have identified all the chunks and their references we can
    # then weave in the cross reference information.
    if {$options(output) ne "-"} {
        set ochan [open $options(output) w]
    } else {
        set ochan stdout
    }
    try {
        w weave $infilename $ochan
    } on error {result opts} {
        chan puts stderr $result
        return -options $opts
    } finally {
        if {$ochan ne "stdout"} {
            chan close $ochan
        }
    }

    w destroy
    exit 0
}

proc ::aweave::versionInfo {} {
    variable version
    puts "aweave: version: $version"
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

# Making the weaver class a subclass of the parser gives us access to
# the parsed information that we need.
::oo::class create ::aweave::weaver {
    superclass ::aweb::parser

    constructor {} {
        next
    }

    destructor {
        next
    }

    # We copy the input file to the output, line by line.  When the number
    # matches that of the beginning of a chunk, then we emit a reference tag
    # for the chunk.  When a line number matches that for the end of a chunk,
    # we emit definition text and any references that the chunk makes.
    method weave {infilename ochan} {
        set ichan [open $infilename r]
        try {
            set lineno 1
            for {set lcnt [chan gets $ichan line]} {$lcnt >= 0}\
                    {set lcnt [chan gets $ichan line]} {
                # Check if this line start a source block that contains a
                # chunk. Here we have to emit some additional asciidoc
                # markup before the beginning of the block.
                set block [relvar restrictone ChunkBlock BeginLineNum $lineno]
                log::debug \n[relformat $block block]
                # If so, emit an anchor defintion.
                if {[relation isnotempty $block]} {
                    relation assign $block BeginLineNum
                    chan puts $ochan "\[\[chunk_block_$BeginLineNum\]\]"

                    # Emit index entries for each chunk defined in the source
                    # block.
                    set chdefs [pipe {
                        relvar set Chunk |
                        relation semijoin $block ~\
                            -using {BeginLineNum BlockLineNum}
                    }]
                    relation foreach chdef $chdefs {
                        chan puts $ochan\
                                "(((chunk,[relation extract $chdef Name])))"
                    }
                }

                # Output the line itself.
                chan puts $ochan $line

                # Check if this line is the end of a source block that contains
                # a chunk definition. If so, then emit cross reference
                # information about the chunk that was just define.
                set block [relvar restrictone ChunkBlock EndLineNum $lineno]
                if {[relation isnotempty $block]} {
                    set chunks [pipe {
                        relvar set Chunk |
                        relation semijoin $block ~\
                            -using {BeginLineNum BlockLineNum}
                    }]
                    if {[relation isnotempty $chunks]} {
                        chan puts $ochan "\[horizontal\]"
                        chan puts -nonewline $ochan "Defines::  "
                        set defs [pipe {
                            relation project $chunks Name |
                            relation list
                        }]
                        chan puts $ochan "  [join $defs {, }]"
                    }

                    set chunkrefs [pipe {
                        relvar set ChunkRef |
                        relation semijoin $block ~\
                            -using {BeginLineNum ChunkLineNum} |
                        relation semijoin ~ [relvar set Chunk]\
                            -using {RefToChunk Name} |
                        relation project ~ Name BlockLineNum |
                        relation tag ~ Line -ascending BlockLineNum\
                            -within Name |
                        relation restrictwith ~ {$Line == 0} |
                        relation extend ~ rf Reference string {\
    "<<chunk_block_[tuple extract $rf BlockLineNum],[tuple extract $rf Name]>>"\
                        } |
                        relation list ~ Reference -ascending Name
                    }]
                    if {[llength $chunkrefs] != 0} {
                        chan puts -nonewline $ochan "References::  "
                        chan puts $ochan "  [join $chunkrefs {, }]"
                    }
                }

                incr lineno
            }
        } on error {result opts} {
            chan puts stderr $result
            return -options $opts
        } finally {
            chan close $ichan
        }
    }

    # Turn a chunk name into something that will work as an asciidoc
    # element identifier.
    method CleanUpChunkName {cname} {
        return [string map [list * root { } _] $cname]
    }
}

aweave main
