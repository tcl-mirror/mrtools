# renumRs.tcl was created to read a text file and extract the relationships and
#   renumber them appropriately. This is especially designed to help with UMLet
#   which requires manual update of the numbering.
#   OPTIONS:
#   input (required) - name of input file to read.
#   output (optional) - name of output file.  Stdout used if not specified.
#   start (optional) - first number to use when renumbering.
package require Tcl 8.5
package require cmdline

set optlist {
    {start.arg 1 {First number to start renumbering}}
    {input.arg {} {Input file}}
    {output.arg {} {Output file}}
}
array set options [::cmdline::getKnownOptions argv $optlist]

if {$options(input) eq {}} {
    puts "Please provide an input file. (-input option)"
    exit
} elseif {[file exists $options(input)]} {
    set iFileH [open $options(input) r]
    set data [read $iFileH]
    close $iFileH    
} else {
    puts "Error:  Input file is unknown."
    exit
}
# Create a list of all the existing relationships:
set allRsList [regexp -all -inline {R[\d]+} $data]
puts "allRsList = \"$allRsList\""

# Create 'newData' - the data from the file but with underscores preceding
#   all the relationships:
regsub -all {R[\d]+} $data {_&} newData
# For each unique relationship in the original file, replace it sequential with
#   numbers in sequence.
set nextNum $options(start)
foreach r [lsort -unique $allRsList] {
#    set lookFor _${r}\[^\[:digit:\]\]
    set lookFor \[\[:<:\]\]_${r}\[\[:>:\]\]
    regsub -all $lookFor $newData R$nextNum newData
    incr nextNum
}

# Choose an output file:
set oFileH stdout
if {$options(output) ne {}} {
    set oFileH [open $options(output) w]
}

# Write the output file.
#   If an output file was not specified it will write to stdout
puts -nonewline $oFileH $newData
close $oFileH

