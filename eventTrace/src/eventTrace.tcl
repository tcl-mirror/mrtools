#*++
# PROJECT:
#   mrtools
#
# MODULE:
#   eventTrace -- decode and print state machine traces
#
# ABSTRACT:
#   This file contains a set of Tcl procs that decode and print state machine
#   traces. Traces as they come from STSA are purely numeric as no string
#   information is placed in the embedded target. These procs use the symbol
#   information from an ELF file and the saved information from "pycca" to
#   decode the numeric values in the trace and build a human readable string
#   indicating dispatched transitions.
#*--
#

package provide eventTrace 1.3.1

package require Tcl 8.6
package require ral
package require ralutil
package require elfdecode
package require logger
package require fileutil

namespace eval ::eventTrace {
    namespace export setTracePlatform
    namespace export traceInit
    namespace export scanTrace
    namespace export formatTrace
    namespace export ptrace
    namespace export markTransition
    namespace export reportCoverage
    namespace export instAddress
    namespace export instStorage
    namespace export setInstSize
    namespace ensemble create

    namespace import ::ral::*
    namespace import ::ralutil::*

    logger::initNamespace ::eventTrace ; #debug

    # A relvar to hold symbol information gleaned from the symbol table
    relvar create ClassStorageBase {
            Module string
            ClassName string
            BaseAddr int
            Size int
        } {Module ClassName} BaseAddr
    # A relvar to hold the mapping from class structure addresses
    # to class names.
    relvar create ClassStructMap {
            Module string
            ClassName string
            StructAddr int
        } {Module ClassName} StructAddr
    # A relvar to hold the mapping from instance addresses to class
    # and instance name.
    relvar create InstAddrMap {
	    DomainName string
	    ClassName string
	    DomainId int
	    ClassId int
	    InstName string
	    InstBegin int
	    InstEnd int
	} {DomainName ClassName InstName} {DomainId ClassId InstName} InstBegin
    # A relvar to hold potential union subtype addresses
    relvar create UnionInstAddrMap {
            DomainName string
            ClassName string
            DomainId int
            ClassId int
            InstName string
            InstBegin int
            InstEnd int
        } {DomainName ClassName InstName} {DomainId ClassId InstName} InstBegin
    # A relvar to hold transition coverage information used in reporting.
    relvar create TransCoverage {
            TestCase string
            ClassName string
            StateName string
            EventName string
        } {TestCase ClassName StateName EventName}
    # A relvar to hold information about storage array for each class.
    relvar create ClassStorageMap {
        DomainName string
        ClassName string
        BaseAddr int
        InstSize int
        TotalInsts int
    } {DomainName ClassName} {DomainName BaseAddr}
    # Relvar to hold symbol information for MSP430 and PEI symbol maps.
    relvar create Symbol {
            Module string
            Name string
            Address int
    } {Module Name} Address
    # Relvar to hold section header information for PEI format
    relvar create Section {
        Name    string
        Num     int
        Addr    int
        Size    int
    } Name Num Addr
    # State variable used to deal with the events that follow
    # a polymorphic event.
    variable polyTrace [dict create]
    variable tracePlatform

    # A relvar to hold the different properties for the different
    # types of trace platforms.
    relvar create PlatformProp {
        Platform    string
        Prop        string
        Value       string
    } {Platform Prop}

    relvar set PlatformProp [relation table {\
        Platform string     Prop string     Value string} {
        MSP430              NormFmt         @1cususucucu        } {
        MSP430              PolyFmt         @1cususucucucucu    } {
        MSP430              CreateFmt       @1cusususu          } {
        MSP430              InstFmt         0x%04X              } {
        ELF                 NormFmt         @1cux2iuiucucu      } {
        ELF                 PolyFmt         @1cux2iuiucucucucu  } {
        ELF                 CreateFmt       @1cux2iuiuiu        } {
        ELF                 InstFmt         0x%08X              } {
        PEI                 NormFmt         @1cux2iuiucucu      } {
        PEI                 PolyFmt         @1cux2iuiucucucucu  } {
        PEI                 CreateFmt       @1cux2iuiuiu        } {
        PEI                 InstFmt         0x%08X              } ]
}

proc ::eventTrace::setTracePlatform {platform} {
    variable tracePlatform

    switch -exact -nocase -- $platform {
        ELF {
            set tracePlatform ELF
        }
        MSP430 {
            set tracePlatform MSP430
        }
        PEI {
            set tracePlatform PEI
        }
        default {
            error "unknown platform, \"$platform\""
        }
    }
}

proc ::eventTrace::traceInit {symfile pyccafile} {
    variable tracePlatform

    scanSymbols$tracePlatform $symfile
    getPyccaData $pyccafile
    buildClassSyms$tracePlatform
    buildInstAddrMap
    return
}

# Format a mechanism trace into a printable string. "trace" is a
# dictionary as returned from "scanTrace" "or "formatTrace".
proc ::eventTrace::ptrace {trace} {
    if {[dict exists $trace time]} {
        append result "[dict get $trace time]: "
    }
    append result\
        "[dict get $trace srcInst] - "\
        "[dict get $trace eventNumber] -> "\
        "[dict get $trace dstInst]: "

    set eventType [dict get $trace eventType]
    if {$eventType eq "Normal"} {
        append result\
            "[dict get $trace currState] -> [dict get $trace newState]"
    } elseif {$eventType eq "Polymorphic"} {
        append result\
            "$eventType: [dict get $trace hierarchy] -\
            [dict get $trace mappedNumber] -> "\
            [dict get $trace subcode]
    } elseif {$eventType eq "Creation"} {
        append result "$eventType: [dict get $trace dstClass]"
    } else {
        error "[lindex [info level 0] 0]: unknown eventType, \"$eventType\""
    }
}

# Transform the trace dictionary as returned from "scanTrace" to have
# string and names rather than numbers. Dictionary keys remain unmodified.
proc ::eventTrace::formatTrace {trace} {
    variable polyTrace
    if {[dict exists $trace time]} {
        lassign [split [dict get $trace time] .] secs msecs
        dict set trace time [clock format $secs\
                -format "%Y/%m/%d %T.[format %03u $msecs]"]
    } else {
        dict set trace time [timeStamp]
    }

    set eventType [dict get $trace eventType]
    dict set trace srcInst [srcAddr2Class [dict get $trace srcInst]]

    set dstInfo [dstAddr2Class [dict get $trace dstInst]]
    log::debug \n[relformat $dstInfo dstInfo]
    if {[relation isempty $dstInfo]} {
        dict set trace dstInst @[format %04x [dict get $trace dstInst]]
        return $trace
    }
    set dst [tuple get [relation tuple $dstInfo]]
    log::debug "dst = $dst"

    if {$eventType eq "Normal"} {
        set polyTrace [dict create]
        dict with dst {
            set event [relvar restrictone EventMap\
                DomainId $DomainId\
                ClassId $ClassId\
                EventNum [dict get $trace eventNumber]\
                EventType event\
            ]
            log::debug \n[relformat $event EventMap]
            dict set trace eventNumber [relation extract $event EventName]
            dict set trace dstInst $ClassName.$InstName

            set currState [relvar restrictone StateMap\
                    DomainId $DomainId\
                    ClassId $ClassId\
                    StateNum [dict get $trace currState]]
            if {[relation isnotempty $currState]} {
                dict set trace currState\
                        [relation extract $currState StateName]
            }
            set ns [dict get $trace newState]
            if {$ns == 255} {
                # Ignore == 255
                dict set trace newState IG
            } elseif {$ns == 254} {
                # Can't Happen == 254
                dict set trace newState CH
            } else {
                set newState [relvar restrictone StateMap\
                        DomainId $DomainId\
                        ClassId $ClassId\
                        StateNum [dict get $trace newState]]
                if {[relation isnotempty $newState]} {
                    dict set trace newState\
                            [relation extract $newState StateName]
                }
            }
        }
    } elseif {$eventType eq "Polymorphic"} {
        set polyTrace $trace

        variable SubtypeMap
        dict with dst {
            set event [relvar restrictone EventMap\
                DomainId $DomainId\
                ClassId $ClassId\
                EventNum [dict get $trace eventNumber]\
                EventType polyevent\
            ]
            log::debug \n[relformat $event event]
            dict set trace eventNumber [relation extract $event EventName]
            dict set trace dstInst $ClassName.$InstName

            set subtype [relvar restrictone SubtypeMap\
                DomainId $DomainId\
                ClassId $ClassId\
                HierId [dict get $trace hierarchy]\
                SubCode [dict get $trace subcode]\
            ]
            log::debug \n[relformat $subtype subtype]
            dict set trace subcode [relation extract $subtype SubName]
            dict set trace hierarchy [relation extract $subtype ElemName]

            set mtype [dict get $trace mappedType]
            if {$mtype == 0} {
                set qmtype event
            } elseif {$mtype == 1} {
                set qmtype polyevent
            }

            variable Class
            variable EventMap
            set mevent [pipe {
                relation rename $subtype ClassId SuperClassId |
                relation join ~ $Class\
                    -using {DomainId DomainId SubName ClassName}\
                    $EventMap -using {DomainId DomainId ClassId ClassId} |
                relation restrictwith ~\
                    {$EventNum == [dict get $trace mappedNumber] &&\
                    $EventType eq $qmtype}
                            
            }]
            log::debug \n[relformat $mevent mevent]
            dict set trace mappedNumber [relation extract $mevent EventName]

            if {$mtype == 0} {
                dict set trace mappedType Normal
            } elseif {$mtype == 1} {
                dict set trace mappedType Polymorphic
            } elseif {$mtype == 2} {
                dict set trace mappedType Creation
            }
        }
    } elseif {$eventType eq "Creation"} {
        set polyTrace [dict create]
        dict with dst {
            set event [relvar restrictone EventMap\
                DomainId $DomainId\
                ClassId $ClassId\
                EventNum [dict get $trace eventNumber]\
                EventType event\
            ]
            log::debug \n[relformat $event EventMap]
            dict set trace eventNumber [relation extract $event EventName]
            dict set trace dstInst $ClassName.$InstName

            set cls [relvar restrictone ClassStructMap\
                    StructAddr [dict get $trace dstClass]]
            log::debug \n[relformat $cls ClassStructMap]
            if {[relation isnotempty $cls]} {
                dict set trace dstClass [relation extract $cls ClassName]
            }
        }
    } else {
        error "unknown eventType, \"$eventType\""
    }
    return $trace
}

# Scan a binary trace record as received and produce a dictionary
# of the numerical values.
# The type of the trace is turned into a readable string.
# All other fields remain numeric. This is the first phase of translation
# that can happen without symbolic information.
# For the Cortex-M3, the mechanisms trace info look like:
#
# 0 ==> eventType
# 1 ==> eventNumber
# 2 ==> compiler pad
# 3 ==> compiler pad
# 4 - 7 ==> srcInst
# 8 - 11 ==> dstInst
# --- normal
# 12 ==> currState
# 13 ==> newState
# --- poly
# 12 ==> subcode
# 13 ==> hierarchy
# 14 ==> mappedNumber
# 15 ==> mappedType
# --- create
# 12 - 15 ==> dstClass
#
proc ::eventTrace::scanTrace {bintrace} {
    variable tracePlatform
    variable PlatformProp
    set instfmt [relation extract [relvar restrictone PlatformProp\
            Platform $tracePlatform Prop InstFmt] Value]

    binary scan $bintrace c type

    if {$type == 0} {
        # Normal
        set fmt [relation extract [relvar restrictone PlatformProp\
                Platform $tracePlatform Prop NormFmt] Value]
        set nscan [binary scan $bintrace $fmt event src dst curr new]
        if {$nscan != 5} {
            error "failed to scan trace, expected 5 conversions, got $nscan"
        }
        set result [dict create\
            eventType Normal\
            eventNumber $event\
            srcInst [format $instfmt $src]\
            dstInst [format $instfmt $dst]\
            currState $curr\
            newState $new\
        ]
    } elseif {$type == 1} {
        # Polymorphic
        set fmt [relation extract [relvar restrictone PlatformProp\
                Platform $tracePlatform Prop PolyFmt] Value]
        set nscan [binary scan $bintrace $fmt event src dst\
                sub hier mnum mtype]
        if {$nscan != 7} {
            error "failed to scan trace, expected 7 conversions, got $nscan"
        }
        set result [dict create\
            eventType Polymorphic\
            eventNumber $event\
            srcInst [format $instfmt $src]\
            dstInst [format $instfmt $dst]\
            subcode $sub\
            hierarchy $hier\
            mappedNumber $mnum\
            mappedType $mtype\
        ]
    } elseif {$type == 2} {
        # Creation
        set fmt [relation extract [relvar restrictone PlatformProp\
                Platform $tracePlatform Prop CreateFmt] Value]
        set nscan [binary scan $bintrace $fmt event src dst class]
        if {$nscan != 4} {
            error "failed to scan trace, expected 4 conversions, got $nscan"
        }
        set result [dict create\
            eventType Creation\
            eventNumber $event\
            srcInst [format $instfmt $src]\
            dstInst [format $instfmt $dst]\
            dstClass [format $instfmt $class]\
        ]
    } else {
        error "unknown bintrace type, \"$type\""
    }
    log::debug "new trace = $result"

    return $result
}

# Look up the address for a source instance and find the corresponding class.
proc ::eventTrace::srcAddr2Class {addr} {
    set result $addr
    if {[string is integer -strict $addr]} {
        # Check if we have a class address at all
        if {$addr == 0} {
            set result DomainOp
        } else {
            variable InstAddrMap
            set inst [relation restrictwith $InstAddrMap {$InstBegin == $addr}]
            if {[relation isnotempty $inst]} {
                set result [relation extract $inst ClassName].[relation extract\
                    $inst InstName]
            } else {
                variable UnionInstAddrMap
                set inst [relation restrictwith $UnionInstAddrMap\
                        {$InstBegin == $addr}]
                set result [expr {[relation isnotempty $inst] ?\
                    "[relation extract $inst ClassName].[relation extract\
                        $inst InstName]" :\
                    "@[format %04x $addr]"}]
            }
        }
    }

    return $result
}

# Look up the address for a destination instance and
# find the corresponding class info.
# Here we return a dictionary with all the require information
# about the transition.
proc ::eventTrace::dstAddr2Class {addr} {
    variable InstAddrMap
    variable polyTrace

    set inst [relation restrictwith $InstAddrMap {
        $addr >= $InstBegin && $addr <= $InstEnd}]
    log::debug \n[relformat $inst inst]
    if {[relation isnotempty $inst]} {
        # Check if we got an exact match. If so, then return that
        # information.
        # Otherwise, look to see if this might be a union subtype.
        set result $inst
        # If the address doesn't start exactly at the beginning and
        # if there was a previous polymorphic event, then see
        # if we can determine that there was a union subtype.
        if {[relation extract $inst InstBegin] != $addr} {
            if {[dict size $polyTrace]} {
                log::debug "polyTrace: \"$polyTrace\""
                # See if we have already seen a subtype, i.e. we may
                # be more than one level down in a class hierarchy.
                variable UnionInstAddrMap
                log::debug \n[relformat $UnionInstAddrMap UnionInstAddrMap]
                set uinst [relation restrict $UnionInstAddrMap uiam {
                    [tuple extract $uiam InstBegin] ==\
                    [dict get $polyTrace dstInst]}]
                if {[relation isnotempty $uinst]} {
                    set inst $uinst
                }
                variable SubtypeMap
                log::debug \n[relformat $SubtypeMap SubtypeMap]
                set stm [pipe {
                    relation join $inst $SubtypeMap |
                    relation restrictwith ~\
                        {$SubCode == [dict get $polyTrace subcode]}
                }]
                log::debug \n[relformat $stm stm]
                if {[relation isnotempty $stm]} {
                    relation assign $inst\
                        {DomainName dnm}\
                        {DomainId did}\
                        {InstName inm}
                    relation assign $stm {SubName sn} {InstEnd iend}
                    set cid [pipe {
                        relvar restrictone Class DomainId $did ClassName $sn |
                        relation extract ~ ClassId
                    }]
                    set us [relation restrictwith $UnionInstAddrMap\
                        {$InstBegin == $addr}]
                    log::debug \n[relformat $us us]
                    if {[relation isempty $us]} {
                        set result [relvar insert UnionInstAddrMap [list\
                            DomainName $dnm\
                            ClassName $sn\
                            DomainId $did\
                            ClassId $cid\
                            InstName $inm\
                            InstBegin $addr\
                            InstEnd $iend\
                        ]]
                    } else {
                        set result [relvar update UnionInstAddrMap ust\
                            {[tuple extract $ust InstBegin] == $addr} {
                            tuple update $ust ClassName $sn ClassId $cid\
                                InstName $inm
                        }]
                    }
                    log::debug \n[relformat $UnionInstAddrMap UnionInstAddrMap]
                }
            } else {
                set result [relvar restrictone UnionInstAddrMap InstBegin $addr]
                if {[relation isempty $result]} {
                    set result [relation emptyof $InstAddrMap]
                }
            }
        }
    } else {
        set result [relation emptyof $InstAddrMap]
    }

    return $result
}

# Scan an ELF file for symbols
proc ::eventTrace::scanSymbolsELF {elfFileName} {
    elfdecode elffile create ef
    ef readFile $elfFileName
    return
}

# Scan an IAR linker map that contains the symbol table and
# build a relvar that contains the symbolic information.
proc ::eventTrace::scanSymbolsMSP430 {symFileName} {
    relvar set Symbol [relation emptyof [relvar set Symbol]]
    set module GLOBAL
    fileutil::foreachLine line $symFileName {
        #log::debug "parsing: \"$line\""
        if {![regexp {\A(\w+)\s\(\s.+\.r43\s\)\Z} $line match module]} {
            #log::debug "module: \"$module\""
            if {[regexp {\A\s+([[:alnum:]]\w+)\s+([[:xdigit:]]{4})}\
                    $line match name addr]} {
                #log::debug "found: $name $addr"
                relvar insert Symbol [list\
                    Module $module\
                    Name $name\
                    Address 0x$addr\
                ]
            }
        }
    }

    log::debug \n[relformat [relvar set Symbol] Symbol]
}

# Scan the output of "objdump --headers --syms --wide" for symbol information.
# We need both the section headers for the address of where the sections
# start and the symbols. Symbols are given as offsets from the
# beginning of the section in which they occur.
proc ::eventTrace::scanSymbolsPEI {symFileName} {
    relvar set Symbol [relation emptyof [relvar set Symbol]]
    relvar set Section [relation emptyof [relvar set Section]]

    set module GLOBAL

    set scanState begin
    fileutil::foreachLine line $symFileName {
        #log::debug "parsing: \"$line\""
        switch -exact -- $scanState {
            begin {
                if {$line eq "Sections:"} {
                    #log::debug "found section headers"
                    set scanState sections
                }
            }
            sections {
                if {$line eq "SYMBOL TABLE:"} {
                    log::debug \n[relformat [relvar set Section]]
                    set scanState symbols
                    #log::debug "found symbols"
                } elseif {[regexp {\s+\d+} $line match]} {
                    lassign $line index name size addr
                    relvar insert Section [list\
                        Name    $name\
                        Num     [expr {$index + 1}]\
                        Addr    0x$addr\
                        Size    0x$size\
                    ]
                }
            }
            symbols {
                if {[regexp {sec -2.*0x[[:xdigit:]]+\s+(.*)}\
                        $line match fname]} {
                    set module [file rootname $fname]
                    #log::debug "found module, \"$module\""
                } elseif {[regexp {sec\s+([124]).*(0x[[:xdigit:]]+)\s+(.*)}\
                        $line match sec addr sym]} {
                    set first [string index $sym 0]
                    if {$first ne "."} {
                        if {$first eq {_}} {
                            set sym [string range $sym 1 end]
                        }
                        set base [pipe {
                            relvar restrictone Section Num $sec |
                            relation extract ~ Addr
                        }]
                        set addr [expr {$addr + $base}]
                        #log::debug "found: $sym $addr"
                        # There are sometimes multiple symbols at the same
                        # "address" but none of the ones we are concerned with.
                        catch {
                            relvar insert Symbol [list\
                                Module $module\
                                Name $sym\
                                Address $addr\
                            ]
                        }
                    }
                }
            }
            default {
                error "unknown scan state value, \"$scanState\""
            }
        }
    }

    log::debug \n[relformat [relvar set Symbol] Symbol Address]
}

# Using the elf symbol data, build relvars that contains just the information
# we need to back translate class names and class structures.
proc ::eventTrace::buildClassSymsELF {} {
    # modules, symbols where st_info == 4 are file names
    set modules [pipe {
        ef getSymbolTable |
        relation restrictwith ~ {$st_info == 4} |
        relation project ~ st_index st_name |
        relation extend ~ extup\
            Module string {[file rootname [tuple extract $extup st_name]]} |
        relation project ~ st_index Module |
        relation rename ~ st_index Index
    }]
    # First the class storage base addresses
    set classStorage [pipe {
        ef getSymbolTable |
        relation restrictwith ~ {[string match *_storage $st_name]} |
        relation extend ~ sgtup\
            ClassName string {[string map {{_storage} {}} [tuple extract $sgtup st_name]]} |
        relation rename ~ st_value BaseAddr st_size Size |
        relation project ~ st_index ClassName BaseAddr Size |
        relation times ~ $modules |
        relation restrictwith ~ {$st_index > $Index} |
        relation summarizeby ~ {st_index ClassName BaseAddr Size} srel\
            Module string {[relation extract\
            [relation restrictwith $srel {$Index == rmax($srel, "Index")}] Module]} |
        relation project ~ Module ClassName BaseAddr Size
    }]
    relvar set ClassStorageBase $classStorage
    log::debug \n[relformat [relvar set ClassStorageBase] ClassStorageBase]

    set classStruct [pipe {
        ef getSymbolTable |
        relation restrictwith ~ {[string match *_class $st_name]} |
        relation extend ~ sgtup\
            ClassName string {[string map {{_class} {}} [tuple extract $sgtup st_name]]} |
        relation rename ~ st_value StructAddr |
        relation project ~ st_index ClassName StructAddr |
        relation times ~ $modules |
        relation restrictwith ~ {$st_index > $Index} |
        relation summarizeby ~ {st_index ClassName StructAddr} srel\
            Module string {[relation extract\
            [relation restrictwith $srel {$Index == rmax($srel, "Index")}] Module]} |
        relation project ~ Module ClassName StructAddr
    }]
    relvar set ClassStructMap $classStruct
    log::debug \n[relformat [relvar set ClassStructMap] ClassStructMap]
}

proc ::eventTrace::buildClassSymsMSP430 {} {
    variable Symbol
    variable currentModule
    set ordSyms [relation tag $Symbol AddrOrder -ascending Address]
    # First the class storage base addresses
    set classStorage [pipe {
        relation restrictwith $ordSyms {\
            $Module eq $currentModule && [string match {*_storage} $Name]} |
        relation rename ~ Name ClassName Address BaseAddr |
        relation extend ~ cs Size int {\
            [relation extract\
                [relation restrictwith $ordSyms\
                {$AddrOrder == ([tuple extract $cs AddrOrder] + 1)}] Address]\
                - [tuple extract $cs BaseAddr]} |
        relation eliminate ~ AddrOrder
    }]
    log::debug \n[relformat $classStorage classStorage]
    relvar set ClassStorageBase $classStorage
    relvar update ClassStorageBase cs {1} {
        tuple update $cs\
            ClassName [regsub {_storage} [tuple extract $cs ClassName] {}]}

    log::debug \n[relformat [relvar set ClassStorageBase] ClassStorageBase]
    # Now the class structure found in creation events.
    set classStruct [pipe {
        relation restrictwith $Symbol {\
            $Module eq $currentModule && [string match {*_class} $Name]} |
        relation rename ~ Name ClassName Address StructAddr
    }]
    relvar set ClassStructMap $classStruct
    relvar update ClassStructMap cs {1} {
        tuple update $cs\
            ClassName [regsub {_class} [tuple extract $cs ClassName] {}]}

    log::debug \n[relformat [relvar set ClassStructMap] ClassStructMap]
}

proc ::eventTrace::buildClassSymsPEI {} {
    # The PEI class symbols are build off of the "Symbol" relvar in the
    # same manner as the MSP430 ones.
    buildClassSymsMSP430
}

# Read in the data contained in the pycca "save" file.
proc ::eventTrace::getPyccaData {pyccaFile} {
    deserializeFromFile $pyccaFile [namespace current]

    variable Domain
    if {[relation cardinality $Domain] > 1} {
        error "Only single domain pycca files supported"
    }
    variable currentDomain
    variable domainId
    relation assign $Domain {DomainName currentDomain} {DomainId domainId}
    variable currentModule [file rootname [file tail $pyccaFile]]

    return
}

# The more difficult back translation is to take an instance address and
# find the corresponding class and instance. To do that we build the following
# relation from the pycca data and the symbol information:
#
# DomainName ClassName DomainId ClassId InstName InstBegin InstEnd
# string     string    int      int     string   int       int
proc ::eventTrace::buildInstAddrMap {} {
    relvar set InstAddrMap [relation emptyof [relvar set InstAddrMap]]
    # Compute the number of instances storage slots allocated with a "slot"
    # command.
    variable currentDomain
    variable Class
    set slotInsts [pipe {
	relvar restrictone Domain DomainName $currentDomain |
        relation eliminate ~ File Line |
	relation join ~ $Class -using {DomainId DomainId} |
	relation project ~ DomainName DomainId ClassName ClassId StorageSlots
    }]
    log::debug \n[relformat $slotInsts slotInsts]

    # Compute the number of instances in the initial instance set
    set initialInsts [pipe {
        relvar set InstanceMap |
        relation summarizeby ~ {DomainId ClassId} im InitialInst int {
            [relation cardinality $im]}
    }]
    log::debug \n[relformat $initialInsts initialInsts]

    # Extend "slotInst" to include the initial instances
    set totalInsts [relation extend $slotInsts si InitialInst int {
        [relation isnotempty [set ii [relation restrictwith $initialInsts {
                $DomainId eq [tuple extract $si DomainId] &&\
                $ClassId eq [tuple extract $si ClassId]}]]] ?\
            [relation extract $ii InitialInst] : "0"
    }]
    log::debug \n[relformat $totalInsts totalInsts]

    variable ClassStorageBase
    # Compute the size of each class instance
    set instMap [pipe {
        relation extend $totalInsts ii TotalInsts int\
            {[tuple extract $ii StorageSlots] +\
                [tuple extract $ii InitialInst]} |
        relation eliminate ~ StorageSlots InitialInst |
        relation join ~ $ClassStorageBase |
        relation extend ~ is InstSize int {[tuple extract $is Size] /\
                                        [tuple extract $is TotalInsts]} |
        relation eliminate ~ Size
    }]
    log::debug \n[relformat $instMap instMap]
    relvar set ClassStorageMap [relation project $instMap\
            DomainName ClassName BaseAddr InstSize TotalInsts]
    # An entry for each instance
    relation foreach inst $instMap {
        relation assign $inst
        for {set i 0} {$i < $TotalInsts} {incr i} {
            set iMap [relvar restrictone InstanceMap DomainId $DomainId\
                    ClassId $ClassId InstNum $i]
            set instName [expr {[relation isnotempty $iMap] ?\
                [relation extract $iMap InstName] : $i}]
            relvar insert InstAddrMap [list\
                DomainName $DomainName\
                ClassName $ClassName\
                DomainId $DomainId\
                ClassId $ClassId\
                InstName $instName\
                InstBegin [expr {$BaseAddr + $i * $InstSize}]\
                InstEnd [expr {$BaseAddr + $i * $InstSize + $InstSize - 1}]\
            ]
        }
    }
    log::debug \n[relformat [relvar set InstAddrMap] InstAddrMap]
}

proc ::eventTrace::timeStamp {} {
    set time [clock milliseconds]
    set ts [expr {$time / 1000}]
    set us [expr {$time % 1000}]
    return [format "%u.%03u" $ts $us]
}

# Compute the Transition Matrix for the given class.
# Returns a relation value with the heading:
# {StateName string StateNum int EventName string EventNum int NewState string}
proc ::eventTrace::transitionMatrix {className} {
    set sm [pipe {
        relvar set Class |
        relation restrictwith ~ {$ClassName eq $className} |
        relation semijoin ~ [relvar set StateModel]\
            -using {DomainId DomainId ClassId ClassId}
    }]
    relation assign $sm
    # Find the states for this state model
    set states [pipe {
        relation semijoin $sm [relvar set StateMap]\
            -using {DomainId DomainId ClassId ClassId} |
        relation project ~ StateName StateNum
    }]
    # Find the events for this state model
    set events [pipe {
        relation semijoin $sm [relvar set EventMap]\
            -using {DomainId DomainId ClassId ClassId} |
        relation restrictwith ~ {$EventType eq "event"} |
        relation project ~ EventName EventNum
    }]
    # Those transitions that are _not_ creation transitions
    set transition [relvar set Transition]
    set normTrans [pipe {
        relation semijoin $sm [relvar set NormalTrans]\
            -using {DomainId DomainId ClassId ClassId} |
        relation join ~ $transition |
        relation project ~ StateName EventName NewState
    }]
    #puts [relformat $normTrans normTrans]
    # The creation transitions have to be handled a bit differently.
    # They transition form the pseudo-initial state "."
    set createTrans [pipe {
        relation semijoin $sm [relvar set CreateTrans]\
            -using {DomainId DomainId ClassId ClassId} |
        relation join ~ $transition |
        relation project ~ EventName NewState |
        relation extend ~ ct StateName string {"."}
    }]
    #puts [relformat $createTrans createTrans]
    # All the transitions for the class are then just the union.
    set allTrans [relation union $normTrans $createTrans]
    #puts [relformat $allTrans allTrans]
    # Compute the transition matrix by taking the Cartesian product
    # of the states and events. Extend that product by finding the
    # state transitioned to.
    set matrix [pipe {
        relation times $states $events |
        relation extend ~ melem NewState string\
            {[compute_newstate $melem $allTrans $DefTrans]}
    }]
    #puts [relformat $matrix transitionMatrix]

    return $matrix
}

proc ::eventTrace::compute_newstate {mtuple allTrans defTrans} {
    tuple assign $mtuple StateName EventName
    set df [expr {$StateName eq "." ? "CH" : $defTrans}]
    set trans [relation restrict $allTrans at {
        [tuple extract $at StateName] eq $StateName &&
	[tuple extract $at EventName] eq $EventName}]
    return [expr {[relation isnotempty $trans] ?\
	[relation extract $trans NewState] : $df}]
}

proc ::eventTrace::markTransition {testName className stateName eventName} {
    # We don't really care about duplicates here.  If the same test case causes
    # a class to go through the same transitions that okay.
    relvar uinsert TransCoverage [list\
        TestCase $testName\
        ClassName $className\
        StateName $stateName\
        EventName $eventName\
    ]
}

proc ::eventTrace::reportCoverage {} {
    variable TransCoverage
    log::debug \n[relformat $TransCoverage TransCoverage TestCase]

    set result\
            "\n\nMissing transitions report: [clock format [clock seconds]]"

    foreach class [relation list\
            [relation project $TransCoverage ClassName]] {
        if {[regexp -- {@[[:xdigit:]]+} $class]} {
            append result \n "*** unable to identify class $class ****" \n
            continue
        }
        set banner "======================= $class ======================="
        append result \n $banner
        set cover [relation restrictwith $TransCoverage\
            {$ClassName eq $class}]
        append result \n [relformat $cover "Transition Coverage for $class"] \n

        # Compute the missing states, i.e. those states to which are never
        # entered.
        set knownStates [relation project $cover StateName]
        set possStates [pipe {
            relvar set Class |
            relation restrictwith ~ {$ClassName eq $class} |
            relation semijoin ~ [relvar set StateModel]\
                -using {DomainId DomainId ClassId ClassId}\
                [relvar set StateMap]\
                -using {DomainId DomainId ClassId ClassId} |
            relation project ~ StateName
        }]
        set missStates [relation semiminus $knownStates $possStates]
        append result \n\
            [relformat $missStates "States Actions Not Executed for $class"]\
            \n

        set tm [pipe {
            transitionMatrix $class |
            relation eliminate ~ StateNum EventNum
        }]
        log::debug \n[relformat $tm "$class Transition Matrix"]

        set miss [pipe {
            relation restrictwith $tm {$NewState ne "CH"} |
            relation semiminus $cover ~
        }]
        # Find the total number of missing transition and the
        # total number of missing ignored transitions.
        set mtotals [relation summarize $miss $::ralutil::DEE mt\
            Missing-Non-IG int {[relation cardinality\
                [relation restrictwith $mt {$NewState ne "IG"}]]}\
            Missing-IG int {[relation cardinality\
                [relation restrictwith $mt {$NewState eq "IG"}]]}\
        ]
        append result \n\
            [relformat $mtotals "Missing Transition Totals for $class"] \n

        append result \n\
            [relformat [relation group $miss MissingTrans EventName NewState]\
            "$class Missing Transitions"] \n
        append result $banner
    }

    return $result
}

# Translate a class name and instance number/name into an address
proc ::eventTrace::instAddress {className {instance 0}} {
    variable currentDomain
    if {[string is digit -strict $instance]} {
        set class [relvar restrictone ClassStorageMap\
                DomainName $currentDomain ClassName $className]
        if {[relation isempty $class]} {
            error "unknown class, \"$className\""
        } else {
            relation assign $class BaseAddr InstSize TotalInsts
            if {$instance >= $TotalInsts} {
                error "instance bounds check: requested $instance,\
                    max is [expr {$TotalInsts - 1}]"
            }
            return [expr {$BaseAddr + $instance * $InstSize}]
        }
    } else {
        # Assume "instance" is an instance name
        set imap [relvar restrictone InstAddrMap\
            DomainName $currentDomain ClassName $className InstName $instance]
        if {[relation isempty $imap]} {
            error "unknown instance, \"$className.$instance\""
        } else {
            return [relation extract $imap InstBegin]
        }
    }
}

proc ::eventTrace::instStorage {module className} {
    set storage [relvar restrictone ClassStorageBase\
        Module $module\
        ClassName $className\
    ]

    if {[relation isnotempty $storage]} {
        return [relation extract $storage BaseAddr]
    } else {
        error "unknown instance storage, $module $className"
    }
}

# Sometime we need to override the determined size because it cannot
# be determined correctly from the symbol information.
# This sometimes occurs for those storage arrays that happen to be "last"
# in definition order in the source file. The linker will often add
# padding and we have to determine size in another way and just
# set it into the data structures here.
proc ::eventTrace::setInstSize {module className instSize} {
    set insts [pipe {
        relvar set InstAddrMap | 
        relation restrictwith ~ {
            $DomainName eq $module && $ClassName eq $className} |
        relation tag ~ AddrTag -ascending InstBegin
    }]
    set baseAddr [pipe {
        relation restrictwith $insts {$AddrTag == 0} |
        relation extract ~ InstBegin
    }]
    set readdr [pipe {
        relation extend $insts retup NewBegin int {
            [tuple extract $retup AddrTag] * $instSize + $baseAddr
        } NewEnd int {
            ([tuple extract $retup AddrTag] + 1) * $instSize + $baseAddr - 1
        } |
        relation eliminate ~ AddrTag InstBegin InstEnd |
        relation rename ~ NewBegin InstBegin NewEnd InstEnd
    }]
    log::debug \n[relformat $readdr "InstAddrMap updates"]
    relvar delete InstAddrMap iam {
        [tuple extract $iam DomainName] eq $module &&
        [tuple extract $iam ClassName] eq $className
    }
    relvar dunion InstAddrMap $readdr
}
