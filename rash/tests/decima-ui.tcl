package require Tcl 8.6
package require Tk 8.6
package require logger
package require rosea
package require comport
package require iconimage
package require autoscroll

namespace eval ::decima::ui {
    logger::initNamespace [namespace current] info

    variable version 1.0a2
}

rosea configure {
    domain ui {
        class APP {
            attribute AppId string -id 1
            attribute Hull string
            instop constructor {} {
                set Hull [readAttribute $self Hull]
                toplevel $Hull
                wm title $Hull "Decima  Version $::decima::ui::version"
                wm protocol $Hull WM_DELETE_WINDOW ::exit
            
                grid rowconfigure $Hull 3 -weight 1
                grid columnconfigure $Hull 0 -weight 1
            }
            instop ShowUserMessage {type title msg} {
                tk_messageBox\
                    -icon $type\
                    -title $title\
                    -parent [readAttribute $self Hull]\
                    -type ok\
                    -message $msg
            }
            statemodel {
                initialstate Disconnected
                defaulttrans CH
                
                transition Disconnected - Disconnected -> IG
                transition Disconnected - Connected -> Connected
                
                transition Connected - Disconnected -> Disconnected
                transition Connected - TargetReady -> Available
                
                transition Available - Disconnected -> Disconnected
                transition Available - CalibrateStart -> Calibrating
                
                transition Calibrating - Disconnected -> Disconnected
                transition Calibrating - CalibrateStop -> Aborted
                transition Calibrating - CalibrateDone -> Completed
                
                transition Aborted - Disconnected -> Disconnected
                transition Aborted - CalibrateDone -> Completed
                
                transition Completed - Disconnected -> Disconnected
                transition Completed - CalibrateStop -> IG
                transition Completed - Finished -> Ready
                
                transition Ready - Disconnected -> Disconnected
                transition Ready - CalibrateStart -> Calibrating
                state Disconnected {} {
                    signal [findRelated $self ~R2] Disconnected
                    signal [findRelated $self ~R3] Disable
                    signal [findRelated $self ~R4] Disable
                    ::decima::ui::CAL::DeleteTarget $self
                }
                state Connected {} {
                    signal [findRelated $self ~R2] Connected
                }
                state Available {type num} {
                    ::decima::ui::CAL::NewTarget $self $type $num
                    signal [findRelated $self ~R3] Enable
                    signal [findRelated $self ~R4] Disable
                }
                state Calibrating {} {
                    signal [findRelated $self ~R4] Enable
                    ::decima::ui::CAL::StartCalibration [readAttribute $self AppId]
                }
                state Aborted {} {
                    ::decima::ui::CAL::StopCalibration [readAttribute $self AppId]
                }
                state Completed {} {
                    signal [findRelated $self ~R3] Stop
                    signal [findRelated $self ~R4] Done
                }
                state Ready {} {
                    signal [findRelated $self ~R3] Enable
                    signal [findRelated $self ~R4] Disable
                }
            }
        }
        class MBAR {
            attribute AppId string -id 1
            attribute Hull string
            attribute TraceControl boolean -default false
            attribute DebugLevel string -default warn
            reference R5 APP -link AppId
            
            instop constructor {} {
                assignAttribute $self AppId Hull
                menu $Hull
            
                $Hull add cascade\
                    -label File\
                    -menu $Hull.file
            
                menu $Hull.file
                $Hull.file add command\
                    -label Exit\
                    -command ::exit
            
                $Hull add cascade\
                    -label Show\
                    -menu $Hull.show
            
                menu $Hull.show
                $Hull.show add command\
                    -label Console\
                    -command [namespace code [list instop $self ShowConsole]]
                $Hull.show add cascade\
                    -label Debug\
                    -menu $Hull.debug
                $Hull.show add checkbutton\
                    -label {State Machine Tracing}\
                    -onvalue true\
                    -offvalue false\
                    -variable [namespace current]::TraceControl($AppId)\
                    -command [namespace code [list instop $self ControlTrace]]
                $Hull.show add command\
                    -label About\
                    -command [namespace code [list instop $self ShowAbout]]
            
                menu $Hull.debug
                foreach level [::logger::levels] {
                    $Hull.debug add radiobutton\
                        -label $level\
                        -variable [namespace current]::DebugLevel($AppId)\
                        -command [namespace code [list instop $self LogLevel]]
                }
            }
            instop LogLevel {} {
                ::logger::setlevel [readAttribute $self DebugLevel]
            }
            instop ShowAbout {} {
                set aboutText "Decima
            Copyright 2014, InCube Labs, LLC
            All Rights Reserved
            Revision: $::decima::ui::version"
            
                instop [findRelated $self R5] ShowUserMessage info Decima $aboutText
                return
            }
            instop ShowConsole {} {
                catch {
                    ::console show
                    ::console title "Decima Console"
                }
            }
            instop ControlTrace {} {
                set TraceControl [readAttribute $self TraceControl]
            
                if {$TraceControl} {
                    rosea trace control on
                    rosea trace control logon
                    rosea trace control loglevel info
                } else {
                    rosea trace control off
                    rosea trace control logoff
                }
            }
        }
        class TCONN {
            attribute AppId string -id 1
            attribute Hull string
            attribute Port string
            reference R1 APP -link AppId
            
            instop constructor {} {
                assignAttribute $self AppId Hull
                ttk::labelframe $Hull\
                    -takefocus 0\
                    -text "Target Connection"
            
                ttk::button $Hull.connect\
                    -image [iconimage getIcon connectno16]\
                    -text Connect\
                    -takefocus 0\
                    -compound left\
                    -command [namespace code [list signal $self Connect]]
                variable Port
                set Port($AppId) {}
                ttk::combobox $Hull.ports\
                    -takefocus 0\
                    -textvariable [namespace current]::Port($AppId)\
            
                grid $Hull.connect $Hull.ports\
                    -padx 4\
                    -sticky w
            
                ::bind $Hull.ports <<ComboboxSelected>>\
                        [namespace code [list instop $self PortSelect]]
            }
            instop PortSelect {} {
                variable Port
                assignAttribute $self AppId Hull
                if {$Port($AppId) eq "rescan"} {
                    instop $self ScanPorts
                    $Hull.ports selection clear
                    $Hull.ports icursor end
                }
            }
            instop ScanPorts {} {
                variable Port
                assignAttribute $self AppId Hull
                set values [$Hull.ports cget -values]
                set index [lsearch -exact $values $Port($AppId)]
                if {$index == -1 || [lindex $values $index] eq "rescan"} {
                    set index 0
                }
            
                set portlist [concat\
                        [lsort -dictionary [comport findPorts *VCP*]]\
                        rescan]
                $Hull.ports configure\
                    -values $portlist
                updateAttribute $self Port [set Port($AppId) [lindex $portlist $index]]
                $Hull.connect state\
                    [expr {$Port($AppId) ne "rescan" ? "!disabled" : "disabled"}]
            }
            statemodel {
                initialstate Disconnected
                defaulttrans CH
                
                transition Disconnected - Connect -> Connecting
                
                transition Connecting - Connected -> Connected
                transition Connecting - Disconnected -> Disconnected
                transition Connecting - Connect -> IG
                
                transition Connected - Disconnect -> Disconnecting
                transition Connected - Disconnected -> Disconnected
                
                transition Disconnecting - Disconnected -> Disconnected
                state Disconnected {} {
                    set Hull [readAttribute $self Hull]
                    $Hull.connect configure\
                        -text Connect\
                        -image [iconimage getIcon connectno16]\
                        -command [namespace code [list signal $self Connect]]
                
                    $Hull.ports state !disabled
                    instop $self ScanPorts
                    signal [findRelated $self R1] Disconnected
                }
                state Connecting {} {
                    assignAttribute $self AppId Port Hull
                
                    $Hull.connect configure\
                        -text Connecting\
                        -image [iconimage getIcon connecting16]
                    $Hull.connect state disabled
                    $Hull.ports state disabled
                
                    update idletasks
                    ::decima::ui::DEV::Connect $AppId $Port
                }
                state Connected {} {
                    set Hull [readAttribute $self Hull]
                    $Hull.connect state !disabled
                    $Hull.connect configure\
                        -text Disconnect\
                        -image [iconimage getIcon connectyes16]\
                        -command [namespace code [list signal $self Disconnect]]
                    signal [findRelated $self R1] Connected
                }
                state Disconnecting {} {
                    ::decima::ui::DEV::Disconnect [readAttribute $self AppId]
                }
            }
        }
        class TINFO {
            attribute AppId string -id 1
            attribute Hull string
            attribute SerialNo string -default ---
            attribute Software string -default ---
            attribute Revision string -default ---
            reference R2 APP -link AppId
            
            instop constructor {} {
                assignAttribute $self AppId Hull
                ttk::labelframe $Hull\
                    -takefocus 0\
                    -text "Target Information"
            
                ttk::label $Hull.serialnolabel\
                    -text "Serial Number"\
                    -takefocus 0
                ttk::label $Hull.serialno\
                    -textvariable [namespace current]::SerialNo($AppId)\
                    -takefocus 0
                grid $Hull.serialnolabel $Hull.serialno\
                    -padx 2\
                    -pady 2
                grid configure $Hull.serialnolabel\
                    -sticky e
                grid configure $Hull.serialno\
                    -sticky w
            
                ttk::label $Hull.softwarelabel\
                    -text Software\
                    -takefocus 0
                ttk::label $Hull.software\
                    -textvariable [namespace current]::Software($AppId)\
                    -takefocus 0
                grid $Hull.softwarelabel $Hull.software\
                    -padx 2\
                    -pady 2
                grid configure $Hull.softwarelabel\
                    -sticky e
                grid configure $Hull.software\
                    -sticky w
            
                ttk::label $Hull.revisionlabel\
                    -text Revision\
                    -takefocus 0
                ttk::label $Hull.revision\
                    -textvariable [namespace current]::Revision($AppId)\
                    -takefocus 0
                grid $Hull.revisionlabel $Hull.revision\
                    -padx 2\
                    -pady 2
                grid configure $Hull.revisionlabel\
                    -sticky e
                grid configure $Hull.revision\
                    -sticky w
            }
            statemodel {
                initialstate Disconnected
                defaulttrans CH
                
                transition Disconnected - Connected -> Connected
                transition Disconnected - Disconnected -> IG
                
                transition Connected - Disconnected -> Disconnected
                state Disconnected {} {
                    updateAttribute $self\
                        SerialNo ---\
                        Software ---\
                        Revision ---
                }
                state Connected {} {
                
                    set appid [readAttribute $self AppId]
                    set SerialNo [::decima::ui::DEV::GetValue $appid SerialNo]
                    set Software [::decima::ui::DEV::GetValue $appid Software]
                    updateAttribute $self\
                        SerialNo $SerialNo\
                        Software $Software\
                        Revision [::decima::ui::DEV::GetValue $appid Revision]
                    signal [findRelated $self R2] TargetReady $Software $SerialNo
                }
            }
        }
        class CSEL {
            attribute AppId string -id 1
            attribute Hull string
            attribute Available list -default [list]
            attribute Selected list -default [list]
            attribute Procedures list -default [list]
            reference R3 APP -link AppId
            
            instop constructor {} {
                assignAttribute $self AppId Hull
                ttk::labelframe $Hull\
                    -takefocus 0\
                    -text "Calibration Selection"
            
                grid columnconfigure $Hull {0 2} -weight 1
            
                ttk::label $Hull.availlabel\
                    -takefocus 0\
                    -text Available
                ttk::label $Hull.selectlabel\
                    -takefocus 0\
                    -text Selected
            
                ttk::frame $Hull.availbox
                listbox $Hull.availbox.availlist\
                    -listvariable [namespace current]::Available($AppId)\
                    -xscrollcommand [list $Hull.availbox.xscroll set]\
                    -yscrollcommand [list $Hull.availbox.yscroll set]\
                    -width 50\
                    -selectmode extended
                ttk::scrollbar $Hull.availbox.xscroll\
                    -orient horizontal\
                    -command [list $Hull.availbox.availlist xview]
                ttk::scrollbar $Hull.availbox.yscroll\
                    -orient vertical\
                    -command [list $Hull.availbox.availlist yview]
                grid $Hull.availbox.availlist\
                    -row 0 -column 0 -sticky nsew
                grid $Hull.availbox.xscroll\
                    -row 1 -column 0 -sticky nsew
                grid $Hull.availbox.yscroll\
                    -row 0 -column 1 -sticky nsew
                grid rowconfigure $Hull.availbox 0 -weight 1
                grid columnconfigure $Hull.availbox 0 -weight 1
                autoscroll::autoscroll $Hull.availbox.xscroll
                autoscroll::autoscroll $Hull.availbox.yscroll
            
                ttk::frame $Hull.selectbox
                listbox $Hull.selectbox.selectlist\
                    -listvariable [namespace current]::Selected($AppId)\
                    -xscrollcommand [list $Hull.selectbox.xscroll set]\
                    -yscrollcommand [list $Hull.selectbox.yscroll set]\
                    -width 50\
                    -selectmode extended
                ttk::scrollbar $Hull.selectbox.xscroll\
                    -orient horizontal\
                    -command [list $Hull.selectbox.selectlist xview]
                ttk::scrollbar $Hull.selectbox.yscroll\
                    -orient vertical\
                    -command [list $Hull.selectbox.selectlist yview]
                grid $Hull.selectbox.selectlist\
                    -row 0 -column 0 -sticky nsew
                grid $Hull.selectbox.xscroll\
                    -row 1 -column 0 -sticky nsew
                grid $Hull.selectbox.yscroll\
                    -row 0 -column 1 -sticky nsew
                grid rowconfigure $Hull.selectbox 0 -weight 1
                grid columnconfigure $Hull.selectbox 0 -weight 1
                autoscroll::autoscroll $Hull.selectbox.xscroll
                autoscroll::autoscroll $Hull.selectbox.yscroll
            
                ttk::frame $Hull.ctrls
                ttk::button $Hull.ctrls.oneleft\
                    -text <\
                    -command [namespace code [list instop $self Left]]
                ttk::button $Hull.ctrls.allleft\
                    -text <<\
                    -command [namespace code [list instop $self  AllLeft]]
                ttk::button $Hull.ctrls.oneright\
                    -text >\
                    -command [namespace code [list instop $self  Right]]
                ttk::button $Hull.ctrls.allright\
                    -text >>\
                    -command [namespace code [list instop $self  AllRight]]
                ttk::button $Hull.ctrls.run\
                    -text Run\
                    -command [namespace code [list signal $self Run]]
                grid $Hull.ctrls.oneright -pady 2
                grid $Hull.ctrls.allright -pady 2
                grid $Hull.ctrls.allleft -pady 2
                grid $Hull.ctrls.oneleft -pady 2
                grid $Hull.ctrls.run -pady 2
            
            
                grid $Hull.availlabel   $Hull.ctrls     $Hull.selectlabel -padx 2
                grid $Hull.availbox     ^               $Hull.selectbox -padx 2
            
                instop $self Disable
            }
            instop Left {} {
                assignAttribute $self AppId Hull Available Selected Procedures
            
                set sindices [$Hull.selectbox.selectlist curselection]
                if {[llength $sindices] == 0} {
                    return
                }
            
                set deselected [lmap sindex $sindices {lindex $Selected $sindex}]
                set newAvailable [concat $Available $deselected]
            
                lmap sindex [lreverse $sindices]\
                    {$Hull.selectbox.selectlist delete $sindex}
                $Hull.selectbox.selectlist selection clear 0 end
            
                set availProcs [instop $self Sort\
                    [instop $self Filter $Procedures Name $newAvailable] Number]
                updateAttribute $self Available [instop $self Project $availProcs Name]
                variable Available
                set Available($AppId) [list]
            
                ::decima::ui::CAL::Deselect $AppId [instop $self Project\
                        [instop $self Filter $Procedures Name $deselected] Number]
            }
            instop AllLeft {} {
                assignAttribute $self AppId Selected Procedures
            
                updateAttribute $self [instop $self Project $Procedures Name]
            
                if {[llength $Selected] != 0} {
                    ::decima::ui::CAL::Deselect $AppId [instop $self Project\
                            [instop $self Filter $Procedures Name $Selected] Number]
                    updateAttribute $self Selected [list]
                    variable Selected
                    set Selected($AppId) [list]
                }
            }
            instop Right {} {
                assignAttributes $self Hull Available Selected Procedures
            
                set sindices [$Hull.availbox.availlist curselection]
                if {[llength $sindices] == 0} {
                    return
                }
            
                set selected [lmap sindex $sindices {lindex $Available $sindex}]
                set newSelected [concat $Selected $selected]
            
                lmap sindex [lreverse $sindices]\
                    {$Hull.availbox.availlist delete $sindex}
                $Hull.availbox.availlist selection clear 0 end
            
                set selectProcs [instop $self Sort\
                    [instop $self Filter $Procedures Name $newSelected] Number]
                updateAttribute $self Selected [instop $self Project $selectProcs Name]
                variable Selected
                set Selected($AppId) [list]
            
                ::decima::ui::CAL::Select $AppId\
                    [instop $self Project\
                        [instop $self Filter $Procedures Name $selected] Number]
            }
            instop AllRight {} {
                assignAttribute $self AppId Available Selected Procedures
            
                updateAttribute $self [instop $self Project $Procedures Name]
            
                if {[llength $Available] != 0} {
                    ::decima::ui::CAL::Select $AppId\
                        [instop $self Project\
                            [instop $self Filter $Procedures Name $Available] Number]
                    updateAttribute Available [list]
                    variable Available
                    set Available($AppId) [list]
                }
            }
            instop Disable {} {
                set Hull [readAttribute $self Hull]
                $Hull.ctrls.run configure\
                    -text Run\
                    -command [namespace code [list signal $self Run]]
                $Hull.ctrls.run state disabled
                instop $self ControlsState disabled
                instop $self SelectState disabled
            }
            instop ControlsState {state} {
                set Hull [readAttribute $self Hull]
                $Hull.ctrls.oneright state $state
                $Hull.ctrls.allright state $state
                $Hull.ctrls.allleft state $state
                $Hull.ctrls.oneleft state $state
            }
            instop SelectState {state} {
                set Hull [readAttribute $self Hull]
                $Hull.availbox.availlist configure -state $state
                $Hull.selectbox.selectlist configure -state $state
            }
            instop Project {list key} {
                return [lmap item $list {dict get $item $key}]
            }
            instop Select {list key value} {
                return [lmap item $list {
                    expr {[dict get $item $key] == $value ? $item : [continue]}
                }]
            }
            instop Sort {list key} {
                return [lsort -command [list apply {{key i1 i2} {
                        return [expr {[dict get $i1 $key] - [dict get $i2 $key]}]
                    }} $key] $list]
            }
            instop Filter {list key contents} {
                return [lmap item $list {
                    expr {[dict get $item $key] in $contents ? $item : [continue]}
                }]
            }
            instop ProcNumToName {procnum} {
                set Procedures [readAttribute $self Procedures]
                set procs [instop $self Select $Procedures Number $procnum]
                return [expr {[llength $procs] == 0 ?\
                    "unknown calibration ($procnum)" : [dict get [lindex $procs 0] Name]}]
            }
            statemodel {
                initialstate Disabled
                defaulttrans CH
                
                transition Disabled - Enable -> Enabled
                transition Disabled - Disable -> IG
                
                transition Enabled - Enable -> Ready
                transition Enabled - Disable -> Disabled
                
                transition Ready - Enable -> IG
                transition Ready - Disable -> Disabled
                transition Ready - Run -> Running
                
                transition Running - Disable -> Disabled
                transition Running - Stop -> Stopping
                
                transition Stopping - Enable -> Ready
                transition Stopping - Disable -> Disabled
                transition Stopping - Stop -> IG
                state Disabled {} {
                    instop $self Disable
                }
                state Enabled {} {
                    set AppId [readAttribute $self AppId]
                
                    set procedures [instop $self Sort\
                            [::decima::ui::CAL::GetCalibProcs $AppId] Number]
                    updateAttribute $self Procedures $procedures Available [list]\
                            Selected [instop $self Project $procedures Name]
                    variable Available
                    set Available($AppId) [list]
                
                    ::decima::ui::CAL::Select $AppId [instop $self Project $procedures Number]
                
                    signal $self Enable
                }
                state Ready {} {
                    set Hull [readAttribute $self Hull]
                
                    instop $self ControlsState !disabled
                    instop $self SelectState normal
                
                    $Hull.ctrls.run state !disabled
                    $Hull.ctrls.run configure\
                        -text Run\
                        -command [namespace code [list signal $self Run]]
                }
                state Running {} {
                    set Hull [readAttribute $self Hull]
                
                    instop $self ControlsState disabled
                    instop $self SelectState disabled
                    $Hull.ctrls.run configure\
                        -text Stop\
                        -command [namespace code [list signal $self Stop]]
                    signal [findRelated $self R3] CalibrateStart
                }
                state Stopping {} {
                    set Hull [readAttribute $self Hull]
                
                    $Hull.ctrls.run state disabled
                    signal [findRelated $self R3] CalibrateStop
                }
            }
        }
        class CRES {
            attribute AppId string -id 1
            attribute Hull string
            reference R4 APP -link AppId
            
            instop constructor {} {
                set Hull [readAttribute $self Hull]
                ttk::labelframe $Hull\
                    -takefocus 0\
                    -text "Calibration Results"
                ttk::treeview $Hull.results\
                    -xscrollcommand [list $Hull.xscroll set]\
                    -yscrollcommand [list $Hull.yscroll set]\
                    -columns {Calibration Status Trim Value}\
                    -displaycolumns {Status Trim Value}\
                    -height 10
                $Hull.results heading #0\
                    -text Calibration
                $Hull.results heading Status\
                    -text Status
                $Hull.results heading Trim\
                    -text Trim
                $Hull.results heading Value\
                    -text Value
                $Hull.results column #0 -width 160
                $Hull.results column Status -width 80
                $Hull.results column Trim -width 100
                $Hull.results column Value -width 50
                $Hull.results tag configure Failed -foreground red
                ttk::scrollbar $Hull.xscroll\
                    -orient horizontal\
                    -command [list $Hull.results xview]
                ttk::scrollbar $Hull.yscroll\
                    -orient vertical\
                    -command [list $Hull.results yview]
                grid $Hull.results\
                    -row 0 -column 0 -sticky nsew
                grid $Hull.xscroll\
                    -row 1 -column 0 -sticky nsew
                grid $Hull.yscroll\
                    -row 0 -column 1 -sticky nsew
                grid rowconfigure $Hull 0 -weight 1
                grid columnconfigure $Hull 0 -weight 1
                autoscroll::autoscroll $Hull.xscroll
                autoscroll::autoscroll $Hull.yscroll
            
                ttk::frame $Hull.ctrls
                grid $Hull.ctrls\
                    -sticky ew
                grid rowconfigure $Hull.ctrls 0 -weight 1
                grid columnconfigure $Hull.ctrls {0 1} -weight 1
            
                ttk::button $Hull.ctrls.save\
                    -text Save\
                    -command [namespace code [list instop $self Save]]
                grid $Hull.ctrls.save\
                    -row 0\
                    -column 0\
                    -sticky e\
                    -pady 2\
                    -padx 2
                ttk::button $Hull.ctrls.discard\
                    -text Discard\
                    -command [namespace code [list instop $self Discard]]
                grid $Hull.ctrls.discard\
                    -row 0\
                    -column 1\
                    -sticky w\
                    -pady 2\
                    -padx 2
            
                instop $self Disable
            }
            instop PostResult {calnum trims} {
                set Hull [readAttribute $self Hull]
            
                set calname [instop [findRelated $self R4 ~R3] ProcNumToName $calnum]
                set id [$Hull.results insert {}  end -text $calname\
                        -values [list $calname SUCCESS {} {}] -open false]
                set trimid $id
                foreach trim $trims {
                    set trimid [$Hull.results insert $id end\
                        -values [list {} {}\
                            [dict get $trim Name] [dict get $trim Value]]\
                        -open false\
                    ]
                }
            
                $Hull.results see $id
            
                return
            }
            instop CalibrationFailed {calnum} {
                set Hull [readAttribute $self Hull]
            
                set calname [instop [findRelated $self R4 ~R3] ProcNumToName $calnum]
                set id [$Hull.results insert {}  end\
                    -text $calname\
                    -values [list $calname FAILED]\
                    -open false\
                    -tags Failed\
                ]
                $Hull.results see $id
            
                return
            }
            instop Save {} {
                ::decima::ui::CAL::SaveData [readAttribute $self AppId]
                signal [findRelated $self R4] Finished
            }
            instop Discard {} {
                ::decima::ui::CAL::DiscardData [readAttribute $self AppId]
                signal [findRelated $self R4] Finished
            }
            instop Disable {} {
                set Hull [readAttribute $self Hull]
                $Hull.results state disabled
                $Hull.ctrls.save state disabled
                $Hull.ctrls.discard state disabled
            }
            statemodel {
                initialstate Disabled
                defaulttrans CH
                
                transition Disabled - Enable -> Ready
                transition Disabled - Disable -> IG
                
                transition Ready - Disable -> Disabled
                transition Ready - Done -> Completed
                
                transition Completed - Disable -> Disabled
                state Disabled {} {
                    instop $self Disable
                }
                state Ready {} {
                    set Hull [readAttribute $self Hull]
                
                    $Hull.results state !disabled
                    $Hull.results delete [$Hull.results children {}]
                
                    $Hull.ctrls.save state disabled
                    $Hull.ctrls.discard state disabled
                }
                state Completed {} {
                    set Hull [readAttribute $self Hull]
                    $Hull.results state disabled
                    $Hull.ctrls.save state !disabled
                    $Hull.ctrls.discard state !disabled
                }
            }
        }
        association R5 MBAR 1--1 APP
        association R1 TCONN 1--1 APP
        association R2 TINFO 1--1 APP
        association R3 CSEL 1--1 APP
        association R4 CRES 1--1 APP
    }
}

rosea generate ui ::decima

namespace eval ::decima::ui {
    ral relvar eval {
        set app [APP create AppId 1 Hull .decima]
        rosea tunnel $app constructor
        
        set mbar [MBAR create AppId 1 Hull .decima.mbar]
        rosea tunnel $mbar constructor
        .decima configure -menu .decima.mbar
        
        set tconn [TCONN create AppId 1 Hull .decima.tconn Port [list]]
        rosea tunnel $tconn constructor
        rosea tunnel $tconn ScanPorts
        grid .decima.tconn -sticky new
        
        set tinfo [TINFO create AppId 1 Hull .decima.tinfo]
        rosea tunnel $tinfo constructor
        grid .decima.tinfo -sticky new
        
        set csel [CSEL create AppId 1 Hull .decima.csel]
        rosea tunnel $csel constructor
        grid .decima.csel -sticky new
        
        set cres [CRES create AppId 1 Hull .decima.cres]
        rosea tunnel $cres constructor
        grid .decima.cres -sticky nsew
    }
}
