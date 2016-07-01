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
    {uint8}
    {const int *}
    {struct foo *}
    {MyType *}
    {void (*)(int, ...)}
    {struct foo * const (*)(void)}
    {enum b {foo = 1, bar, baz}}
    {enum {foo, bar} *}
    {char []}
    {char [32]}
    {char [*]}
    {char [sizeof(char)]}
    {struct a {int *a ;} *}
    {struct a {int a ;}}
    {int * int (*)()}
}

foreach type $types {
    puts "*****   $type   ******"
    try {
        puts [::pt::ast print [tp parset $type]]
    } on error {result} {
        puts $result
        set perror [tp error]
        puts "error = \"$perror\""
        puts "current = \"[tp current]\""
        lassign $perror pos expect
        puts "parse error: expected: \"[lindex $expect 0 1]\" at:"
        puts [string repeat { } $pos]v
        puts $type
    }
}
