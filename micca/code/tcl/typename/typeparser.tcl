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
    # value Symbol 'declared_typename'
    #
    
    method sym_declared_typename {} {
        # x
        #     (TYPENAME)
        #     (LPAREN)
        #     (identifier)
        #     (RPAREN)
    
        my si:value_symbol_start declared_typename
        my sequence_292
        my si:reduce_symbol_end declared_typename
        return
    }
    
    method sequence_292 {} {
        # x
        #     (TYPENAME)
        #     (LPAREN)
        #     (identifier)
        #     (RPAREN)
    
        my si:value_state_push
        my sym_TYPENAME
        my si:valuevalue_part
        my sym_LPAREN
        my si:valuevalue_part
        my sym_identifier
        my si:valuevalue_part
        my sym_RPAREN
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
        my sequence_297
        my si:reduce_symbol_end designation
        return
    }
    
    method sequence_297 {} {
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
        my choice_309
        my si:reduce_symbol_end designator
        return
    }
    
    method choice_309 {} {
        # /
        #     x
        #         (LBRACKET)
        #         (constant_expression)
        #         (RBRACKET)
        #     x
        #         (DOT)
        #         (identifier)
    
        my si:value_state_push
        my sequence_303
        my si:valuevalue_branch
        my sequence_307
        my si:value_state_merge
        return
    }
    
    method sequence_303 {} {
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
    
    method sequence_307 {} {
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
        my poskleene_313
        my si:reduce_symbol_end designator_list
        return
    }
    
    method poskleene_313 {} {
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
        my poskleene_319
        my si:void_leaf_symbol_end digit_sequence
        return
    }
    
    method poskleene_319 {} {
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
        my sequence_326
        my si:reduce_symbol_end direct_abstract_declarator
        return
    }
    
    method sequence_326 {} {
        # x
        #     (direct_abstract_declarator_head)
        #     *
        #         (direct_abstract_declarator_tail)
    
        my si:value_state_push
        my sym_direct_abstract_declarator_head
        my si:valuevalue_part
        my kleene_324
        my si:value_state_merge
        return
    }
    
    method kleene_324 {} {
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
        my choice_335
        my si:reduce_symbol_end direct_abstract_declarator_head
        return
    }
    
    method choice_335 {} {
        # /
        #     x
        #         (LPAREN)
        #         (abstract_declarator)
        #         (RPAREN)
        #     (direct_abstract_declarator_tail)
    
        my si:value_state_push
        my sequence_332
        my si:valuevalue_branch
        my sym_direct_abstract_declarator_tail
        my si:value_state_merge
        return
    }
    
    method sequence_332 {} {
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
        my choice_346
        my si:reduce_symbol_end direct_abstract_declarator_tail
        return
    }
    
    method choice_346 {} {
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
        my sequence_344
        my si:value_state_merge
        return
    }
    
    method sequence_344 {} {
        # x
        #     (LPAREN)
        #     ?
        #         (parameter_type_list)
        #     (RPAREN)
    
        my si:value_state_push
        my sym_LPAREN
        my si:valuevalue_part
        my optional_341
        my si:valuevalue_part
        my sym_RPAREN
        my si:value_state_merge
        return
    }
    
    method optional_341 {} {
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
        my sequence_353
        my si:reduce_symbol_end direct_declarator
        return
    }
    
    method sequence_353 {} {
        # x
        #     (direct_declarator_head)
        #     ?
        #         (direct_declarator_tail)
    
        my si:value_state_push
        my sym_direct_declarator_head
        my si:valuevalue_part
        my optional_351
        my si:value_state_merge
        return
    }
    
    method optional_351 {} {
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
        my choice_362
        my si:reduce_symbol_end direct_declarator_head
        return
    }
    
    method choice_362 {} {
        # /
        #     (identifier)
        #     x
        #         (LPAREN)
        #         (declarator)
        #         (RPAREN)
    
        my si:value_state_push
        my sym_identifier
        my si:valuevalue_branch
        my sequence_360
        my si:value_state_merge
        return
    }
    
    method sequence_360 {} {
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
        my choice_408
        my si:reduce_symbol_end direct_declarator_tail
        return
    }
    
    method choice_408 {} {
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
        my sequence_372
        my si:valuevalue_branch
        my sequence_380
        my si:valuevalue_branch
        my sequence_387
        my si:valuevalue_branch
        my sequence_394
        my si:valuevalue_branch
        my sequence_399
        my si:valuevalue_branch
        my sequence_406
        my si:value_state_merge
        return
    }
    
    method sequence_372 {} {
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
        my optional_367
        my si:valuevalue_part
        my optional_81
        my si:valuevalue_part
        my sym_RBRACKET
        my si:value_state_merge
        return
    }
    
    method optional_367 {} {
        # ?
        #     (type_qualifier_list)
    
        my si:void2_state_push
        my sym_type_qualifier_list
        my si:void_state_merge_ok
        return
    }
    
    method sequence_380 {} {
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
        my optional_367
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
    
    method sequence_394 {} {
        # x
        #     (LBRACKET)
        #     ?
        #         (type_qualifier_list)
        #     (STAR)
        #     (RBRACKET)
    
        my si:value_state_push
        my sym_LBRACKET
        my si:valuevalue_part
        my optional_367
        my si:valuevalue_part
        my sym_STAR
        my si:valuevalue_part
        my sym_RBRACKET
        my si:value_state_merge
        return
    }
    
    method sequence_399 {} {
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
    
    method sequence_406 {} {
        # x
        #     (LPAREN)
        #     ?
        #         (identifier_list)
        #     (RPAREN)
    
        my si:value_state_push
        my sym_LPAREN
        my si:valuevalue_part
        my optional_403
        my si:valuevalue_part
        my sym_RPAREN
        my si:value_state_merge
        return
    }
    
    method optional_403 {} {
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
        my sequence_413
        my si:void_leaf_symbol_end DOT
        return
    }
    
    method sequence_413 {} {
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
        my sequence_418
        my si:void_leaf_symbol_end double
        return
    }
    
    method sequence_418 {} {
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
        my sequence_423
        my si:void_leaf_symbol_end ELLIPSIS
        return
    }
    
    method sequence_423 {} {
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
        my sequence_428
        my si:void_leaf_symbol_end enum
        return
    }
    
    method sequence_428 {} {
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
        my choice_453
        my si:reduce_symbol_end enum_specifier
        return
    }
    
    method choice_453 {} {
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
        my sequence_438
        my si:valuevalue_branch
        my sequence_447
        my si:valuevalue_branch
        my sequence_451
        my si:value_state_merge
        return
    }
    
    method sequence_438 {} {
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
        my optional_433
        my si:valuevalue_part
        my sym_LBRACE
        my si:valuevalue_part
        my sym_enumerator_list
        my si:valuevalue_part
        my sym_RBRACE
        my si:value_state_merge
        return
    }
    
    method optional_433 {} {
        # ?
        #     (identifier)
    
        my si:void2_state_push
        my sym_identifier
        my si:void_state_merge_ok
        return
    }
    
    method sequence_447 {} {
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
        my optional_433
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
    
    method sequence_451 {} {
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
        my sequence_465
        my si:reduce_symbol_end enumerator
        return
    }
    
    method sequence_465 {} {
        # x
        #     (enumeration_constant)
        #     ?
        #         x
        #             (EQUAL)
        #             (constant_expression)
    
        my si:value_state_push
        my sym_enumeration_constant
        my si:valuevalue_part
        my optional_463
        my si:value_state_merge
        return
    }
    
    method optional_463 {} {
        # ?
        #     x
        #         (EQUAL)
        #         (constant_expression)
    
        my si:void2_state_push
        my sequence_461
        my si:void_state_merge_ok
        return
    }
    
    method sequence_461 {} {
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
        my sequence_475
        my si:reduce_symbol_end enumerator_list
        return
    }
    
    method sequence_475 {} {
        # x
        #     (enumerator)
        #     *
        #         x
        #             (COMMA)
        #             (enumerator)
    
        my si:value_state_push
        my sym_enumerator
        my si:valuevalue_part
        my kleene_473
        my si:value_state_merge
        return
    }
    
    method kleene_473 {} {
        # *
        #     x
        #         (COMMA)
        #         (enumerator)
    
        while {1} {
            my si:void2_state_push
        my sequence_471
            my si:kleene_close
        }
        return
    }
    
    method sequence_471 {} {
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
        my notahead_479
        my si:void_clear_symbol_end EOF
        return
    }
    
    method notahead_479 {} {
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
        my sequence_484
        my si:void_leaf_symbol_end EQUAL
        return
    }
    
    method sequence_484 {} {
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
        my sequence_489
        my si:void_leaf_symbol_end EQUALEQUAL
        return
    }
    
    method sequence_489 {} {
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
        my sequence_502
        my si:reduce_symbol_end equality_expression
        return
    }
    
    method sequence_502 {} {
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
        my kleene_500
        my si:value_state_merge
        return
    }
    
    method kleene_500 {} {
        # *
        #     x
        #         /
        #             (EQUALEQUAL)
        #             (PLINGEQUAL)
        #         (relational_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_498
            my si:kleene_close
        }
        return
    }
    
    method sequence_498 {} {
        # x
        #     /
        #         (EQUALEQUAL)
        #         (PLINGEQUAL)
        #     (relational_expression)
    
        my si:value_state_push
        my choice_495
        my si:valuevalue_part
        my sym_relational_expression
        my si:value_state_merge
        return
    }
    
    method choice_495 {} {
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
        my choice_509
        my si:reduce_symbol_end escape_sequence
        return
    }
    
    method choice_509 {} {
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
        my sequence_519
        my si:reduce_symbol_end exclusive_OR_expression
        return
    }
    
    method sequence_519 {} {
        # x
        #     (AND_expression)
        #     *
        #         x
        #             (HAT)
        #             (AND_expression)
    
        my si:value_state_push
        my sym_AND_expression
        my si:valuevalue_part
        my kleene_517
        my si:value_state_merge
        return
    }
    
    method kleene_517 {} {
        # *
        #     x
        #         (HAT)
        #         (AND_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_515
            my si:kleene_close
        }
        return
    }
    
    method sequence_515 {} {
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
        my sequence_526
        my si:reduce_symbol_end exponent_part
        return
    }
    
    method sequence_526 {} {
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
        my sequence_538
        my si:void_leaf_symbol_end extern
        return
    }
    
    method sequence_538 {} {
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
        my sequence_543
        my si:void_leaf_symbol_end float
        return
    }
    
    method sequence_543 {} {
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
        my choice_548
        my si:reduce_symbol_end floating_constant
        return
    }
    
    method choice_548 {} {
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
        my choice_564
        my si:reduce_symbol_end fractional_constant
        return
    }
    
    method choice_564 {} {
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
        my sequence_558
        my si:valuevalue_branch
        my sequence_562
        my si:value_state_merge
        return
    }
    
    method sequence_558 {} {
        # x
        #     ?
        #         (digit_sequence)
        #     '.'
        #     (digit_sequence)
    
        my si:value_state_push
        my optional_554
        my si:valuevalue_part
        my si:next_char .
        my si:valuevalue_part
        my sym_digit_sequence
        my si:value_state_merge
        return
    }
    
    method optional_554 {} {
        # ?
        #     (digit_sequence)
    
        my si:void2_state_push
        my sym_digit_sequence
        my si:void_state_merge_ok
        return
    }
    
    method sequence_562 {} {
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
        my sequence_571
        my si:void_leaf_symbol_end GREATER
        return
    }
    
    method sequence_571 {} {
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
        my sequence_576
        my si:void_leaf_symbol_end GREATEREQUAL
        return
    }
    
    method sequence_576 {} {
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
        my sequence_581
        my si:void_leaf_symbol_end GREATERGREATER
        return
    }
    
    method sequence_581 {} {
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
        my sequence_586
        my si:void_leaf_symbol_end GREATERGREATEREQUAL
        return
    }
    
    method sequence_586 {} {
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
        my sequence_591
        my si:void_leaf_symbol_end HAT
        return
    }
    
    method sequence_591 {} {
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
        my sequence_596
        my si:void_leaf_symbol_end HATEQUAL
        return
    }
    
    method sequence_596 {} {
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
        my sequence_603
        my si:reduce_symbol_end hexadecimal_constant
        return
    }
    
    method sequence_603 {} {
        # x
        #     (hexadecimal_prefix)
        #     +
        #         (hexadecimal_digit)
    
        my si:value_state_push
        my sym_hexadecimal_prefix
        my si:valuevalue_part
        my poskleene_601
        my si:value_state_merge
        return
    }
    
    method poskleene_601 {} {
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
        my choice_613
        my si:reduce_symbol_end hexadecimal_digit_sequence
        return
    }
    
    method choice_613 {} {
        # /
        #     (hexadecimal_digit)
        #     x
        #         (hexadecimal_digit_sequence)
        #         (hexadecimal_digit)
    
        my si:value_state_push
        my sym_hexadecimal_digit
        my si:valuevalue_branch
        my sequence_611
        my si:value_state_merge
        return
    }
    
    method sequence_611 {} {
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
        my sequence_619
        my si:reduce_symbol_end hexadecimal_escape_sequence
        return
    }
    
    method sequence_619 {} {
        # x
        #     "\x"
        #     +
        #         (hexadecimal_digit)
    
        my si:void_state_push
        my si:next_str \134x
        my si:voidvalue_part
        my poskleene_601
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
        my choice_636
        my si:reduce_symbol_end hexadecimal_floating_constant
        return
    }
    
    method choice_636 {} {
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
        my sequence_627
        my si:valuevalue_branch
        my sequence_634
        my si:value_state_merge
        return
    }
    
    method sequence_627 {} {
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
    
    method sequence_634 {} {
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
        my choice_650
        my si:reduce_symbol_end hexadecimal_fractional_constant
        return
    }
    
    method choice_650 {} {
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
        my sequence_644
        my si:valuevalue_branch
        my sequence_648
        my si:value_state_merge
        return
    }
    
    method sequence_644 {} {
        # x
        #     ?
        #         (hexadecimal_digit_sequence)
        #     '.'
        #     (hexadecimal_digit_sequence)
    
        my si:value_state_push
        my optional_640
        my si:valuevalue_part
        my si:next_char .
        my si:valuevalue_part
        my sym_hexadecimal_digit_sequence
        my si:value_state_merge
        return
    }
    
    method optional_640 {} {
        # ?
        #     (hexadecimal_digit_sequence)
    
        my si:void2_state_push
        my sym_hexadecimal_digit_sequence
        my si:void_state_merge_ok
        return
    }
    
    method sequence_648 {} {
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
        my choice_655
        my si:void_leaf_symbol_end hexadecimal_prefix
        return
    }
    
    method choice_655 {} {
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
        my sequence_666
        my si:void_leaf_symbol_end identifier
        return
    }
    
    method sequence_666 {} {
        # x
        #     !
        #         (keyword)
        #     <alpha>
        #     *
        #         <wordchar>
        #     (WHITESPACE)
    
        my si:void_state_push
        my notahead_659
        my si:voidvoid_part
        my si:next_alpha
        my si:voidvoid_part
        my kleene_663
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    method notahead_659 {} {
        # !
        #     (keyword)
    
        my si:value_notahead_start
        my sym_keyword
        my si:value_notahead_exit
        return
    }
    
    method kleene_663 {} {
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
        my sequence_676
        my si:reduce_symbol_end identifier_list
        return
    }
    
    method sequence_676 {} {
        # x
        #     (identifier)
        #     *
        #         x
        #             (COMMA)
        #             (identifier)
    
        my si:value_state_push
        my sym_identifier
        my si:valuevalue_part
        my kleene_674
        my si:value_state_merge
        return
    }
    
    method kleene_674 {} {
        # *
        #     x
        #         (COMMA)
        #         (identifier)
    
        while {1} {
            my si:void2_state_push
        my sequence_672
            my si:kleene_close
        }
        return
    }
    
    method sequence_672 {} {
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
        my sequence_681
        my si:void_leaf_symbol_end imaginary
        return
    }
    
    method sequence_681 {} {
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
        my sequence_691
        my si:reduce_symbol_end inclusive_OR_expression
        return
    }
    
    method sequence_691 {} {
        # x
        #     (exclusive_OR_expression)
        #     *
        #         x
        #             (BAR)
        #             (exclusive_OR_expression)
    
        my si:value_state_push
        my sym_exclusive_OR_expression
        my si:valuevalue_part
        my kleene_689
        my si:value_state_merge
        return
    }
    
    method kleene_689 {} {
        # *
        #     x
        #         (BAR)
        #         (exclusive_OR_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_687
            my si:kleene_close
        }
        return
    }
    
    method sequence_687 {} {
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
        my sequence_706
        my si:reduce_symbol_end initializer_list
        return
    }
    
    method sequence_706 {} {
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
        my optional_695
        my si:valuevalue_part
        my i_status_fail ; # Undefined symbol 'initializer'
        my si:valuevalue_part
        my kleene_704
        my si:value_state_merge
        return
    }
    
    method optional_695 {} {
        # ?
        #     (designation)
    
        my si:void2_state_push
        my sym_designation
        my si:void_state_merge_ok
        return
    }
    
    method kleene_704 {} {
        # *
        #     x
        #         (COMMA)
        #         ?
        #             (designation)
        #         (initializer)
    
        while {1} {
            my si:void2_state_push
        my sequence_702
            my si:kleene_close
        }
        return
    }
    
    method sequence_702 {} {
        # x
        #     (COMMA)
        #     ?
        #         (designation)
        #     (initializer)
    
        my si:void_state_push
        my sym_COMMA
        my si:voidvalue_part
        my optional_695
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
        my sequence_711
        my si:void_leaf_symbol_end inline
        return
    }
    
    method sequence_711 {} {
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
        my sequence_716
        my si:void_leaf_symbol_end int
        return
    }
    
    method sequence_716 {} {
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
        my sequence_721
        my si:void_leaf_symbol_end int8_t
        return
    }
    
    method sequence_721 {} {
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
        my sequence_726
        my si:void_leaf_symbol_end int16_t
        return
    }
    
    method sequence_726 {} {
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
        my sequence_731
        my si:void_leaf_symbol_end int32_t
        return
    }
    
    method sequence_731 {} {
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
        my sequence_736
        my si:void_leaf_symbol_end int64_t
        return
    }
    
    method sequence_736 {} {
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
        my sequence_741
        my si:void_leaf_symbol_end int_fast8_t
        return
    }
    
    method sequence_741 {} {
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
        my sequence_746
        my si:void_leaf_symbol_end int_fast16_t
        return
    }
    
    method sequence_746 {} {
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
        my sequence_751
        my si:void_leaf_symbol_end int_fast32_t
        return
    }
    
    method sequence_751 {} {
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
        my sequence_756
        my si:void_leaf_symbol_end int_fast64_t
        return
    }
    
    method sequence_756 {} {
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
        my sequence_761
        my si:void_leaf_symbol_end int_least8_t
        return
    }
    
    method sequence_761 {} {
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
        my sequence_766
        my si:void_leaf_symbol_end int_least16_t
        return
    }
    
    method sequence_766 {} {
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
        my sequence_771
        my si:void_leaf_symbol_end int_least32_t
        return
    }
    
    method sequence_771 {} {
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
        my sequence_776
        my si:void_leaf_symbol_end int_least64_t
        return
    }
    
    method sequence_776 {} {
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
        my choice_795
        my si:reduce_symbol_end integer_constant
        return
    }
    
    method choice_795 {} {
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
        my sequence_783
        my si:valuevalue_branch
        my sequence_788
        my si:valuevalue_branch
        my sequence_793
        my si:value_state_merge
        return
    }
    
    method sequence_783 {} {
        # x
        #     (decimal_constant)
        #     ?
        #         (integer_suffix)
    
        my si:value_state_push
        my sym_decimal_constant
        my si:valuevalue_part
        my optional_781
        my si:value_state_merge
        return
    }
    
    method optional_781 {} {
        # ?
        #     (integer_suffix)
    
        my si:void2_state_push
        my sym_integer_suffix
        my si:void_state_merge_ok
        return
    }
    
    method sequence_788 {} {
        # x
        #     (octal_constant)
        #     ?
        #         (integer_suffix)
    
        my si:value_state_push
        my sym_octal_constant
        my si:valuevalue_part
        my optional_781
        my si:value_state_merge
        return
    }
    
    method sequence_793 {} {
        # x
        #     (hexadecimal_constant)
        #     ?
        #         (integer_suffix)
    
        my si:value_state_push
        my sym_hexadecimal_constant
        my si:valuevalue_part
        my optional_781
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
        my choice_819
        my si:reduce_symbol_end integer_suffix
        return
    }
    
    method choice_819 {} {
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
        my sequence_802
        my si:valuevalue_branch
        my sequence_806
        my si:valuevalue_branch
        my sequence_812
        my si:valuevalue_branch
        my sequence_817
        my si:value_state_merge
        return
    }
    
    method sequence_802 {} {
        # x
        #     (unsigned_suffix)
        #     ?
        #         (long_suffix)
    
        my si:value_state_push
        my sym_unsigned_suffix
        my si:valuevalue_part
        my optional_800
        my si:value_state_merge
        return
    }
    
    method optional_800 {} {
        # ?
        #     (long_suffix)
    
        my si:void2_state_push
        my sym_long_suffix
        my si:void_state_merge_ok
        return
    }
    
    method sequence_806 {} {
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
    
    method sequence_812 {} {
        # x
        #     (long_suffix)
        #     ?
        #         (unsigned_suffix)
    
        my si:value_state_push
        my sym_long_suffix
        my si:valuevalue_part
        my optional_810
        my si:value_state_merge
        return
    }
    
    method optional_810 {} {
        # ?
        #     (unsigned_suffix)
    
        my si:void2_state_push
        my sym_unsigned_suffix
        my si:void_state_merge_ok
        return
    }
    
    method sequence_817 {} {
        # x
        #     (long_long_suffix)
        #     ?
        #         (unsigned_suffix)
    
        my si:value_state_push
        my sym_long_long_suffix
        my si:valuevalue_part
        my optional_810
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
        my sequence_824
        my si:void_leaf_symbol_end intmax_t
        return
    }
    
    method sequence_824 {} {
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
        my sequence_829
        my si:void_leaf_symbol_end intptr_t
        return
    }
    
    method sequence_829 {} {
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
        my choice_874
        my si:void_leaf_symbol_end keyword
        return
    }
    
    method choice_874 {} {
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
        my sequence_879
        my si:void_leaf_symbol_end LBRACE
        return
    }
    
    method sequence_879 {} {
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
        my sequence_884
        my si:void_leaf_symbol_end LBRACKET
        return
    }
    
    method sequence_884 {} {
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
        my sequence_889
        my si:void_leaf_symbol_end LESS
        return
    }
    
    method sequence_889 {} {
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
        my sequence_894
        my si:void_leaf_symbol_end LESSEQUAL
        return
    }
    
    method sequence_894 {} {
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
        my sequence_899
        my si:void_leaf_symbol_end LESSLESS
        return
    }
    
    method sequence_899 {} {
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
        my sequence_904
        my si:void_leaf_symbol_end LESSLESSEQUAL
        return
    }
    
    method sequence_904 {} {
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
        my sequence_914
        my si:reduce_symbol_end logical_AND_expression
        return
    }
    
    method sequence_914 {} {
        # x
        #     (inclusive_OR_expression)
        #     *
        #         x
        #             (ANDAND)
        #             (inclusive_OR_expression)
    
        my si:value_state_push
        my sym_inclusive_OR_expression
        my si:valuevalue_part
        my kleene_912
        my si:value_state_merge
        return
    }
    
    method kleene_912 {} {
        # *
        #     x
        #         (ANDAND)
        #         (inclusive_OR_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_910
            my si:kleene_close
        }
        return
    }
    
    method sequence_910 {} {
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
        my sequence_924
        my si:reduce_symbol_end logical_OR_expression
        return
    }
    
    method sequence_924 {} {
        # x
        #     (logical_AND_expression)
        #     *
        #         x
        #             (BARBAR)
        #             (logical_AND_expression)
    
        my si:value_state_push
        my sym_logical_AND_expression
        my si:valuevalue_part
        my kleene_922
        my si:value_state_merge
        return
    }
    
    method kleene_922 {} {
        # *
        #     x
        #         (BARBAR)
        #         (logical_AND_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_920
            my si:kleene_close
        }
        return
    }
    
    method sequence_920 {} {
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
        my sequence_929
        my si:void_leaf_symbol_end long
        return
    }
    
    method sequence_929 {} {
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
        my choice_934
        my si:void_leaf_symbol_end long_long_suffix
        return
    }
    
    method choice_934 {} {
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
        my sequence_941
        my si:void_leaf_symbol_end LPAREN
        return
    }
    
    method sequence_941 {} {
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
        my sequence_946
        my si:void_leaf_symbol_end MINUS
        return
    }
    
    method sequence_946 {} {
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
        my sequence_951
        my si:void_leaf_symbol_end MINUSEQUAL
        return
    }
    
    method sequence_951 {} {
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
        my sequence_956
        my si:void_leaf_symbol_end MINUSMINUS
        return
    }
    
    method sequence_956 {} {
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
        my sequence_970
        my si:reduce_symbol_end multiplicative_expression
        return
    }
    
    method sequence_970 {} {
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
        my kleene_968
        my si:value_state_merge
        return
    }
    
    method kleene_968 {} {
        # *
        #     x
        #         /
        #             (STAR)
        #             (SLASH)
        #             (PERCENT)
        #         (cast_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_966
            my si:kleene_close
        }
        return
    }
    
    method sequence_966 {} {
        # x
        #     /
        #         (STAR)
        #         (SLASH)
        #         (PERCENT)
        #     (cast_expression)
    
        my si:value_state_push
        my choice_963
        my si:valuevalue_part
        my sym_cast_expression
        my si:value_state_merge
        return
    }
    
    method choice_963 {} {
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
    # value Symbol 'named_typename'
    #
    
    method sym_named_typename {} {
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
    
        my si:void_symbol_start named_typename
        my choice_988
        my si:void_leaf_symbol_end named_typename
        return
    }
    
    method choice_988 {} {
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
        my sequence_979
        my si:voidvoid_branch
        my sequence_986
        my si:void_state_merge
        return
    }
    
    method sequence_979 {} {
        # x
        #     <upper>
        #     *
        #         <alnum>
        #     "_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_upper
        my si:voidvoid_part
        my kleene_975
        my si:voidvoid_part
        my si:next_str _t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    method kleene_975 {} {
        # *
        #     <alnum>
    
        while {1} {
            my si:void2_state_push
        my si:next_alnum
            my si:kleene_close
        }
        return
    }
    
    method sequence_986 {} {
        # x
        #     "MRT_"
        #     +
        #         <alnum>
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str MRT_
        my si:voidvoid_part
        my poskleene_983
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    method poskleene_983 {} {
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
        my sequence_997
        my si:reduce_symbol_end octal_constant
        return
    }
    
    method sequence_997 {} {
        # x
        #     '0'
        #     *
        #         (octal_digit)
    
        my si:void_state_push
        my si:next_char 0
        my si:voidvalue_part
        my kleene_995
        my si:value_state_merge
        return
    }
    
    method kleene_995 {} {
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
        my choice_1017
        my si:reduce_symbol_end octal_escape_sequence
        return
    }
    
    method choice_1017 {} {
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
        my sequence_1004
        my si:valuevalue_branch
        my sequence_1009
        my si:valuevalue_branch
        my sequence_1015
        my si:value_state_merge
        return
    }
    
    method sequence_1004 {} {
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
    
    method sequence_1009 {} {
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
    
    method sequence_1015 {} {
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
        my choice_1030
        my si:reduce_symbol_end parameter_declaration
        return
    }
    
    method choice_1030 {} {
        # /
        #     x
        #         (declaration_specifiers)
        #         (declarator)
        #     x
        #         (declaration_specifiers)
        #         ?
        #             (abstract_declarator)
    
        my si:value_state_push
        my sequence_1022
        my si:valuevalue_branch
        my sequence_1028
        my si:value_state_merge
        return
    }
    
    method sequence_1022 {} {
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
    
    method sequence_1028 {} {
        # x
        #     (declaration_specifiers)
        #     ?
        #         (abstract_declarator)
    
        my si:value_state_push
        my sym_declaration_specifiers
        my si:valuevalue_part
        my optional_1026
        my si:value_state_merge
        return
    }
    
    method optional_1026 {} {
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
        my sequence_1040
        my si:reduce_symbol_end parameter_list
        return
    }
    
    method sequence_1040 {} {
        # x
        #     (parameter_declaration)
        #     *
        #         x
        #             (COMMA)
        #             (parameter_declaration)
    
        my si:value_state_push
        my sym_parameter_declaration
        my si:valuevalue_part
        my kleene_1038
        my si:value_state_merge
        return
    }
    
    method kleene_1038 {} {
        # *
        #     x
        #         (COMMA)
        #         (parameter_declaration)
    
        while {1} {
            my si:void2_state_push
        my sequence_1036
            my si:kleene_close
        }
        return
    }
    
    method sequence_1036 {} {
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
        my sequence_1050
        my si:reduce_symbol_end parameter_type_list
        return
    }
    
    method sequence_1050 {} {
        # x
        #     (parameter_list)
        #     ?
        #         x
        #             (COMMA)
        #             (ELLIPSIS)
    
        my si:value_state_push
        my sym_parameter_list
        my si:valuevalue_part
        my optional_1048
        my si:value_state_merge
        return
    }
    
    method optional_1048 {} {
        # ?
        #     x
        #         (COMMA)
        #         (ELLIPSIS)
    
        my si:void2_state_push
        my sequence_1046
        my si:void_state_merge_ok
        return
    }
    
    method sequence_1046 {} {
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
        my sequence_1055
        my si:void_leaf_symbol_end PERCEN
        return
    }
    
    method sequence_1055 {} {
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
        my sequence_1060
        my si:void_leaf_symbol_end PERCENTEQUAL
        return
    }
    
    method sequence_1060 {} {
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
        my sequence_1065
        my si:void_leaf_symbol_end PLING
        return
    }
    
    method sequence_1065 {} {
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
        my sequence_1070
        my si:void_leaf_symbol_end PLINGEQUAL
        return
    }
    
    method sequence_1070 {} {
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
        my sequence_1075
        my si:void_leaf_symbol_end PLUS
        return
    }
    
    method sequence_1075 {} {
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
        my sequence_1080
        my si:void_leaf_symbol_end PLUSEQUAL
        return
    }
    
    method sequence_1080 {} {
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
        my sequence_1085
        my si:void_leaf_symbol_end PLUSPLUS
        return
    }
    
    method sequence_1085 {} {
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
        my poskleene_1093
        my si:reduce_symbol_end pointer
        return
    }
    
    method poskleene_1093 {} {
        # +
        #     x
        #         (STAR)
        #         ?
        #             (type_qualifier_list)
    
        my i_loc_push
        my sequence_1091
        my si:kleene_abort
        while {1} {
            my si:void2_state_push
        my sequence_1091
            my si:kleene_close
        }
        return
    }
    
    method sequence_1091 {} {
        # x
        #     (STAR)
        #     ?
        #         (type_qualifier_list)
    
        my si:value_state_push
        my sym_STAR
        my si:valuevalue_part
        my optional_367
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
        my sequence_1100
        my si:reduce_symbol_end postfix_expression
        return
    }
    
    method sequence_1100 {} {
        # x
        #     (postfix_expression_head)
        #     *
        #         (postfix_expression_tail)
    
        my si:value_state_push
        my sym_postfix_expression_head
        my si:valuevalue_part
        my kleene_1098
        my si:value_state_merge
        return
    }
    
    method kleene_1098 {} {
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
        my choice_1121
        my si:reduce_symbol_end postfix_expression_head
        return
    }
    
    method choice_1121 {} {
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
        my sequence_1110
        my si:valuevalue_branch
        my sequence_1119
        my si:value_state_merge
        return
    }
    
    method sequence_1110 {} {
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
    
    method sequence_1119 {} {
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
        my choice_1145
        my si:reduce_symbol_end postfix_expression_tail
        return
    }
    
    method choice_1145 {} {
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
        my sequence_1127
        my si:valuevalue_branch
        my sequence_1134
        my si:valuevalue_branch
        my sequence_307
        my si:valuevalue_branch
        my sequence_1141
        my si:valuevalue_branch
        my sym_PLUSPLUS
        my si:valuevalue_branch
        my sym_MINUSMINUS
        my si:value_state_merge
        return
    }
    
    method sequence_1127 {} {
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
    
    method sequence_1134 {} {
        # x
        #     (LPAREN)
        #     ?
        #         (argument_expression_list)
        #     (RPAREN)
    
        my si:value_state_push
        my sym_LPAREN
        my si:valuevalue_part
        my optional_1131
        my si:valuevalue_part
        my sym_RPAREN
        my si:value_state_merge
        return
    }
    
    method optional_1131 {} {
        # ?
        #     (argument_expression_list)
    
        my si:void2_state_push
        my sym_argument_expression_list
        my si:void_state_merge_ok
        return
    }
    
    method sequence_1141 {} {
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
        my choice_1156
        my si:reduce_symbol_end primary_expression
        return
    }
    
    method choice_1156 {} {
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
        my sequence_1154
        my si:value_state_merge
        return
    }
    
    method sequence_1154 {} {
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
        my sequence_1161
        my si:void_leaf_symbol_end ptrdiff_t
        return
    }
    
    method sequence_1161 {} {
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
        my sequence_1166
        my si:void_leaf_symbol_end QUERY
        return
    }
    
    method sequence_1166 {} {
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
        my sequence_1171
        my si:void_leaf_symbol_end RBRACE
        return
    }
    
    method sequence_1171 {} {
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
        my sequence_1176
        my si:void_leaf_symbol_end RBRACKET
        return
    }
    
    method sequence_1176 {} {
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
        my sequence_1181
        my si:void_leaf_symbol_end register
        return
    }
    
    method sequence_1181 {} {
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
        my sequence_1196
        my si:reduce_symbol_end relational_expression
        return
    }
    
    method sequence_1196 {} {
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
        my kleene_1194
        my si:value_state_merge
        return
    }
    
    method kleene_1194 {} {
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
        my sequence_1192
            my si:kleene_close
        }
        return
    }
    
    method sequence_1192 {} {
        # x
        #     /
        #         (LESSEQUAL)
        #         (GREATEREQUAL)
        #         (LESS)
        #         (GREATER)
        #     (shift_expression)
    
        my si:value_state_push
        my choice_1189
        my si:valuevalue_part
        my sym_shift_expression
        my si:value_state_merge
        return
    }
    
    method choice_1189 {} {
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
        my sequence_1201
        my si:void_leaf_symbol_end restrict
        return
    }
    
    method sequence_1201 {} {
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
        my sequence_1206
        my si:void_leaf_symbol_end RPAREN
        return
    }
    
    method sequence_1206 {} {
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
        my choice_1211
        my si:reduce_symbol_end s_char
        return
    }
    
    method choice_1211 {} {
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
        my sequence_1216
        my si:void_clear_symbol_end SEMICOLON
        return
    }
    
    method sequence_1216 {} {
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
        my sequence_1229
        my si:reduce_symbol_end shift_expression
        return
    }
    
    method sequence_1229 {} {
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
        my kleene_1227
        my si:value_state_merge
        return
    }
    
    method kleene_1227 {} {
        # *
        #     x
        #         /
        #             (LESSLESS)
        #             (GREATERGREATER)
        #         (additive_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_1225
            my si:kleene_close
        }
        return
    }
    
    method sequence_1225 {} {
        # x
        #     /
        #         (LESSLESS)
        #         (GREATERGREATER)
        #     (additive_expression)
    
        my si:value_state_push
        my choice_1222
        my si:valuevalue_part
        my sym_additive_expression
        my si:value_state_merge
        return
    }
    
    method choice_1222 {} {
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
        my sequence_1234
        my si:void_leaf_symbol_end short
        return
    }
    
    method sequence_1234 {} {
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
        my sequence_1241
        my si:void_leaf_symbol_end signed
        return
    }
    
    method sequence_1241 {} {
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
        my sequence_1246
        my si:void_leaf_symbol_end simple_escape_sequence
        return
    }
    
    method sequence_1246 {} {
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
        my sequence_1251
        my si:void_leaf_symbol_end size_t
        return
    }
    
    method sequence_1251 {} {
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
        my sequence_1256
        my si:void_leaf_symbol_end sizeof
        return
    }
    
    method sequence_1256 {} {
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
        my sequence_1261
        my si:void_leaf_symbol_end SLASH
        return
    }
    
    method sequence_1261 {} {
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
        my sequence_1266
        my si:void_leaf_symbol_end SLASHEQUAL
        return
    }
    
    method sequence_1266 {} {
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
        my poskleene_1273
        my si:reduce_symbol_end specifier_qualifier_list
        return
    }
    
    method poskleene_1273 {} {
        # +
        #     /
        #         (type_specifier)
        #         (type_qualifier)
    
        my i_loc_push
        my choice_1271
        my si:kleene_abort
        while {1} {
            my si:void2_state_push
        my choice_1271
            my si:kleene_close
        }
        return
    }
    
    method choice_1271 {} {
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
        my sequence_1278
        my si:void_leaf_symbol_end STAR
        return
    }
    
    method sequence_1278 {} {
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
        my sequence_1283
        my si:void_leaf_symbol_end STAREQUAL
        return
    }
    
    method sequence_1283 {} {
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
        my sequence_1288
        my si:void_leaf_symbol_end static
        return
    }
    
    method sequence_1288 {} {
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
        my choice_1296
        my si:reduce_symbol_end storage_class_specifier
        return
    }
    
    method choice_1296 {} {
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
        my sequence_1306
        my si:reduce_symbol_end string_literal
        return
    }
    
    method sequence_1306 {} {
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
        my kleene_1303
        my si:valuevalue_part
        my si:next_char \42
        my si:value_state_merge
        return
    }
    
    method kleene_1303 {} {
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
        my sequence_1311
        my si:void_leaf_symbol_end struct
        return
    }
    
    method sequence_1311 {} {
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
        my sequence_1317
        my si:reduce_symbol_end struct_declaration
        return
    }
    
    method sequence_1317 {} {
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
        my poskleene_1321
        my si:reduce_symbol_end struct_declaration_list
        return
    }
    
    method poskleene_1321 {} {
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
        my choice_1332
        my si:reduce_symbol_end struct_declarator
        return
    }
    
    method choice_1332 {} {
        # /
        #     x
        #         ?
        #             (declarator)
        #         (COLON)
        #         (constant_expression)
        #     (declarator)
    
        my si:value_state_push
        my sequence_1329
        my si:valuevalue_branch
        my sym_declarator
        my si:value_state_merge
        return
    }
    
    method sequence_1329 {} {
        # x
        #     ?
        #         (declarator)
        #     (COLON)
        #     (constant_expression)
    
        my si:value_state_push
        my optional_1325
        my si:valuevalue_part
        my sym_COLON
        my si:valuevalue_part
        my sym_constant_expression
        my si:value_state_merge
        return
    }
    
    method optional_1325 {} {
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
        my sequence_1342
        my si:reduce_symbol_end struct_declarator_list
        return
    }
    
    method sequence_1342 {} {
        # x
        #     (struct_declarator)
        #     *
        #         x
        #             (COMMA)
        #             (struct_declarator)
    
        my si:value_state_push
        my sym_struct_declarator
        my si:valuevalue_part
        my kleene_1340
        my si:value_state_merge
        return
    }
    
    method kleene_1340 {} {
        # *
        #     x
        #         (COMMA)
        #         (struct_declarator)
    
        while {1} {
            my si:void2_state_push
        my sequence_1338
            my si:kleene_close
        }
        return
    }
    
    method sequence_1338 {} {
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
        my choice_1347
        my si:reduce_symbol_end struct_or_union
        return
    }
    
    method choice_1347 {} {
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
        my choice_1362
        my si:reduce_symbol_end struct_or_union_specifier
        return
    }
    
    method choice_1362 {} {
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
        my sequence_1356
        my si:valuevalue_branch
        my sequence_1360
        my si:value_state_merge
        return
    }
    
    method sequence_1356 {} {
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
        my optional_433
        my si:valuevalue_part
        my sym_LBRACE
        my si:valuevalue_part
        my sym_struct_declaration_list
        my si:valuevalue_part
        my sym_RBRACE
        my si:value_state_merge
        return
    }
    
    method sequence_1360 {} {
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
        my sequence_1367
        my si:void_leaf_symbol_end TILDE
        return
    }
    
    method sequence_1367 {} {
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
        my sequence_1374
        my si:reduce_symbol_end type_name
        return
    }
    
    method sequence_1374 {} {
        # x
        #     (specifier_qualifier_list)
        #     ?
        #         (abstract_declarator)
        #     (EOF)
    
        my si:value_state_push
        my sym_specifier_qualifier_list
        my si:valuevalue_part
        my optional_1026
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
        my choice_1380
        my si:reduce_symbol_end type_qualifier
        return
    }
    
    method choice_1380 {} {
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
        my poskleene_1384
        my si:reduce_symbol_end type_qualifier_list
        return
    }
    
    method poskleene_1384 {} {
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
        #     (struct_or_union_specifier)
        #     (enum_specifier)
        #     (uint8_t)
        #     (uint16_t)
        #     (uint32_t)
        #     (uint64_t)
        #     (int8_t)
        #     (int16_t)
        #     (int32_t)
        #     (int64_t)
        #     (int_least8_t)
        #     (int_least16_t)
        #     (int_least32_t)
        #     (int_least64_t)
        #     (uint_least8_t)
        #     (uint_least16_t)
        #     (uint_least32_t)
        #     (uint_least64_t)
        #     (int_fast8_t)
        #     (int_fast16_t)
        #     (int_fast32_t)
        #     (int_fast64_t)
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
        #     (typedef_name)
    
        my si:value_symbol_start type_specifier
        my choice_1435
        my si:reduce_symbol_end type_specifier
        return
    }
    
    method choice_1435 {} {
        # /
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
        #     (struct_or_union_specifier)
        #     (enum_specifier)
        #     (uint8_t)
        #     (uint16_t)
        #     (uint32_t)
        #     (uint64_t)
        #     (int8_t)
        #     (int16_t)
        #     (int32_t)
        #     (int64_t)
        #     (int_least8_t)
        #     (int_least16_t)
        #     (int_least32_t)
        #     (int_least64_t)
        #     (uint_least8_t)
        #     (uint_least16_t)
        #     (uint_least32_t)
        #     (uint_least64_t)
        #     (int_fast8_t)
        #     (int_fast16_t)
        #     (int_fast32_t)
        #     (int_fast64_t)
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
        #     (typedef_name)
    
        my si:value_state_push
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
        my sym_struct_or_union_specifier
        my si:valuevalue_branch
        my sym_enum_specifier
        my si:valuevalue_branch
        my sym_uint8_t
        my si:valuevalue_branch
        my sym_uint16_t
        my si:valuevalue_branch
        my sym_uint32_t
        my si:valuevalue_branch
        my sym_uint64_t
        my si:valuevalue_branch
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
        my sym_uint_least8_t
        my si:valuevalue_branch
        my sym_uint_least16_t
        my si:valuevalue_branch
        my sym_uint_least32_t
        my si:valuevalue_branch
        my sym_uint_least64_t
        my si:valuevalue_branch
        my sym_int_fast8_t
        my si:valuevalue_branch
        my sym_int_fast16_t
        my si:valuevalue_branch
        my sym_int_fast32_t
        my si:valuevalue_branch
        my sym_int_fast64_t
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
        my sequence_1440
        my si:void_leaf_symbol_end typedef
        return
    }
    
    method sequence_1440 {} {
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
        #     (declared_typename)
        #     (named_typename)
    
        my si:value_symbol_start typedef_name
        my choice_1445
        my si:reduce_symbol_end typedef_name
        return
    }
    
    method choice_1445 {} {
        # /
        #     (declared_typename)
        #     (named_typename)
    
        my si:value_state_push
        my sym_declared_typename
        my si:valuevalue_branch
        my sym_named_typename
        my si:value_state_merge
        return
    }
    
    #
    # leaf Symbol 'TYPENAME'
    #
    
    method sym_TYPENAME {} {
        # x
        #     "typename"
        #     (WHITESPACE)
    
        my si:void_symbol_start TYPENAME
        my sequence_1450
        my si:void_leaf_symbol_end TYPENAME
        return
    }
    
    method sequence_1450 {} {
        # x
        #     "typename"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_str typename
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
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
        my sequence_1455
        my si:void_leaf_symbol_end uint8_t
        return
    }
    
    method sequence_1455 {} {
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
        my sequence_1460
        my si:void_leaf_symbol_end uint16_t
        return
    }
    
    method sequence_1460 {} {
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
        my sequence_1465
        my si:void_leaf_symbol_end uint32_t
        return
    }
    
    method sequence_1465 {} {
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
        my sequence_1470
        my si:void_leaf_symbol_end uint64_t
        return
    }
    
    method sequence_1470 {} {
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
        my sequence_1475
        my si:void_leaf_symbol_end uint_fast8_t
        return
    }
    
    method sequence_1475 {} {
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
        my sequence_1480
        my si:void_leaf_symbol_end uint_fast16_t
        return
    }
    
    method sequence_1480 {} {
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
        my sequence_1485
        my si:void_leaf_symbol_end uint_fast32_t
        return
    }
    
    method sequence_1485 {} {
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
        my sequence_1490
        my si:void_leaf_symbol_end uint_fast64_t
        return
    }
    
    method sequence_1490 {} {
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
        my sequence_1495
        my si:void_leaf_symbol_end uint_least8_t
        return
    }
    
    method sequence_1495 {} {
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
        my sequence_1500
        my si:void_leaf_symbol_end uint_least16_t
        return
    }
    
    method sequence_1500 {} {
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
        my sequence_1505
        my si:void_leaf_symbol_end uint_least32_t
        return
    }
    
    method sequence_1505 {} {
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
        my sequence_1510
        my si:void_leaf_symbol_end uint_least64_t
        return
    }
    
    method sequence_1510 {} {
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
        my sequence_1515
        my si:void_leaf_symbol_end uintmax_t
        return
    }
    
    method sequence_1515 {} {
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
        my sequence_1520
        my si:void_leaf_symbol_end uintptr_t
        return
    }
    
    method sequence_1520 {} {
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
        my choice_1546
        my si:reduce_symbol_end unary_expression
        return
    }
    
    method choice_1546 {} {
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
        my sequence_1526
        my si:valuevalue_branch
        my sequence_1530
        my si:valuevalue_branch
        my sequence_1534
        my si:valuevalue_branch
        my sequence_1538
        my si:valuevalue_branch
        my sequence_1544
        my si:value_state_merge
        return
    }
    
    method sequence_1526 {} {
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
    
    method sequence_1530 {} {
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
    
    method sequence_1534 {} {
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
    
    method sequence_1538 {} {
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
    
    method sequence_1544 {} {
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
        my choice_1555
        my si:reduce_symbol_end unary_operator
        return
    }
    
    method choice_1555 {} {
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
        my sequence_1560
        my si:void_leaf_symbol_end union
        return
    }
    
    method sequence_1560 {} {
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
        my sequence_1565
        my si:void_leaf_symbol_end unsigned
        return
    }
    
    method sequence_1565 {} {
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
        my sequence_1572
        my si:void_leaf_symbol_end void
        return
    }
    
    method sequence_1572 {} {
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
        my sequence_1577
        my si:void_leaf_symbol_end volatile
        return
    }
    
    method sequence_1577 {} {
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
        my kleene_1581
        my si:void_clear_symbol_end WHITESPACE
        return
    }
    
    method kleene_1581 {} {
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