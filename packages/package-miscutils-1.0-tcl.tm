# ACTIVESTATE TEAPOT-PKG BEGIN TM -*- tcl -*-
# -- Tcl Module

# @@ Meta Begin
# Package miscutils 1.0
# Meta description This package contains a set of miscellaneous utility
# Meta description procedures that didn't find a better home.
# Meta platform    tcl
# Meta require     {Tcl 8.6}
# Meta summary     Miscellaneous Utility Procedures
# @@ Meta End


# ACTIVESTATE TEAPOT-PKG BEGIN REQUIREMENTS

package require Tcl 8.6

# ACTIVESTATE TEAPOT-PKG END REQUIREMENTS

# ACTIVESTATE TEAPOT-PKG BEGIN DECLARE

package provide miscutils 1.0

# ACTIVESTATE TEAPOT-PKG END DECLARE
# ACTIVESTATE TEAPOT-PKG END TM
# This software is copyrighted 2016 by G. Andrew Mangogna.
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
#*--
#

package require Tcl 8.6

namespace eval ::miscutils {
    namespace export hashcolor
    namespace ensemble create

    variable revision 1.0
}

# This is a Tcl rendering of the fossil algorithm that hashes an arbitrary
# string to a RGB color spec. When you need colors but don't want to have to
# choose them yourself, this gives an interesting set of colors.
# This is a direct rendering of the "C" code from fossil. I have no idea
# how it really works and there was no commentary in the original code.
#
# "s" is the string to hash into a color
# "fgwhite" is a boolean indicating if the foreground text is white. This
# causes a choice of darker colors to maintain contrast.
#
# returns an RGB color value as a #RRGGBB hex style color literal

proc ::miscutils::hashcolor {s {fgwhite false}} {
    if {$fgwhite} {
        set ix0 140
        set ix1 40
    } else {
        set ix0 216
        set ix1 16
    }

    # Convert the string into binary numbers
    binary scan $s c* sbin
    set h 0
    # Hash togther the numerical values of the string.
    foreach c $sbin {
        set h [expr {($h << 11) ^ ($h << 1) ^ ($h >> 3) ^ $c}]
    }
    set h1 [expr {$h % 6}] ; set h [expr {$h / 6}]
    set h3 [expr {$h % 30}] ; set h [expr {$h / 30}]
    set h4 [expr {$h % 40}] ; set h [expr {$h / 40}]
    set mx [expr {$ix0 - $h3}]
    set mn [expr {$mx - $h4 - $ix1}]
    set h2 [expr {($h % ($mx - $mn)) + $mn}]
    switch -exact -- $h1 {
        0 {
            set r $mx ; set g $h2 ; set b $mn
        }
        1 {
            set r $h1 ; set g $mx ; set b $mn
        }
        2 {
            set r $mn ; set g $mx ; set b $h2
        }
        3 {
            set r $mn ; set g $h2 ; set b $mx
        }
        4 {
            set r $h2 ; set g $mn ; set b $mx
        }
        default {
            set r $mx ; set g $mn ; set b $h2
        }
    }
    return [format #%02x%02x%02x $r $g $b]
}

package provide miscutils $::miscutils::revision
