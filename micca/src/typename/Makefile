test : typeparser.tcl testparser.tcl
	tclsh testparser.tcl

typeparser.tcl : datatype.peg
	pt generate oo\
	    -file datatype.peg -name datatype -user andrewm\
	    -class typeparser -package typeparser -version 1 typeparser.tcl\
	    peg datatype.peg
