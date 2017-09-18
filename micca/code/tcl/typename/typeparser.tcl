## -*- tcl -*-
##
## OO-based Tcl/PARAM implementation of the parsing
## expression grammar
##
##	datatype
##
## Generated from file	datatype.peg
##            for user  andrewm
##
# # ## ### ##### ######## ############# #####################
## Requirements

package require Tcl 8.5
package require TclOO
package require pt::rde::oo ; # OO-based implementation of the
			      # PARAM virtual machine
			      # underlying the Tcl/PARAM code
			      # used below.

# # ## ### ##### ######## ############# #####################
##

oo::class create typeparser {
    # # ## ### ##### ######## #############
    ## Public API

    superclass pt::rde::oo ; # TODO - Define this class.
                             # Or can we inherit from a snit
                             # class too ?

    method parse {channel} {
	my reset $channel
	my MAIN ; # Entrypoint for the generated code.
	return [my complete]
    }

    method parset {text} {
	my reset {}
	my data $text
	my MAIN ; # Entrypoint for the generated code.
	return [my complete]
    }

    # # ## ### ###### ######## #############
    ## BEGIN of GENERATED CODE. DO NOT EDIT.

    #
    # Grammar Start Expression
    #
    
    method MAIN {} {
        my sym_type_name
        return
    }
    
    #
    # leaf Symbol '_Bool'
    #
    
    method sym__Bool {} {
        # x
        #     "_Bool"
        #     (WHITESPACE)
    
        my si:void_symbol_start _Bool
        my sequence_4
        my si:void_leaf_symbol_end _Bool
        return
    }
    
    method sequence_4 {} {
        # x
        #     "_Bool"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str _Bool
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol '_Complex'
    #
    
    method sym__Complex {} {
        # x
        #     "_Complex"
        #     (WHITESPACE)
    
        my si:void_symbol_start _Complex
        my sequence_9
        my si:void_leaf_symbol_end _Complex
        return
    }
    
    method sequence_9 {} {
        # x
        #     "_Complex"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str _Complex
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol '_Imaginary'
    #
    
    method sym__Imaginary {} {
        # x
        #     "_Imaginary"
        #     (WHITESPACE)
    
        my si:void_symbol_start _Imaginary
        my sequence_14
        my si:void_leaf_symbol_end _Imaginary
        return
    }
    
    method sequence_14 {} {
        # x
        #     "_Imaginary"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str _Imaginary
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'abstract_declarator'
    #
    
    method sym_abstract_declarator {} {
        # /
        #     x
        #         ?
        #             (pointer)
        #         (direct_abstract_declarator)
        #     (pointer)
    
        my si:value_symbol_start abstract_declarator
        my choice_24
        my si:reduce_symbol_end abstract_declarator
        return
    }
    
    method choice_24 {} {
        # /
        #     x
        #         ?
        #             (pointer)
        #         (direct_abstract_declarator)
        #     (pointer)
    
        my si:value_state_push
        my sequence_21
        my si:valuevalue_branch
        my sym_pointer
        my si:value_state_merge
        return
    }
    
    method sequence_21 {} {
        # x
        #     ?
        #         (pointer)
        #     (direct_abstract_declarator)
    
        my si:value_state_push
        my optional_18
        my si:valuevalue_part
        my sym_direct_abstract_declarator
        my si:value_state_merge
        return
    }
    
    method optional_18 {} {
        # ?
        #     (pointer)
    
        my si:void2_state_push
        my sym_pointer
        my si:void_state_merge_ok
        return
    }
    
    #
    # value Symbol 'additive_expression'
    #
    
    method sym_additive_expression {} {
        # x
        #     (multiplicative_expression)
        #     *
        #         x
        #             /
        #                 (PLUS)
        #                 (MINUS)
        #             (multiplicative_expression)
    
        my si:value_symbol_start additive_expression
        my sequence_37
        my si:reduce_symbol_end additive_expression
        return
    }
    
    method sequence_37 {} {
        # x
        #     (multiplicative_expression)
        #     *
        #         x
        #             /
        #                 (PLUS)
        #                 (MINUS)
        #             (multiplicative_expression)
    
        my si:value_state_push
        my sym_multiplicative_expression
        my si:valuevalue_part
        my kleene_35
        my si:value_state_merge
        return
    }
    
    method kleene_35 {} {
        # *
        #     x
        #         /
        #             (PLUS)
        #             (MINUS)
        #         (multiplicative_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_33
            my si:kleene_close
        }
        return
    }
    
    method sequence_33 {} {
        # x
        #     /
        #         (PLUS)
        #         (MINUS)
        #     (multiplicative_expression)
    
        my si:value_state_push
        my choice_30
        my si:valuevalue_part
        my sym_multiplicative_expression
        my si:value_state_merge
        return
    }
    
    method choice_30 {} {
        # /
        #     (PLUS)
        #     (MINUS)
    
        my si:value_state_push
        my sym_PLUS
        my si:valuevalue_branch
        my sym_MINUS
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'AMPERSAND'
    #
    
    method sym_AMPERSAND {} {
        # x
        #     '&'
        #     (WHITESPACE)
    
        my si:void_symbol_start AMPERSAND
        my sequence_42
        my si:void_leaf_symbol_end AMPERSAND
        return
    }
    
    method sequence_42 {} {
        # x
        #     '&'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char &
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'AND'
    #
    
    method sym_AND {} {
        # x
        #     '&'
        #     (WHITESPACE)
    
        my si:void_symbol_start AND
        my sequence_42
        my si:void_leaf_symbol_end AND
        return
    }
    
    #
    # value Symbol 'AND_expression'
    #
    
    method sym_AND_expression {} {
        # x
        #     (equality_expression)
        #     *
        #         x
        #             (AND)
        #             (equality_expression)
    
        my si:value_symbol_start AND_expression
        my sequence_56
        my si:reduce_symbol_end AND_expression
        return
    }
    
    method sequence_56 {} {
        # x
        #     (equality_expression)
        #     *
        #         x
        #             (AND)
        #             (equality_expression)
    
        my si:value_state_push
        my sym_equality_expression
        my si:valuevalue_part
        my kleene_54
        my si:value_state_merge
        return
    }
    
    method kleene_54 {} {
        # *
        #     x
        #         (AND)
        #         (equality_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_52
            my si:kleene_close
        }
        return
    }
    
    method sequence_52 {} {
        # x
        #     (AND)
        #     (equality_expression)
    
        my si:value_state_push
        my sym_AND
        my si:valuevalue_part
        my sym_equality_expression
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'ANDAND'
    #
    
    method sym_ANDAND {} {
        # x
        #     "&&"
        #     (WHITESPACE)
    
        my si:void_symbol_start ANDAND
        my sequence_61
        my si:void_leaf_symbol_end ANDAND
        return
    }
    
    method sequence_61 {} {
        # x
        #     "&&"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str &&
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'ANDEQUAL'
    #
    
    method sym_ANDEQUAL {} {
        # x
        #     "&="
        #     (WHITESPACE)
    
        my si:void_symbol_start ANDEQUAL
        my sequence_66
        my si:void_leaf_symbol_end ANDEQUAL
        return
    }
    
    method sequence_66 {} {
        # x
        #     "&="
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str &=
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'argument_expression_list'
    #
    
    method sym_argument_expression_list {} {
        # x
        #     (assignment_expression)
        #     *
        #         x
        #             (COMMA)
        #             (assignment_expression)
    
        my si:value_symbol_start argument_expression_list
        my sequence_76
        my si:reduce_symbol_end argument_expression_list
        return
    }
    
    method sequence_76 {} {
        # x
        #     (assignment_expression)
        #     *
        #         x
        #             (COMMA)
        #             (assignment_expression)
    
        my si:value_state_push
        my sym_assignment_expression
        my si:valuevalue_part
        my kleene_74
        my si:value_state_merge
        return
    }
    
    method kleene_74 {} {
        # *
        #     x
        #         (COMMA)
        #         (assignment_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_72
            my si:kleene_close
        }
        return
    }
    
    method sequence_72 {} {
        # x
        #     (COMMA)
        #     (assignment_expression)
    
        my si:void_state_push
        my sym_COMMA
        my si:voidvalue_part
        my sym_assignment_expression
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'array_declarator'
    #
    
    method sym_array_declarator {} {
        # /
        #     x
        #         (LBRACKET)
        #         ?
        #             (assignment_expression)
        #         (RBRACKET)
        #     x
        #         (LBRACKET)
        #         (STAR)
        #         (RBRACKET)
    
        my si:value_symbol_start array_declarator
        my choice_91
        my si:reduce_symbol_end array_declarator
        return
    }
    
    method choice_91 {} {
        # /
        #     x
        #         (LBRACKET)
        #         ?
        #             (assignment_expression)
        #         (RBRACKET)
        #     x
        #         (LBRACKET)
        #         (STAR)
        #         (RBRACKET)
    
        my si:value_state_push
        my sequence_84
        my si:valuevalue_branch
        my sequence_89
        my si:value_state_merge
        return
    }
    
    method sequence_84 {} {
        # x
        #     (LBRACKET)
        #     ?
        #         (assignment_expression)
        #     (RBRACKET)
    
        my si:value_state_push
        my sym_LBRACKET
        my si:valuevalue_part
        my optional_81
        my si:valuevalue_part
        my sym_RBRACKET
        my si:value_state_merge
        return
    }
    
    method optional_81 {} {
        # ?
        #     (assignment_expression)
    
        my si:void2_state_push
        my sym_assignment_expression
        my si:void_state_merge_ok
        return
    }
    
    method sequence_89 {} {
        # x
        #     (LBRACKET)
        #     (STAR)
        #     (RBRACKET)
    
        my si:value_state_push
        my sym_LBRACKET
        my si:valuevalue_part
        my sym_STAR
        my si:valuevalue_part
        my sym_RBRACKET
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'ARROW'
    #
    
    method sym_ARROW {} {
        # x
        #     "->"
        #     (WHITESPACE)
    
        my si:void_symbol_start ARROW
        my sequence_96
        my si:void_leaf_symbol_end ARROW
        return
    }
    
    method sequence_96 {} {
        # x
        #     "->"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str ->
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'assignment_expression'
    #
    
    method sym_assignment_expression {} {
        # /
        #     x
        #         (unary_expression)
        #         (assignment_operator)
        #         (assignment_expression)
        #     (conditional_expression)
    
        my si:value_symbol_start assignment_expression
        my choice_105
        my si:reduce_symbol_end assignment_expression
        return
    }
    
    method choice_105 {} {
        # /
        #     x
        #         (unary_expression)
        #         (assignment_operator)
        #         (assignment_expression)
        #     (conditional_expression)
    
        my si:value_state_push
        my sequence_102
        my si:valuevalue_branch
        my sym_conditional_expression
        my si:value_state_merge
        return
    }
    
    method sequence_102 {} {
        # x
        #     (unary_expression)
        #     (assignment_operator)
        #     (assignment_expression)
    
        my si:value_state_push
        my sym_unary_expression
        my si:valuevalue_part
        my sym_assignment_operator
        my si:valuevalue_part
        my sym_assignment_expression
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'assignment_operator'
    #
    
    method sym_assignment_operator {} {
        # /
        #     (EQUAL)
        #     (STAREQUAL)
        #     (SLASHEQUAL)
        #     (PERCENTEQUAL)
        #     (PLUSEQUAL)
        #     (MINUSEQUAL)
        #     (LESSLESSEQUAL)
        #     (GREATERGREATEREQUAL)
        #     (ANDEQUAL)
        #     (HATEQUAL)
        #     (BAREQUAL)
    
        my si:value_symbol_start assignment_operator
        my choice_119
        my si:reduce_symbol_end assignment_operator
        return
    }
    
    method choice_119 {} {
        # /
        #     (EQUAL)
        #     (STAREQUAL)
        #     (SLASHEQUAL)
        #     (PERCENTEQUAL)
        #     (PLUSEQUAL)
        #     (MINUSEQUAL)
        #     (LESSLESSEQUAL)
        #     (GREATERGREATEREQUAL)
        #     (ANDEQUAL)
        #     (HATEQUAL)
        #     (BAREQUAL)
    
        my si:value_state_push
        my sym_EQUAL
        my si:valuevalue_branch
        my sym_STAREQUAL
        my si:valuevalue_branch
        my sym_SLASHEQUAL
        my si:valuevalue_branch
        my sym_PERCENTEQUAL
        my si:valuevalue_branch
        my sym_PLUSEQUAL
        my si:valuevalue_branch
        my sym_MINUSEQUAL
        my si:valuevalue_branch
        my sym_LESSLESSEQUAL
        my si:valuevalue_branch
        my sym_GREATERGREATEREQUAL
        my si:valuevalue_branch
        my sym_ANDEQUAL
        my si:valuevalue_branch
        my sym_HATEQUAL
        my si:valuevalue_branch
        my sym_BAREQUAL
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'auto'
    #
    
    method sym_auto {} {
        # x
        #     "auto"
        #     (WHITESPACE)
    
        my si:void_symbol_start auto
        my sequence_124
        my si:void_leaf_symbol_end auto
        return
    }
    
    method sequence_124 {} {
        # x
        #     "auto"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str auto
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'BAR'
    #
    
    method sym_BAR {} {
        # x
        #     '|'
        #     (WHITESPACE)
    
        my si:void_symbol_start BAR
        my sequence_129
        my si:void_leaf_symbol_end BAR
        return
    }
    
    method sequence_129 {} {
        # x
        #     '|'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char |
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'BARBAR'
    #
    
    method sym_BARBAR {} {
        # x
        #     "||"
        #     (WHITESPACE)
    
        my si:void_symbol_start BARBAR
        my sequence_134
        my si:void_leaf_symbol_end BARBAR
        return
    }
    
    method sequence_134 {} {
        # x
        #     "||"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str ||
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'BAREQUAL'
    #
    
    method sym_BAREQUAL {} {
        # x
        #     "|="
        #     (WHITESPACE)
    
        my si:void_symbol_start BAREQUAL
        my sequence_139
        my si:void_leaf_symbol_end BAREQUAL
        return
    }
    
    method sequence_139 {} {
        # x
        #     "|="
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str |=
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'binary_exponent_part'
    #
    
    method sym_binary_exponent_part {} {
        # x
        #     [pP]
        #     ?
        #         (sign)
        #     (digit_sequence)
    
        my si:value_symbol_start binary_exponent_part
        my sequence_147
        my si:reduce_symbol_end binary_exponent_part
        return
    }
    
    method sequence_147 {} {
        # x
        #     [pP]
        #     ?
        #         (sign)
        #     (digit_sequence)
    
        my si:void_state_push
        my si:next_class pP
        my si:voidvalue_part
        my optional_144
        my si:valuevalue_part
        my sym_digit_sequence
        my si:value_state_merge
        return
    }
    
    method optional_144 {} {
        # ?
        #     (sign)
    
        my si:void2_state_push
        my sym_sign
        my si:void_state_merge_ok
        return
    }
    
    #
    # leaf Symbol 'bool'
    #
    
    method sym_bool {} {
        # x
        #     "bool"
        #     (WHITESPACE)
    
        my si:void_symbol_start bool
        my sequence_152
        my si:void_leaf_symbol_end bool
        return
    }
    
    method sequence_152 {} {
        # x
        #     "bool"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str bool
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'c_char'
    #
    
    method sym_c_char {} {
        # /
        #     [^'\\n\r]
        #     (escape_sequence)
    
        my si:value_symbol_start c_char
        my choice_157
        my si:reduce_symbol_end c_char
        return
    }
    
    method choice_157 {} {
        # /
        #     [^'\\n\r]
        #     (escape_sequence)
    
        my si:void_state_push
        my si:next_class ^'\134\n\r
        my si:voidvalue_branch
        my sym_escape_sequence
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'c_char_sequence'
    #
    
    method sym_c_char_sequence {} {
        # /
        #     (c_char)
        #     x
        #         (c_char_sequence)
        #         (c_char)
    
        my si:value_symbol_start c_char_sequence
        my choice_165
        my si:reduce_symbol_end c_char_sequence
        return
    }
    
    method choice_165 {} {
        # /
        #     (c_char)
        #     x
        #         (c_char_sequence)
        #         (c_char)
    
        my si:value_state_push
        my sym_c_char
        my si:valuevalue_branch
        my sequence_163
        my si:value_state_merge
        return
    }
    
    method sequence_163 {} {
        # x
        #     (c_char_sequence)
        #     (c_char)
    
        my si:value_state_push
        my sym_c_char_sequence
        my si:valuevalue_part
        my sym_c_char
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'cast_expression'
    #
    
    method sym_cast_expression {} {
        # /
        #     (unary_expression)
        #     x
        #         (LPAREN)
        #         (type_name)
        #         (RPAREN)
        #         (cast_expression)
    
        my si:value_symbol_start cast_expression
        my choice_175
        my si:reduce_symbol_end cast_expression
        return
    }
    
    method choice_175 {} {
        # /
        #     (unary_expression)
        #     x
        #         (LPAREN)
        #         (type_name)
        #         (RPAREN)
        #         (cast_expression)
    
        my si:value_state_push
        my sym_unary_expression
        my si:valuevalue_branch
        my sequence_173
        my si:value_state_merge
        return
    }
    
    method sequence_173 {} {
        # x
        #     (LPAREN)
        #     (type_name)
        #     (RPAREN)
        #     (cast_expression)
    
        my si:value_state_push
        my sym_LPAREN
        my si:valuevalue_part
        my sym_type_name
        my si:valuevalue_part
        my sym_RPAREN
        my si:valuevalue_part
        my sym_cast_expression
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'char'
    #
    
    method sym_char {} {
        # x
        #     "char"
        #     (WHITESPACE)
    
        my si:void_symbol_start char
        my sequence_180
        my si:void_leaf_symbol_end char
        return
    }
    
    method sequence_180 {} {
        # x
        #     "char"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str char
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'character_constant'
    #
    
    method sym_character_constant {} {
        # x
        #     ?
        #         'L'
        #     '''
        #     (c_char_sequence)
        #     '''
    
        my si:value_symbol_start character_constant
        my sequence_189
        my si:reduce_symbol_end character_constant
        return
    }
    
    method sequence_189 {} {
        # x
        #     ?
        #         'L'
        #     '''
        #     (c_char_sequence)
        #     '''
    
        my si:void_state_push
        my optional_184
        my si:voidvoid_part
        my si:next_char '
        my si:voidvalue_part
        my sym_c_char_sequence
        my si:valuevalue_part
        my si:next_char '
        my si:value_state_merge
        return
    }
    
    method optional_184 {} {
        # ?
        #     'L'
    
        my si:void2_state_push
        my si:next_char L
        my si:void_state_merge_ok
        return
    }
    
    #
    # leaf Symbol 'COLON'
    #
    
    method sym_COLON {} {
        # x
        #     ':'
        #     (WHITESPACE)
    
        my si:void_symbol_start COLON
        my sequence_194
        my si:void_leaf_symbol_end COLON
        return
    }
    
    method sequence_194 {} {
        # x
        #     ':'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char :
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # void Symbol 'COMMA'
    #
    
    method sym_COMMA {} {
        # x
        #     ','
        #     (WHITESPACE)
    
        my si:void_void_symbol_start COMMA
        my sequence_199
        my si:void_clear_symbol_end COMMA
        return
    }
    
    method sequence_199 {} {
        # x
        #     ','
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char ,
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'complex'
    #
    
    method sym_complex {} {
        # x
        #     "complex"
        #     (WHITESPACE)
    
        my si:void_symbol_start complex
        my sequence_204
        my si:void_leaf_symbol_end complex
        return
    }
    
    method sequence_204 {} {
        # x
        #     "complex"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str complex
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'conditional_expression'
    #
    
    method sym_conditional_expression {} {
        # x
        #     (logical_OR_expression)
        #     *
        #         x
        #             (QUERY)
        #             (expression)
        #             (COLON)
        #             (conditional_expression)
    
        my si:value_symbol_start conditional_expression
        my sequence_216
        my si:reduce_symbol_end conditional_expression
        return
    }
    
    method sequence_216 {} {
        # x
        #     (logical_OR_expression)
        #     *
        #         x
        #             (QUERY)
        #             (expression)
        #             (COLON)
        #             (conditional_expression)
    
        my si:value_state_push
        my sym_logical_OR_expression
        my si:valuevalue_part
        my kleene_214
        my si:value_state_merge
        return
    }
    
    method kleene_214 {} {
        # *
        #     x
        #         (QUERY)
        #         (expression)
        #         (COLON)
        #         (conditional_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_212
            my si:kleene_close
        }
        return
    }
    
    method sequence_212 {} {
        # x
        #     (QUERY)
        #     (expression)
        #     (COLON)
        #     (conditional_expression)
    
        my si:value_state_push
        my sym_QUERY
        my si:valuevalue_part
        my sym_expression
        my si:valuevalue_part
        my sym_COLON
        my si:valuevalue_part
        my sym_conditional_expression
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'const'
    #
    
    method sym_const {} {
        # x
        #     "const"
        #     (WHITESPACE)
    
        my si:void_symbol_start const
        my sequence_221
        my si:void_leaf_symbol_end const
        return
    }
    
    method sequence_221 {} {
        # x
        #     "const"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str const
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'constant'
    #
    
    method sym_constant {} {
        # /
        #     (integer_constant)
        #     (floating_constant)
        #     (enumeration_constant)
        #     (character_constant)
    
        my si:value_symbol_start constant
        my choice_228
        my si:reduce_symbol_end constant
        return
    }
    
    method choice_228 {} {
        # /
        #     (integer_constant)
        #     (floating_constant)
        #     (enumeration_constant)
        #     (character_constant)
    
        my si:value_state_push
        my sym_integer_constant
        my si:valuevalue_branch
        my sym_floating_constant
        my si:valuevalue_branch
        my sym_enumeration_constant
        my si:valuevalue_branch
        my sym_character_constant
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'constant_expression'
    #
    
    method sym_constant_expression {} {
        # (conditional_expression)
    
        my si:value_symbol_start constant_expression
        my sym_conditional_expression
        my si:reduce_symbol_end constant_expression
        return
    }
    
    #
    # value Symbol 'decimal_constant'
    #
    
    method sym_decimal_constant {} {
        # x
        #     (nonzero_digit)
        #     *
        #         (digit)
    
        my si:value_symbol_start decimal_constant
        my sequence_237
        my si:reduce_symbol_end decimal_constant
        return
    }
    
    method sequence_237 {} {
        # x
        #     (nonzero_digit)
        #     *
        #         (digit)
    
        my si:value_state_push
        my sym_nonzero_digit
        my si:valuevalue_part
        my kleene_235
        my si:value_state_merge
        return
    }
    
    method kleene_235 {} {
        # *
        #     (digit)
    
        while {1} {
            my si:void2_state_push
        my sym_digit
            my si:kleene_close
        }
        return
    }
    
    #
    # value Symbol 'decimal_floating_constant'
    #
    
    method sym_decimal_floating_constant {} {
        # /
        #     x
        #         (fractional_constant)
        #         ?
        #             (exponent_part)
        #         ?
        #             (floating_suffix)
        #     x
        #         (digit_sequence)
        #         (exponent_part)
        #         ?
        #             (floating_suffix)
    
        my si:value_symbol_start decimal_floating_constant
        my choice_255
        my si:reduce_symbol_end decimal_floating_constant
        return
    }
    
    method choice_255 {} {
        # /
        #     x
        #         (fractional_constant)
        #         ?
        #             (exponent_part)
        #         ?
        #             (floating_suffix)
        #     x
        #         (digit_sequence)
        #         (exponent_part)
        #         ?
        #             (floating_suffix)
    
        my si:value_state_push
        my sequence_247
        my si:valuevalue_branch
        my sequence_253
        my si:value_state_merge
        return
    }
    
    method sequence_247 {} {
        # x
        #     (fractional_constant)
        #     ?
        #         (exponent_part)
        #     ?
        #         (floating_suffix)
    
        my si:value_state_push
        my sym_fractional_constant
        my si:valuevalue_part
        my optional_242
        my si:valuevalue_part
        my optional_245
        my si:value_state_merge
        return
    }
    
    method optional_242 {} {
        # ?
        #     (exponent_part)
    
        my si:void2_state_push
        my sym_exponent_part
        my si:void_state_merge_ok
        return
    }
    
    method optional_245 {} {
        # ?
        #     (floating_suffix)
    
        my si:void2_state_push
        my sym_floating_suffix
        my si:void_state_merge_ok
        return
    }
    
    method sequence_253 {} {
        # x
        #     (digit_sequence)
        #     (exponent_part)
        #     ?
        #         (floating_suffix)
    
        my si:value_state_push
        my sym_digit_sequence
        my si:valuevalue_part
        my sym_exponent_part
        my si:valuevalue_part
        my optional_245
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'declaration_specifiers'
    #
    
    method sym_declaration_specifiers {} {
        # /
        #     x
        #         (storage_class_specifier)
        #         ?
        #             (declaration_specifiers)
        #     x
        #         (type_specifier)
        #         ?
        #             (declaration_specifiers)
        #     x
        #         (type_qualifier)
        #         ?
        #             (declaration_specifiers)
        #     x
        #         (function_specifier)
        #         ?
        #             (declaration_specifiers)
    
        my si:value_symbol_start declaration_specifiers
        my choice_279
        my si:reduce_symbol_end declaration_specifiers
        return
    }
    
    method choice_279 {} {
        # /
        #     x
        #         (storage_class_specifier)
        #         ?
        #             (declaration_specifiers)
        #     x
        #         (type_specifier)
        #         ?
        #             (declaration_specifiers)
        #     x
        #         (type_qualifier)
        #         ?
        #             (declaration_specifiers)
        #     x
        #         (function_specifier)
        #         ?
        #             (declaration_specifiers)
    
        my si:value_state_push
        my sequence_262
        my si:valuevalue_branch
        my sequence_267
        my si:valuevalue_branch
        my sequence_272
        my si:valuevalue_branch
        my sequence_277
        my si:value_state_merge
        return
    }
    
    method sequence_262 {} {
        # x
        #     (storage_class_specifier)
        #     ?
        #         (declaration_specifiers)
    
        my si:value_state_push
        my sym_storage_class_specifier
        my si:valuevalue_part
        my optional_260
        my si:value_state_merge
        return
    }
    
    method optional_260 {} {
        # ?
        #     (declaration_specifiers)
    
        my si:void2_state_push
        my sym_declaration_specifiers
        my si:void_state_merge_ok
        return
    }
    
    method sequence_267 {} {
        # x
        #     (type_specifier)
        #     ?
        #         (declaration_specifiers)
    
        my si:value_state_push
        my sym_type_specifier
        my si:valuevalue_part
        my optional_260
        my si:value_state_merge
        return
    }
    
    method sequence_272 {} {
        # x
        #     (type_qualifier)
        #     ?
        #         (declaration_specifiers)
    
        my si:value_state_push
        my sym_type_qualifier
        my si:valuevalue_part
        my optional_260
        my si:value_state_merge
        return
    }
    
    method sequence_277 {} {
        # x
        #     (function_specifier)
        #     ?
        #         (declaration_specifiers)
    
        my si:value_state_push
        my sym_function_specifier
        my si:valuevalue_part
        my optional_260
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'declarator'
    #
    
    method sym_declarator {} {
        # x
        #     ?
        #         (pointer)
        #     (direct_declarator)
    
        my si:value_symbol_start declarator
        my sequence_285
        my si:reduce_symbol_end declarator
        return
    }
    
    method sequence_285 {} {
        # x
        #     ?
        #         (pointer)
        #     (direct_declarator)
    
        my si:value_state_push
        my optional_18
        my si:valuevalue_part
        my sym_direct_declarator
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'designation'
    #
    
    method sym_designation {} {
        # x
        #     (designator_list)
        #     (EQUAL)
    
        my si:value_symbol_start designation
        my sequence_290
        my si:reduce_symbol_end designation
        return
    }
    
    method sequence_290 {} {
        # x
        #     (designator_list)
        #     (EQUAL)
    
        my si:value_state_push
        my sym_designator_list
        my si:valuevalue_part
        my sym_EQUAL
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'designator'
    #
    
    method sym_designator {} {
        # /
        #     x
        #         (LBRACKET)
        #         (constant_expression)
        #         (RBRACKET)
        #     x
        #         (DOT)
        #         (identifier)
    
        my si:value_symbol_start designator
        my choice_302
        my si:reduce_symbol_end designator
        return
    }
    
    method choice_302 {} {
        # /
        #     x
        #         (LBRACKET)
        #         (constant_expression)
        #         (RBRACKET)
        #     x
        #         (DOT)
        #         (identifier)
    
        my si:value_state_push
        my sequence_296
        my si:valuevalue_branch
        my sequence_300
        my si:value_state_merge
        return
    }
    
    method sequence_296 {} {
        # x
        #     (LBRACKET)
        #     (constant_expression)
        #     (RBRACKET)
    
        my si:value_state_push
        my sym_LBRACKET
        my si:valuevalue_part
        my sym_constant_expression
        my si:valuevalue_part
        my sym_RBRACKET
        my si:value_state_merge
        return
    }
    
    method sequence_300 {} {
        # x
        #     (DOT)
        #     (identifier)
    
        my si:value_state_push
        my sym_DOT
        my si:valuevalue_part
        my sym_identifier
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'designator_list'
    #
    
    method sym_designator_list {} {
        # +
        #     (designator)
    
        my si:value_symbol_start designator_list
        my poskleene_306
        my si:reduce_symbol_end designator_list
        return
    }
    
    method poskleene_306 {} {
        # +
        #     (designator)
    
        my i_loc_push
        my sym_designator
        my si:kleene_abort
        while {1} {
            my si:void2_state_push
        my sym_designator
            my si:kleene_close
        }
        return
    }
    
    #
    # value Symbol 'digit'
    #
    
    method sym_digit {} {
        # <digit>
    
        my si:void_symbol_start digit
        my si:next_digit
        my si:void_leaf_symbol_end digit
        return
    }
    
    #
    # value Symbol 'digit_sequence'
    #
    
    method sym_digit_sequence {} {
        # +
        #     <digit>
    
        my si:void_symbol_start digit_sequence
        my poskleene_312
        my si:void_leaf_symbol_end digit_sequence
        return
    }
    
    method poskleene_312 {} {
        # +
        #     <digit>
    
        my i_loc_push
        my si:next_digit
        my si:kleene_abort
        while {1} {
            my si:void2_state_push
        my si:next_digit
            my si:kleene_close
        }
        return
    }
    
    #
    # value Symbol 'direct_abstract_declarator'
    #
    
    method sym_direct_abstract_declarator {} {
        # x
        #     (direct_abstract_declarator_head)
        #     *
        #         (direct_abstract_declarator_tail)
    
        my si:value_symbol_start direct_abstract_declarator
        my sequence_319
        my si:reduce_symbol_end direct_abstract_declarator
        return
    }
    
    method sequence_319 {} {
        # x
        #     (direct_abstract_declarator_head)
        #     *
        #         (direct_abstract_declarator_tail)
    
        my si:value_state_push
        my sym_direct_abstract_declarator_head
        my si:valuevalue_part
        my kleene_317
        my si:value_state_merge
        return
    }
    
    method kleene_317 {} {
        # *
        #     (direct_abstract_declarator_tail)
    
        while {1} {
            my si:void2_state_push
        my sym_direct_abstract_declarator_tail
            my si:kleene_close
        }
        return
    }
    
    #
    # value Symbol 'direct_abstract_declarator_head'
    #
    
    method sym_direct_abstract_declarator_head {} {
        # /
        #     x
        #         (LPAREN)
        #         (abstract_declarator)
        #         (RPAREN)
        #     (direct_abstract_declarator_tail)
    
        my si:value_symbol_start direct_abstract_declarator_head
        my choice_328
        my si:reduce_symbol_end direct_abstract_declarator_head
        return
    }
    
    method choice_328 {} {
        # /
        #     x
        #         (LPAREN)
        #         (abstract_declarator)
        #         (RPAREN)
        #     (direct_abstract_declarator_tail)
    
        my si:value_state_push
        my sequence_325
        my si:valuevalue_branch
        my sym_direct_abstract_declarator_tail
        my si:value_state_merge
        return
    }
    
    method sequence_325 {} {
        # x
        #     (LPAREN)
        #     (abstract_declarator)
        #     (RPAREN)
    
        my si:value_state_push
        my sym_LPAREN
        my si:valuevalue_part
        my sym_abstract_declarator
        my si:valuevalue_part
        my sym_RPAREN
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'direct_abstract_declarator_tail'
    #
    
    method sym_direct_abstract_declarator_tail {} {
        # /
        #     (array_declarator)
        #     x
        #         (LPAREN)
        #         ?
        #             (parameter_type_list)
        #         (RPAREN)
    
        my si:value_symbol_start direct_abstract_declarator_tail
        my choice_339
        my si:reduce_symbol_end direct_abstract_declarator_tail
        return
    }
    
    method choice_339 {} {
        # /
        #     (array_declarator)
        #     x
        #         (LPAREN)
        #         ?
        #             (parameter_type_list)
        #         (RPAREN)
    
        my si:value_state_push
        my sym_array_declarator
        my si:valuevalue_branch
        my sequence_337
        my si:value_state_merge
        return
    }
    
    method sequence_337 {} {
        # x
        #     (LPAREN)
        #     ?
        #         (parameter_type_list)
        #     (RPAREN)
    
        my si:value_state_push
        my sym_LPAREN
        my si:valuevalue_part
        my optional_334
        my si:valuevalue_part
        my sym_RPAREN
        my si:value_state_merge
        return
    }
    
    method optional_334 {} {
        # ?
        #     (parameter_type_list)
    
        my si:void2_state_push
        my sym_parameter_type_list
        my si:void_state_merge_ok
        return
    }
    
    #
    # value Symbol 'direct_declarator'
    #
    
    method sym_direct_declarator {} {
        # x
        #     (direct_declarator_head)
        #     ?
        #         (direct_declarator_tail)
    
        my si:value_symbol_start direct_declarator
        my sequence_346
        my si:reduce_symbol_end direct_declarator
        return
    }
    
    method sequence_346 {} {
        # x
        #     (direct_declarator_head)
        #     ?
        #         (direct_declarator_tail)
    
        my si:value_state_push
        my sym_direct_declarator_head
        my si:valuevalue_part
        my optional_344
        my si:value_state_merge
        return
    }
    
    method optional_344 {} {
        # ?
        #     (direct_declarator_tail)
    
        my si:void2_state_push
        my sym_direct_declarator_tail
        my si:void_state_merge_ok
        return
    }
    
    #
    # value Symbol 'direct_declarator_head'
    #
    
    method sym_direct_declarator_head {} {
        # /
        #     (identifier)
        #     x
        #         (LPAREN)
        #         (declarator)
        #         (RPAREN)
    
        my si:value_symbol_start direct_declarator_head
        my choice_355
        my si:reduce_symbol_end direct_declarator_head
        return
    }
    
    method choice_355 {} {
        # /
        #     (identifier)
        #     x
        #         (LPAREN)
        #         (declarator)
        #         (RPAREN)
    
        my si:value_state_push
        my sym_identifier
        my si:valuevalue_branch
        my sequence_353
        my si:value_state_merge
        return
    }
    
    method sequence_353 {} {
        # x
        #     (LPAREN)
        #     (declarator)
        #     (RPAREN)
    
        my si:value_state_push
        my sym_LPAREN
        my si:valuevalue_part
        my sym_declarator
        my si:valuevalue_part
        my sym_RPAREN
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'direct_declarator_tail'
    #
    
    method sym_direct_declarator_tail {} {
        # /
        #     x
        #         (LBRACKET)
        #         ?
        #             (type_qualifier_list)
        #         ?
        #             (assignment_expression)
        #         (RBRACKET)
        #     x
        #         (LBRACKET)
        #         (static)
        #         ?
        #             (type_qualifier_list)
        #         (assignment_expression)
        #         (RBRACKET)
        #     x
        #         (LBRACKET)
        #         (type_qualifier_list)
        #         (static)
        #         (assignment_expression)
        #         (RBRACKET)
        #     x
        #         (LBRACKET)
        #         ?
        #             (type_qualifier_list)
        #         (STAR)
        #         (RBRACKET)
        #     x
        #         (LPAREN)
        #         (parameter_type_list)
        #         (RPAREN)
        #     x
        #         (LPAREN)
        #         ?
        #             (identifier_list)
        #         (RPAREN)
    
        my si:value_symbol_start direct_declarator_tail
        my choice_401
        my si:reduce_symbol_end direct_declarator_tail
        return
    }
    
    method choice_401 {} {
        # /
        #     x
        #         (LBRACKET)
        #         ?
        #             (type_qualifier_list)
        #         ?
        #             (assignment_expression)
        #         (RBRACKET)
        #     x
        #         (LBRACKET)
        #         (static)
        #         ?
        #             (type_qualifier_list)
        #         (assignment_expression)
        #         (RBRACKET)
        #     x
        #         (LBRACKET)
        #         (type_qualifier_list)
        #         (static)
        #         (assignment_expression)
        #         (RBRACKET)
        #     x
        #         (LBRACKET)
        #         ?
        #             (type_qualifier_list)
        #         (STAR)
        #         (RBRACKET)
        #     x
        #         (LPAREN)
        #         (parameter_type_list)
        #         (RPAREN)
        #     x
        #         (LPAREN)
        #         ?
        #             (identifier_list)
        #         (RPAREN)
    
        my si:value_state_push
        my sequence_365
        my si:valuevalue_branch
        my sequence_373
        my si:valuevalue_branch
        my sequence_380
        my si:valuevalue_branch
        my sequence_387
        my si:valuevalue_branch
        my sequence_392
        my si:valuevalue_branch
        my sequence_399
        my si:value_state_merge
        return
    }
    
    method sequence_365 {} {
        # x
        #     (LBRACKET)
        #     ?
        #         (type_qualifier_list)
        #     ?
        #         (assignment_expression)
        #     (RBRACKET)
    
        my si:value_state_push
        my sym_LBRACKET
        my si:valuevalue_part
        my optional_360
        my si:valuevalue_part
        my optional_81
        my si:valuevalue_part
        my sym_RBRACKET
        my si:value_state_merge
        return
    }
    
    method optional_360 {} {
        # ?
        #     (type_qualifier_list)
    
        my si:void2_state_push
        my sym_type_qualifier_list
        my si:void_state_merge_ok
        return
    }
    
    method sequence_373 {} {
        # x
        #     (LBRACKET)
        #     (static)
        #     ?
        #         (type_qualifier_list)
        #     (assignment_expression)
        #     (RBRACKET)
    
        my si:value_state_push
        my sym_LBRACKET
        my si:valuevalue_part
        my sym_static
        my si:valuevalue_part
        my optional_360
        my si:valuevalue_part
        my sym_assignment_expression
        my si:valuevalue_part
        my sym_RBRACKET
        my si:value_state_merge
        return
    }
    
    method sequence_380 {} {
        # x
        #     (LBRACKET)
        #     (type_qualifier_list)
        #     (static)
        #     (assignment_expression)
        #     (RBRACKET)
    
        my si:value_state_push
        my sym_LBRACKET
        my si:valuevalue_part
        my sym_type_qualifier_list
        my si:valuevalue_part
        my sym_static
        my si:valuevalue_part
        my sym_assignment_expression
        my si:valuevalue_part
        my sym_RBRACKET
        my si:value_state_merge
        return
    }
    
    method sequence_387 {} {
        # x
        #     (LBRACKET)
        #     ?
        #         (type_qualifier_list)
        #     (STAR)
        #     (RBRACKET)
    
        my si:value_state_push
        my sym_LBRACKET
        my si:valuevalue_part
        my optional_360
        my si:valuevalue_part
        my sym_STAR
        my si:valuevalue_part
        my sym_RBRACKET
        my si:value_state_merge
        return
    }
    
    method sequence_392 {} {
        # x
        #     (LPAREN)
        #     (parameter_type_list)
        #     (RPAREN)
    
        my si:value_state_push
        my sym_LPAREN
        my si:valuevalue_part
        my sym_parameter_type_list
        my si:valuevalue_part
        my sym_RPAREN
        my si:value_state_merge
        return
    }
    
    method sequence_399 {} {
        # x
        #     (LPAREN)
        #     ?
        #         (identifier_list)
        #     (RPAREN)
    
        my si:value_state_push
        my sym_LPAREN
        my si:valuevalue_part
        my optional_396
        my si:valuevalue_part
        my sym_RPAREN
        my si:value_state_merge
        return
    }
    
    method optional_396 {} {
        # ?
        #     (identifier_list)
    
        my si:void2_state_push
        my sym_identifier_list
        my si:void_state_merge_ok
        return
    }
    
    #
    # leaf Symbol 'DOT'
    #
    
    method sym_DOT {} {
        # x
        #     '.'
        #     (WHITESPACE)
    
        my si:void_symbol_start DOT
        my sequence_406
        my si:void_leaf_symbol_end DOT
        return
    }
    
    method sequence_406 {} {
        # x
        #     '.'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char .
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'double'
    #
    
    method sym_double {} {
        # x
        #     "double"
        #     (WHITESPACE)
    
        my si:void_symbol_start double
        my sequence_411
        my si:void_leaf_symbol_end double
        return
    }
    
    method sequence_411 {} {
        # x
        #     "double"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str double
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'ELLIPSIS'
    #
    
    method sym_ELLIPSIS {} {
        # x
        #     "..."
        #     (WHITESPACE)
    
        my si:void_symbol_start ELLIPSIS
        my sequence_416
        my si:void_leaf_symbol_end ELLIPSIS
        return
    }
    
    method sequence_416 {} {
        # x
        #     "..."
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str ...
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'enum'
    #
    
    method sym_enum {} {
        # x
        #     "enum"
        #     (WHITESPACE)
    
        my si:void_symbol_start enum
        my sequence_421
        my si:void_leaf_symbol_end enum
        return
    }
    
    method sequence_421 {} {
        # x
        #     "enum"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str enum
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'enum_specifier'
    #
    
    method sym_enum_specifier {} {
        # /
        #     x
        #         (enum)
        #         ?
        #             (identifier)
        #         (LBRACE)
        #         (enumerator_list)
        #         (RBRACE)
        #     x
        #         (enum)
        #         ?
        #             (identifier)
        #         (LBRACE)
        #         (enumerator_list)
        #         (COMMA)
        #         (RBRACE)
        #     x
        #         (enum)
        #         (identifier)
    
        my si:value_symbol_start enum_specifier
        my choice_446
        my si:reduce_symbol_end enum_specifier
        return
    }
    
    method choice_446 {} {
        # /
        #     x
        #         (enum)
        #         ?
        #             (identifier)
        #         (LBRACE)
        #         (enumerator_list)
        #         (RBRACE)
        #     x
        #         (enum)
        #         ?
        #             (identifier)
        #         (LBRACE)
        #         (enumerator_list)
        #         (COMMA)
        #         (RBRACE)
        #     x
        #         (enum)
        #         (identifier)
    
        my si:value_state_push
        my sequence_431
        my si:valuevalue_branch
        my sequence_440
        my si:valuevalue_branch
        my sequence_444
        my si:value_state_merge
        return
    }
    
    method sequence_431 {} {
        # x
        #     (enum)
        #     ?
        #         (identifier)
        #     (LBRACE)
        #     (enumerator_list)
        #     (RBRACE)
    
        my si:value_state_push
        my sym_enum
        my si:valuevalue_part
        my optional_426
        my si:valuevalue_part
        my sym_LBRACE
        my si:valuevalue_part
        my sym_enumerator_list
        my si:valuevalue_part
        my sym_RBRACE
        my si:value_state_merge
        return
    }
    
    method optional_426 {} {
        # ?
        #     (identifier)
    
        my si:void2_state_push
        my sym_identifier
        my si:void_state_merge_ok
        return
    }
    
    method sequence_440 {} {
        # x
        #     (enum)
        #     ?
        #         (identifier)
        #     (LBRACE)
        #     (enumerator_list)
        #     (COMMA)
        #     (RBRACE)
    
        my si:value_state_push
        my sym_enum
        my si:valuevalue_part
        my optional_426
        my si:valuevalue_part
        my sym_LBRACE
        my si:valuevalue_part
        my sym_enumerator_list
        my si:valuevalue_part
        my sym_COMMA
        my si:valuevalue_part
        my sym_RBRACE
        my si:value_state_merge
        return
    }
    
    method sequence_444 {} {
        # x
        #     (enum)
        #     (identifier)
    
        my si:value_state_push
        my sym_enum
        my si:valuevalue_part
        my sym_identifier
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'enumeration_constant'
    #
    
    method sym_enumeration_constant {} {
        # (identifier)
    
        my si:value_symbol_start enumeration_constant
        my sym_identifier
        my si:reduce_symbol_end enumeration_constant
        return
    }
    
    #
    # value Symbol 'enumerator'
    #
    
    method sym_enumerator {} {
        # x
        #     (enumeration_constant)
        #     ?
        #         x
        #             (EQUAL)
        #             (constant_expression)
    
        my si:value_symbol_start enumerator
        my sequence_458
        my si:reduce_symbol_end enumerator
        return
    }
    
    method sequence_458 {} {
        # x
        #     (enumeration_constant)
        #     ?
        #         x
        #             (EQUAL)
        #             (constant_expression)
    
        my si:value_state_push
        my sym_enumeration_constant
        my si:valuevalue_part
        my optional_456
        my si:value_state_merge
        return
    }
    
    method optional_456 {} {
        # ?
        #     x
        #         (EQUAL)
        #         (constant_expression)
    
        my si:void2_state_push
        my sequence_454
        my si:void_state_merge_ok
        return
    }
    
    method sequence_454 {} {
        # x
        #     (EQUAL)
        #     (constant_expression)
    
        my si:value_state_push
        my sym_EQUAL
        my si:valuevalue_part
        my sym_constant_expression
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'enumerator_list'
    #
    
    method sym_enumerator_list {} {
        # x
        #     (enumerator)
        #     *
        #         x
        #             (COMMA)
        #             (enumerator)
    
        my si:value_symbol_start enumerator_list
        my sequence_468
        my si:reduce_symbol_end enumerator_list
        return
    }
    
    method sequence_468 {} {
        # x
        #     (enumerator)
        #     *
        #         x
        #             (COMMA)
        #             (enumerator)
    
        my si:value_state_push
        my sym_enumerator
        my si:valuevalue_part
        my kleene_466
        my si:value_state_merge
        return
    }
    
    method kleene_466 {} {
        # *
        #     x
        #         (COMMA)
        #         (enumerator)
    
        while {1} {
            my si:void2_state_push
        my sequence_464
            my si:kleene_close
        }
        return
    }
    
    method sequence_464 {} {
        # x
        #     (COMMA)
        #     (enumerator)
    
        my si:void_state_push
        my sym_COMMA
        my si:voidvalue_part
        my sym_enumerator
        my si:value_state_merge
        return
    }
    
    #
    # void Symbol 'EOF'
    #
    
    method sym_EOF {} {
        # !
        #     <dot>
    
        my si:void_void_symbol_start EOF
        my notahead_472
        my si:void_clear_symbol_end EOF
        return
    }
    
    method notahead_472 {} {
        # !
        #     <dot>
    
        my i_loc_push
        my i_input_next dot
        my si:void_notahead_exit
        return
    }
    
    #
    # leaf Symbol 'EQUAL'
    #
    
    method sym_EQUAL {} {
        # x
        #     '='
        #     (WHITESPACE)
    
        my si:void_symbol_start EQUAL
        my sequence_477
        my si:void_leaf_symbol_end EQUAL
        return
    }
    
    method sequence_477 {} {
        # x
        #     '='
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char =
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'EQUALEQUAL'
    #
    
    method sym_EQUALEQUAL {} {
        # x
        #     "=="
        #     (WHITESPACE)
    
        my si:void_symbol_start EQUALEQUAL
        my sequence_482
        my si:void_leaf_symbol_end EQUALEQUAL
        return
    }
    
    method sequence_482 {} {
        # x
        #     "=="
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str ==
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'equality_expression'
    #
    
    method sym_equality_expression {} {
        # x
        #     (relational_expression)
        #     *
        #         x
        #             /
        #                 (EQUALEQUAL)
        #                 (PLINGEQUAL)
        #             (relational_expression)
    
        my si:value_symbol_start equality_expression
        my sequence_495
        my si:reduce_symbol_end equality_expression
        return
    }
    
    method sequence_495 {} {
        # x
        #     (relational_expression)
        #     *
        #         x
        #             /
        #                 (EQUALEQUAL)
        #                 (PLINGEQUAL)
        #             (relational_expression)
    
        my si:value_state_push
        my sym_relational_expression
        my si:valuevalue_part
        my kleene_493
        my si:value_state_merge
        return
    }
    
    method kleene_493 {} {
        # *
        #     x
        #         /
        #             (EQUALEQUAL)
        #             (PLINGEQUAL)
        #         (relational_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_491
            my si:kleene_close
        }
        return
    }
    
    method sequence_491 {} {
        # x
        #     /
        #         (EQUALEQUAL)
        #         (PLINGEQUAL)
        #     (relational_expression)
    
        my si:value_state_push
        my choice_488
        my si:valuevalue_part
        my sym_relational_expression
        my si:value_state_merge
        return
    }
    
    method choice_488 {} {
        # /
        #     (EQUALEQUAL)
        #     (PLINGEQUAL)
    
        my si:value_state_push
        my sym_EQUALEQUAL
        my si:valuevalue_branch
        my sym_PLINGEQUAL
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'escape_sequence'
    #
    
    method sym_escape_sequence {} {
        # /
        #     (simple_escape_sequence)
        #     (octal_escape_sequence)
        #     (hexadecimal_escape_sequence)
        #     (universal_character_name)
    
        my si:value_symbol_start escape_sequence
        my choice_502
        my si:reduce_symbol_end escape_sequence
        return
    }
    
    method choice_502 {} {
        # /
        #     (simple_escape_sequence)
        #     (octal_escape_sequence)
        #     (hexadecimal_escape_sequence)
        #     (universal_character_name)
    
        my si:value_state_push
        my sym_simple_escape_sequence
        my si:valuevalue_branch
        my sym_octal_escape_sequence
        my si:valuevalue_branch
        my sym_hexadecimal_escape_sequence
        my si:valuevoid_branch
        my i_status_fail ; # Undefined symbol 'universal_character_name'
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'exclusive_OR_expression'
    #
    
    method sym_exclusive_OR_expression {} {
        # x
        #     (AND_expression)
        #     *
        #         x
        #             (HAT)
        #             (AND_expression)
    
        my si:value_symbol_start exclusive_OR_expression
        my sequence_512
        my si:reduce_symbol_end exclusive_OR_expression
        return
    }
    
    method sequence_512 {} {
        # x
        #     (AND_expression)
        #     *
        #         x
        #             (HAT)
        #             (AND_expression)
    
        my si:value_state_push
        my sym_AND_expression
        my si:valuevalue_part
        my kleene_510
        my si:value_state_merge
        return
    }
    
    method kleene_510 {} {
        # *
        #     x
        #         (HAT)
        #         (AND_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_508
            my si:kleene_close
        }
        return
    }
    
    method sequence_508 {} {
        # x
        #     (HAT)
        #     (AND_expression)
    
        my si:value_state_push
        my sym_HAT
        my si:valuevalue_part
        my sym_AND_expression
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'exponent_part'
    #
    
    method sym_exponent_part {} {
        # x
        #     [eE]
        #     ?
        #         (sign)
        #     (digit_sequence)
    
        my si:value_symbol_start exponent_part
        my sequence_519
        my si:reduce_symbol_end exponent_part
        return
    }
    
    method sequence_519 {} {
        # x
        #     [eE]
        #     ?
        #         (sign)
        #     (digit_sequence)
    
        my si:void_state_push
        my si:next_class eE
        my si:voidvalue_part
        my optional_144
        my si:valuevalue_part
        my sym_digit_sequence
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'expression'
    #
    
    method sym_expression {} {
        # x
        #     (assignment_expression)
        #     *
        #         x
        #             (COMMA)
        #             (assignment_expression)
    
        my si:value_symbol_start expression
        my sequence_76
        my si:reduce_symbol_end expression
        return
    }
    
    #
    # leaf Symbol 'extern'
    #
    
    method sym_extern {} {
        # x
        #     "extern"
        #     (WHITESPACE)
    
        my si:void_symbol_start extern
        my sequence_531
        my si:void_leaf_symbol_end extern
        return
    }
    
    method sequence_531 {} {
        # x
        #     "extern"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str extern
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'float'
    #
    
    method sym_float {} {
        # x
        #     "float"
        #     (WHITESPACE)
    
        my si:void_symbol_start float
        my sequence_536
        my si:void_leaf_symbol_end float
        return
    }
    
    method sequence_536 {} {
        # x
        #     "float"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str float
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'floating_constant'
    #
    
    method sym_floating_constant {} {
        # /
        #     (decimal_floating_constant)
        #     (hexadecimal_floating_constant)
    
        my si:value_symbol_start floating_constant
        my choice_541
        my si:reduce_symbol_end floating_constant
        return
    }
    
    method choice_541 {} {
        # /
        #     (decimal_floating_constant)
        #     (hexadecimal_floating_constant)
    
        my si:value_state_push
        my sym_decimal_floating_constant
        my si:valuevalue_branch
        my sym_hexadecimal_floating_constant
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'floating_suffix'
    #
    
    method sym_floating_suffix {} {
        # [flFL]
    
        my si:void_symbol_start floating_suffix
        my si:next_class flFL
        my si:void_leaf_symbol_end floating_suffix
        return
    }
    
    #
    # value Symbol 'fractional_constant'
    #
    
    method sym_fractional_constant {} {
        # /
        #     x
        #         ?
        #             (digit_sequence)
        #         '.'
        #         (digit_sequence)
        #     x
        #         (digit_sequence)
        #         '.'
    
        my si:value_symbol_start fractional_constant
        my choice_557
        my si:reduce_symbol_end fractional_constant
        return
    }
    
    method choice_557 {} {
        # /
        #     x
        #         ?
        #             (digit_sequence)
        #         '.'
        #         (digit_sequence)
        #     x
        #         (digit_sequence)
        #         '.'
    
        my si:value_state_push
        my sequence_551
        my si:valuevalue_branch
        my sequence_555
        my si:value_state_merge
        return
    }
    
    method sequence_551 {} {
        # x
        #     ?
        #         (digit_sequence)
        #     '.'
        #     (digit_sequence)
    
        my si:value_state_push
        my optional_547
        my si:valuevalue_part
        my si:next_char .
        my si:valuevalue_part
        my sym_digit_sequence
        my si:value_state_merge
        return
    }
    
    method optional_547 {} {
        # ?
        #     (digit_sequence)
    
        my si:void2_state_push
        my sym_digit_sequence
        my si:void_state_merge_ok
        return
    }
    
    method sequence_555 {} {
        # x
        #     (digit_sequence)
        #     '.'
    
        my si:value_state_push
        my sym_digit_sequence
        my si:valuevalue_part
        my si:next_char .
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'function_specifier'
    #
    
    method sym_function_specifier {} {
        # (inline)
    
        my si:value_symbol_start function_specifier
        my sym_inline
        my si:reduce_symbol_end function_specifier
        return
    }
    
    #
    # leaf Symbol 'GREATER'
    #
    
    method sym_GREATER {} {
        # x
        #     '>'
        #     (WHITESPACE)
    
        my si:void_symbol_start GREATER
        my sequence_564
        my si:void_leaf_symbol_end GREATER
        return
    }
    
    method sequence_564 {} {
        # x
        #     '>'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char >
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'GREATEREQUAL'
    #
    
    method sym_GREATEREQUAL {} {
        # x
        #     ">="
        #     (WHITESPACE)
    
        my si:void_symbol_start GREATEREQUAL
        my sequence_569
        my si:void_leaf_symbol_end GREATEREQUAL
        return
    }
    
    method sequence_569 {} {
        # x
        #     ">="
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str >=
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'GREATERGREATER'
    #
    
    method sym_GREATERGREATER {} {
        # x
        #     ">>"
        #     (WHITESPACE)
    
        my si:void_symbol_start GREATERGREATER
        my sequence_574
        my si:void_leaf_symbol_end GREATERGREATER
        return
    }
    
    method sequence_574 {} {
        # x
        #     ">>"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str >>
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'GREATERGREATEREQUAL'
    #
    
    method sym_GREATERGREATEREQUAL {} {
        # x
        #     ">>="
        #     (WHITESPACE)
    
        my si:void_symbol_start GREATERGREATEREQUAL
        my sequence_579
        my si:void_leaf_symbol_end GREATERGREATEREQUAL
        return
    }
    
    method sequence_579 {} {
        # x
        #     ">>="
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str >>=
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'HAT'
    #
    
    method sym_HAT {} {
        # x
        #     '^'
        #     (WHITESPACE)
    
        my si:void_symbol_start HAT
        my sequence_584
        my si:void_leaf_symbol_end HAT
        return
    }
    
    method sequence_584 {} {
        # x
        #     '^'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char ^
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'HATEQUAL'
    #
    
    method sym_HATEQUAL {} {
        # x
        #     "^="
        #     (WHITESPACE)
    
        my si:void_symbol_start HATEQUAL
        my sequence_589
        my si:void_leaf_symbol_end HATEQUAL
        return
    }
    
    method sequence_589 {} {
        # x
        #     "^="
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str ^=
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'hexadecimal_constant'
    #
    
    method sym_hexadecimal_constant {} {
        # x
        #     (hexadecimal_prefix)
        #     +
        #         (hexadecimal_digit)
    
        my si:value_symbol_start hexadecimal_constant
        my sequence_596
        my si:reduce_symbol_end hexadecimal_constant
        return
    }
    
    method sequence_596 {} {
        # x
        #     (hexadecimal_prefix)
        #     +
        #         (hexadecimal_digit)
    
        my si:value_state_push
        my sym_hexadecimal_prefix
        my si:valuevalue_part
        my poskleene_594
        my si:value_state_merge
        return
    }
    
    method poskleene_594 {} {
        # +
        #     (hexadecimal_digit)
    
        my i_loc_push
        my sym_hexadecimal_digit
        my si:kleene_abort
        while {1} {
            my si:void2_state_push
        my sym_hexadecimal_digit
            my si:kleene_close
        }
        return
    }
    
    #
    # value Symbol 'hexadecimal_digit'
    #
    
    method sym_hexadecimal_digit {} {
        # <xdigit>
    
        my si:void_symbol_start hexadecimal_digit
        my si:next_xdigit
        my si:void_leaf_symbol_end hexadecimal_digit
        return
    }
    
    #
    # value Symbol 'hexadecimal_digit_sequence'
    #
    
    method sym_hexadecimal_digit_sequence {} {
        # /
        #     (hexadecimal_digit)
        #     x
        #         (hexadecimal_digit_sequence)
        #         (hexadecimal_digit)
    
        my si:value_symbol_start hexadecimal_digit_sequence
        my choice_606
        my si:reduce_symbol_end hexadecimal_digit_sequence
        return
    }
    
    method choice_606 {} {
        # /
        #     (hexadecimal_digit)
        #     x
        #         (hexadecimal_digit_sequence)
        #         (hexadecimal_digit)
    
        my si:value_state_push
        my sym_hexadecimal_digit
        my si:valuevalue_branch
        my sequence_604
        my si:value_state_merge
        return
    }
    
    method sequence_604 {} {
        # x
        #     (hexadecimal_digit_sequence)
        #     (hexadecimal_digit)
    
        my si:value_state_push
        my sym_hexadecimal_digit_sequence
        my si:valuevalue_part
        my sym_hexadecimal_digit
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'hexadecimal_escape_sequence'
    #
    
    method sym_hexadecimal_escape_sequence {} {
        # x
        #     "\x"
        #     +
        #         (hexadecimal_digit)
    
        my si:value_symbol_start hexadecimal_escape_sequence
        my sequence_612
        my si:reduce_symbol_end hexadecimal_escape_sequence
        return
    }
    
    method sequence_612 {} {
        # x
        #     "\x"
        #     +
        #         (hexadecimal_digit)
    
        my si:void_state_push
        my si:next_str \134x
        my si:voidvalue_part
        my poskleene_594
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'hexadecimal_floating_constant'
    #
    
    method sym_hexadecimal_floating_constant {} {
        # /
        #     x
        #         (hexadecimal_prefix)
        #         (hexadecimal_fractional_constant)
        #         (binary_exponent_part)
        #         ?
        #             (floating_suffix)
        #     x
        #         (hexadecimal_prefix)
        #         (hexadecimal_digit_sequence)
        #         (binary_exponent_part)
        #         ?
        #             (floating_suffix)
    
        my si:value_symbol_start hexadecimal_floating_constant
        my choice_629
        my si:reduce_symbol_end hexadecimal_floating_constant
        return
    }
    
    method choice_629 {} {
        # /
        #     x
        #         (hexadecimal_prefix)
        #         (hexadecimal_fractional_constant)
        #         (binary_exponent_part)
        #         ?
        #             (floating_suffix)
        #     x
        #         (hexadecimal_prefix)
        #         (hexadecimal_digit_sequence)
        #         (binary_exponent_part)
        #         ?
        #             (floating_suffix)
    
        my si:value_state_push
        my sequence_620
        my si:valuevalue_branch
        my sequence_627
        my si:value_state_merge
        return
    }
    
    method sequence_620 {} {
        # x
        #     (hexadecimal_prefix)
        #     (hexadecimal_fractional_constant)
        #     (binary_exponent_part)
        #     ?
        #         (floating_suffix)
    
        my si:value_state_push
        my sym_hexadecimal_prefix
        my si:valuevalue_part
        my sym_hexadecimal_fractional_constant
        my si:valuevalue_part
        my sym_binary_exponent_part
        my si:valuevalue_part
        my optional_245
        my si:value_state_merge
        return
    }
    
    method sequence_627 {} {
        # x
        #     (hexadecimal_prefix)
        #     (hexadecimal_digit_sequence)
        #     (binary_exponent_part)
        #     ?
        #         (floating_suffix)
    
        my si:value_state_push
        my sym_hexadecimal_prefix
        my si:valuevalue_part
        my sym_hexadecimal_digit_sequence
        my si:valuevalue_part
        my sym_binary_exponent_part
        my si:valuevalue_part
        my optional_245
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'hexadecimal_fractional_constant'
    #
    
    method sym_hexadecimal_fractional_constant {} {
        # /
        #     x
        #         ?
        #             (hexadecimal_digit_sequence)
        #         '.'
        #         (hexadecimal_digit_sequence)
        #     x
        #         (hexadecimal_digit_sequence)
        #         '.'
    
        my si:value_symbol_start hexadecimal_fractional_constant
        my choice_643
        my si:reduce_symbol_end hexadecimal_fractional_constant
        return
    }
    
    method choice_643 {} {
        # /
        #     x
        #         ?
        #             (hexadecimal_digit_sequence)
        #         '.'
        #         (hexadecimal_digit_sequence)
        #     x
        #         (hexadecimal_digit_sequence)
        #         '.'
    
        my si:value_state_push
        my sequence_637
        my si:valuevalue_branch
        my sequence_641
        my si:value_state_merge
        return
    }
    
    method sequence_637 {} {
        # x
        #     ?
        #         (hexadecimal_digit_sequence)
        #     '.'
        #     (hexadecimal_digit_sequence)
    
        my si:value_state_push
        my optional_633
        my si:valuevalue_part
        my si:next_char .
        my si:valuevalue_part
        my sym_hexadecimal_digit_sequence
        my si:value_state_merge
        return
    }
    
    method optional_633 {} {
        # ?
        #     (hexadecimal_digit_sequence)
    
        my si:void2_state_push
        my sym_hexadecimal_digit_sequence
        my si:void_state_merge_ok
        return
    }
    
    method sequence_641 {} {
        # x
        #     (hexadecimal_digit_sequence)
        #     '.'
    
        my si:value_state_push
        my sym_hexadecimal_digit_sequence
        my si:valuevalue_part
        my si:next_char .
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'hexadecimal_prefix'
    #
    
    method sym_hexadecimal_prefix {} {
        # /
        #     "0x"
        #     "0X"
    
        my si:void_symbol_start hexadecimal_prefix
        my choice_648
        my si:void_leaf_symbol_end hexadecimal_prefix
        return
    }
    
    method choice_648 {} {
        # /
        #     "0x"
        #     "0X"
    
        my si:void_state_push
        my si:next_str 0x
        my si:voidvoid_branch
        my si:next_str 0X
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'identifier'
    #
    
    method sym_identifier {} {
        # x
        #     !
        #         (keyword)
        #     <alpha>
        #     *
        #         <wordchar>
        #     (WHITESPACE)
    
        my si:void_symbol_start identifier
        my sequence_659
        my si:void_leaf_symbol_end identifier
        return
    }
    
    method sequence_659 {} {
        # x
        #     !
        #         (keyword)
        #     <alpha>
        #     *
        #         <wordchar>
        #     (WHITESPACE)
    
        my si:void_state_push
        my notahead_652
        my si:voidvoid_part
        my si:next_alpha
        my si:voidvoid_part
        my kleene_656
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    method notahead_652 {} {
        # !
        #     (keyword)
    
        my si:value_notahead_start
        my sym_keyword
        my si:value_notahead_exit
        return
    }
    
    method kleene_656 {} {
        # *
        #     <wordchar>
    
        while {1} {
            my si:void2_state_push
        my si:next_wordchar
            my si:kleene_close
        }
        return
    }
    
    #
    # value Symbol 'identifier_list'
    #
    
    method sym_identifier_list {} {
        # x
        #     (identifier)
        #     *
        #         x
        #             (COMMA)
        #             (identifier)
    
        my si:value_symbol_start identifier_list
        my sequence_669
        my si:reduce_symbol_end identifier_list
        return
    }
    
    method sequence_669 {} {
        # x
        #     (identifier)
        #     *
        #         x
        #             (COMMA)
        #             (identifier)
    
        my si:value_state_push
        my sym_identifier
        my si:valuevalue_part
        my kleene_667
        my si:value_state_merge
        return
    }
    
    method kleene_667 {} {
        # *
        #     x
        #         (COMMA)
        #         (identifier)
    
        while {1} {
            my si:void2_state_push
        my sequence_665
            my si:kleene_close
        }
        return
    }
    
    method sequence_665 {} {
        # x
        #     (COMMA)
        #     (identifier)
    
        my si:void_state_push
        my sym_COMMA
        my si:voidvalue_part
        my sym_identifier
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'imaginary'
    #
    
    method sym_imaginary {} {
        # x
        #     "imaginary"
        #     (WHITESPACE)
    
        my si:void_symbol_start imaginary
        my sequence_674
        my si:void_leaf_symbol_end imaginary
        return
    }
    
    method sequence_674 {} {
        # x
        #     "imaginary"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str imaginary
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'inclusive_OR_expression'
    #
    
    method sym_inclusive_OR_expression {} {
        # x
        #     (exclusive_OR_expression)
        #     *
        #         x
        #             (BAR)
        #             (exclusive_OR_expression)
    
        my si:value_symbol_start inclusive_OR_expression
        my sequence_684
        my si:reduce_symbol_end inclusive_OR_expression
        return
    }
    
    method sequence_684 {} {
        # x
        #     (exclusive_OR_expression)
        #     *
        #         x
        #             (BAR)
        #             (exclusive_OR_expression)
    
        my si:value_state_push
        my sym_exclusive_OR_expression
        my si:valuevalue_part
        my kleene_682
        my si:value_state_merge
        return
    }
    
    method kleene_682 {} {
        # *
        #     x
        #         (BAR)
        #         (exclusive_OR_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_680
            my si:kleene_close
        }
        return
    }
    
    method sequence_680 {} {
        # x
        #     (BAR)
        #     (exclusive_OR_expression)
    
        my si:value_state_push
        my sym_BAR
        my si:valuevalue_part
        my sym_exclusive_OR_expression
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'initializer_list'
    #
    
    method sym_initializer_list {} {
        # x
        #     ?
        #         (designation)
        #     (initializer)
        #     *
        #         x
        #             (COMMA)
        #             ?
        #                 (designation)
        #             (initializer)
    
        my si:value_symbol_start initializer_list
        my sequence_699
        my si:reduce_symbol_end initializer_list
        return
    }
    
    method sequence_699 {} {
        # x
        #     ?
        #         (designation)
        #     (initializer)
        #     *
        #         x
        #             (COMMA)
        #             ?
        #                 (designation)
        #             (initializer)
    
        my si:value_state_push
        my optional_688
        my si:valuevalue_part
        my i_status_fail ; # Undefined symbol 'initializer'
        my si:valuevalue_part
        my kleene_697
        my si:value_state_merge
        return
    }
    
    method optional_688 {} {
        # ?
        #     (designation)
    
        my si:void2_state_push
        my sym_designation
        my si:void_state_merge_ok
        return
    }
    
    method kleene_697 {} {
        # *
        #     x
        #         (COMMA)
        #         ?
        #             (designation)
        #         (initializer)
    
        while {1} {
            my si:void2_state_push
        my sequence_695
            my si:kleene_close
        }
        return
    }
    
    method sequence_695 {} {
        # x
        #     (COMMA)
        #     ?
        #         (designation)
        #     (initializer)
    
        my si:void_state_push
        my sym_COMMA
        my si:voidvalue_part
        my optional_688
        my si:valuevalue_part
        my i_status_fail ; # Undefined symbol 'initializer'
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'inline'
    #
    
    method sym_inline {} {
        # x
        #     "inline"
        #     (WHITESPACE)
    
        my si:void_symbol_start inline
        my sequence_704
        my si:void_leaf_symbol_end inline
        return
    }
    
    method sequence_704 {} {
        # x
        #     "inline"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str inline
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'int'
    #
    
    method sym_int {} {
        # x
        #     "int"
        #     (WHITESPACE)
    
        my si:void_symbol_start int
        my sequence_709
        my si:void_leaf_symbol_end int
        return
    }
    
    method sequence_709 {} {
        # x
        #     "int"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str int
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'int8_t'
    #
    
    method sym_int8_t {} {
        # x
        #     "int8_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start int8_t
        my sequence_714
        my si:void_leaf_symbol_end int8_t
        return
    }
    
    method sequence_714 {} {
        # x
        #     "int8_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str int8_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'int16_t'
    #
    
    method sym_int16_t {} {
        # x
        #     "int16_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start int16_t
        my sequence_719
        my si:void_leaf_symbol_end int16_t
        return
    }
    
    method sequence_719 {} {
        # x
        #     "int16_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str int16_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'int32_t'
    #
    
    method sym_int32_t {} {
        # x
        #     "int32_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start int32_t
        my sequence_724
        my si:void_leaf_symbol_end int32_t
        return
    }
    
    method sequence_724 {} {
        # x
        #     "int32_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str int32_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'int64_t'
    #
    
    method sym_int64_t {} {
        # x
        #     "int64_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start int64_t
        my sequence_729
        my si:void_leaf_symbol_end int64_t
        return
    }
    
    method sequence_729 {} {
        # x
        #     "int64_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str int64_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'int_fast8_t'
    #
    
    method sym_int_fast8_t {} {
        # x
        #     "int_fast8_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start int_fast8_t
        my sequence_734
        my si:void_leaf_symbol_end int_fast8_t
        return
    }
    
    method sequence_734 {} {
        # x
        #     "int_fast8_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str int_fast8_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'int_fast16_t'
    #
    
    method sym_int_fast16_t {} {
        # x
        #     "int_fast16_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start int_fast16_t
        my sequence_739
        my si:void_leaf_symbol_end int_fast16_t
        return
    }
    
    method sequence_739 {} {
        # x
        #     "int_fast16_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str int_fast16_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'int_fast32_t'
    #
    
    method sym_int_fast32_t {} {
        # x
        #     "int_fast32_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start int_fast32_t
        my sequence_744
        my si:void_leaf_symbol_end int_fast32_t
        return
    }
    
    method sequence_744 {} {
        # x
        #     "int_fast32_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str int_fast32_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'int_fast64_t'
    #
    
    method sym_int_fast64_t {} {
        # x
        #     "int_fast64_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start int_fast64_t
        my sequence_749
        my si:void_leaf_symbol_end int_fast64_t
        return
    }
    
    method sequence_749 {} {
        # x
        #     "int_fast64_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str int_fast64_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'int_least8_t'
    #
    
    method sym_int_least8_t {} {
        # x
        #     "int_least8_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start int_least8_t
        my sequence_754
        my si:void_leaf_symbol_end int_least8_t
        return
    }
    
    method sequence_754 {} {
        # x
        #     "int_least8_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str int_least8_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'int_least16_t'
    #
    
    method sym_int_least16_t {} {
        # x
        #     "int_least16_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start int_least16_t
        my sequence_759
        my si:void_leaf_symbol_end int_least16_t
        return
    }
    
    method sequence_759 {} {
        # x
        #     "int_least16_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str int_least16_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'int_least32_t'
    #
    
    method sym_int_least32_t {} {
        # x
        #     "int_least32_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start int_least32_t
        my sequence_764
        my si:void_leaf_symbol_end int_least32_t
        return
    }
    
    method sequence_764 {} {
        # x
        #     "int_least32_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str int_least32_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'int_least64_t'
    #
    
    method sym_int_least64_t {} {
        # x
        #     "int_least64_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start int_least64_t
        my sequence_769
        my si:void_leaf_symbol_end int_least64_t
        return
    }
    
    method sequence_769 {} {
        # x
        #     "int_least64_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str int_least64_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'integer_constant'
    #
    
    method sym_integer_constant {} {
        # /
        #     x
        #         (decimal_constant)
        #         ?
        #             (integer_suffix)
        #     x
        #         (octal_constant)
        #         ?
        #             (integer_suffix)
        #     x
        #         (hexadecimal_constant)
        #         ?
        #             (integer_suffix)
    
        my si:value_symbol_start integer_constant
        my choice_788
        my si:reduce_symbol_end integer_constant
        return
    }
    
    method choice_788 {} {
        # /
        #     x
        #         (decimal_constant)
        #         ?
        #             (integer_suffix)
        #     x
        #         (octal_constant)
        #         ?
        #             (integer_suffix)
        #     x
        #         (hexadecimal_constant)
        #         ?
        #             (integer_suffix)
    
        my si:value_state_push
        my sequence_776
        my si:valuevalue_branch
        my sequence_781
        my si:valuevalue_branch
        my sequence_786
        my si:value_state_merge
        return
    }
    
    method sequence_776 {} {
        # x
        #     (decimal_constant)
        #     ?
        #         (integer_suffix)
    
        my si:value_state_push
        my sym_decimal_constant
        my si:valuevalue_part
        my optional_774
        my si:value_state_merge
        return
    }
    
    method optional_774 {} {
        # ?
        #     (integer_suffix)
    
        my si:void2_state_push
        my sym_integer_suffix
        my si:void_state_merge_ok
        return
    }
    
    method sequence_781 {} {
        # x
        #     (octal_constant)
        #     ?
        #         (integer_suffix)
    
        my si:value_state_push
        my sym_octal_constant
        my si:valuevalue_part
        my optional_774
        my si:value_state_merge
        return
    }
    
    method sequence_786 {} {
        # x
        #     (hexadecimal_constant)
        #     ?
        #         (integer_suffix)
    
        my si:value_state_push
        my sym_hexadecimal_constant
        my si:valuevalue_part
        my optional_774
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'integer_suffix'
    #
    
    method sym_integer_suffix {} {
        # /
        #     x
        #         (unsigned_suffix)
        #         ?
        #             (long_suffix)
        #     x
        #         (unsigned_suffix)
        #         (long_long_suffix)
        #     x
        #         (long_suffix)
        #         ?
        #             (unsigned_suffix)
        #     x
        #         (long_long_suffix)
        #         ?
        #             (unsigned_suffix)
    
        my si:value_symbol_start integer_suffix
        my choice_812
        my si:reduce_symbol_end integer_suffix
        return
    }
    
    method choice_812 {} {
        # /
        #     x
        #         (unsigned_suffix)
        #         ?
        #             (long_suffix)
        #     x
        #         (unsigned_suffix)
        #         (long_long_suffix)
        #     x
        #         (long_suffix)
        #         ?
        #             (unsigned_suffix)
        #     x
        #         (long_long_suffix)
        #         ?
        #             (unsigned_suffix)
    
        my si:value_state_push
        my sequence_795
        my si:valuevalue_branch
        my sequence_799
        my si:valuevalue_branch
        my sequence_805
        my si:valuevalue_branch
        my sequence_810
        my si:value_state_merge
        return
    }
    
    method sequence_795 {} {
        # x
        #     (unsigned_suffix)
        #     ?
        #         (long_suffix)
    
        my si:value_state_push
        my sym_unsigned_suffix
        my si:valuevalue_part
        my optional_793
        my si:value_state_merge
        return
    }
    
    method optional_793 {} {
        # ?
        #     (long_suffix)
    
        my si:void2_state_push
        my sym_long_suffix
        my si:void_state_merge_ok
        return
    }
    
    method sequence_799 {} {
        # x
        #     (unsigned_suffix)
        #     (long_long_suffix)
    
        my si:value_state_push
        my sym_unsigned_suffix
        my si:valuevalue_part
        my sym_long_long_suffix
        my si:value_state_merge
        return
    }
    
    method sequence_805 {} {
        # x
        #     (long_suffix)
        #     ?
        #         (unsigned_suffix)
    
        my si:value_state_push
        my sym_long_suffix
        my si:valuevalue_part
        my optional_803
        my si:value_state_merge
        return
    }
    
    method optional_803 {} {
        # ?
        #     (unsigned_suffix)
    
        my si:void2_state_push
        my sym_unsigned_suffix
        my si:void_state_merge_ok
        return
    }
    
    method sequence_810 {} {
        # x
        #     (long_long_suffix)
        #     ?
        #         (unsigned_suffix)
    
        my si:value_state_push
        my sym_long_long_suffix
        my si:valuevalue_part
        my optional_803
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'intmax_t'
    #
    
    method sym_intmax_t {} {
        # x
        #     "intmax_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start intmax_t
        my sequence_817
        my si:void_leaf_symbol_end intmax_t
        return
    }
    
    method sequence_817 {} {
        # x
        #     "intmax_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str intmax_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'intptr_t'
    #
    
    method sym_intptr_t {} {
        # x
        #     "intptr_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start intptr_t
        my sequence_822
        my si:void_leaf_symbol_end intptr_t
        return
    }
    
    method sequence_822 {} {
        # x
        #     "intptr_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str intptr_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'keyword'
    #
    
    method sym_keyword {} {
        # /
        #     "auto"
        #     "break"
        #     "case"
        #     "char"
        #     "const"
        #     "continue"
        #     "default"
        #     "do"
        #     "double"
        #     "else"
        #     "enum"
        #     "extern"
        #     "float"
        #     "for"
        #     "goto"
        #     "if"
        #     "inline"
        #     "int"
        #     "long"
        #     "register"
        #     "restrict"
        #     "return"
        #     "short"
        #     "signed"
        #     "sizeof"
        #     "static"
        #     "struct"
        #     "switch"
        #     "typedef"
        #     "union"
        #     "unsigned"
        #     "void"
        #     "volatile"
        #     "while"
        #     "_Bool"
        #     "bool"
        #     "_Complex"
        #     "complex"
        #     "_Imaginary"
        #     "imaginary"
        #     "_Atomic"
        #     "atomic"
    
        my si:void_symbol_start keyword
        my choice_867
        my si:void_leaf_symbol_end keyword
        return
    }
    
    method choice_867 {} {
        # /
        #     "auto"
        #     "break"
        #     "case"
        #     "char"
        #     "const"
        #     "continue"
        #     "default"
        #     "do"
        #     "double"
        #     "else"
        #     "enum"
        #     "extern"
        #     "float"
        #     "for"
        #     "goto"
        #     "if"
        #     "inline"
        #     "int"
        #     "long"
        #     "register"
        #     "restrict"
        #     "return"
        #     "short"
        #     "signed"
        #     "sizeof"
        #     "static"
        #     "struct"
        #     "switch"
        #     "typedef"
        #     "union"
        #     "unsigned"
        #     "void"
        #     "volatile"
        #     "while"
        #     "_Bool"
        #     "bool"
        #     "_Complex"
        #     "complex"
        #     "_Imaginary"
        #     "imaginary"
        #     "_Atomic"
        #     "atomic"
    
        my si:void_state_push
        my si:next_str auto
        my si:voidvoid_branch
        my si:next_str break
        my si:voidvoid_branch
        my si:next_str case
        my si:voidvoid_branch
        my si:next_str char
        my si:voidvoid_branch
        my si:next_str const
        my si:voidvoid_branch
        my si:next_str continue
        my si:voidvoid_branch
        my si:next_str default
        my si:voidvoid_branch
        my si:next_str do
        my si:voidvoid_branch
        my si:next_str double
        my si:voidvoid_branch
        my si:next_str else
        my si:voidvoid_branch
        my si:next_str enum
        my si:voidvoid_branch
        my si:next_str extern
        my si:voidvoid_branch
        my si:next_str float
        my si:voidvoid_branch
        my si:next_str for
        my si:voidvoid_branch
        my si:next_str goto
        my si:voidvoid_branch
        my si:next_str if
        my si:voidvoid_branch
        my si:next_str inline
        my si:voidvoid_branch
        my si:next_str int
        my si:voidvoid_branch
        my si:next_str long
        my si:voidvoid_branch
        my si:next_str register
        my si:voidvoid_branch
        my si:next_str restrict
        my si:voidvoid_branch
        my si:next_str return
        my si:voidvoid_branch
        my si:next_str short
        my si:voidvoid_branch
        my si:next_str signed
        my si:voidvoid_branch
        my si:next_str sizeof
        my si:voidvoid_branch
        my si:next_str static
        my si:voidvoid_branch
        my si:next_str struct
        my si:voidvoid_branch
        my si:next_str switch
        my si:voidvoid_branch
        my si:next_str typedef
        my si:voidvoid_branch
        my si:next_str union
        my si:voidvoid_branch
        my si:next_str unsigned
        my si:voidvoid_branch
        my si:next_str void
        my si:voidvoid_branch
        my si:next_str volatile
        my si:voidvoid_branch
        my si:next_str while
        my si:voidvoid_branch
        my si:next_str _Bool
        my si:voidvoid_branch
        my si:next_str bool
        my si:voidvoid_branch
        my si:next_str _Complex
        my si:voidvoid_branch
        my si:next_str complex
        my si:voidvoid_branch
        my si:next_str _Imaginary
        my si:voidvoid_branch
        my si:next_str imaginary
        my si:voidvoid_branch
        my si:next_str _Atomic
        my si:voidvoid_branch
        my si:next_str atomic
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'LBRACE'
    #
    
    method sym_LBRACE {} {
        # x
        #     '\{'
        #     (WHITESPACE)
    
        my si:void_symbol_start LBRACE
        my sequence_872
        my si:void_leaf_symbol_end LBRACE
        return
    }
    
    method sequence_872 {} {
        # x
        #     '\{'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char \173
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'LBRACKET'
    #
    
    method sym_LBRACKET {} {
        # x
        #     '['
        #     (WHITESPACE)
    
        my si:void_symbol_start LBRACKET
        my sequence_877
        my si:void_leaf_symbol_end LBRACKET
        return
    }
    
    method sequence_877 {} {
        # x
        #     '['
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char \133
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'LESS'
    #
    
    method sym_LESS {} {
        # x
        #     '<'
        #     (WHITESPACE)
    
        my si:void_symbol_start LESS
        my sequence_882
        my si:void_leaf_symbol_end LESS
        return
    }
    
    method sequence_882 {} {
        # x
        #     '<'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char <
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'LESSEQUAL'
    #
    
    method sym_LESSEQUAL {} {
        # x
        #     "<="
        #     (WHITESPACE)
    
        my si:void_symbol_start LESSEQUAL
        my sequence_887
        my si:void_leaf_symbol_end LESSEQUAL
        return
    }
    
    method sequence_887 {} {
        # x
        #     "<="
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str <=
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'LESSLESS'
    #
    
    method sym_LESSLESS {} {
        # x
        #     "<<"
        #     (WHITESPACE)
    
        my si:void_symbol_start LESSLESS
        my sequence_892
        my si:void_leaf_symbol_end LESSLESS
        return
    }
    
    method sequence_892 {} {
        # x
        #     "<<"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str <<
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'LESSLESSEQUAL'
    #
    
    method sym_LESSLESSEQUAL {} {
        # x
        #     "<<="
        #     (WHITESPACE)
    
        my si:void_symbol_start LESSLESSEQUAL
        my sequence_897
        my si:void_leaf_symbol_end LESSLESSEQUAL
        return
    }
    
    method sequence_897 {} {
        # x
        #     "<<="
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str <<=
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'logical_AND_expression'
    #
    
    method sym_logical_AND_expression {} {
        # x
        #     (inclusive_OR_expression)
        #     *
        #         x
        #             (ANDAND)
        #             (inclusive_OR_expression)
    
        my si:value_symbol_start logical_AND_expression
        my sequence_907
        my si:reduce_symbol_end logical_AND_expression
        return
    }
    
    method sequence_907 {} {
        # x
        #     (inclusive_OR_expression)
        #     *
        #         x
        #             (ANDAND)
        #             (inclusive_OR_expression)
    
        my si:value_state_push
        my sym_inclusive_OR_expression
        my si:valuevalue_part
        my kleene_905
        my si:value_state_merge
        return
    }
    
    method kleene_905 {} {
        # *
        #     x
        #         (ANDAND)
        #         (inclusive_OR_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_903
            my si:kleene_close
        }
        return
    }
    
    method sequence_903 {} {
        # x
        #     (ANDAND)
        #     (inclusive_OR_expression)
    
        my si:value_state_push
        my sym_ANDAND
        my si:valuevalue_part
        my sym_inclusive_OR_expression
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'logical_OR_expression'
    #
    
    method sym_logical_OR_expression {} {
        # x
        #     (logical_AND_expression)
        #     *
        #         x
        #             (BARBAR)
        #             (logical_AND_expression)
    
        my si:value_symbol_start logical_OR_expression
        my sequence_917
        my si:reduce_symbol_end logical_OR_expression
        return
    }
    
    method sequence_917 {} {
        # x
        #     (logical_AND_expression)
        #     *
        #         x
        #             (BARBAR)
        #             (logical_AND_expression)
    
        my si:value_state_push
        my sym_logical_AND_expression
        my si:valuevalue_part
        my kleene_915
        my si:value_state_merge
        return
    }
    
    method kleene_915 {} {
        # *
        #     x
        #         (BARBAR)
        #         (logical_AND_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_913
            my si:kleene_close
        }
        return
    }
    
    method sequence_913 {} {
        # x
        #     (BARBAR)
        #     (logical_AND_expression)
    
        my si:value_state_push
        my sym_BARBAR
        my si:valuevalue_part
        my sym_logical_AND_expression
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'long'
    #
    
    method sym_long {} {
        # x
        #     "long"
        #     (WHITESPACE)
    
        my si:void_symbol_start long
        my sequence_922
        my si:void_leaf_symbol_end long
        return
    }
    
    method sequence_922 {} {
        # x
        #     "long"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str long
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'long_long_suffix'
    #
    
    method sym_long_long_suffix {} {
        # /
        #     "ll"
        #     "LL"
    
        my si:void_symbol_start long_long_suffix
        my choice_927
        my si:void_leaf_symbol_end long_long_suffix
        return
    }
    
    method choice_927 {} {
        # /
        #     "ll"
        #     "LL"
    
        my si:void_state_push
        my si:next_str ll
        my si:voidvoid_branch
        my si:next_str LL
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'long_suffix'
    #
    
    method sym_long_suffix {} {
        # [lL]
    
        my si:void_symbol_start long_suffix
        my si:next_class lL
        my si:void_leaf_symbol_end long_suffix
        return
    }
    
    #
    # leaf Symbol 'LPAREN'
    #
    
    method sym_LPAREN {} {
        # x
        #     '\('
        #     (WHITESPACE)
    
        my si:void_symbol_start LPAREN
        my sequence_934
        my si:void_leaf_symbol_end LPAREN
        return
    }
    
    method sequence_934 {} {
        # x
        #     '\('
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char \50
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'MINUS'
    #
    
    method sym_MINUS {} {
        # x
        #     '-'
        #     (WHITESPACE)
    
        my si:void_symbol_start MINUS
        my sequence_939
        my si:void_leaf_symbol_end MINUS
        return
    }
    
    method sequence_939 {} {
        # x
        #     '-'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char -
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'MINUSEQUAL'
    #
    
    method sym_MINUSEQUAL {} {
        # x
        #     "-="
        #     (WHITESPACE)
    
        my si:void_symbol_start MINUSEQUAL
        my sequence_944
        my si:void_leaf_symbol_end MINUSEQUAL
        return
    }
    
    method sequence_944 {} {
        # x
        #     "-="
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str -=
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'MINUSMINUS'
    #
    
    method sym_MINUSMINUS {} {
        # x
        #     "--"
        #     (WHITESPACE)
    
        my si:void_symbol_start MINUSMINUS
        my sequence_949
        my si:void_leaf_symbol_end MINUSMINUS
        return
    }
    
    method sequence_949 {} {
        # x
        #     "--"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str --
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'multiplicative_expression'
    #
    
    method sym_multiplicative_expression {} {
        # x
        #     (cast_expression)
        #     *
        #         x
        #             /
        #                 (STAR)
        #                 (SLASH)
        #                 (PERCENT)
        #             (cast_expression)
    
        my si:value_symbol_start multiplicative_expression
        my sequence_963
        my si:reduce_symbol_end multiplicative_expression
        return
    }
    
    method sequence_963 {} {
        # x
        #     (cast_expression)
        #     *
        #         x
        #             /
        #                 (STAR)
        #                 (SLASH)
        #                 (PERCENT)
        #             (cast_expression)
    
        my si:value_state_push
        my sym_cast_expression
        my si:valuevalue_part
        my kleene_961
        my si:value_state_merge
        return
    }
    
    method kleene_961 {} {
        # *
        #     x
        #         /
        #             (STAR)
        #             (SLASH)
        #             (PERCENT)
        #         (cast_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_959
            my si:kleene_close
        }
        return
    }
    
    method sequence_959 {} {
        # x
        #     /
        #         (STAR)
        #         (SLASH)
        #         (PERCENT)
        #     (cast_expression)
    
        my si:value_state_push
        my choice_956
        my si:valuevalue_part
        my sym_cast_expression
        my si:value_state_merge
        return
    }
    
    method choice_956 {} {
        # /
        #     (STAR)
        #     (SLASH)
        #     (PERCENT)
    
        my si:value_state_push
        my sym_STAR
        my si:valuevalue_branch
        my sym_SLASH
        my si:valuevoid_branch
        my i_status_fail ; # Undefined symbol 'PERCENT'
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'nonzero_digit'
    #
    
    method sym_nonzero_digit {} {
        # range (1 .. 9)
    
        my si:void_symbol_start nonzero_digit
        my si:next_range 1 9
        my si:void_leaf_symbol_end nonzero_digit
        return
    }
    
    #
    # value Symbol 'octal_constant'
    #
    
    method sym_octal_constant {} {
        # x
        #     '0'
        #     *
        #         (octal_digit)
    
        my si:value_symbol_start octal_constant
        my sequence_972
        my si:reduce_symbol_end octal_constant
        return
    }
    
    method sequence_972 {} {
        # x
        #     '0'
        #     *
        #         (octal_digit)
    
        my si:void_state_push
        my si:next_char 0
        my si:voidvalue_part
        my kleene_970
        my si:value_state_merge
        return
    }
    
    method kleene_970 {} {
        # *
        #     (octal_digit)
    
        while {1} {
            my si:void2_state_push
        my sym_octal_digit
            my si:kleene_close
        }
        return
    }
    
    #
    # value Symbol 'octal_digit'
    #
    
    method sym_octal_digit {} {
        # range (0 .. 7)
    
        my si:void_symbol_start octal_digit
        my si:next_range 0 7
        my si:void_leaf_symbol_end octal_digit
        return
    }
    
    #
    # value Symbol 'octal_escape_sequence'
    #
    
    method sym_octal_escape_sequence {} {
        # /
        #     x
        #         '\'
        #         (octal_digit)
        #     x
        #         '\'
        #         (octal_digit)
        #         (octal_digit)
        #     x
        #         '\'
        #         (octal_digit)
        #         (octal_digit)
        #         (octal_digit)
    
        my si:value_symbol_start octal_escape_sequence
        my choice_992
        my si:reduce_symbol_end octal_escape_sequence
        return
    }
    
    method choice_992 {} {
        # /
        #     x
        #         '\'
        #         (octal_digit)
        #     x
        #         '\'
        #         (octal_digit)
        #         (octal_digit)
        #     x
        #         '\'
        #         (octal_digit)
        #         (octal_digit)
        #         (octal_digit)
    
        my si:value_state_push
        my sequence_979
        my si:valuevalue_branch
        my sequence_984
        my si:valuevalue_branch
        my sequence_990
        my si:value_state_merge
        return
    }
    
    method sequence_979 {} {
        # x
        #     '\'
        #     (octal_digit)
    
        my si:void_state_push
        my si:next_char \134
        my si:voidvalue_part
        my sym_octal_digit
        my si:value_state_merge
        return
    }
    
    method sequence_984 {} {
        # x
        #     '\'
        #     (octal_digit)
        #     (octal_digit)
    
        my si:void_state_push
        my si:next_char \134
        my si:voidvalue_part
        my sym_octal_digit
        my si:valuevalue_part
        my sym_octal_digit
        my si:value_state_merge
        return
    }
    
    method sequence_990 {} {
        # x
        #     '\'
        #     (octal_digit)
        #     (octal_digit)
        #     (octal_digit)
    
        my si:void_state_push
        my si:next_char \134
        my si:voidvalue_part
        my sym_octal_digit
        my si:valuevalue_part
        my sym_octal_digit
        my si:valuevalue_part
        my sym_octal_digit
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'parameter_declaration'
    #
    
    method sym_parameter_declaration {} {
        # /
        #     x
        #         (declaration_specifiers)
        #         (declarator)
        #     x
        #         (declaration_specifiers)
        #         ?
        #             (abstract_declarator)
    
        my si:value_symbol_start parameter_declaration
        my choice_1005
        my si:reduce_symbol_end parameter_declaration
        return
    }
    
    method choice_1005 {} {
        # /
        #     x
        #         (declaration_specifiers)
        #         (declarator)
        #     x
        #         (declaration_specifiers)
        #         ?
        #             (abstract_declarator)
    
        my si:value_state_push
        my sequence_997
        my si:valuevalue_branch
        my sequence_1003
        my si:value_state_merge
        return
    }
    
    method sequence_997 {} {
        # x
        #     (declaration_specifiers)
        #     (declarator)
    
        my si:value_state_push
        my sym_declaration_specifiers
        my si:valuevalue_part
        my sym_declarator
        my si:value_state_merge
        return
    }
    
    method sequence_1003 {} {
        # x
        #     (declaration_specifiers)
        #     ?
        #         (abstract_declarator)
    
        my si:value_state_push
        my sym_declaration_specifiers
        my si:valuevalue_part
        my optional_1001
        my si:value_state_merge
        return
    }
    
    method optional_1001 {} {
        # ?
        #     (abstract_declarator)
    
        my si:void2_state_push
        my sym_abstract_declarator
        my si:void_state_merge_ok
        return
    }
    
    #
    # value Symbol 'parameter_list'
    #
    
    method sym_parameter_list {} {
        # x
        #     (parameter_declaration)
        #     *
        #         x
        #             (COMMA)
        #             (parameter_declaration)
    
        my si:value_symbol_start parameter_list
        my sequence_1015
        my si:reduce_symbol_end parameter_list
        return
    }
    
    method sequence_1015 {} {
        # x
        #     (parameter_declaration)
        #     *
        #         x
        #             (COMMA)
        #             (parameter_declaration)
    
        my si:value_state_push
        my sym_parameter_declaration
        my si:valuevalue_part
        my kleene_1013
        my si:value_state_merge
        return
    }
    
    method kleene_1013 {} {
        # *
        #     x
        #         (COMMA)
        #         (parameter_declaration)
    
        while {1} {
            my si:void2_state_push
        my sequence_1011
            my si:kleene_close
        }
        return
    }
    
    method sequence_1011 {} {
        # x
        #     (COMMA)
        #     (parameter_declaration)
    
        my si:void_state_push
        my sym_COMMA
        my si:voidvalue_part
        my sym_parameter_declaration
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'parameter_type_list'
    #
    
    method sym_parameter_type_list {} {
        # x
        #     (parameter_list)
        #     ?
        #         x
        #             (COMMA)
        #             (ELLIPSIS)
    
        my si:value_symbol_start parameter_type_list
        my sequence_1025
        my si:reduce_symbol_end parameter_type_list
        return
    }
    
    method sequence_1025 {} {
        # x
        #     (parameter_list)
        #     ?
        #         x
        #             (COMMA)
        #             (ELLIPSIS)
    
        my si:value_state_push
        my sym_parameter_list
        my si:valuevalue_part
        my optional_1023
        my si:value_state_merge
        return
    }
    
    method optional_1023 {} {
        # ?
        #     x
        #         (COMMA)
        #         (ELLIPSIS)
    
        my si:void2_state_push
        my sequence_1021
        my si:void_state_merge_ok
        return
    }
    
    method sequence_1021 {} {
        # x
        #     (COMMA)
        #     (ELLIPSIS)
    
        my si:void_state_push
        my sym_COMMA
        my si:voidvalue_part
        my sym_ELLIPSIS
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'PERCEN'
    #
    
    method sym_PERCEN {} {
        # x
        #     '%'
        #     (WHITESPACE)
    
        my si:void_symbol_start PERCEN
        my sequence_1030
        my si:void_leaf_symbol_end PERCEN
        return
    }
    
    method sequence_1030 {} {
        # x
        #     '%'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char %
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'PERCENTEQUAL'
    #
    
    method sym_PERCENTEQUAL {} {
        # x
        #     "%="
        #     (WHITESPACE)
    
        my si:void_symbol_start PERCENTEQUAL
        my sequence_1035
        my si:void_leaf_symbol_end PERCENTEQUAL
        return
    }
    
    method sequence_1035 {} {
        # x
        #     "%="
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str %=
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'PLING'
    #
    
    method sym_PLING {} {
        # x
        #     '!'
        #     (WHITESPACE)
    
        my si:void_symbol_start PLING
        my sequence_1040
        my si:void_leaf_symbol_end PLING
        return
    }
    
    method sequence_1040 {} {
        # x
        #     '!'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char !
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'PLINGEQUAL'
    #
    
    method sym_PLINGEQUAL {} {
        # x
        #     "!="
        #     (WHITESPACE)
    
        my si:void_symbol_start PLINGEQUAL
        my sequence_1045
        my si:void_leaf_symbol_end PLINGEQUAL
        return
    }
    
    method sequence_1045 {} {
        # x
        #     "!="
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str !=
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'PLUS'
    #
    
    method sym_PLUS {} {
        # x
        #     '+'
        #     (WHITESPACE)
    
        my si:void_symbol_start PLUS
        my sequence_1050
        my si:void_leaf_symbol_end PLUS
        return
    }
    
    method sequence_1050 {} {
        # x
        #     '+'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char +
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'PLUSEQUAL'
    #
    
    method sym_PLUSEQUAL {} {
        # x
        #     "+="
        #     (WHITESPACE)
    
        my si:void_symbol_start PLUSEQUAL
        my sequence_1055
        my si:void_leaf_symbol_end PLUSEQUAL
        return
    }
    
    method sequence_1055 {} {
        # x
        #     "+="
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str +=
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'PLUSPLUS'
    #
    
    method sym_PLUSPLUS {} {
        # x
        #     "++"
        #     (WHITESPACE)
    
        my si:void_symbol_start PLUSPLUS
        my sequence_1060
        my si:void_leaf_symbol_end PLUSPLUS
        return
    }
    
    method sequence_1060 {} {
        # x
        #     "++"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str ++
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'pointer'
    #
    
    method sym_pointer {} {
        # +
        #     x
        #         (STAR)
        #         ?
        #             (type_qualifier_list)
    
        my si:value_symbol_start pointer
        my poskleene_1068
        my si:reduce_symbol_end pointer
        return
    }
    
    method poskleene_1068 {} {
        # +
        #     x
        #         (STAR)
        #         ?
        #             (type_qualifier_list)
    
        my i_loc_push
        my sequence_1066
        my si:kleene_abort
        while {1} {
            my si:void2_state_push
        my sequence_1066
            my si:kleene_close
        }
        return
    }
    
    method sequence_1066 {} {
        # x
        #     (STAR)
        #     ?
        #         (type_qualifier_list)
    
        my si:value_state_push
        my sym_STAR
        my si:valuevalue_part
        my optional_360
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'postfix_expression'
    #
    
    method sym_postfix_expression {} {
        # x
        #     (postfix_expression_head)
        #     *
        #         (postfix_expression_tail)
    
        my si:value_symbol_start postfix_expression
        my sequence_1075
        my si:reduce_symbol_end postfix_expression
        return
    }
    
    method sequence_1075 {} {
        # x
        #     (postfix_expression_head)
        #     *
        #         (postfix_expression_tail)
    
        my si:value_state_push
        my sym_postfix_expression_head
        my si:valuevalue_part
        my kleene_1073
        my si:value_state_merge
        return
    }
    
    method kleene_1073 {} {
        # *
        #     (postfix_expression_tail)
    
        while {1} {
            my si:void2_state_push
        my sym_postfix_expression_tail
            my si:kleene_close
        }
        return
    }
    
    #
    # value Symbol 'postfix_expression_head'
    #
    
    method sym_postfix_expression_head {} {
        # /
        #     (primary_expression)
        #     x
        #         (LPAREN)
        #         (type_name)
        #         (RPAREN)
        #         (LBRACE)
        #         (initializer_list)
        #         (RBRACE)
        #     x
        #         (LPAREN)
        #         (type_name)
        #         (RPAREN)
        #         (LBRACE)
        #         (initializer_list)
        #         (COMMA)
        #         (RBRACE)
    
        my si:value_symbol_start postfix_expression_head
        my choice_1096
        my si:reduce_symbol_end postfix_expression_head
        return
    }
    
    method choice_1096 {} {
        # /
        #     (primary_expression)
        #     x
        #         (LPAREN)
        #         (type_name)
        #         (RPAREN)
        #         (LBRACE)
        #         (initializer_list)
        #         (RBRACE)
        #     x
        #         (LPAREN)
        #         (type_name)
        #         (RPAREN)
        #         (LBRACE)
        #         (initializer_list)
        #         (COMMA)
        #         (RBRACE)
    
        my si:value_state_push
        my sym_primary_expression
        my si:valuevalue_branch
        my sequence_1085
        my si:valuevalue_branch
        my sequence_1094
        my si:value_state_merge
        return
    }
    
    method sequence_1085 {} {
        # x
        #     (LPAREN)
        #     (type_name)
        #     (RPAREN)
        #     (LBRACE)
        #     (initializer_list)
        #     (RBRACE)
    
        my si:value_state_push
        my sym_LPAREN
        my si:valuevalue_part
        my sym_type_name
        my si:valuevalue_part
        my sym_RPAREN
        my si:valuevalue_part
        my sym_LBRACE
        my si:valuevalue_part
        my sym_initializer_list
        my si:valuevalue_part
        my sym_RBRACE
        my si:value_state_merge
        return
    }
    
    method sequence_1094 {} {
        # x
        #     (LPAREN)
        #     (type_name)
        #     (RPAREN)
        #     (LBRACE)
        #     (initializer_list)
        #     (COMMA)
        #     (RBRACE)
    
        my si:value_state_push
        my sym_LPAREN
        my si:valuevalue_part
        my sym_type_name
        my si:valuevalue_part
        my sym_RPAREN
        my si:valuevalue_part
        my sym_LBRACE
        my si:valuevalue_part
        my sym_initializer_list
        my si:valuevalue_part
        my sym_COMMA
        my si:valuevalue_part
        my sym_RBRACE
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'postfix_expression_tail'
    #
    
    method sym_postfix_expression_tail {} {
        # /
        #     x
        #         (LBRACKET)
        #         (expression)
        #         (RBRACKET)
        #     x
        #         (LPAREN)
        #         ?
        #             (argument_expression_list)
        #         (RPAREN)
        #     x
        #         (DOT)
        #         (identifier)
        #     x
        #         (ARROW)
        #         (identifier)
        #     (PLUSPLUS)
        #     (MINUSMINUS)
    
        my si:value_symbol_start postfix_expression_tail
        my choice_1120
        my si:reduce_symbol_end postfix_expression_tail
        return
    }
    
    method choice_1120 {} {
        # /
        #     x
        #         (LBRACKET)
        #         (expression)
        #         (RBRACKET)
        #     x
        #         (LPAREN)
        #         ?
        #             (argument_expression_list)
        #         (RPAREN)
        #     x
        #         (DOT)
        #         (identifier)
        #     x
        #         (ARROW)
        #         (identifier)
        #     (PLUSPLUS)
        #     (MINUSMINUS)
    
        my si:value_state_push
        my sequence_1102
        my si:valuevalue_branch
        my sequence_1109
        my si:valuevalue_branch
        my sequence_300
        my si:valuevalue_branch
        my sequence_1116
        my si:valuevalue_branch
        my sym_PLUSPLUS
        my si:valuevalue_branch
        my sym_MINUSMINUS
        my si:value_state_merge
        return
    }
    
    method sequence_1102 {} {
        # x
        #     (LBRACKET)
        #     (expression)
        #     (RBRACKET)
    
        my si:value_state_push
        my sym_LBRACKET
        my si:valuevalue_part
        my sym_expression
        my si:valuevalue_part
        my sym_RBRACKET
        my si:value_state_merge
        return
    }
    
    method sequence_1109 {} {
        # x
        #     (LPAREN)
        #     ?
        #         (argument_expression_list)
        #     (RPAREN)
    
        my si:value_state_push
        my sym_LPAREN
        my si:valuevalue_part
        my optional_1106
        my si:valuevalue_part
        my sym_RPAREN
        my si:value_state_merge
        return
    }
    
    method optional_1106 {} {
        # ?
        #     (argument_expression_list)
    
        my si:void2_state_push
        my sym_argument_expression_list
        my si:void_state_merge_ok
        return
    }
    
    method sequence_1116 {} {
        # x
        #     (ARROW)
        #     (identifier)
    
        my si:value_state_push
        my sym_ARROW
        my si:valuevalue_part
        my sym_identifier
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'primary_expression'
    #
    
    method sym_primary_expression {} {
        # /
        #     (identifier)
        #     (constant)
        #     (string_literal)
        #     x
        #         (LPAREN)
        #         (expression)
        #         (RPAREN)
    
        my si:value_symbol_start primary_expression
        my choice_1131
        my si:reduce_symbol_end primary_expression
        return
    }
    
    method choice_1131 {} {
        # /
        #     (identifier)
        #     (constant)
        #     (string_literal)
        #     x
        #         (LPAREN)
        #         (expression)
        #         (RPAREN)
    
        my si:value_state_push
        my sym_identifier
        my si:valuevalue_branch
        my sym_constant
        my si:valuevalue_branch
        my sym_string_literal
        my si:valuevalue_branch
        my sequence_1129
        my si:value_state_merge
        return
    }
    
    method sequence_1129 {} {
        # x
        #     (LPAREN)
        #     (expression)
        #     (RPAREN)
    
        my si:value_state_push
        my sym_LPAREN
        my si:valuevalue_part
        my sym_expression
        my si:valuevalue_part
        my sym_RPAREN
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'ptrdiff_t'
    #
    
    method sym_ptrdiff_t {} {
        # x
        #     "ptrdiff_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start ptrdiff_t
        my sequence_1136
        my si:void_leaf_symbol_end ptrdiff_t
        return
    }
    
    method sequence_1136 {} {
        # x
        #     "ptrdiff_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str ptrdiff_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'QUERY'
    #
    
    method sym_QUERY {} {
        # x
        #     '?'
        #     (WHITESPACE)
    
        my si:void_symbol_start QUERY
        my sequence_1141
        my si:void_leaf_symbol_end QUERY
        return
    }
    
    method sequence_1141 {} {
        # x
        #     '?'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char ?
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'RBRACE'
    #
    
    method sym_RBRACE {} {
        # x
        #     '\}'
        #     (WHITESPACE)
    
        my si:void_symbol_start RBRACE
        my sequence_1146
        my si:void_leaf_symbol_end RBRACE
        return
    }
    
    method sequence_1146 {} {
        # x
        #     '\}'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char \175
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'RBRACKET'
    #
    
    method sym_RBRACKET {} {
        # x
        #     ']'
        #     (WHITESPACE)
    
        my si:void_symbol_start RBRACKET
        my sequence_1151
        my si:void_leaf_symbol_end RBRACKET
        return
    }
    
    method sequence_1151 {} {
        # x
        #     ']'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char \135
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'register'
    #
    
    method sym_register {} {
        # x
        #     "register"
        #     (WHITESPACE)
    
        my si:void_symbol_start register
        my sequence_1156
        my si:void_leaf_symbol_end register
        return
    }
    
    method sequence_1156 {} {
        # x
        #     "register"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str register
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'relational_expression'
    #
    
    method sym_relational_expression {} {
        # x
        #     (shift_expression)
        #     *
        #         x
        #             /
        #                 (LESSEQUAL)
        #                 (GREATEREQUAL)
        #                 (LESS)
        #                 (GREATER)
        #             (shift_expression)
    
        my si:value_symbol_start relational_expression
        my sequence_1171
        my si:reduce_symbol_end relational_expression
        return
    }
    
    method sequence_1171 {} {
        # x
        #     (shift_expression)
        #     *
        #         x
        #             /
        #                 (LESSEQUAL)
        #                 (GREATEREQUAL)
        #                 (LESS)
        #                 (GREATER)
        #             (shift_expression)
    
        my si:value_state_push
        my sym_shift_expression
        my si:valuevalue_part
        my kleene_1169
        my si:value_state_merge
        return
    }
    
    method kleene_1169 {} {
        # *
        #     x
        #         /
        #             (LESSEQUAL)
        #             (GREATEREQUAL)
        #             (LESS)
        #             (GREATER)
        #         (shift_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_1167
            my si:kleene_close
        }
        return
    }
    
    method sequence_1167 {} {
        # x
        #     /
        #         (LESSEQUAL)
        #         (GREATEREQUAL)
        #         (LESS)
        #         (GREATER)
        #     (shift_expression)
    
        my si:value_state_push
        my choice_1164
        my si:valuevalue_part
        my sym_shift_expression
        my si:value_state_merge
        return
    }
    
    method choice_1164 {} {
        # /
        #     (LESSEQUAL)
        #     (GREATEREQUAL)
        #     (LESS)
        #     (GREATER)
    
        my si:value_state_push
        my sym_LESSEQUAL
        my si:valuevalue_branch
        my sym_GREATEREQUAL
        my si:valuevalue_branch
        my sym_LESS
        my si:valuevalue_branch
        my sym_GREATER
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'restrict'
    #
    
    method sym_restrict {} {
        # x
        #     "restrict"
        #     (WHITESPACE)
    
        my si:void_symbol_start restrict
        my sequence_1176
        my si:void_leaf_symbol_end restrict
        return
    }
    
    method sequence_1176 {} {
        # x
        #     "restrict"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str restrict
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'RPAREN'
    #
    
    method sym_RPAREN {} {
        # x
        #     '\)'
        #     (WHITESPACE)
    
        my si:void_symbol_start RPAREN
        my sequence_1181
        my si:void_leaf_symbol_end RPAREN
        return
    }
    
    method sequence_1181 {} {
        # x
        #     '\)'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char \51
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 's_char'
    #
    
    method sym_s_char {} {
        # /
        #     [^\"\\n\r]
        #     (escape_sequence)
    
        my si:value_symbol_start s_char
        my choice_1186
        my si:reduce_symbol_end s_char
        return
    }
    
    method choice_1186 {} {
        # /
        #     [^\"\\n\r]
        #     (escape_sequence)
    
        my si:void_state_push
        my si:next_class ^\42\134\n\r
        my si:voidvalue_branch
        my sym_escape_sequence
        my si:value_state_merge
        return
    }
    
    #
    # void Symbol 'SEMICOLON'
    #
    
    method sym_SEMICOLON {} {
        # x
        #     ';'
        #     (WHITESPACE)
    
        my si:void_void_symbol_start SEMICOLON
        my sequence_1191
        my si:void_clear_symbol_end SEMICOLON
        return
    }
    
    method sequence_1191 {} {
        # x
        #     ';'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char \73
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'shift_expression'
    #
    
    method sym_shift_expression {} {
        # x
        #     (additive_expression)
        #     *
        #         x
        #             /
        #                 (LESSLESS)
        #                 (GREATERGREATER)
        #             (additive_expression)
    
        my si:value_symbol_start shift_expression
        my sequence_1204
        my si:reduce_symbol_end shift_expression
        return
    }
    
    method sequence_1204 {} {
        # x
        #     (additive_expression)
        #     *
        #         x
        #             /
        #                 (LESSLESS)
        #                 (GREATERGREATER)
        #             (additive_expression)
    
        my si:value_state_push
        my sym_additive_expression
        my si:valuevalue_part
        my kleene_1202
        my si:value_state_merge
        return
    }
    
    method kleene_1202 {} {
        # *
        #     x
        #         /
        #             (LESSLESS)
        #             (GREATERGREATER)
        #         (additive_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_1200
            my si:kleene_close
        }
        return
    }
    
    method sequence_1200 {} {
        # x
        #     /
        #         (LESSLESS)
        #         (GREATERGREATER)
        #     (additive_expression)
    
        my si:value_state_push
        my choice_1197
        my si:valuevalue_part
        my sym_additive_expression
        my si:value_state_merge
        return
    }
    
    method choice_1197 {} {
        # /
        #     (LESSLESS)
        #     (GREATERGREATER)
    
        my si:value_state_push
        my sym_LESSLESS
        my si:valuevalue_branch
        my sym_GREATERGREATER
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'short'
    #
    
    method sym_short {} {
        # x
        #     "short"
        #     (WHITESPACE)
    
        my si:void_symbol_start short
        my sequence_1209
        my si:void_leaf_symbol_end short
        return
    }
    
    method sequence_1209 {} {
        # x
        #     "short"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str short
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'sign'
    #
    
    method sym_sign {} {
        # [_+]
    
        my si:void_symbol_start sign
        my si:next_class _+
        my si:void_leaf_symbol_end sign
        return
    }
    
    #
    # leaf Symbol 'signed'
    #
    
    method sym_signed {} {
        # x
        #     "signed"
        #     (WHITESPACE)
    
        my si:void_symbol_start signed
        my sequence_1216
        my si:void_leaf_symbol_end signed
        return
    }
    
    method sequence_1216 {} {
        # x
        #     "signed"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str signed
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'simple_escape_sequence'
    #
    
    method sym_simple_escape_sequence {} {
        # x
        #     '\'
        #     ['\"?\abfnrtv]
    
        my si:void_symbol_start simple_escape_sequence
        my sequence_1221
        my si:void_leaf_symbol_end simple_escape_sequence
        return
    }
    
    method sequence_1221 {} {
        # x
        #     '\'
        #     ['\"?\abfnrtv]
    
        my si:void_state_push
        my si:next_char \134
        my si:voidvoid_part
        my si:next_class '\42?\134abfnrtv
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'size_t'
    #
    
    method sym_size_t {} {
        # x
        #     "size_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start size_t
        my sequence_1226
        my si:void_leaf_symbol_end size_t
        return
    }
    
    method sequence_1226 {} {
        # x
        #     "size_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str size_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'sizeof'
    #
    
    method sym_sizeof {} {
        # x
        #     "sizeof"
        #     (WHITESPACE)
    
        my si:void_symbol_start sizeof
        my sequence_1231
        my si:void_leaf_symbol_end sizeof
        return
    }
    
    method sequence_1231 {} {
        # x
        #     "sizeof"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str sizeof
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'SLASH'
    #
    
    method sym_SLASH {} {
        # x
        #     '/'
        #     (WHITESPACE)
    
        my si:void_symbol_start SLASH
        my sequence_1236
        my si:void_leaf_symbol_end SLASH
        return
    }
    
    method sequence_1236 {} {
        # x
        #     '/'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char /
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'SLASHEQUAL'
    #
    
    method sym_SLASHEQUAL {} {
        # x
        #     "/="
        #     (WHITESPACE)
    
        my si:void_symbol_start SLASHEQUAL
        my sequence_1241
        my si:void_leaf_symbol_end SLASHEQUAL
        return
    }
    
    method sequence_1241 {} {
        # x
        #     "/="
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str /=
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'specifier_qualifier_list'
    #
    
    method sym_specifier_qualifier_list {} {
        # +
        #     /
        #         (type_specifier)
        #         (type_qualifier)
    
        my si:value_symbol_start specifier_qualifier_list
        my poskleene_1248
        my si:reduce_symbol_end specifier_qualifier_list
        return
    }
    
    method poskleene_1248 {} {
        # +
        #     /
        #         (type_specifier)
        #         (type_qualifier)
    
        my i_loc_push
        my choice_1246
        my si:kleene_abort
        while {1} {
            my si:void2_state_push
        my choice_1246
            my si:kleene_close
        }
        return
    }
    
    method choice_1246 {} {
        # /
        #     (type_specifier)
        #     (type_qualifier)
    
        my si:value_state_push
        my sym_type_specifier
        my si:valuevalue_branch
        my sym_type_qualifier
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'STAR'
    #
    
    method sym_STAR {} {
        # x
        #     '*'
        #     (WHITESPACE)
    
        my si:void_symbol_start STAR
        my sequence_1253
        my si:void_leaf_symbol_end STAR
        return
    }
    
    method sequence_1253 {} {
        # x
        #     '*'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char *
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'STAREQUAL'
    #
    
    method sym_STAREQUAL {} {
        # x
        #     "*="
        #     (WHITESPACE)
    
        my si:void_symbol_start STAREQUAL
        my sequence_1258
        my si:void_leaf_symbol_end STAREQUAL
        return
    }
    
    method sequence_1258 {} {
        # x
        #     "*="
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str *=
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'static'
    #
    
    method sym_static {} {
        # x
        #     "static"
        #     (WHITESPACE)
    
        my si:void_symbol_start static
        my sequence_1263
        my si:void_leaf_symbol_end static
        return
    }
    
    method sequence_1263 {} {
        # x
        #     "static"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str static
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'storage_class_specifier'
    #
    
    method sym_storage_class_specifier {} {
        # /
        #     (typedef)
        #     (extern)
        #     (static)
        #     (auto)
        #     (register)
    
        my si:value_symbol_start storage_class_specifier
        my choice_1271
        my si:reduce_symbol_end storage_class_specifier
        return
    }
    
    method choice_1271 {} {
        # /
        #     (typedef)
        #     (extern)
        #     (static)
        #     (auto)
        #     (register)
    
        my si:value_state_push
        my sym_typedef
        my si:valuevalue_branch
        my sym_extern
        my si:valuevalue_branch
        my sym_static
        my si:valuevalue_branch
        my sym_auto
        my si:valuevalue_branch
        my sym_register
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'string_literal'
    #
    
    method sym_string_literal {} {
        # x
        #     ?
        #         'L'
        #     '\"'
        #     *
        #         (s_char)
        #     '\"'
    
        my si:value_symbol_start string_literal
        my sequence_1281
        my si:reduce_symbol_end string_literal
        return
    }
    
    method sequence_1281 {} {
        # x
        #     ?
        #         'L'
        #     '\"'
        #     *
        #         (s_char)
        #     '\"'
    
        my si:void_state_push
        my optional_184
        my si:voidvoid_part
        my si:next_char \42
        my si:voidvalue_part
        my kleene_1278
        my si:valuevalue_part
        my si:next_char \42
        my si:value_state_merge
        return
    }
    
    method kleene_1278 {} {
        # *
        #     (s_char)
    
        while {1} {
            my si:void2_state_push
        my sym_s_char
            my si:kleene_close
        }
        return
    }
    
    #
    # leaf Symbol 'struct'
    #
    
    method sym_struct {} {
        # x
        #     "struct"
        #     (WHITESPACE)
    
        my si:void_symbol_start struct
        my sequence_1286
        my si:void_leaf_symbol_end struct
        return
    }
    
    method sequence_1286 {} {
        # x
        #     "struct"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str struct
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'struct_declaration'
    #
    
    method sym_struct_declaration {} {
        # x
        #     (specifier_qualifier_list)
        #     (struct_declarator_list)
        #     (SEMICOLON)
    
        my si:value_symbol_start struct_declaration
        my sequence_1292
        my si:reduce_symbol_end struct_declaration
        return
    }
    
    method sequence_1292 {} {
        # x
        #     (specifier_qualifier_list)
        #     (struct_declarator_list)
        #     (SEMICOLON)
    
        my si:value_state_push
        my sym_specifier_qualifier_list
        my si:valuevalue_part
        my sym_struct_declarator_list
        my si:valuevalue_part
        my sym_SEMICOLON
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'struct_declaration_list'
    #
    
    method sym_struct_declaration_list {} {
        # +
        #     (struct_declaration)
    
        my si:value_symbol_start struct_declaration_list
        my poskleene_1296
        my si:reduce_symbol_end struct_declaration_list
        return
    }
    
    method poskleene_1296 {} {
        # +
        #     (struct_declaration)
    
        my i_loc_push
        my sym_struct_declaration
        my si:kleene_abort
        while {1} {
            my si:void2_state_push
        my sym_struct_declaration
            my si:kleene_close
        }
        return
    }
    
    #
    # value Symbol 'struct_declarator'
    #
    
    method sym_struct_declarator {} {
        # /
        #     x
        #         ?
        #             (declarator)
        #         (COLON)
        #         (constant_expression)
        #     (declarator)
    
        my si:value_symbol_start struct_declarator
        my choice_1307
        my si:reduce_symbol_end struct_declarator
        return
    }
    
    method choice_1307 {} {
        # /
        #     x
        #         ?
        #             (declarator)
        #         (COLON)
        #         (constant_expression)
        #     (declarator)
    
        my si:value_state_push
        my sequence_1304
        my si:valuevalue_branch
        my sym_declarator
        my si:value_state_merge
        return
    }
    
    method sequence_1304 {} {
        # x
        #     ?
        #         (declarator)
        #     (COLON)
        #     (constant_expression)
    
        my si:value_state_push
        my optional_1300
        my si:valuevalue_part
        my sym_COLON
        my si:valuevalue_part
        my sym_constant_expression
        my si:value_state_merge
        return
    }
    
    method optional_1300 {} {
        # ?
        #     (declarator)
    
        my si:void2_state_push
        my sym_declarator
        my si:void_state_merge_ok
        return
    }
    
    #
    # value Symbol 'struct_declarator_list'
    #
    
    method sym_struct_declarator_list {} {
        # x
        #     (struct_declarator)
        #     *
        #         x
        #             (COMMA)
        #             (struct_declarator)
    
        my si:value_symbol_start struct_declarator_list
        my sequence_1317
        my si:reduce_symbol_end struct_declarator_list
        return
    }
    
    method sequence_1317 {} {
        # x
        #     (struct_declarator)
        #     *
        #         x
        #             (COMMA)
        #             (struct_declarator)
    
        my si:value_state_push
        my sym_struct_declarator
        my si:valuevalue_part
        my kleene_1315
        my si:value_state_merge
        return
    }
    
    method kleene_1315 {} {
        # *
        #     x
        #         (COMMA)
        #         (struct_declarator)
    
        while {1} {
            my si:void2_state_push
        my sequence_1313
            my si:kleene_close
        }
        return
    }
    
    method sequence_1313 {} {
        # x
        #     (COMMA)
        #     (struct_declarator)
    
        my si:void_state_push
        my sym_COMMA
        my si:voidvalue_part
        my sym_struct_declarator
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'struct_or_union'
    #
    
    method sym_struct_or_union {} {
        # /
        #     (struct)
        #     (union)
    
        my si:value_symbol_start struct_or_union
        my choice_1322
        my si:reduce_symbol_end struct_or_union
        return
    }
    
    method choice_1322 {} {
        # /
        #     (struct)
        #     (union)
    
        my si:value_state_push
        my sym_struct
        my si:valuevalue_branch
        my sym_union
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'struct_or_union_specifier'
    #
    
    method sym_struct_or_union_specifier {} {
        # /
        #     x
        #         (struct_or_union)
        #         ?
        #             (identifier)
        #         (LBRACE)
        #         (struct_declaration_list)
        #         (RBRACE)
        #     x
        #         (struct_or_union)
        #         (identifier)
    
        my si:value_symbol_start struct_or_union_specifier
        my choice_1337
        my si:reduce_symbol_end struct_or_union_specifier
        return
    }
    
    method choice_1337 {} {
        # /
        #     x
        #         (struct_or_union)
        #         ?
        #             (identifier)
        #         (LBRACE)
        #         (struct_declaration_list)
        #         (RBRACE)
        #     x
        #         (struct_or_union)
        #         (identifier)
    
        my si:value_state_push
        my sequence_1331
        my si:valuevalue_branch
        my sequence_1335
        my si:value_state_merge
        return
    }
    
    method sequence_1331 {} {
        # x
        #     (struct_or_union)
        #     ?
        #         (identifier)
        #     (LBRACE)
        #     (struct_declaration_list)
        #     (RBRACE)
    
        my si:value_state_push
        my sym_struct_or_union
        my si:valuevalue_part
        my optional_426
        my si:valuevalue_part
        my sym_LBRACE
        my si:valuevalue_part
        my sym_struct_declaration_list
        my si:valuevalue_part
        my sym_RBRACE
        my si:value_state_merge
        return
    }
    
    method sequence_1335 {} {
        # x
        #     (struct_or_union)
        #     (identifier)
    
        my si:value_state_push
        my sym_struct_or_union
        my si:valuevalue_part
        my sym_identifier
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'TILDE'
    #
    
    method sym_TILDE {} {
        # x
        #     '~'
        #     (WHITESPACE)
    
        my si:void_symbol_start TILDE
        my sequence_1342
        my si:void_leaf_symbol_end TILDE
        return
    }
    
    method sequence_1342 {} {
        # x
        #     '~'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_char ~
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'type_name'
    #
    
    method sym_type_name {} {
        # x
        #     (specifier_qualifier_list)
        #     ?
        #         (abstract_declarator)
        #     (EOF)
    
        my si:value_symbol_start type_name
        my sequence_1349
        my si:reduce_symbol_end type_name
        return
    }
    
    method sequence_1349 {} {
        # x
        #     (specifier_qualifier_list)
        #     ?
        #         (abstract_declarator)
        #     (EOF)
    
        my si:value_state_push
        my sym_specifier_qualifier_list
        my si:valuevalue_part
        my optional_1001
        my si:valuevalue_part
        my sym_EOF
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'type_qualifier'
    #
    
    method sym_type_qualifier {} {
        # /
        #     (const)
        #     (restrict)
        #     (volatile)
    
        my si:value_symbol_start type_qualifier
        my choice_1355
        my si:reduce_symbol_end type_qualifier
        return
    }
    
    method choice_1355 {} {
        # /
        #     (const)
        #     (restrict)
        #     (volatile)
    
        my si:value_state_push
        my sym_const
        my si:valuevalue_branch
        my sym_restrict
        my si:valuevalue_branch
        my sym_volatile
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'type_qualifier_list'
    #
    
    method sym_type_qualifier_list {} {
        # +
        #     (type_qualifier)
    
        my si:value_symbol_start type_qualifier_list
        my poskleene_1359
        my si:reduce_symbol_end type_qualifier_list
        return
    }
    
    method poskleene_1359 {} {
        # +
        #     (type_qualifier)
    
        my i_loc_push
        my sym_type_qualifier
        my si:kleene_abort
        while {1} {
            my si:void2_state_push
        my sym_type_qualifier
            my si:kleene_close
        }
        return
    }
    
    #
    # value Symbol 'type_specifier'
    #
    
    method sym_type_specifier {} {
        # /
        #     (int8_t)
        #     (int16_t)
        #     (int32_t)
        #     (int64_t)
        #     (int_least8_t)
        #     (int_least16_t)
        #     (int_least32_t)
        #     (int_least64_t)
        #     (int_fast8_t)
        #     (int_fast16_t)
        #     (int_fast32_t)
        #     (int_fast64_t)
        #     (void)
        #     (char)
        #     (short)
        #     (int)
        #     (long)
        #     (float)
        #     (double)
        #     (signed)
        #     (unsigned)
        #     (_Bool)
        #     (bool)
        #     (_Complex)
        #     (complex)
        #     (_Imaginary)
        #     (imaginary)
        #     (uint8_t)
        #     (uint16_t)
        #     (uint32_t)
        #     (uint64_t)
        #     (uint_least8_t)
        #     (uint_least16_t)
        #     (uint_least32_t)
        #     (uint_least64_t)
        #     (uint_fast8_t)
        #     (uint_fast16_t)
        #     (uint_fast32_t)
        #     (uint_fast64_t)
        #     (intptr_t)
        #     (uintptr_t)
        #     (intmax_t)
        #     (uintmax_t)
        #     (size_t)
        #     (ptrdiff_t)
        #     (struct_or_union_specifier)
        #     (enum_specifier)
        #     (typedef_name)
    
        my si:value_symbol_start type_specifier
        my choice_1410
        my si:reduce_symbol_end type_specifier
        return
    }
    
    method choice_1410 {} {
        # /
        #     (int8_t)
        #     (int16_t)
        #     (int32_t)
        #     (int64_t)
        #     (int_least8_t)
        #     (int_least16_t)
        #     (int_least32_t)
        #     (int_least64_t)
        #     (int_fast8_t)
        #     (int_fast16_t)
        #     (int_fast32_t)
        #     (int_fast64_t)
        #     (void)
        #     (char)
        #     (short)
        #     (int)
        #     (long)
        #     (float)
        #     (double)
        #     (signed)
        #     (unsigned)
        #     (_Bool)
        #     (bool)
        #     (_Complex)
        #     (complex)
        #     (_Imaginary)
        #     (imaginary)
        #     (uint8_t)
        #     (uint16_t)
        #     (uint32_t)
        #     (uint64_t)
        #     (uint_least8_t)
        #     (uint_least16_t)
        #     (uint_least32_t)
        #     (uint_least64_t)
        #     (uint_fast8_t)
        #     (uint_fast16_t)
        #     (uint_fast32_t)
        #     (uint_fast64_t)
        #     (intptr_t)
        #     (uintptr_t)
        #     (intmax_t)
        #     (uintmax_t)
        #     (size_t)
        #     (ptrdiff_t)
        #     (struct_or_union_specifier)
        #     (enum_specifier)
        #     (typedef_name)
    
        my si:value_state_push
        my sym_int8_t
        my si:valuevalue_branch
        my sym_int16_t
        my si:valuevalue_branch
        my sym_int32_t
        my si:valuevalue_branch
        my sym_int64_t
        my si:valuevalue_branch
        my sym_int_least8_t
        my si:valuevalue_branch
        my sym_int_least16_t
        my si:valuevalue_branch
        my sym_int_least32_t
        my si:valuevalue_branch
        my sym_int_least64_t
        my si:valuevalue_branch
        my sym_int_fast8_t
        my si:valuevalue_branch
        my sym_int_fast16_t
        my si:valuevalue_branch
        my sym_int_fast32_t
        my si:valuevalue_branch
        my sym_int_fast64_t
        my si:valuevalue_branch
        my sym_void
        my si:valuevalue_branch
        my sym_char
        my si:valuevalue_branch
        my sym_short
        my si:valuevalue_branch
        my sym_int
        my si:valuevalue_branch
        my sym_long
        my si:valuevalue_branch
        my sym_float
        my si:valuevalue_branch
        my sym_double
        my si:valuevalue_branch
        my sym_signed
        my si:valuevalue_branch
        my sym_unsigned
        my si:valuevalue_branch
        my sym__Bool
        my si:valuevalue_branch
        my sym_bool
        my si:valuevalue_branch
        my sym__Complex
        my si:valuevalue_branch
        my sym_complex
        my si:valuevalue_branch
        my sym__Imaginary
        my si:valuevalue_branch
        my sym_imaginary
        my si:valuevalue_branch
        my sym_uint8_t
        my si:valuevalue_branch
        my sym_uint16_t
        my si:valuevalue_branch
        my sym_uint32_t
        my si:valuevalue_branch
        my sym_uint64_t
        my si:valuevalue_branch
        my sym_uint_least8_t
        my si:valuevalue_branch
        my sym_uint_least16_t
        my si:valuevalue_branch
        my sym_uint_least32_t
        my si:valuevalue_branch
        my sym_uint_least64_t
        my si:valuevalue_branch
        my sym_uint_fast8_t
        my si:valuevalue_branch
        my sym_uint_fast16_t
        my si:valuevalue_branch
        my sym_uint_fast32_t
        my si:valuevalue_branch
        my sym_uint_fast64_t
        my si:valuevalue_branch
        my sym_intptr_t
        my si:valuevalue_branch
        my sym_uintptr_t
        my si:valuevalue_branch
        my sym_intmax_t
        my si:valuevalue_branch
        my sym_uintmax_t
        my si:valuevalue_branch
        my sym_size_t
        my si:valuevalue_branch
        my sym_ptrdiff_t
        my si:valuevalue_branch
        my sym_struct_or_union_specifier
        my si:valuevalue_branch
        my sym_enum_specifier
        my si:valuevalue_branch
        my sym_typedef_name
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'typedef'
    #
    
    method sym_typedef {} {
        # x
        #     "typedef"
        #     (WHITESPACE)
    
        my si:void_symbol_start typedef
        my sequence_1415
        my si:void_leaf_symbol_end typedef
        return
    }
    
    method sequence_1415 {} {
        # x
        #     "typedef"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str typedef
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'typedef_name'
    #
    
    method sym_typedef_name {} {
        # /
        #     x
        #         <upper>
        #         *
        #             <alnum>
        #         "_t"
        #         (WHITESPACE)
        #     x
        #         "MRT_"
        #         +
        #             <alnum>
        #         (WHITESPACE)
    
        my si:void_symbol_start typedef_name
        my choice_1433
        my si:void_leaf_symbol_end typedef_name
        return
    }
    
    method choice_1433 {} {
        # /
        #     x
        #         <upper>
        #         *
        #             <alnum>
        #         "_t"
        #         (WHITESPACE)
        #     x
        #         "MRT_"
        #         +
        #             <alnum>
        #         (WHITESPACE)
    
        my si:void_state_push
        my sequence_1424
        my si:voidvoid_branch
        my sequence_1431
        my si:void_state_merge
        return
    }
    
    method sequence_1424 {} {
        # x
        #     <upper>
        #     *
        #         <alnum>
        #     "_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_upper
        my si:voidvoid_part
        my kleene_1420
        my si:voidvoid_part
        my si:next_str _t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    method kleene_1420 {} {
        # *
        #     <alnum>
    
        while {1} {
            my si:void2_state_push
        my si:next_alnum
            my si:kleene_close
        }
        return
    }
    
    method sequence_1431 {} {
        # x
        #     "MRT_"
        #     +
        #         <alnum>
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str MRT_
        my si:voidvoid_part
        my poskleene_1428
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    method poskleene_1428 {} {
        # +
        #     <alnum>
    
        my i_loc_push
        my si:next_alnum
        my si:kleene_abort
        while {1} {
            my si:void2_state_push
        my si:next_alnum
            my si:kleene_close
        }
        return
    }
    
    #
    # leaf Symbol 'uint8_t'
    #
    
    method sym_uint8_t {} {
        # x
        #     "uint8_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start uint8_t
        my sequence_1438
        my si:void_leaf_symbol_end uint8_t
        return
    }
    
    method sequence_1438 {} {
        # x
        #     "uint8_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str uint8_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'uint16_t'
    #
    
    method sym_uint16_t {} {
        # x
        #     "uint16_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start uint16_t
        my sequence_1443
        my si:void_leaf_symbol_end uint16_t
        return
    }
    
    method sequence_1443 {} {
        # x
        #     "uint16_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str uint16_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'uint32_t'
    #
    
    method sym_uint32_t {} {
        # x
        #     "uint32_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start uint32_t
        my sequence_1448
        my si:void_leaf_symbol_end uint32_t
        return
    }
    
    method sequence_1448 {} {
        # x
        #     "uint32_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str uint32_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'uint64_t'
    #
    
    method sym_uint64_t {} {
        # x
        #     "uint64_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start uint64_t
        my sequence_1453
        my si:void_leaf_symbol_end uint64_t
        return
    }
    
    method sequence_1453 {} {
        # x
        #     "uint64_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str uint64_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'uint_fast8_t'
    #
    
    method sym_uint_fast8_t {} {
        # x
        #     "uint_fast8_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start uint_fast8_t
        my sequence_1458
        my si:void_leaf_symbol_end uint_fast8_t
        return
    }
    
    method sequence_1458 {} {
        # x
        #     "uint_fast8_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str uint_fast8_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'uint_fast16_t'
    #
    
    method sym_uint_fast16_t {} {
        # x
        #     "uint_fast16_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start uint_fast16_t
        my sequence_1463
        my si:void_leaf_symbol_end uint_fast16_t
        return
    }
    
    method sequence_1463 {} {
        # x
        #     "uint_fast16_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str uint_fast16_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'uint_fast32_t'
    #
    
    method sym_uint_fast32_t {} {
        # x
        #     "uint_fast32_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start uint_fast32_t
        my sequence_1468
        my si:void_leaf_symbol_end uint_fast32_t
        return
    }
    
    method sequence_1468 {} {
        # x
        #     "uint_fast32_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str uint_fast32_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'uint_fast64_t'
    #
    
    method sym_uint_fast64_t {} {
        # x
        #     "uint_fast64_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start uint_fast64_t
        my sequence_1473
        my si:void_leaf_symbol_end uint_fast64_t
        return
    }
    
    method sequence_1473 {} {
        # x
        #     "uint_fast64_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str uint_fast64_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'uint_least8_t'
    #
    
    method sym_uint_least8_t {} {
        # x
        #     "uint_least8_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start uint_least8_t
        my sequence_1478
        my si:void_leaf_symbol_end uint_least8_t
        return
    }
    
    method sequence_1478 {} {
        # x
        #     "uint_least8_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str uint_least8_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'uint_least16_t'
    #
    
    method sym_uint_least16_t {} {
        # x
        #     "uint_least16_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start uint_least16_t
        my sequence_1483
        my si:void_leaf_symbol_end uint_least16_t
        return
    }
    
    method sequence_1483 {} {
        # x
        #     "uint_least16_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str uint_least16_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'uint_least32_t'
    #
    
    method sym_uint_least32_t {} {
        # x
        #     "uint_least32_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start uint_least32_t
        my sequence_1488
        my si:void_leaf_symbol_end uint_least32_t
        return
    }
    
    method sequence_1488 {} {
        # x
        #     "uint_least32_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str uint_least32_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'uint_least64_t'
    #
    
    method sym_uint_least64_t {} {
        # x
        #     "uint_least64_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start uint_least64_t
        my sequence_1493
        my si:void_leaf_symbol_end uint_least64_t
        return
    }
    
    method sequence_1493 {} {
        # x
        #     "uint_least64_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str uint_least64_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'uintmax_t'
    #
    
    method sym_uintmax_t {} {
        # x
        #     "uintmax_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start uintmax_t
        my sequence_1498
        my si:void_leaf_symbol_end uintmax_t
        return
    }
    
    method sequence_1498 {} {
        # x
        #     "uintmax_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str uintmax_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'uintptr_t'
    #
    
    method sym_uintptr_t {} {
        # x
        #     "uintptr_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start uintptr_t
        my sequence_1503
        my si:void_leaf_symbol_end uintptr_t
        return
    }
    
    method sequence_1503 {} {
        # x
        #     "uintptr_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str uintptr_t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'unary_expression'
    #
    
    method sym_unary_expression {} {
        # /
        #     (postfix_expression)
        #     x
        #         (PLUSPLUS)
        #         (unary_expression)
        #     x
        #         (MINUSMINUS)
        #         (unary_expression)
        #     x
        #         (unary_operator)
        #         (cast_expression)
        #     x
        #         (sizeof)
        #         (unary_expression)
        #     x
        #         (sizeof)
        #         (LPAREN)
        #         (type_specifier)
        #         (RPAREN)
    
        my si:value_symbol_start unary_expression
        my choice_1529
        my si:reduce_symbol_end unary_expression
        return
    }
    
    method choice_1529 {} {
        # /
        #     (postfix_expression)
        #     x
        #         (PLUSPLUS)
        #         (unary_expression)
        #     x
        #         (MINUSMINUS)
        #         (unary_expression)
        #     x
        #         (unary_operator)
        #         (cast_expression)
        #     x
        #         (sizeof)
        #         (unary_expression)
        #     x
        #         (sizeof)
        #         (LPAREN)
        #         (type_specifier)
        #         (RPAREN)
    
        my si:value_state_push
        my sym_postfix_expression
        my si:valuevalue_branch
        my sequence_1509
        my si:valuevalue_branch
        my sequence_1513
        my si:valuevalue_branch
        my sequence_1517
        my si:valuevalue_branch
        my sequence_1521
        my si:valuevalue_branch
        my sequence_1527
        my si:value_state_merge
        return
    }
    
    method sequence_1509 {} {
        # x
        #     (PLUSPLUS)
        #     (unary_expression)
    
        my si:value_state_push
        my sym_PLUSPLUS
        my si:valuevalue_part
        my sym_unary_expression
        my si:value_state_merge
        return
    }
    
    method sequence_1513 {} {
        # x
        #     (MINUSMINUS)
        #     (unary_expression)
    
        my si:value_state_push
        my sym_MINUSMINUS
        my si:valuevalue_part
        my sym_unary_expression
        my si:value_state_merge
        return
    }
    
    method sequence_1517 {} {
        # x
        #     (unary_operator)
        #     (cast_expression)
    
        my si:value_state_push
        my sym_unary_operator
        my si:valuevalue_part
        my sym_cast_expression
        my si:value_state_merge
        return
    }
    
    method sequence_1521 {} {
        # x
        #     (sizeof)
        #     (unary_expression)
    
        my si:value_state_push
        my sym_sizeof
        my si:valuevalue_part
        my sym_unary_expression
        my si:value_state_merge
        return
    }
    
    method sequence_1527 {} {
        # x
        #     (sizeof)
        #     (LPAREN)
        #     (type_specifier)
        #     (RPAREN)
    
        my si:value_state_push
        my sym_sizeof
        my si:valuevalue_part
        my sym_LPAREN
        my si:valuevalue_part
        my sym_type_specifier
        my si:valuevalue_part
        my sym_RPAREN
        my si:value_state_merge
        return
    }
    
    #
    # value Symbol 'unary_operator'
    #
    
    method sym_unary_operator {} {
        # /
        #     (AMPERSAND)
        #     (STAR)
        #     (PLUS)
        #     (MINUS)
        #     (TILDE)
        #     (PLING)
    
        my si:value_symbol_start unary_operator
        my choice_1538
        my si:reduce_symbol_end unary_operator
        return
    }
    
    method choice_1538 {} {
        # /
        #     (AMPERSAND)
        #     (STAR)
        #     (PLUS)
        #     (MINUS)
        #     (TILDE)
        #     (PLING)
    
        my si:value_state_push
        my sym_AMPERSAND
        my si:valuevalue_branch
        my sym_STAR
        my si:valuevalue_branch
        my sym_PLUS
        my si:valuevalue_branch
        my sym_MINUS
        my si:valuevalue_branch
        my sym_TILDE
        my si:valuevalue_branch
        my sym_PLING
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'union'
    #
    
    method sym_union {} {
        # x
        #     "union"
        #     (WHITESPACE)
    
        my si:void_symbol_start union
        my sequence_1543
        my si:void_leaf_symbol_end union
        return
    }
    
    method sequence_1543 {} {
        # x
        #     "union"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str union
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'unsigned'
    #
    
    method sym_unsigned {} {
        # x
        #     "unsigned"
        #     (WHITESPACE)
    
        my si:void_symbol_start unsigned
        my sequence_1548
        my si:void_leaf_symbol_end unsigned
        return
    }
    
    method sequence_1548 {} {
        # x
        #     "unsigned"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str unsigned
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # value Symbol 'unsigned_suffix'
    #
    
    method sym_unsigned_suffix {} {
        # [uU]
    
        my si:void_symbol_start unsigned_suffix
        my si:next_class uU
        my si:void_leaf_symbol_end unsigned_suffix
        return
    }
    
    #
    # leaf Symbol 'void'
    #
    
    method sym_void {} {
        # x
        #     "void"
        #     (WHITESPACE)
    
        my si:void_symbol_start void
        my sequence_1555
        my si:void_leaf_symbol_end void
        return
    }
    
    method sequence_1555 {} {
        # x
        #     "void"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str void
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # leaf Symbol 'volatile'
    #
    
    method sym_volatile {} {
        # x
        #     "volatile"
        #     (WHITESPACE)
    
        my si:void_symbol_start volatile
        my sequence_1560
        my si:void_leaf_symbol_end volatile
        return
    }
    
    method sequence_1560 {} {
        # x
        #     "volatile"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str volatile
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    #
    # void Symbol 'WHITESPACE'
    #
    
    method sym_WHITESPACE {} {
        # *
        #     <space>
    
        my si:void_void_symbol_start WHITESPACE
        my kleene_1564
        my si:void_clear_symbol_end WHITESPACE
        return
    }
    
    method kleene_1564 {} {
        # *
        #     <space>
    
        while {1} {
            my si:void2_state_push
        my si:next_space
            my si:kleene_close
        }
        return
    }
    
    ## END of GENERATED CODE. DO NOT EDIT.
    # # ## ### ###### ######## #############
}

# # ## ### ##### ######## ############# #####################
## Ready

package provide typeparser 1
return