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

set iswrapped [expr {[lindex [file system [info script]] 0] ne "native"}]
if {$iswrapped} {
    set top [file join $::starkit::topdir lib application]
    if {$::tcl_platform(os) eq "Linux"} {
        lappend ::auto_path [file join $::starkit::topdir lib\
            P-[::platform::identify]]
    }
} else {
    set top [file dirname [info script]]
}

package require Tcl 8.6
package require Tk 8.6
package require logger
package require cmdline
package require ral
package require ralutil
package require iconimage
package require harness
package require traceview

namespace eval ::dressage {
    namespace export main
    namespace ensemble create

    namespace import ::ral::*
    namespace import ::ralutil::*

    variable revision 1.0
    variable title "Dressage - $revision"
    variable debugLevel warn
    variable browseDir [pwd]

    variable fileNames ; array set fileNames {
        tack        {}
        exec        {}
        pycca       {}
    }
    variable nameWidgets ; array set nameWidgets {
        tack        {}
        exec        {}
        pycca       {}
    }

    ::logger::initNamespace [namespace current] $debugLevel

    namespace eval tack {
        namespace import ::ral::*
        namespace import ::ralutil::*
    }
}

proc ::dressage::main {} {
    # Get rid of tearoffs
    option add *tearOff 0
    # Set up style for invalid entry.
    ttk::style configure Invalid.TEntry
    ttk::style map Invalid.TEntry -foreground {invalid red}

    wm withdraw .
    variable title
    wm title . $title
    initUI .
    wm deiconify .
}

proc ::dressage::initUI {w} {
    # Top level menu bar
    set menubar [menu $w.menubar]
    $w configure -menu $menubar

    set filemenu [menu $menubar.filemenu]
    $menubar add cascade -menu $filemenu -label File
    $filemenu add command\
        -label Exit\
        -command [namespace code exitApp]

    set showmenu [menu $menubar.showmenu]
    $menubar add cascade -menu $showmenu -label Show
    if {$::tcl_platform(platform) eq "windows"} {
        $showmenu add command\
            -label Console\
            -command [namespace code showConsole]
    }
    $showmenu add cascade\
        -label Debug\
        -menu $showmenu.debug

    set debugmenu [menu $showmenu.debug]
    foreach level [::logger::levels] {
        $debugmenu add radiobutton\
            -label $level\
            -value $level\
            -variable [namespace current]::debugLevel\
            -command [namespace code changeDebugLevel]
    }

    set helpmenu [menu $menubar.help]
    $menubar add cascade -menu $helpmenu -label Help
    $helpmenu add command\
        -label About\
        -command [namespace code showAbout]

    # An icon bar
    set iconbar [ttk::frame $w.iconbar]
    grid $iconbar\
        -sticky ew

    set exiticon [ttk::button $iconbar.exit\
        -image [iconimage getIcon actexit22]\
        -command [namespace code exitApp]\
    ]
    if {$::tcl_platform(platform) eq "windows"} {
        set consoleicon [ttk::button $iconbar.console\
            -image [iconimage getIcon devscreen22]\
            -command [namespace code showConsole]\
        ]
    } else {
        set consoleicon x
    }
    grid $exiticon $consoleicon

    # Frame for tack file
    set tframe [ttk::labelframe $w.tframe\
        -text "Tack Save File"\
    ]
    grid $tframe -\
        -sticky ew\
        -pady 5
    set tflabel [ttk::label $tframe.tflabel\
        -text Name
    ]
    variable nameWidgets
    set nameWidgets(tack) [ttk::entry $tframe.tfile\
        -textvariable [namespace current]::fileNames(tack)\
        -style Invalid.TEntry\
        -width 30\
        -validate all\
        -validatecommand [namespace code {validateFileName %W %P %V}]\
        -invalidcommand [namespace code {invalidateFileName %W}]\
    ]
    set tbrowse [ttk::button $tframe.tbrowse\
        -text Browse\
        -command [namespace code browseTackFile]\
    ]
    grid $tflabel\
        -row 0\
        -column 0\
        -sticky e\
        -padx 3
    grid $nameWidgets(tack)\
        -row 0\
        -column 1\
        -sticky we
    grid $tbrowse\
        -row 0\
        -column 2\
        -padx 3
    grid columnconfigure $tframe 1 -weight 1

    # Frame for executable file
    set eframe [ttk::labelframe $w.eframe\
        -text "Harness Executable File"\
    ]
    grid $eframe -\
        -sticky ew\
        -pady 5
    set eflabel [ttk::label $eframe.eflabel\
        -text Name
    ]
    set nameWidgets(exec) [ttk::entry $eframe.efile\
        -textvariable [namespace current]::fileNames(exec)\
        -style Invalid.TEntry\
        -width 30\
        -validate all\
        -validatecommand [namespace code {validateFileName %W %P %V}]\
        -invalidcommand [namespace code {invalidateFileName %W}]\
    ]
    set ebrowse [ttk::button $eframe.ebrowse\
        -text Browse\
        -command [namespace code browseExecFile]\
    ]
    variable execStart true
    set estart [ttk::radiobutton $eframe.estart\
        -text "Start on Connect"\
        -value true\
        -variable [namespace current]::execStart\
    ]
    set enostart [ttk::radiobutton $eframe.enostart\
        -text "Don't Start"\
        -value false\
        -variable [namespace current]::execStart\
    ]
    grid $eflabel\
        -row 0\
        -column 0\
        -sticky e\
        -padx 3
    grid $nameWidgets(exec)\
        -row 0\
        -column 1\
        -sticky we
    grid $ebrowse\
        -row 0\
        -column 2\
        -padx 3
    grid $estart\
        -row 1\
        -column 1\
        -sticky w
    grid $enostart\
        -row 2\
        -column 1\
        -sticky w
    grid columnconfigure $eframe 1 -weight 1

    # Frame for pycca file
    set pframe [ttk::labelframe $w.pframe\
        -text "Pycca Save File"\
    ]
    grid $pframe -\
        -sticky ew\
        -pady 5
    set pflabel [ttk::label $pframe.pflabel\
        -text Name
    ]
    variable nameWidgets
    set nameWidgets(pycca) [ttk::entry $pframe.pfile\
        -textvariable [namespace current]::fileNames(pycca)\
        -style Invalid.TEntry\
        -width 30\
        -validate all\
        -validatecommand [namespace code {validateFileName %W %P %V}]\
        -invalidcommand [namespace code {invalidateFileName %W}]\
    ]
    set pbrowse [ttk::button $pframe.pbrowse\
        -text Browse\
        -command [namespace code browsePyccaFile]\
    ]
    grid $pflabel\
        -row 0\
        -column 0\
        -sticky e\
        -padx 3
    grid $nameWidgets(pycca)\
        -row 0\
        -column 1\
        -sticky we
    grid $pbrowse\
        -row 0\
        -column 2\
        -padx 3
    grid columnconfigure $pframe 1 -weight 1

    # Connect button
    variable connButton [ttk::button $w.conn\
        -text Connect\
        -command [namespace code connectToHarness]\
        -state disabled\
    ]
    grid $connButton - -

    grid columnconfigure $w 0 -weight 1
}

proc ::dressage::showConsole {} {
    variable title
    catch {
        ::console show
        ::console title "$title Console"
    }
}

proc ::dressage::showAbout {} {
    variable revision
    variable title
    set aboutText "$title
Copyright 2016, G. Andrew Mangogna
Revision: $revision"

    tk_messageBox\
	-icon info\
	-message $aboutText\
	-title $title\
	-type ok

    return
}

proc ::dressage::changeDebugLevel {} {
    variable debugLevel
    log::setlevel $debugLevel
}

proc ::dressage::exitApp {} {
    ::exit 0
}

proc ::dressage::validateFileName {w val cond} {
    if {$cond eq "key"} {
        set isValid true
        if {[file exists $val]} {
            $w state !invalid
        } else {
            invalidateFileName $w
        }
    } else {
        set isValid [file exists $val]
    }
    evalConnectAllowed
    return $isValid
}

proc ::dressage::invalidateFileName {w} {
    $w state invalid
}

proc ::dressage::browseTackFile {} {
    variable browseDir
    set file [tk_getOpenFile\
        -defaultextension .ral\
        -filetypes {
            {{Tack Save Files}  {.ral}  }
            {{All Files}        *       }
        }\
        -initialdir $browseDir\
        -multiple false\
        -title "Tack Save File Selection"\
    ]
    if {$file ne {}} {
        variable fileNames
        set fileNames(tack) $file
        variable nameWidgets
        $nameWidgets(tack) validate
        set browseDir [file dirname $file]
    }
}

proc ::dressage::browseExecFile {} {
    variable browseDir
    set file [tk_getOpenFile\
        -filetypes {
            {{All Files}        *       }
        }\
        -initialdir $browseDir\
        -multiple false\
        -title "Test Harness Executable File Selection"\
    ]
    if {$file ne {}} {
        variable fileNames
        set fileNames(exec) $file
        variable nameWidgets
        $nameWidgets(exec) validate
        set browseDir [file dirname $file]
    }
}

proc ::dressage::browsePyccaFile {} {
    variable browseDir
    set file [tk_getOpenFile\
        -defaultextension .ral\
        -filetypes {
            {{Pycca Save Files}  {.ral}  }
            {{All Files}        *       }
        }\
        -initialdir $browseDir\
        -multiple false\
        -title "Pycca Save File Selection"\
    ]
    if {$file ne {}} {
        variable fileNames
        set fileNames(pycca) $file
        variable nameWidgets
        $nameWidgets(pycca) validate
        set browseDir [file dirname $file]
    }
}

proc ::dressage::evalConnectAllowed {} {
    variable fileNames
    variable nameWidgets
    set allowed true
    foreach type [array names fileNames] {
        if {[string length $fileNames($type)] == 0 ||\
                "invalid" in [$nameWidgets($type) state]} {
            set allowed false
            break
        }
    }
    variable connButton
    $connButton state [expr {$allowed ? "!disabled" : "disabled"}]
    return $allowed
}

proc ::dressage::connectToHarness {} {
    variable execStart
    variable fileNames

    set cursor [. cget -cursor]
    . configure -cursor watch
    update

    # Get the tack information
    deserializeFromFile $fileNames(tack) [namespace current]::tack
    setupTackView

    showTackControls

    # Start the harness executable, if necessary
    if {$execStart} {
        exec $fileNames(exec) &
        after 1000
    }

    # Set up the trace window
    toplevel .trace
    wm title .trace "Test Harness Output Log"
    wm protocol .trace WM_DELETE_WINDOW { }
    variable trview [traceview tacktrace new\
        .trace -mapfile $fileNames(exec) -ralfile $fileNames(pycca)]
    grid rowconfigure .trace 0 -weight 1
    grid columnconfigure .trace 0 -weight 1

    # Connect to the harness executable
    variable hcmd [harness open driver stub]
    # Configure handling the stub output
    set stubchan [$hcmd cget stub]
    chan configure $stubchan -blocking no
    chan event $stubchan readable\
            [namespace code [list recvStubInput $stubchan]]
    $hcmd trace true

    # Finally, mark the button for disconnecting.
    variable connButton
    $connButton configure\
        -text Disconnect\
        -command [namespace code disconnectFromHarness]

    . configure -cursor $cursor
    update
}

proc ::dressage::disconnectFromHarness {} {
    variable connButton
    $connButton state disabled

    variable hcmd
    $hcmd close

    destroy .tack
}

proc ::dressage::recvStubInput {chan} {
    variable trview
    for {set lcnt [chan gets $chan line]} {$lcnt >= 0}\
            {set lcnt [chan gets $chan line]} {
        $trview receive $line
    }
    if {[chan eof $chan]} {
        disconnectFromHarness
    }
}

proc ::dressage::showTackControls {} {
    toplevel .tack
    wm title .tack "Test Harness Domains"
    wm protocol .tack WM_DELETE_WINDOW [namespace code disconnectFromHarness]

    # Create a notebook, with one tab foreach domain.
    set domains [ttk::notebook .tack.domains\
        -takefocus 0\
    ]
    foreach dname [relation list $tack::Harness DomainName\
            -ascending DomainName] {
        addDomainTab $dname $domains
    }
    grid $domains\
        -sticky nsew
    grid rowconfigure .tack 0 -weight 1
    grid columnconfigure .tack 0 -weight 1
}

proc ::dressage::addDomainTab {name nb} {
    set domainFrame [ttk::frame $nb.[string tolower $name]]
    $nb add $domainFrame\
        -text $name\
        -sticky nsew\
        -padding 3
    grid rowconfigure $domainFrame {0 1} -weight 1
    grid columnconfigure $domainFrame 0 -weight 1
    showDrivers $name $domainFrame
    showClasses $name $domainFrame
}

proc ::dressage::showDrivers {domain w} {
    set drivers [pipe {
        relvar set tack::Driver |
        relation restrictwith ~ {$DomainName eq $domain} |
        rvajoin ~ $tack::DriverParam Params DomainName OpName
    }]
    log::debug \n[relformat $drivers drivers]
    if {[relation isempty $drivers]} {
        return
    }

    set dframe [ttk::labelframe $w.drivers\
        -text Drivers\
    ]
    grid $dframe\
        -sticky nsew
    grid columnconfigure $dframe 1 -weight 1

    variable hcmd
    set row 0
    relation foreach driver $drivers {
        relation assign $driver
        lassign [newDriverButton $dframe $DomainName $OpName] button result
        grid $button\
            -row $row\
            -column 0\
            -sticky new\
            -padx 5\
            -pady 5

        if {[relation isnotempty $Params]} {
            set pframe [ttk::labelframe\
                    $dframe.[string tolower ${OpName}_params]\
                -text "$OpName Arguments"\
            ]
            showDriverParams $pframe $DomainName $OpName $Params
            grid $pframe\
                -row $row\
                -column 1\
                -sticky ew\
                -padx 5\
                -pady 5
            grid columnconfigure $pframe 1 -weight 1
        }

        grid $result\
            -row $row\
            -column 2\
            -sticky new\
            -padx 5\
            -pady 5

        incr row
    }
}

proc ::dressage::showDriverParams {f domainName opName params} {
    set row 0
    relation foreach param $params -ascending ParamOrder {
        relation assign $param
        set pn [string tolower $ParamName]

        set lab [ttk::label $f.${pn}_lab\
            -text $ParamDef\
        ]
        grid $lab\
            -row $row\
            -column 0\
            -padx 3\
            -sticky e

        set ent [newDriverParamEntry $f $domainName $opName $ParamName]
        grid $ent\
            -row $row\
            -column 1\
            -padx 3\
            -sticky ew

        set type [ttk::label $f.[string tolower $ParamName]_type\
            -text ($ImplType)\
        ]
        grid $type\
            -row $row\
            -column 2\
            -padx 3\
            -sticky w

        incr row
    }
}

proc ::dressage::showClasses {domain w} {
    set classes [pipe {
        relvar set tack::Class |
        relation restrictwith ~ {$DomainName eq $domain}
    }]
    log::debug \n[relformat $classes classes]
    if {[relation isempty $classes]} {
        return
    }

    set attrs [rvajoin $classes $tack::Attribute Attributes]
    log::debug \n[relformat $attrs attrs]
    set params [pipe {
        relvar set tack::Event |
        relation restrictwith ~ {$DomainName eq $domain} |
        rvajoin ~ $tack::EventParam EventParams
    }]
    log::debug \n[relformat $params params]
    set attrs_events [rvajoin $attrs $params Events]
    log::debug \n[relformat $attrs_events attrs_events]

    # Put the classes in a labeled frame and then use a notebook
    # with a tab per class.
    set cframe [ttk::labelframe $w.cframe\
        -text Classes\
    ]
    grid $cframe\
        -sticky nsew
    grid columnconfigure $cframe 0 -weight 1

    set cnb [ttk::notebook $cframe.classes\
        -takefocus 0\
    ]
    grid $cnb\
        -sticky nsew

    relation foreach attr_event $attrs_events -ascending ClassName {
        addClassTab $attr_event $cnb
    }
}

proc ::dressage::addClassTab {class nb} {
    relation assign $class
    set classFrame [ttk::frame $nb.[string tolower $ClassName]]
    $nb add $classFrame\
        -text $ClassName\
        -sticky nsew\
        -padding 3
    grid columnconfigure $classFrame 0 -weight 1
    grid rowconfigure $classFrame {1 2} -weight 1

    set instsel [newInstanceSelector $classFrame $DomainName $ClassName]
    grid $instsel\
        -row 0\
        -column 0\
        -sticky nsew\
        -padx 5\
        -pady 5

    addClassAttrs $DomainName $ClassName $Attributes $classFrame
    addClassEvents $DomainName $ClassName $Events $classFrame
}

proc ::dressage::addClassAttrs {domainName className attrs w} {
    if {[relation isempty $attrs]} {
        return
    }
    set attrFrame [ttk::labelframe $w.attributes\
        -text Attributes\
        -takefocus 0\
    ]
    grid $attrFrame\
        -sticky nsew
    grid columnconfigure $attrFrame 1 -weight 1

    set row 0
    relation foreach attr $attrs {
        relation assign $attr
        set aname [string tolower $AttrName]
        set lab [ttk::label $attrFrame.${aname}_lab\
            -text $AttrDef\
        ]
        grid $lab\
            -row $row\
            -column 0\
            -padx 3\
            -sticky e

        set ent [newAttributeEntry $attrFrame $domainName $className $AttrName]
        grid $ent\
            -row $row\
            -column 1\
            -padx 3\
            -sticky ew

        set impltype [ttk::label $attrFrame.${aname}_impl\
            -text ($ImplType)\
        ]
        grid $impltype\
            -row $row\
            -column 2\
            -padx 3\
            -sticky w

        set w [ttk::button $attrFrame.${aname}_update\
            -text Update\
            -command [namespace code [list sendUpdate $domainName $className\
                $AttrName]]\
            -takefocus 0\
        ]
        grid $w\
            -row $row\
            -column 3\
            -padx 3

        set w [ttk::button $attrFrame.${aname}_read\
            -text Read\
            -command [namespace code [list sendRead $domainName $className\
                $AttrName]]\
            -takefocus 0\
        ]
        grid $w\
            -row $row\
            -column 4\
            -padx 3

        incr row
    }

    set upall [ttk::button $attrFrame.upall\
        -text "Update All"\
        -takefocus 0\
        -command [namespace code [list updateAllAttrs $domainName $className]]\
    ]
    grid $upall\
        -row $row\
        -column 3\
        -padx 3

    set rdall [ttk::button $attrFrame.rdall\
        -text "Read All"\
        -takefocus 0\
        -command [namespace code [list readAllAttrs $domainName $className]]\
    ]
    grid $rdall\
        -row $row\
        -column 4\
        -padx 3
}

proc ::dressage::addClassEvents {domainName className events w} {
    if {[relation isempty $events]} {
        return
    }
    set eventFrame [ttk::labelframe $w.events\
        -text Events\
        -takefocus 0\
    ]
    grid $eventFrame\
        -sticky nsew
    grid columnconfigure $eventFrame 1 -weight 1

    set row 0
    relation foreach event $events {
        relation assign $event
        set ename [string tolower $EventName]
        set evtbut [ttk::button $eventFrame.$ename\
            -takefocus 0\
            -text $EventName\
            -command [namespace code [list sendEvent $domainName $className\
                    $EventName $EventType]]\
        ]
        grid $evtbut\
            -row $row\
            -column 0\
            -sticky new\
            -padx 3\
            -pady 3

        # add frame and entries for each event parameter
        if {[relation isnotempty $EventParams]} {
            # Add frame
            set pframe [ttk::labelframe $eventFrame.${ename}_params\
                -text "$EventName Arguments"\
                -takefocus 0\
            ]
            showEventParams $pframe $domainName $className $EventName\
                    $EventType $EventParams
            grid $pframe\
                -row $row\
                -column 1\
                -sticky ew\
                -padx 3\
                -pady 3
            grid columnconfigure $pframe 1 -weight 1
        }

        incr row
    }
}

proc ::dressage::showEventParams {f domainName className eventName\
        eventType params} {
    set row 0
    relation foreach param $params -ascending ParamOrder {
        relation assign $param
        set pn [string tolower $ParamName]

        set lab [ttk::label $f.${pn}_lab\
            -text $ParamDef\
        ]
        grid $lab\
            -row $row\
            -column 0\
            -padx 3\
            -sticky e

        set ent [newEventParamEntry $f $domainName $className $eventName\
                $eventType $ParamName]
        grid $ent\
            -row $row\
            -column 1\
            -padx 3\
            -sticky ew

        set type [ttk::label $f.${pn}_type\
            -text ($ImplType)\
        ]
        grid $type\
            -row $row\
            -column 2\
            -padx 3\
            -sticky w

        incr row
    }
}

# Add some relvars that enable mapping parameters to entry widgets
proc ::dressage::setupTackView {} {
    namespace eval tack {
        relvar create DriverButton {
            DomainName      string
            OpName          string
            Widget          string
        } {DomainName OpName}
        relvar association R100\
            Driver {DomainName OpName} 1\
            DriverButton {DomainName OpName} ?
            
        relvar create DriverParamEntry {
            DomainName      string
            OpName          string
            ParamName       string
            Widget          string
        } {DomainName OpName ParamName}
        relvar association R101\
            DriverParam {DomainName OpName ParamName} 1\
            DriverParamEntry {DomainName OpName ParamName} ?

        relvar create InstanceSelector {
            DomainName      string
            ClassName       string
            Widget          string
        } {DomainName ClassName}
        relvar association R105\
            Class {DomainName ClassName} 1\
            InstanceSelector {DomainName ClassName} ?

        relvar create AttributeEntry {
            DomainName      string
            ClassName       string
            AttrName        string
            Widget          string
        } {DomainName ClassName AttrName}
        relvar association R102\
            Attribute {DomainName ClassName AttrName} 1\
            AttributeEntry {DomainName ClassName AttrName} ?

        relvar create EventParamEntry {
            DomainName      string
            ClassName       string
            EventName       string
            EventType       string
            ParamName       string
            Widget          string
        } {DomainName ClassName EventName EventType ParamName}
        relvar association R104\
            EventParam {DomainName ClassName EventName EventType ParamName} 1\
            EventParamEntry\
                {DomainName ClassName EventName EventType ParamName} ?

    }
}

proc ::dressage::newDriverButton {w domainName opName} {
    set on [string tolower $opName]
    set button [ttk::button $w.${on}_button\
        -text $opName\
        -command [namespace code [list sendInvoke $domainName $opName]]\
        -takefocus 0\
    ]
    set entry [ttk::entry $w.${on}_result\
        -state readonly\
        -style Invalid.TEntry\
        -takefocus 0\
    ]
    relvar insert tack::DriverButton [list\
        DomainName      $domainName\
        OpName          $opName\
        Widget          $entry\
    ]
    return [list $button $entry]
}

proc ::dressage::newDriverParamEntry {w domainName opName paramName} {
    set entry [ttk::entry $w.[string tolower $paramName]_ent\
        -style Invalid.TEntry\
        -validate all\
        -validatecommand [namespace code {entryValidate %W %V %P}]\
        -invalidcommand [namespace code {invalidEntry %W}]\
    ]
    relvar insert tack::DriverParamEntry [list\
        DomainName      $domainName\
        OpName          $opName\
        ParamName       $paramName\
        Widget          $entry\
    ]
    return $entry
}

proc ::dressage::newInstanceSelector {w domainName className} {
    set cn [string tolower $className]
    set f [ttk::frame $w.${cn}_iframe]
    set lab [ttk::label $f.lab\
        -text Instance\
    ]
    grid $lab\
        -row 0\
        -column 0\
        -sticky e

    set spin [ttk::spinbox $f.spin\
        -from 0\
        -to 20\
        -increment 1\
        -format %.0f\
        -width 3\
        -wrap true\
        -command [namespace code [list clearAttrs $domainName $className]]\
    ]
    grid $spin\
        -row 0\
        -column 1\
        -sticky w
    $spin set 0

    relvar insert tack::InstanceSelector [list\
        DomainName      $domainName\
        ClassName       $className\
        Widget          $spin\
    ]
    return $f
}

proc ::dressage::newAttributeEntry {w domainName className attrName} {
    set entry [ttk::entry $w.[string tolower $attrName]_ent\
        -style Invalid.TEntry\
        -validate all\
        -validatecommand [namespace code {entryValidate %W %V %P}]\
        -invalidcommand [namespace code {invalidEntry %W}]\
    ]
    bind $entry <Key-Return> [namespace code\
            [list sendUpdate $domainName $className $attrName]]

    relvar insert tack::AttributeEntry [list\
        DomainName      $domainName\
        ClassName       $className\
        AttrName        $attrName\
        Widget          $entry\
    ]
    return $entry
}

proc ::dressage::entryValidate {w cond ent} {
    log::debug [info level 0]
    switch -exact -- $cond {
        key {
            if {$ent ne {}} {
                $w state invalid
            }
        }
        focusin {
        }
        focusout {
            return 0
        }
        forced {
            return 0
        }
    }
    return 1
}

proc ::dressage::invalidEntry {w} {
    $w state invalid
}

proc ::dressage::newEventParamEntry {w domainName className eventName\
            eventType paramName} {
    set entry [ttk::entry $w.[string tolower $paramName]_ent\
        -style Invalid.TEntry\
        -validate all\
        -validatecommand [namespace code {entryValidate %W %V %P}]\
        -invalidcommand [namespace code {invalidEntry %W}]\
    ]
    relvar insert tack::EventParamEntry [list\
        DomainName      $domainName\
        ClassName       $className\
        EventName       $eventName\
        EventType       $eventType\
        ParamName       $paramName\
        Widget          $entry\
    ]
    return $entry
}

proc ::dressage::sendInvoke {domainName opName} {
    variable hcmd
    set cmd [list $hcmd invoke $domainName $opName]
    # Round up the parameter values
    set params [pipe {
        relvar set tack::DriverParamEntry |
        relation restrictwith ~\
                {$DomainName eq $domainName && $OpName eq $opName} |
        relation join ~ $tack::DriverParam |
        relation project ~ ParamName ParamOrder Widget
    }]
    relation foreach param $params {
        relation assign $param
        set value [$Widget get]
        if {$value eq {}} {
            error "no value given for \"$ParamName\" argument"
        }
        $Widget state !invalid
        lappend cmd $value
    }
    # The response is a dictionary
    set response [eval $cmd]
    log::debug "$cmd -> $response"

    set resultValue [dict get $response result]
    set resultWidget [pipe {
        relvar set tack::DriverButton |
        relation restrictwith ~\
                {$DomainName eq [dict get $response domain] &&
                $OpName eq [dict get $response operation]} |
        relation extract ~ Widget
    }]
    switch -exact -- [dict get $response code] {
        success {
            if {$resultValue eq {}} {
                set resultValue success
            }
            $resultWidget state !invalid
        }
        error {
            tk_messageBox\
                -icon error\
                -message "$opName failed: $resultValue"\
                -parent .\
                -title "Failed Domain Operation"\
                -type ok
            $resultWidget state invalid
        }
        default {
            error "unknown response code, \"[dict get $response code]\""
        }
    }
    $resultWidget state !readonly
    $resultWidget delete 0 end
    $resultWidget insert 0 $resultValue
    $resultWidget state readonly
}

proc ::dressage::updateAllAttrs {domainName className} {
    set attrNames [pipe {
        relvar set tack::AttributeEntry |
        relation restrictwith ~ {$DomainName eq $domainName &&\
            $ClassName eq $className} |
        relation list ~ AttrName
    }]
    foreach attrName $attrNames {
        sendUpdate $domainName $className $attrName
    }
}

proc ::dressage::sendUpdate {domainName className attrName} {
    set inst [pipe {
        relvar restrictone tack::InstanceSelector DomainName $domainName\
                ClassName $className |
        relation extract ~ Widget |
        ~ get
    }]
    set attrw [pipe {
        relvar restrictone tack::AttributeEntry DomainName $domainName\
                ClassName $className AttrName $attrName |
        relation extract ~ Widget
    }]
    set value [$attrw get]
    if {$value eq {}} {
        error "value for attribute, \"$attrName\", is empty"
    }
    $attrw state !invalid

    variable hcmd
    set cmd [list $hcmd update $domainName $className $inst $attrName $value]
    set response [eval $cmd]
    log::debug "$cmd -> $response"

    set resultValue [dict get $response result]
    $attrw delete 0 end
    $attrw insert 0 $resultValue
    switch -exact -- [dict get $response code] {
        success {
            $attrw state !invalid
        }
        error {
            tk_messageBox\
                -icon error\
                -message "$attrName update failed: $resultValue"\
                -parent .\
                -title "Failed Attribute Update"\
                -type ok
            # This state setting seems to need to be after the message box
            # or else it doesn't seem to take.
            $attrw state invalid
        }
        default {
            error "unknown response code, \"[dict get $response code]\""
        }
    }
}

proc ::dressage::readAllAttrs {domainName className} {
    set attrNames [pipe {
        relvar set tack::AttributeEntry |
        relation restrictwith ~ {$DomainName eq $domainName &&\
            $ClassName eq $className} |
        relation list ~ AttrName
    }]
    foreach attrName $attrNames {
        sendRead $domainName $className $attrName
    }
}

proc ::dressage::sendRead {domainName className attrName} {
    set inst [pipe {
        relvar restrictone tack::InstanceSelector DomainName $domainName\
                ClassName $className |
        relation extract ~ Widget |
        ~ get
    }]
    set attrw [pipe {
        relvar restrictone tack::AttributeEntry DomainName $domainName\
                ClassName $className AttrName $attrName |
        relation extract ~ Widget
    }]

    variable hcmd
    set cmd [list $hcmd read $domainName $className $inst $attrName]
    set response [eval $cmd]
    log::debug "$cmd -> $response"

    set resultValue [dict get $response result]
    $attrw delete 0 end
    $attrw insert 0 $resultValue
    switch -exact -- [dict get $response code] {
        success {
            $attrw state !invalid
        }
        error {
            tk_messageBox\
                -icon error\
                -message "$attrName update failed: $resultValue"\
                -parent .\
                -title "Failed Attribute Update"\
                -type ok
            # This state setting seems to need to be after the message box
            # or else it doesn't seem to take.
            $attrw state invalid
        }
        default {
            error "unknown response code, \"[dict get $response code]\""
        }
    }
}

proc ::dressage::sendEvent {domainName className eventName eventType} {
    set inst [pipe {
        relvar restrictone tack::InstanceSelector DomainName $domainName\
                ClassName $className |
        relation extract ~ Widget |
        ~ get
    }]
    variable hcmd

    set cmd [list $hcmd $eventType $domainName $className $inst $eventName]

    set pwidgets [pipe {
        relvar set tack::EventParamEntry |
        relation restrictwith ~ {$DomainName eq $domainName &&\
            $ClassName eq $className && $EventName eq $eventName &&\
            $EventType eq $eventType} |
        relation join ~ $tack::EventParam |
        relation project ~ ParamName ParamOrder Widget
    }]
    relation foreach pwidget $pwidgets -ascending ParamOrder {
        relation assign $pwidget
        set pvalue [$Widget get]
        if {$pvalue eq {}} {
            error "event parameter, \"$ParamName\", value is empty"
        }
        $Widget state !invalid
        lappend cmd $pvalue
    }

    set response [eval $cmd]
    log::debug "$cmd -> $response"
    set resultValue [dict get $response result]
    set code [dict get $response code]
    if {$code eq "error"} {
        tk_messageBox\
            -icon error\
            -message "$eventName send event failed: $resultValue"\
            -parent .\
            -title "Failed Attribute Update"\
            -type ok
    } elseif {$code ne "success"} {
        error "unknown response code, \"[dict get $response code]\""
    }
}

proc ::dressage::clearAttrs {domainName className} {
    set widgets [pipe {
        relvar set tack::AttributeEntry |
        relation restrictwith ~ {$DomainName eq $domainName &&\
                $ClassName eq $className} |
        relation list ~ Widget
    }]
    foreach widget $widgets {
        $widget delete 0 end
    }
}

set optlist {
    {level.arg warn {Log debug level}}
    {tack.arg {} {Tack save file}}
    {exec.arg {} {Harness executable file}}
    {pycca.arg {} {Pycca domain save file}}
}
array set options [::cmdline::getKnownOptions argv $optlist]

::logger::setlevel $options(level)

dressage main

set ::dressage::fileNames(tack) $options(tack)
set ::dressage::fileNames(exec) $options(exec)
set ::dressage::fileNames(pycca) $options(pycca)
::dressage::evalConnectAllowed
