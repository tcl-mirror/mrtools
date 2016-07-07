source typeparser.tcl

typeparser create tp

set types {
    {int (*)()}
    {char (*)(int, int)}
    {char *const}
    {char *const*}
    {int **}
    {enum a}
    {struct a}
    {uint8_t}
    {const int *}
    {struct foo *}
    {MyType_t *}
    {int (*)(int, int)}
    {void (*)(int, ...)}
    {struct foo * const (*)(void)}
    {enum b {foo = 1, bar, baz}}
    {enum {foo, bar} *}
    {char []}
    {char [*]}
    {char [32]}
    {char [sizeof(char)]}
    {struct a {int *a ;} *}
    {struct a {int a ;}}
    {int * int (*)()}
}

proc top {ast} {
    lassign $ast type start end children
    global location

    if {$type eq "pointer"} {
        set location $end
        # puts "found abstract declarator at $start"
    } elseif {$type eq "array_declarator"} {
        set location [expr {$start - 1}]
    }
    return $ast
}

proc declare {type name} {
    global location

    set ast [tp parset $type]
    set location [lindex $ast 2]
    ::pt::ast topdown ::top $ast
    top $ast

    return [string cat\
        [string range $type 0 $location]\
        " $name"\
        [string range $type $location+1 end]\
    ]
}

package require pt::util

foreach type $types {
    try {
        puts "**** type \"$type\""
        puts "**** declaration \"[declare $type XXX]\""
    } on error {result} {
        puts [::pt::util error2readable $result $type]
    }
}
