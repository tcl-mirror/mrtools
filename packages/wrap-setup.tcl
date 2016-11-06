
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
