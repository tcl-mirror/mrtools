source ../../code/tcl/micca.tcl
micca configureFromFile wmctrl.micca
micca configureFromFile wmctrl_pop.micca
micca generate stubexternalops true ; # <1>
micca harness
