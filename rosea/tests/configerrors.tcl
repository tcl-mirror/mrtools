source ../src/rosea.tcl

rosea configure {
    domain d1 {
        class c2 {
            attribute a1 string
        }
    }
    domain d2 {
        class c3 {
            attribute a1 string -id 1
            attribute a2 int
        }
        class c4 {
            attribute a1 string -id 1
            reference R1 c3 -link a1
        }
    }
    domain d2-2 {
        class c3 {
            attribute a1 string -id 1
            attribute a2 int
        }
        class c4 {
            attribute a1 string -id 1
        }
        association R1 c4 1--1 c3
    }
    domain d2-3 {
        class c3 {
            attribute a1 string -id 1
            attribute a2 int
        }
        class c4 {
            attribute a1 string -id 1
        }
        association R1 c4 1--1 c3 -associator c5
    }
    domain d3 {
        class super {
            attribute a1 string -id 1
        }

        class sub1 {
            attribute a1 string -id 1
            reference R2 super -link a1
        }

        class sub2 {
            attribute a1 string -id 1
            reference R2 super -link a1
        }
        generalization R2 super sub1 sub2 sub3
    }
    domain d3-2 {
        class super {
            attribute a1 string -id 1
            polymorphic e1
        }

        class sub1 {
            attribute a1 string -id 1
            reference R2 super -link a1
        }

        class sub2 {
            attribute a1 string -id 1
            reference R2 super -link a1
        }
        generalization R2 super sub1 sub2
    }
    domain d4 {
        class s1 {
            attribute a1 string -id 1
            statemodel {
                state state1 {} {
                }
                transition state1 - e1 -> state2
            }
        }
    }
    domain d5 {
        class c1 {
            attribute a1 string -id 1
            polymorphic e1
        }
    }
    domain d6 {
        class super {
            attribute a1 string -id 1
        }

        class sub1 {
            attribute a1 string -id 1
            reference R2 super -link a1
        }

        class sub2 {
            attribute a1 string -id 1
            reference R2 super -link a1
        }
        generalization R2 super sub1 sub2
        assigner R2 {
            state s1 {} {
            }
            transition s1 - e1 -> s1
        }
    }
    domain d7 {
        class A {
            attribute x1 string -id 1
            attribute y1 string -id 1
            reference R1 X -link x1
        }
        class X {
            attribute x1 string -id 1
        }
        class Y {
            attribute y1 string -id 1
        }
        association R1 X +--+ Y -associator A
    }

    domain d8 {
        association R1 Personality *--1 Human

        class Human {
            attribute id string -id 1
            attribute ego string -id 2
        }

        class Personality {
            attribute ego string -id 1
            attribute type string -id 1
            reference R1 Human -link id
        }
    }
}
