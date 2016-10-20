source typeparser.tcl

typeparser create tp

package require pt::util

source types.tcl

foreach type $types {
    puts "*****   $type   ******"
    try {
        puts [::pt::ast print [tp parset $type]]
    } on error {result} {
        puts [pt::util error2readable $result $type]
    }
}
