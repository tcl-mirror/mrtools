source typeparser.tcl

puts "oo rde version = [package require pt::rde::oo]"

typeparser create tp

# puts "debug tags = [debug names]"

# debug on pt/rdengine


package require pt::util

set types {
    {char}
    {int (*)()}
    {char (*)(int, int)}
    {char *const}
    {char *const*}
    {int **}
    {long long int}
    {enum a}
    {struct a}
    {uint8_t}
    {const int *}
    {struct foo_bar *}
    {MyType_t *}
    {FintFooBar_t}
    {typename(MyType_t) *}
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
        puts [::pt::util error2readable $result $type]
        # puts $result
        # set perror [tp error]
        # puts "error = \"$perror\""
        # puts "current = \"[tp current]\""
        # lassign $perror pos expect
        # puts "parse error: expected: \"[lindex $expect 0 1]\" at:"
        # puts [string repeat { } $pos]v
        # puts $type
    }
}
