test : typeparser.tcl testparser.tcl
	tclsh testparser.tcl

# The pt command inserts a "return" statement at the end of the generated code.
# It also fails to have a terminal newline on the last line.  The return
# creates problems when the script is folded into a module file along with the
# other micca code.  So we use "head" to remove the last line.
typeparser.tcl : datatype.peg
	pt generate oo\
	    -file datatype.peg -name datatype -user andrewm\
	    -class typeparser -package typeparser -version 1.0 typeparser.tcl\
	    peg datatype.peg
	head --lines=-1 typeparser.tcl > typeparser.tcl.fixed
	mv typeparser.tcl.fixed typeparser.tcl
