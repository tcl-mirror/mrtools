source ../code/tcl/micca.tcl

catch {
    micca configure {
        domain d1 {
            class c1 {
            }
        }
    }
}

catch {
    micca configure {
        domain d2 {
            class c1 {
                attribute id int
            }
            class c2 {
                attribute id int
            }
            class c3 {
                attribute id int
            }
            association R1 c2 1--1 c3
        }
    }
}

catch {
    micca configure {
        domain d3 {
            class c1 {
                attribute id int
                statemodel {
                    event e1 a float b int

                    state s1 {a int b float} {
                    }
                    transition s1 - e1 -> s1
                }
            }
        }
    }
}

catch {
    micca configure {
        domain d4 {
            class c1 {
                attribute id char
            }
        }
        population d4 {
            class c2 {
                instance fred1 id 'c'
            }
        }
    }
}

catch {
    micca configure {
        domain d5 {
            class c1 {
                attribute id int
                statemodel {
                    state s1 {a int b float} {
                    }
                    transition s1 - e1 -> s1
                    transition s1 - e2 -> s2
                }
            }
        }
    }
}

catch {
    micca configure {
        domain d6 {
            class c1 {
                attribute id int
                statemodel {
                    state s1 {a int b float} {
                    }
                    transition s1 - e1 -> s1
                    transition s2 - e2 -> s1
                }
            }
        }
    }
}

catch {
    micca configure {
        domain d7 {
            class c1 {
                attribute id int
                statemodel {
                    state s1 {a int b float} {
                        printf("in s1\n") ;
                    }
                }
            }
        }
    }
}

catch {
    micca configure {
        domain d8 {
            class c1 {
                attribute id int
            }
            class c2 {
                attribute id int
            }
            association R1 c1 0..1--1 c3
        }
    }
}
