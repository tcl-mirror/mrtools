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
        my choice_1435
        my si:reduce_symbol_end type_specifier
        return
    }
    
    method choice_1435 {} {
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

package provide typeparser 1.0

# DO NOT EDIT THIS FILE!
# THIS FILE IS AUTOMATICALLY GENERATED FROM A LITERATE PROGRAM SOURCE FILE.
#
# This software is copyrighted 2015 - 2019 by G. Andrew Mangogna.
# The following terms apply to all files associated with the software unless
# explicitly disclaimed in individual files.
# 
# The authors hereby grant permission to use, copy, modify, distribute,
# and license this software and its documentation for any purpose, provided
# that existing copyright notices are retained in all copies and that this
# notice is included verbatim in any distributions. No written agreement,
# license, or royalty fee is required for any of the authorized uses.
# Modifications to this software may be copyrighted by their authors and
# need not follow the licensing terms described here, provided that the
# new terms are clearly indicated on the first page of each file where
# they apply.
# 
# IN NO EVENT SHALL THE AUTHORS OR DISTRIBUTORS BE LIABLE TO ANY PARTY FOR
# DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING
# OUT OF THE USE OF THIS SOFTWARE, ITS DOCUMENTATION, OR ANY DERIVATIVES
# THEREOF, EVEN IF THE AUTHORS HAVE BEEN ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
# 
# THE AUTHORS AND DISTRIBUTORS SPECIFICALLY DISCLAIM ANY WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT.  THIS SOFTWARE
# IS PROVIDED ON AN "AS IS" BASIS, AND THE AUTHORS AND DISTRIBUTORS HAVE
# NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS,
# OR MODIFICATIONS.
# 
# GOVERNMENT USE: If you are acquiring this software on behalf of the
# U.S. government, the Government shall have only "Restricted Rights"
# in the software and related documentation as defined in the Federal
# Acquisition Regulations (FARs) in Clause 52.227.19 (c) (2).  If you
# are acquiring the software on behalf of the Department of Defense,
# the software shall be classified as "Commercial Computer Software"
# and the Government shall have only "Restricted Rights" as defined in
# Clause 252.227-7013 (c) (1) of DFARs.  Notwithstanding the foregoing,
# the authors grant the U.S. Government and others acting in its behalf
# permission to use and distribute the software in accordance with the
# terms specified in this license.

package require Tcl 8.6
package require logger
package require logger::utils
package require logger::appender

package require rosea
package require textutil::expander
package require textutil::adjust
package require oo::util
package require pt::util

rosea configure {
    domain micca {
        operation generate {args} {
            return [@Gen@::miccaGenerate $args]
        }
        operation configure {script} {
            return [@Config@::miccaConfigure $script]
        }
        operation configureFromChan {chan} {
            return [@Config@::miccaConfigure [::chan read -nonewline $chan]]
        }
        operation configureFromFile {filename} {
            namespace upvar @Config@ configfile configfile
            set configfile $filename
            set chan [::open $filename r]
            try {
                return [@Config@::miccaConfigure [::chan read -nonewline $chan]]
            } finally {
                ::chan close $chan
                set configfile {}
            }
        }
        operation clear {} {
            return [@Config@::miccaClear]
        }
        class Domain {
            attribute Name string -id 1\
                -check {[::micca::@Config@::Helpers::isIdentifier $Name]}
            attribute Interface string -default {}
            attribute Prologue string -default {}
            attribute Epilogue string -default {}
        }
        class DomainElement {
            attribute Domain string -id 1
            attribute Name string -id 1\
                -check {[::micca::@Config@::Helpers::isIdentifier $Name] &&\
                    ![::regexp -- {__[A-Z]+\Z} $Name]} ; # <1>
        
            reference R1 Domain -link {Domain Name}
        }
        association R1 DomainElement 0..*--1 Domain
        class Class {
            attribute Domain string -id 1 -id 2
            attribute Name string -id 1 ; # <1>
            attribute Number int -id 2
        
            reference R2 DomainElement -link Domain -link Name
            reference R104 ValueElement -link Domain -link Name
        }
        class Relationship {
            attribute Domain string -id 1 -id 2
            attribute Name string -id 1
            attribute Number int -id 2 -system 0
        
            reference R2 DomainElement -link Domain -link Name
        }
        generalization R2 DomainElement Class Relationship ExternalEntity
        class DomainOperation {
            attribute Domain string -id 1
            attribute Name string -id 1\
                -check {[::micca::@Config@::Helpers::isIdentifier $Name]}
            attribute Body string
            attribute ReturnDataType string\
                -check {[::micca::@Config@::Helpers::typeCheck verifyTypeName\
                    $ReturnDataType]}
            attribute Comment string -default {}
            attribute File string
            attribute Line int
        
            reference R5 Domain -link {Domain Name}
        }
        association R5 DomainOperation 0..*--1 Domain
        class DomainOperationParameter {
            attribute Domain string -id 1 -id 2
            attribute Operation string -id 1 -id 2
            attribute Name string -id 1\
                -check {[::micca::@Config@::Helpers::isIdentifier $Name]}
            attribute Number int -id 2
            attribute DataType string\
                -check {[::micca::@Config@::Helpers::typeCheck verifyTypeName $DataType]}
        
            reference R6 DomainOperation -link Domain -link {Operation Name}
        }
        association R6 DomainOperationParameter 0..*--1 DomainOperation
        class ExternalEntity {
            attribute Domain string -id 1
            attribute Name string -id 1\
                -check {[::micca::@Config@::Helpers::isIdentifier $Name]}
        
            reference R2 DomainElement -link Domain -link Name
        }
        class ExternalOperation {
            attribute Domain string -id 1
            attribute Entity string -id 1
            attribute Name string -id 1\
                -check {[::micca::@Config@::Helpers::isIdentifier $Name]}
            attribute Body string -default {}
            attribute ReturnDataType string\
                -check {[::micca::@Config@::Helpers::typeCheck verifyTypeName\
                    $ReturnDataType]}
            attribute Comment string -default {}
            attribute File string
            attribute Line int
        
            reference R10 ExternalEntity -link Domain -link {Entity Name}
        }
        association R10 ExternalOperation 1..*--1 ExternalEntity
        class ExternalOperationParameter {
            attribute Domain string -id 1 -id 2
            attribute Entity string -id 1 -id 2
            attribute Operation string -id 1 -id 2
            attribute Name string -id 1\
                -check {[::micca::@Config@::Helpers::isIdentifier $Name]}
            attribute Number int -id 2
            attribute DataType string\
                -check {[::micca::@Config@::Helpers::typeCheck verifyTypeName $DataType]}
        
            reference R11 ExternalOperation -link Domain -link Entity\
                    -link {Operation Name}
        }
        association R11 ExternalOperationParameter 0..*--1 ExternalOperation
        class Constructor {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Body string
            attribute File string
            attribute Line int
        
            reference R8 Class -link Domain -link {Class Name}
        }
        association R8 Constructor 0..*--1 Class
        class Destructor {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Body string
            attribute File string
            attribute Line int
        
            reference R9 Class -link Domain -link {Class Name}
        }
        association R9 Destructor 0..*--1 Class
        class Operation {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1\
                -check {[::micca::@Config@::Helpers::isIdentifier $Name]}
            attribute IsInstance boolean
            attribute Body string
            attribute ReturnDataType string\
                -check {[::micca::@Config@::Helpers::typeCheck verifyTypeName\
                    $ReturnDataType]}
            attribute File string
            attribute Line int
        
            reference R3 Class -link Domain -link {Class Name}
        }
        association R3 Operation 0..*--1 Class
        class OperationParameter {
            attribute Domain string -id 1 -id 2
            attribute Class string -id 1 -id 2
            attribute Operation string -id 1 -id 2
            attribute Name string -id 1\
                -check {[::micca::@Config@::Helpers::isIdentifier $Name]}
            attribute Number int -id 2
            attribute DataType string\
                -check {[::micca::@Config@::Helpers::typeCheck verifyTypeName $DataType]}
        
            reference R4 Operation -link Domain -link Class -link {Operation Name}
        }
        association R4 OperationParameter 0..*--1 Operation
        class TypeAlias {
            attribute Domain string -id 1
            attribute TypeName string -id 1\
                -check {[::micca::@Config@::Helpers::isIdentifier $TypeName]}
            attribute TypeDefinition string\
                -check {[::micca::@Config@::Helpers::typeCheck verifyTypeName\
                    $TypeDefinition]}
        
            reference R7 Domain -link {Domain Name}
        }
        association R7 TypeAlias 0..*--1 Domain
        class ClassComponent {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R20 Class -link Domain -link {Class Name}
        }
        association R20 ClassComponent 1..*--1 Class
        generalization R25 ClassComponent GeneratedComponent PopulatedComponent
        class PopulatedComponent {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R25 ClassComponent -link Domain -link Class -link Name
        }
        class GeneratedComponent {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R25 ClassComponent -link Domain -link Class -link Name
        }
        generalization R21 PopulatedComponent Attribute Reference
        class Attribute {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1\
                -check {[::micca::@Config@::Helpers::isIdentifier $Name]}
            attribute DataType string\
                -check {[::micca::@Config@::Helpers::typeCheck verifyTypeName $DataType]}
        
            reference R21 PopulatedComponent -link Domain -link Class -link Name
        }
        class IndependentAttribute {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R29 Attribute -link Domain -link Class -link Name
        }
        class DependentAttribute {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
            attribute Formula string
            attribute File string
            attribute Line int
        
            reference R29 Attribute -link Domain -link Class -link Name
        }
        generalization R29 Attribute IndependentAttribute DependentAttribute
        generalization R19 IndependentAttribute\
                ValueInitializedAttribute ZeroInitializedAttribute
        class ValueInitializedAttribute {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R19 IndependentAttribute -link Domain -link Class -link Name
        }
        class ZeroInitializedAttribute {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R19 IndependentAttribute -link Domain -link Class -link Name
        }
        class DefaultValue {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Attribute string -id 1
            attribute Value string
        
            reference R22 ValueInitializedAttribute -link Domain -link Class\
                    -link {Attribute Name}
        }
        association R22 DefaultValue 0..1--1 ValueInitializedAttribute
        class Reference {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R21 PopulatedComponent -link Domain -link Class -link Name
        }
        generalization R23 Reference\
            AssociationReference AssociatorReference SuperclassReference
        class AssociationReference {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R23 Reference -link Domain -link Class -link Name
        }
        class AssociatorReference {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R23 Reference -link Domain -link Class -link Name
        }
        class SuperclassReference {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R23 Reference -link Domain -link Class -link Name
        }
        generalization R24 GeneratedComponent ComplementaryReference LinkContainer\
                SubclassContainer SubclassReference
        class ComplementaryReference {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R24 GeneratedComponent -link Domain -link Class -link Name
        }
        class LinkContainer {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
            attribute LinkClass string
            attribute LinkComp string
        
            reference R24 GeneratedComponent -link Domain -link Class -link Name
            reference R27 LinkReference -link Domain -link {LinkClass Class}\
                    -link {LinkComp Name}
        }
        class SubclassContainer {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R24 GeneratedComponent -link Domain -link Class -link Name
        }
        class SubclassReference {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R24 GeneratedComponent -link Domain -link Class -link Name
        }
        generalization R26 ComplementaryReference SingularReference ArrayReference\
                LinkReference
        class SingularReference {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R26 ComplementaryReference -link Domain -link Class -link Name
        }
        class ArrayReference {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R26 ComplementaryReference -link Domain -link Class -link Name
        }
        class LinkReference {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Name string -id 1
        
            reference R26 ComplementaryReference -link Domain -link Class -link Name
        }
        association R27 LinkContainer 1--1 LinkReference
        generalization R28 ComplementaryReference ForwardReference BackwardReference
        class ForwardReference {
            attribute Domain string -id 1 -id 2
            attribute Class string -id 1 -id 2
            attribute Name string -id 1
            attribute Relationship string -id 2
        
            reference R28 ComplementaryReference -link Domain -link Class -link Name
        }
        class BackwardReference {
            attribute Domain string -id 1 -id 2
            attribute Class string -id 1 -id 2
            attribute Name string -id 1
            attribute Relationship string -id 2
        
            reference R28 ComplementaryReference -link Domain -link Class -link Name
        }
        class Association {
            attribute Domain string -id 1
            attribute Name string -id 1
            attribute IsStatic boolean -default false
        
            reference R30 Relationship -link Domain -link Name
        }
        class Generalization {
            attribute Domain string -id 1
            attribute Name string -id 1
        
            reference R30 Relationship -link Domain -link Name
        }
        generalization R30 Relationship Association Generalization
        generalization R31 Association ClassBasedAssociation SimpleAssociation
        class ClassBasedAssociation {
            attribute Domain string -id 1
            attribute Name string -id 1
        
            reference R31 Association -link Domain -link Name
        }
        class SimpleAssociation {
            attribute Domain string -id 1
            attribute Name string -id 1
        
            reference R31 Association -link Domain -link Name
        }
        generalization R43 Generalization ReferenceGeneralization UnionGeneralization
        class ReferenceGeneralization {
            attribute Domain string -id 1
            attribute Name string -id 1
        
            reference R43 Generalization -link Domain -link Name
        }
        class UnionGeneralization {
            attribute Domain string -id 1
            attribute Name string -id 1
        
            reference R43 Generalization -link Domain -link Name
        }
        class SimpleReferringClass {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Relationship string -id 1
            attribute Role string -id 1
            attribute Conditionality boolean
            attribute Multiplicity boolean
        
            reference R32 SimpleAssociation -link Domain -link {Relationship Name}
            reference R40 ClassRole\
                -link Domain -link Class -link Relationship -link Role
            reference R90 AssociationReference -link Domain -link Class\
                    -link {Relationship Name}
        }
        association R32 SimpleReferringClass 1--1 SimpleAssociation
        class SimpleReferencedClass {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Relationship string -id 1
            attribute Role string -id 1
        
            reference R33 SimpleAssociation -link Domain -link {Relationship Name}
            reference R38 DestinationClass\
                -link Domain -link Class -link Relationship -link Role
        }
        association R33 SimpleReferencedClass 1--1 SimpleAssociation
        class SourceClass {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Relationship string -id 1
            attribute Role string -id 1
            attribute Conditionality boolean
            attribute Multiplicity boolean
        
            reference R34 ClassBasedAssociation -link Domain -link {Relationship Name}
            reference R40 ClassRole\
                -link Domain -link Class -link Relationship -link Role
            reference R95 ForwardReference -link Domain -link Class -link Relationship\
                -refid 2
        }
        association R34 SourceClass 1--1 ClassBasedAssociation
        class TargetClass {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Relationship string -id 1
            attribute Role string -id 1
            attribute Conditionality boolean
            attribute Multiplicity boolean
        
            reference R35 ClassBasedAssociation -link Domain -link {Relationship Name}
            reference R38 DestinationClass\
                -link Domain -link Class -link Relationship -link Role
        }
        association R35 TargetClass 1--1 ClassBasedAssociation
        class AssociatorClass {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Relationship string -id 1
            attribute Role string -id 1
            attribute Multiplicity boolean
        
            reference R42 ClassBasedAssociation -link Domain -link {Relationship Name}
            reference R40 ClassRole -link Domain -link Class -link Relationship -link Role
            reference R93 AssociatorReference -link Domain -link Class\
                -link {Relationship Name}
        }
        association R42 AssociatorClass 1--1 ClassBasedAssociation
        generalization R38 DestinationClass\
            SimpleReferencedClass TargetClass
        class DestinationClass {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Relationship string -id 1
            attribute Role string -id 1
        
            reference R40 ClassRole -link Domain -link Class -link Relationship -link Role
            reference R94 BackwardReference -link Domain -link Class -link Relationship\
                -refid 2
        }
        class ReferencedSuperclass {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Relationship string -id 1
            attribute Role string -id 1
        
            reference R36 ReferenceGeneralization -link Domain -link {Relationship Name}
            reference R48 Superclass -link Domain -link Class\
                    -link Relationship -link Role
            reference R92 SubclassReference -link Domain -link Class\
                    -link {Relationship Name}
        }
        association R36 ReferencedSuperclass 1--1 ReferenceGeneralization
        class ReferringSubclass {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Relationship string -id 1
            attribute Role string -id 1
        
            reference R37 ReferenceGeneralization -link Domain -link {Relationship Name}
            reference R47 Subclass -link Domain -link Class -link Relationship -link Role
        }
        association R37 ReferringSubclass 1..*--1 ReferenceGeneralization
        class UnionSuperclass {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Relationship string -id 1
            attribute Role string -id 1
        
            reference R44 UnionGeneralization -link Domain -link {Relationship Name}
            reference R48 Superclass -link Domain -link Class\
                    -link Relationship -link Role
            reference R96 SubclassContainer -link Domain -link Class\
                -link {Relationship Name}
        }
        association R44 UnionSuperclass 1--1 UnionGeneralization
        class UnionSubclass {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Relationship string -id 1
            attribute Role string -id 1
        
            reference R47 Subclass -link Domain -link Class -link Relationship -link Role
            reference R45 UnionGeneralization -link Domain -link {Relationship Name}
        }
        association R45 UnionSubclass 1..*--1 UnionGeneralization
        class Superclass {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Relationship string -id 1
            attribute Role string -id 1
        
            reference R40 ClassRole -link Domain -link Class -link Relationship -link Role
        
            instop findSubclasses {} {
                set refsubs [findRelated $self {~R48 ReferencedSuperclass} R36 ~R37 R47]
                set usubs [findRelated $self {~R48 UnionSuperclass} R44 ~R45 R47]
                return [refUnion $refsubs $usubs]
            }
        }
        generalization R48 Superclass ReferencedSuperclass UnionSuperclass
        class Subclass {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Relationship string -id 1
            attribute Role string -id 1
        
            reference R40 ClassRole -link Domain -link Class -link Relationship -link Role
            reference R91 SuperclassReference -link Domain -link Class\
                    -link {Relationship Name}
        }
        generalization R47 Subclass ReferringSubclass UnionSubclass
        class ClassRole {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Relationship string -id 1
            attribute Role string -id 1 -check {$Role in {source target associator}}
        
            reference R41 Relationship -link Domain -link {Relationship Name}
            reference R41 Class -link Domain -link {Class Name}
        }
        generalization R40 ClassRole SimpleReferringClass DestinationClass\
                SourceClass AssociatorClass Superclass Subclass
        association R41 Relationship 0..*--1..* Class -associator ClassRole
        association R90 SimpleReferringClass 1--1 AssociationReference
        association R91 Subclass 1--1 SuperclassReference
        association R94 DestinationClass 1--1 BackwardReference
        association R95 SourceClass 1--1 ForwardReference
        association R92 ReferencedSuperclass 1--1 SubclassReference
        association R93 AssociatorClass 1--1 AssociatorReference
        association R96 UnionSuperclass 1--1 SubclassContainer
        class StateModel {
            attribute Domain string -id 1
            attribute Model string -id 1
            attribute InitialState string
            attribute DefaultTrans string
        
            reference R58 State -link Domain -link Model -link {InitialState Name}
            reference R59 TransitionRule -link {DefaultTrans Name}
        }
        association R58 StateModel 0..1--1 State
        association R59 StateModel 0..*--1 TransitionRule
        generalization R50 StateModel InstanceStateModel AssignerStateModel
        class InstanceStateModel {
            attribute Domain string -id 1
            attribute Class string -id 1
        
            reference R50 StateModel -link Domain -link {Class Model}
            reference R51 Class -link Domain -link {Class Name}
        }
        association R51 InstanceStateModel 0..1--1 Class
        class AssignerStateModel {
            attribute Domain string -id 1
            attribute Association string -id 1
        
            reference R50 StateModel -link Domain -link {Association Model}
            reference R52 Association -link Domain -link {Association Name}
        }
        association R52 AssignerStateModel 0..1--1 Association
        class State {
            attribute Domain string -id 1
            attribute Model string -id 1
            attribute Name string -id 1\
                -check {[::micca::@Config@::Helpers::isIdentifier $Name]}
            attribute Activity string
            attribute File string
            attribute Line int
            attribute IsFinal boolean
            attribute PSigID string
        
            reference R55 StateModel -link Domain -link Model
            reference R57 StatePlace -link Domain -link Model -link Name
            reference R78 ParameterSignature -link Domain -link PSigID
        }
        association R55 State 1..*--1 StateModel
        class CreationState {
            attribute Domain string -id 1
            attribute Model string -id 1
            attribute Name string -id 1
        
            reference R56 StateModel -link Domain -link Model
            reference R57 StatePlace -link Domain -link Model -link Name
        }
        association R56 CreationState 0..1--1 StateModel
        class StatePlace {
            attribute Domain string -id 1 -id 2
            attribute Model string -id 1 -id 2
            attribute Name string -id 1
            attribute Number int -id 2
        }
        generalization R57 StatePlace State CreationState
        class TransitionRule {
            attribute Name string -id 1 -check {$Name in {IG CH}}
        }
        generalization R53 AssignerStateModel SingleAssigner MultipleAssigner
        class SingleAssigner {
            attribute Domain string -id 1
            attribute Association string -id 1
        
            reference R53 AssignerStateModel -link Domain -link Association
        }
        class MultipleAssigner {
            attribute Domain string -id 1
            attribute Association string -id 1
            attribute Class string
        
            reference R53 AssignerStateModel -link Domain -link Association
            reference R54 Class -link Domain -link {Class Name}
            reference R104 ValueElement -link Domain -link {Association Name}
        }
        association R54 MultipleAssigner 0..*--1 Class
        class Event {
            attribute Domain string -id 1
            attribute Model string -id 1
            attribute Event string -id 1
            attribute PSigID string
            attribute Number int
        
            reference R69 ParameterSignature -link Domain -link PSigID
        }
        generalization R80 Event DeferredEvent TransitioningEvent
        class DeferredEvent {
            attribute Domain string -id 1
            attribute Model string -id 1
            attribute Event string -id 1
        
            reference R80 Event -link Domain -link Model -link Event
        }
        generalization R81 DeferredEvent PolymorphicEvent InheritedEvent
        class DeferralPath {
            attribute Domain string -id 1
            attribute Model string -id 1
            attribute Event string -id 1
            attribute Relationship string -id 1
            attribute Role string -id 1
        
            reference R86 DeferredEvent -link Domain -link Model -link Event
            reference R86 Superclass -link Domain -link {Model Class}\
                -link Relationship -link Role
        }
        association R86 Superclass 1..*--0..* DeferredEvent -associator DeferralPath
        class TransitioningEvent {
            attribute Domain string -id 1
            attribute Model string -id 1
            attribute Event string -id 1
        
            reference R80 Event -link Domain -link Model -link Event
            reference R87 StateModel -link Domain -link Model
        }
        generalization R82 TransitioningEvent MappedEvent LocalEvent
        association R87 TransitioningEvent 1..*--1 StateModel
        class PolymorphicEvent {
            attribute Domain string -id 1
            attribute Model string -id 1
            attribute Event string -id 1
        
            reference R81 DeferredEvent -link Domain -link Model -link Event
        }
        class InheritedEvent {
            attribute Domain string -id 1
            attribute Model string -id 1
            attribute Event string -id 1
        
            reference R81 DeferredEvent -link Domain -link Model -link Event
            reference R83 NonLocalEvent -link Domain -link Model -link Event
        }
        class MappedEvent {
            attribute Domain string -id 1
            attribute Model string -id 1
            attribute Event string -id 1
            attribute ParentModel string
        
            reference R82 TransitioningEvent -link Domain -link Model -link Event
            reference R83 NonLocalEvent -link Domain -link Model -link Event
            reference R84 DeferredEvent -link Domain -link {ParentModel Model}\
                -link Event
        }
        association R84 MappedEvent 0..*--1 DeferredEvent
        class LocalEvent {
            attribute Domain string -id 1
            attribute Model string -id 1
            attribute Event string -id 1
        
            reference R82 TransitioningEvent -link Domain -link Model -link Event
        }
        generalization R83 NonLocalEvent InheritedEvent MappedEvent
        class NonLocalEvent {
            attribute Domain string -id 1
            attribute Model string -id 1
            attribute Event string -id 1
            attribute Relationship string
            attribute Role string
        
            reference R85 Subclass -link Domain -link {Model Class} -link Relationship\
                -link Role
        }
        association R85 NonLocalEvent 0..*--1 Subclass
        class TransitionPlace {
            attribute Domain string -id 1
            attribute Model string -id 1
            attribute State string -id 1
            attribute Event string -id 1
        
            reference R70 StatePlace -link Domain -link Model -link {State Name}
            reference R70 TransitioningEvent -link Domain -link Model -link Event
        }
        association R70 StatePlace 0..*--0..* TransitioningEvent -associator TransitionPlace
        generalization R71 TransitionPlace StateTransition NonStateTransition
        class StateTransition {
            attribute Domain string -id 1
            attribute Model string -id 1
            attribute State string -id 1
            attribute Event string -id 1
            attribute NewState string
            attribute ASigID string
        
            reference R71 TransitionPlace -link Domain -link Model -link State\
                -link Event
            reference R72 State -link Domain -link Model -link {NewState Name}
            reference R74 ArgumentSignature -link Domain -link ASigID
        }
        association R72 StateTransition 0..*--1 State
        class NonStateTransition {
            attribute Domain string -id 1
            attribute Model string -id 1
            attribute State string -id 1
            attribute Event string -id 1
            attribute TransRule string
        
            reference R71 TransitionPlace -link Domain -link Model -link State\
                -link Event
            reference R73 TransitionRule -link {TransRule Name}
        }
        association R73 NonStateTransition 0..*--1 TransitionRule
        class ArgumentSignature {
            attribute Domain string -id 1
            attribute ASigID string -id 1
        }
        association R74 StateTransition 0..*--0..1 ArgumentSignature
        class ParameterSignature {
            attribute Domain string -id 1
            attribute PSigID string -id 1
            attribute ASigID string
        
            reference R76 ArgumentSignature -link Domain -link ASigID
        }
        association R76 ParameterSignature 1..*--1 ArgumentSignature
        association R78 State 0..*--0..1 ParameterSignature
        association R69 Event 0..*--0..1 ParameterSignature
        class Argument {
            attribute Domain string -id 1
            attribute ASigID string -id 1
            attribute Position int -id 1
            attribute DataType string\
                -check {[::micca::@Config@::Helpers::typeCheck verifyTypeName $DataType]}
        
            reference R75 ArgumentSignature -link Domain -link ASigID
        }
        association R75 Argument 1..*--1 ArgumentSignature
        class Parameter {
            attribute Domain string -id 1 -id 2
            attribute PSigID string -id 1 -id 2
            attribute Name string -id 1
            attribute Position int -id 2
            attribute ASigID string
        
            reference R77 Argument -link Domain -link ASigID -link Position
            reference R79 ParameterSignature -link Domain -link PSigID
        }
        association R77 Parameter 1..*--1 Argument
        association R79 Parameter 1..*--1 ParameterSignature
        class Population {
            attribute Domain string -id 1
        
            reference R100 Domain -link {Domain Name}
        }
        association R100 Population 0..1--1 Domain
        class ValueElement {
            attribute Domain string -id 1
            attribute Name string -id 1
        }
        generalization R104 ValueElement Class MultipleAssigner
        class ElementPopulation {
            attribute Domain string -id 1
            attribute Element string -id 1
        
            reference R101 Population -link Domain
            reference R101 ValueElement -link Domain -link {Element Name}
        }
        association R101 Population 0..*--1..* ValueElement -associator ElementPopulation
        generalization R105 ElementPopulation ClassPopulation AssignerPopulation
        class ClassPopulation {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Allocation int -check {$Allocation >= 0}
        
            reference R105 ElementPopulation -link Domain -link {Class Element}
        }
        class AssignerPopulation {
            attribute Domain string -id 1
            attribute Association string -id 1
        
            reference R105 ElementPopulation -link Domain -link {Association Element}
        }
        class ClassInstance {
            attribute Domain string -id 1 -id 2
            attribute Class string -id 1 -id 2
            attribute Instance string -id 1\
                -check {[::micca::@Config@::Helpers::isIdentifier $Instance]}
            attribute Number int -id 2
        
            reference R102 ClassPopulation -link Domain -link Class
        }
        association R102 ClassInstance 0..*--1 ClassPopulation
        class ClassComponentValue {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Component string -id 1
            attribute Instance string -id 1
        
            reference R103 ClassInstance -link Domain -link Class -link Instance
            reference R103 ClassComponent -link Domain -link Class -link {Component Name}
        }
        association R103 ClassInstance 0..*--1..* ClassComponent\
            -associator ClassComponentValue
        generalization R109 ClassComponentValue\
                SpecifiedComponentValue UnspecifiedComponentValue
        class SpecifiedComponentValue {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Component string -id 1
            attribute Instance string -id 1
            attribute Value string
        
            reference R109 ClassComponentValue -link Domain -link Class\
                    -link Component -link Instance
        }
        class UnspecifiedComponentValue {
            attribute Domain string -id 1
            attribute Class string -id 1
            attribute Component string -id 1
            attribute Instance string -id 1
        
            reference R109 ClassComponentValue -link Domain -link Class\
                    -link Component -link Instance
        }
        class MultipleAssignerInstance {
            attribute Domain string -id 1 -id 2
            attribute Association string -id 1 -id 2
            attribute Instance string -id 1
            attribute Number int -id 2
            attribute IdClass string
            attribute IdInstance string
        
            reference R107 AssignerPopulation -link Domain -link Association
            reference R106 MultipleAssigner -link Domain -link Association
            reference R108 ClassInstance -link Domain -link {IdClass Class}\
                -link {IdInstance Instance}
        }
        association R106 MultipleAssignerInstance 0..*--1 MultipleAssigner
        association R107 MultipleAssignerInstance 0..*--1 AssignerPopulation
        association R108 MultipleAssignerInstance 0..*--1 ClassInstance
    }
}
rosea generate micca

namespace eval ::micca {
    variable version 1.1.8

    set logger [::logger::init micca]
    set appenderType [expr {[dict exist [fconfigure stdout] -mode] ?\
            "colorConsole" : "console"}]
    ::logger::utils::applyAppender -appender $appenderType -serviceCmd $logger\
            -appenderArgs {-conversionPattern {%c: \[%p\] '%m'}}
    ::logger::import -all -force -namespace log micca
    
    if 0 {
    proc logproc {level txt} {
        if {[string match {-_logger*} $txt]} {
            set txt [lindex $txt end]
        }
        puts "micca: $level: $txt"
    }
    proc errorlogproc {txt} {
        logproc error $txt
    }
    proc warnlogproc {txt} {
        logproc warn $txt
    }
    log::logproc error [namespace current]::errorlogproc
    log::logproc warn [namespace current]::warnlogproc
    }

    namespace import\
        ::ral::relation\
        ::ral::tuple\
        ::ral::relformat\
        ::ralutil::pipe
    namespace import ::ral::relvar

    relvar procedural R74C StateTransition {
        set found 0
    
        set viaStateTrans [ralutil pipe {
            ral relation eliminate $StateTransition State |
            ral relation rename ~ NewState State
        }] ; # <1>
        # puts [ral relformat $viaStateTrans viaStateTrans]
    
        set viaState [ralutil pipe {
            ral relation semijoin\
                $StateTransition $State\
                    -using {Domain Domain Model Model NewState Name} |
            ralutil rvajoin ~ $ParameterSignature ASigIDs |
            ral relation extend ~ stup StateASigID string {
                [ral tuple extract $stup PSigID] eq {} ? {} :\
                    [ral tuple extract [ral relation tuple\
                    [ral tuple extract $stup ASigIDs]] ASigID]} |
            ral relation eliminate ~ Activity IsFinal PSigID ASigIDs |
            ral relation rename ~ Name State
        }] ; # <2>
        # puts [ral relformat $viaState viaState]
        set viaEvent [ralutil pipe {
            ral relation semijoin\
                $StateTransition $TransitionPlace\
                $TransitioningEvent $Event |
            ralutil rvajoin ~ $ParameterSignature ASigIDs |
            ral relation extend ~ stup EventASigID string {
                [ral tuple extract $stup PSigID] eq {} ? {} :\
                    [ral tuple extract [ral relation tuple\
                    [ral tuple extract $stup ASigIDs]] ASigID]} |
            ral relation eliminate ~ PSigID ASigIDs
        }] ; # <3>
        # puts [ral relformat $viaEvent viaEvent]
    
        set sigs [ral relation join $viaStateTrans $viaState $viaEvent] ; # <4>
    
        set badstates [ral relation restrict $sigs stup {
                [ral tuple extract $stup ASigID] ne\
                [ral tuple extract $stup StateASigID]}] ; # <5>
        # puts [ral relformat $badstates badstates]
    
        ral relation foreach badstate $badstates {
            incr found
            ral relation assign $badstate {Domain domain} {Model model} {Event event}\
                {State state}
            puts stderr "in domain, \"$domain\", state model for, \"$model\",\
                event, \"$event\", causes a transition to state, \"$state\",\
                but the state and event argument signatures do not match"
        }
    
        set badevts [ral relation restrict $sigs stup {
                [ral tuple extract $stup ASigID] ne\
                [ral tuple extract $stup EventASigID]}] ; # <6>
        # puts [ral relformat $badevts badevts]
    
        ral relation foreach badevt $badevts {
            incr found
            ral relation assign $badevt {Domain domain} {Model model} {Event event}\
                {State state}
            puts stderr "in domain, \"$domain\", state model for, \"$model\",\
                event, \"$event\", causes a transition to state, \"$state\",\
                but the event and state argument signatures do not match"
        }
    
        return [expr {$found == 0}]
    }
    namespace eval @Config@ {
        ::logger::import -all -force -namespace log micca
    
        namespace import\
            ::ral::relation\
            ::ral::tuple\
            ::ral::relformat\
            ::ralutil::pipe
        namespace eval Helpers {
            ::logger::import -all -force -namespace log micca
        
            namespace import\
                ::ral::relation\
                ::ral::tuple\
                ::ral::relformat\
                ::ralutil::pipe
            namespace import ::ral::relvar
            namespace path {::micca ::rosea::InstCmds}
        
            set keywords {_Alignas _Alignof _Atomic _Bool _Complex _Generic _Imaginary
                _Noreturn _Static_assert _Thread_local alignas alignof auto bool break case
                char complex const continue default do double else enum extern float for
                goto if imaginary inline int long noreturn register restrict return short
                signed sizeof static static_assert struct switch thread_local typedef union
                unsigned void volatile while}
            
            variable errFormats
            set errFormats [dict create {*}{
                GENERATE_ERRORS     {%d code generation error(s)}
                CONFIG_ERRORS     {%d configuration script error(s)}
                BAD_NAME      {"%s" is not a valid name for a(n) %s}
                TILDE_NAME {names beginning with the tilde character are not allowed\
                    in this context, "%s"}
                ASSOC_OPTIONS {association options error, expected\
                    "?-associator <class> | -multiple | -static | -dynamic | --?\
                    source spec target ?script?", got "%s"}
                BAD_RELATIONSHIP_SPEC  {bad association specifier, "%s"}
                NEED_ASSOCIATOR {relationship of type, "%s", requires an associative class}
                REFLEXIVE_NOT_ALLOWED   {associations of type, "%s", cannot be reflexive}
                BAD_MULTIPLE_OPT  {for relationship "%s", multiple option is not allowed}
                GEN_OPTIONS     {generalization options error, expected\
                    "?-union | -reference | --? superclass subclass1 subclass2 ...", got "%s"}
                TOO_FEW_SUBCLASSES  {at least 2 subclasses must be specified, got %d}
                SUPER_AS_SUBCLASS   {super class, "%s", cannot be included in subclasses, "%s"}
                DUPLICATE_SUBCLASS  {subclass set contains a duplicate subclass name, "%s"}
                UNION_SUBCLASS_EXISTS {subclass, "%s", is already a union subclass for\
                                    relationship, "%s"}
                ARG_FORMAT      {options and values must come in pairs, got "%s"}
                ATTR_OPTIONS    {attribute options error, expected\
                    "-default <value> or -dependent <formula> or -zeroinit", got "%s"}
                FINAL_OUTTRANS      {state, "%s", are final states, but have outgoing\
                                     transitions defined for them}
                BAD_FINAL           {states, "%s", are defined as final states,\
                                     but do not exist}
                BAD_STATE_NAME    {"%s" is not a valid state name}
                BAD_CREATION_TARGET {the target of a creation event must be a state,\
                        got "%s"}
                EXPECTED_NONTRANS_STATE    {expected CH or IG, got "%s"}
                EXPECTED_INT    {expected integer "%s": got "%s"}
                EXPECTED_NONNEG {expected non-negative "%s": got "%s"}
                MISSING_VALUES  {for domain population, %s, class, %s,\
                        values for class attribute,\
                        "%s", are not provided and have no default values}
                NOINIT_VALUES  {for domain population, %s, class, %s,\
                        values for class attribute,\
                        "%s", may not have initial values specified}
                UNKNOWN_INIT  {for domain population, %s, class, %s,\
                        "%s" are not attributes of the class}
                COMPONENT_MISMATCH  {for domain population, %s, class, %s,\
                                    number of component values does not match heading:\
                                    got %d values, expected %d values}
                MISSING_POPULATION    {for domain population, "%s", the following elements\
                                       are missing any population values: "%s"}
                NO_INSTANCES    {for domain population, "%s", the following classes have no\
                                defined instances and a zero allocation: "%s"}
                DUPLICATE_ENTITY    {%s, identified by, "%s", already exists}
                MISSING_ENTITY    {%s, identified by, "%s", does not exist}
            }]
            relvar create SeqNumbers {
                Domain string
                ClassName string
                Attrs list
                Number int
            } {Domain ClassName Attrs}
            proc isIdentifier {name} {
                variable keywords
                return [expr {[lsearch -sorted -exact $keywords $name] == -1 &&\
                        [regexp {\A[[:alpha:]]\w*\Z} $name]}] ; # <1>
            }
            proc CleanUpCommand {command} {
                set cleancmd [string trim $command]
                if {[string length $cleancmd] > 60} {
                    set cleancmd "[string range $cleancmd 0 54] ..."
                } else {
                    set cleancmd $cleancmd
                }
                return $cleancmd
            }
            proc FindUltimateSuperclasses {domain} {
                set subs [deRef [Subclass findWhere {$Domain eq $domain}]]
                set supers [deRef [Superclass findWhere {$Domain eq $domain}]]
                return [pipe {
                    relation semiminus $subs $supers -using {Domain Domain Class Class} |
                    ::rosea::Helpers::ToRef ::micca::Superclass ~
                }] ; # <1>
            }
            proc findSubclassesOf {supers} {
                if {[isEmptyRef $supers]} {# <1>
                    return [relation create {Super string Sub string}]
                }
                set supnames [pipe {
                    deRef $supers |
                    relation project ~ Class |
                    relation rename ~ Class Super
                }] ; # <2>
                set subclasses [instop $supers findSubclasses] ; # <3>
                set subnames [pipe {
                    deRef $subclasses |
                    relation project ~ Class |
                    relation rename ~ Class Sub
                }] ; # <4>
            
                set uses [relation times $supnames $subnames]
            
                set nextsupers [pipe {
                    deRef $subclasses |
                    relation semijoin ~ [deRef [ClassRole findAll]]\
                        -using {Domain Domain Class Class} |
                    relation semijoin ~ [deRef [Superclass findAll]] |
                    ::rosea::Helpers::ToRef ::micca::Superclass ~
                }] ; # <5>
            
                return [relation union $uses [findSubclassesOf $nextsupers]] ; # <6>
            }
            proc FindParameterSignature {params} {
                if {[dict size $params] == 0} {
                    return
                }
            
                set asigid [FindArgumentSignature $params] ; # <1>
                if {$asigid eq {}} {
                    error "panic: did not create an argument signature for \"$params\""
                }
            
                set poscounter -1
                set parampos [relation create {Name string Position int ASigID string}]
                dict for {pname ptype} $params {
                    set parampos [relation insert $parampos [list\
                        Name $pname\
                        Position [incr poscounter]\
                        ASigID $asigid\
                    ]]
                } ; # <2>
                set psigref [pipe {
                    Parameter findAll | deRef ~ |
                    relation group ~ ParamNames Name Position ASigID |
                    relation restrictwith ~ {[relation is $ParamNames == $parampos]} |
                    relation semijoin ~ [deRef [ParameterSignature findAll]]
                    ::rosea::Helpers::ToRef ::micca::ParameterSignature ~
                }] ; # <3>
            
                if {[isEmptyRef $psigref]} {# <4>
                    namespace upvar ::micca::@Config@::DomainDef DomainName DomainName
            
                    set psigid psig[GenNumber $DomainName ParameterSignature\
                            [list $DomainName]]
                    ParameterSignature create\
                        Domain $DomainName\
                        PSigID $psigid\
                        ASigID $asigid
                    set poscounter -1
                    dict for {pname ptype} $params {
                        Parameter create\
                            Domain $DomainName\
                            PSigID $psigid\
                            Name $pname\
                            Position [incr poscounter]\
                            ASigID $asigid
                    }
                } else {
                    set psigid [readAttribute $psigref PSigID]
                }
            
                return $psigid
            }
            proc FindArgumentSignature {params} {
                if {[llength $params] == 0} {
                    return
                }
            
                set poscounter -1
                set parampos [dict create]
                dict for {pname ptype} $params {
                    dict set parampos [incr poscounter] $ptype
                }
                set argpos [relation fromdict $parampos Position int DataType string] ; # <1>
                set asigref [pipe {
                    Argument findAll | deRef ~ |
                    relation group ~ ArgPositions Position DataType |
                    relation restrictwith ~ {[relation is $ArgPositions == $argpos]} |
                    relation semijoin ~ [deRef [ArgumentSignature findAll]] |
                    ::rosea::Helpers::ToRef ::micca::ArgumentSignature ~
                }]
            
                if {[isEmptyRef $asigref]} {
                    namespace upvar ::micca::@Config@::DomainDef DomainName DomainName
            
                    set asigid asig[GenNumber $DomainName ArgumentSignature\
                            [list $DomainName]]
                    ArgumentSignature create\
                        Domain  $DomainName\
                        ASigID   $asigid
                    set poscounter -1
                    dict for {pname ptype} $params {
                        Argument create\
                            Domain      $DomainName\
                            ASigID      $asigid\
                            Position    [incr poscounter]\
                            DataType    $ptype
                    }
                } else {
                    set asigid [readAttribute $asigref ASigID]
                }
            
                return $asigid
            }
            proc CheckPopAttrs {domainName className attrNames} {
                set reqcomps [FindRequiredPopComps $domainName $className]
                set missing [struct::set difference $reqcomps $attrNames]
                if {![struct::set empty $missing]} {
                    tailcall DeclError MISSING_VALUES $domainName $className\
                            [join $missing {, }]
                }
            
                set noinitattrs [FindNoInitializeAttrs $domainName $className]
                set cantinit [struct::set intersect $noinitattrs $attrNames]
                if {![struct::set empty $cantinit]} {
                    tailcall DeclError NOINIT_VALUES $domainName $className\
                            [join $cantinit {, }]
                }
            
                set allcomps [FindAllPopComps $domainName $className]
                set extra [struct::set difference $attrNames $allcomps]
                if {![struct::set empty $extra]} {
                    tailcall DeclError UNKNOWN_INIT $domainName $className\
                            [join $extra {, }]
                }
            
                return $reqcomps
            }
            proc CreateRequiredValues {domainName className instName namedValues} {
                set comptuple [dict create\
                    Domain $domainName\
                    Class $className\
                    Instance $instName\
                ]
                foreach attrname [FindRequiredPopComps $domainName $className] {
                    dict set comptuple Component $attrname
                    set attrvalue [dict get $namedValues $attrname]
                    if {$attrvalue eq "-"} {    # <1>
                        set attrvalue [ResolveInitialValue $domainName $className\
                                $attrname $attrvalue]
                    }
                    ClassComponentValue create {*}$comptuple
                    SpecifiedComponentValue create {*}$comptuple Value $attrvalue
                }
            }
            proc CreateDefaultedValues {domainName className instName namedValues} {
                set comptuple [dict create\
                    Domain $domainName\
                    Class $className\
                    Instance $instName\
                ]
                foreach attrname [FindDefaultableAttrs $domainName $className] {
                    dict set comptuple Component $attrname
                    if {[dict exists $namedValues $attrname]} {
                        set argvalue [dict get $namedValues $attrname]
                    } else {
                        set argvalue -
                    }
                    set attrvalue [ResolveInitialValue $domainName $className\
                            $attrname $argvalue]
                    ClassComponentValue create {*}$comptuple
                    SpecifiedComponentValue create {*}$comptuple Value $attrvalue
                }
            }
            proc CreateZeroInitValues {domainName className instName namedValues} {
                set comptuple [dict create\
                    Domain $domainName\
                    Class $className\
                    Instance $instName\
                ]
                foreach attrname [FindZeroInitAttrs $domainName $className] {
                    dict set comptuple Component $attrname
                    if {[dict exists $namedValues $attrname] &&\
                            [dict get $namedValues $attrname] ne "-"} {
                        set attrvalue [dict get $namedValues $attrname]
                        SpecifiedComponentValue create {*}$comptuple Value $attrvalue
                    } else {
                        UnspecifiedComponentValue create {*}$comptuple
                    }
                    ClassComponentValue create {*}$comptuple
                }
            }
            proc FindAllPopComps {domain class} {
                return [pipe {
                    PopulatedComponent findWhere {$Domain eq $domain && $Class eq $class} |
                    deRef ~ |
                    relation list ~ Name
                }]
            }
            proc FindRequiredPopComps {domain class} {
                # The attributes having NO default values must be specified
                set defattrs [pipe {
                    DefaultValue findWhere {$Domain eq $domain && $Class eq $class} |
                    deRef ~ |
                    relation list ~ Attribute
                }]
                set valueattrs [pipe {
                    ValueInitializedAttribute findWhere\
                            {$Domain eq $domain && $Class eq $class} |
                    deRef ~ |
                    relation list ~ Name
                }]
                set popattrs [struct::set difference $valueattrs $defattrs]
                # All Reference components must be specified
                set refattrs [pipe {
                    Reference findWhere {$Domain eq $domain && $Class eq $class} |
                    deRef ~ |
                    relation list ~ Name
                }]
                return [struct::set union $popattrs $refattrs]
            }
            proc FindDefaultableAttrs {domain class} {
                # The attributes having a default value may be left unspecified or
                # may be specified as "-".
                return [pipe {
                    DefaultValue findWhere {$Domain eq $domain && $Class eq $class} |
                    deRef ~ |
                    relation list ~ Attribute
                }]
            }
            proc FindZeroInitAttrs {domain class} {
                # The zero initialized attributes may be specified explicitly,
                # may be specfied as "-", or may be left unspecified.
                return [pipe {
                    ZeroInitializedAttribute findWhere\
                            {$Domain eq $domain && $Class eq $class} |
                    deRef ~ |
                    relation list ~ Name
                }]
            }
            proc FindNoInitializeAttrs {domain class} {
                # The dependent attributes may be not be initialized at all.
                return [pipe {
                    DependentAttribute findWhere\
                            {$Domain eq $domain && $Class eq $class} |
                    deRef ~ |
                    relation list ~ Name
                }]
            }
            proc ResolveInitialValue {domain class component value} {
                set compref [PopulatedComponent findById\
                    Domain $domain\
                    Class $class\
                    Name $component]
                if {[isEmptyRef $compref]} {
                    error "component, \"$component\", is not a component that can be\
                        populated"
                }
                if {$value eq "-"} {
                    # Check for default attribute value
                    set defref [findRelated $compref {~R21 Attribute}\
                            {~R29 IndependentAttribute} {~R19 ValueInitializedAttribute}\
                            ~R22]
                    if {[isNotEmptyRef $defref]} {
                        return [readAttribute $defref Value]
                    }
                    error "attribute $component does not have a default value"
                } else {
                    set value [subst -nocommands -novariables $value]
                }
            
                return $value
            }
            proc CreateNilDestBackRefs {refedclasses backrefs} {
                set nilbackrefs [FindNilDestBackRefs $refedclasses $backrefs]
                # puts [relformat $nilbackrefs nilbackrefs]
                foreach nilbackref [relation body $nilbackrefs] {
                    SpecifiedComponentValue create {*}$nilbackref Value @nil@
                    ClassComponentValue create {*}$nilbackref
                }
            }
            proc FindNilDestBackRefs {refedclasses backrefs} {
                # Find the components for the Referenced Classes regardless of value.
                # The difference between this set and those components where a value
                # was specified must be the set of components whose value are nil.
                set valueinsts [relation project $backrefs Domain Class Component Instance]
                set nilrefs [pipe {
                    findRelated $refedclasses R38 R94 |
                    deRef ~ |
                    relation project ~ Domain Class Name |
                    relation rename ~ Name Component |
                    relation join ~ $::micca::ClassInstance |
                    relation eliminate ~ Number |
                    relation minus ~ $valueinsts
                }]
                # puts [relformat $nilrefs nilrefs]
                return $nilrefs
            }
            proc CreateNilSourceForwRefs {srcclasses forwrefs} {
                set nilforwrefs [FindNilSourceForwRefs $srcclasses $forwrefs]
                # puts [relformat $nilforwrefs nilforwrefs]
                foreach nilforwref [relation body $nilforwrefs] {
                    ClassComponentValue create {*}$nilforwref
                    SpecifiedComponentValue create {*}$nilforwref Value @nil@
                }
            }
            proc FindNilSourceForwRefs {refedclasses forwrefs} {
                # Find the components for the Referenced Classes regardless of value.
                # The difference between this set and those components where a value
                # was specified must be the set of components whose value are nil.
                set valueinsts [relation project $forwrefs Domain Class Component Instance]
                set nilrefs [pipe {
                    findRelated $refedclasses R95 |
                    deRef ~ |
                    relation project ~ Domain Class Name |
                    relation rename ~ Name Component |
                    relation join ~ $::micca::ClassInstance |
                    relation eliminate ~ Number |
                    relation minus ~ $valueinsts
                }]
                # puts [relformat $nilrefs nilrefs]
                return $nilrefs
            }
            proc FindSimpleReferringRefs {refedclasses popvalues} {
                return [pipe {
                    deRef $refedclasses |
                    relation eliminate ~ Role |
                    relation rename ~ Class ReferencedClass |
                    relation join ~ $::micca::SimpleReferringClass |
                    relation rename ~ Class ReferringClass |
                    relation eliminate ~ Role Conditionality Multiplicity |
                    relation join ~ $popvalues -using\
                        {Domain Domain Relationship Component ReferringClass Class} |
                    relation extend ~ abtup\
                        Component string {"[tuple extract $abtup Relationship]__BACK"}
                }]
            }
            
            proc FindSimpleBackRefs {refingrefs} {
                return [pipe {
                    relation group $refingrefs Instances Instance |
                    relation extend ~ abtup\
                        NewValue string {[list [tuple extract $abtup ReferringClass]\
                            [relation list [tuple extract $abtup Instances]]]} |
                    relation eliminate ~ ReferringClass Instances |
                    relation rename ~ ReferencedClass Class Value Instance NewValue Value
                }]
            }
            proc FindTargetReferringRefs {refedclasses popvalues} {
                set backrefs [pipe {
                    deRef $refedclasses |
                    relation eliminate ~ Role Conditionality Multiplicity |
                    relation rename ~ Class TargetClass |
                    relation join ~ $::micca::AssociatorClass |
                    relation rename ~ Class AssociatorClass |
                    relation eliminate ~ Role Multiplicity |
                    relation join ~ $::micca::SourceClass |
                    relation rename ~ Class SourceClass |
                    relation eliminate ~ Role Conditionality Multiplicity |
                    relation join ~ $popvalues -using\
                        {Domain Domain Relationship Component AssociatorClass Class}
                }]
                # puts [relformat $backrefs backrefs]
            
                # Non-reflexive
                set nrtrgbackrefs [pipe {
                    relation restrictwith $backrefs {$SourceClass ne $TargetClass} |
                    relation extend ~ tbtup TargetInstance string {[dict get\
                        [tuple extract $tbtup Value] [tuple extract $tbtup TargetClass]]}
                }]
                # puts [relformat $nrtrgbackrefs nrtrgbackrefs]
            
                # Reflexive
                set rtrgbackrefs [pipe {
                    relation restrictwith $backrefs {$SourceClass eq $TargetClass} |
                    relation extend ~ tbtup TargetInstance string {[dict get\
                        [tuple extract $tbtup Value] forward]}
                }]
                # puts [relformat $rtrgbackrefs rtrgbackrefs]
                return [pipe {
                    relation union $nrtrgbackrefs $rtrgbackrefs |
                    relation eliminate ~ SourceClass Value |
                    relation extend ~ brtup\
                        Component string {"[tuple extract $brtup Relationship]__BACK"}
                }]
            }
            
            proc FindTargetBackRefs {refingrefs} {
                return [pipe {
                    relation group $refingrefs Instances Instance |
                    relation extend ~ brtup\
                        NewValue string {[list\
                            [tuple extract $brtup AssociatorClass]\
                            [relation list [tuple extract $brtup Instances]]]} |
                    relation eliminate ~ AssociatorClass Instances |
                    relation rename ~ TargetClass Class TargetInstance Instance NewValue Value
                }]
            }
            proc FindSourceReferringRefs {refedclasses popvalues} {
                set forwrefs [pipe {
                    deRef $refedclasses |
                    relation eliminate ~ Role Conditionality Multiplicity |
                    relation rename ~ Class SourceClass |
                    relation join ~ $::micca::AssociatorClass |
                    relation rename ~ Class AssociatorClass |
                    relation eliminate ~ Role Multiplicity |
                    relation join ~ $::micca::TargetClass |
                    relation rename ~ Class TargetClass |
                    relation eliminate ~ Role Conditionality Multiplicity |
                    relation join ~ $popvalues -using\
                        {Domain Domain Relationship Component AssociatorClass Class}
                }]
                # puts [relformat $forwrefs forwrefs]
            
                # Non-reflexive
                set nrsrcforwrefs [pipe {
                    relation restrictwith $forwrefs {$SourceClass ne $TargetClass} |
                    relation extend ~ tbtup SourceInstance string {[dict get\
                        [tuple extract $tbtup Value] [tuple extract $tbtup SourceClass]]}
                }]
                # puts [relformat $nrsrcforwrefs nrsrcforwrefs]
            
                # Reflexive
                set rsrcforwrefs [pipe {
                    relation restrictwith $forwrefs {$SourceClass eq $TargetClass} |
                    relation extend ~ tbtup SourceInstance string {[dict get\
                        [tuple extract $tbtup Value] backward]}
                }]
                # puts [relformat $rsrcforwrefs rsrcforwrefs]
                return [pipe {
                    relation union $nrsrcforwrefs $rsrcforwrefs |
                    relation eliminate ~ TargetClass Value |
                    relation extend ~ frtup\
                        Component string {"[tuple extract $frtup Relationship]__FORW"}
                }]
            }
            
            proc FindSourceForwRefs {refingrefs} {
                return [pipe {
                    relation group $refingrefs Instances Instance |
                    relation extend ~ frtup\
                        NewValue string {[list\
                            [tuple extract $frtup AssociatorClass]\
                            [relation list [tuple extract $frtup Instances]]]} |
                    relation eliminate ~ AssociatorClass Instances |
                    relation rename ~ SourceClass Class SourceInstance Instance NewValue Value
                }]
            }
            proc CreateLinkedRefs {backrefs compname} {
                foreach backref [relation body $backrefs] {
                    lassign [dict get $backref Value] refing insts
                    set relship [dict get $backref Relationship]
                    set next [list $refing [lindex $insts 0] ${relship}__$compname]
                    set prev [list $refing [lindex $insts end] ${relship}__$compname]
                    ClassComponentValue create\
                        Domain [dict get $backref Domain]\
                        Class [dict get $backref Class]\
                        Instance [dict get $backref Instance]\
                        Component [dict get $backref Component]
                    SpecifiedComponentValue create\
                        Domain [dict get $backref Domain]\
                        Class [dict get $backref Class]\
                        Instance [dict get $backref Instance]\
                        Component [dict get $backref Component]\
                        Value [dict create next $next prev $prev]
            
                    set instindex 0
                    set terminus [list\
                        [dict get $backref Class]\
                        [dict get $backref Instance]\
                        [dict get $backref Component]\
                    ]
                    set prev $terminus
                    for {set value [lindex $insts $instindex]} {$value ne {}}\
                            {set value [lindex $insts [incr instindex]]} {
                        if {$instindex < [llength $insts] - 1} {
                            set next [list\
                                $refing\
                                [lindex $insts $instindex+1]\
                                ${relship}__$compname\
                            ]
                        } else {
                            set next $terminus
                        }
                        ClassComponentValue create\
                            Domain [dict get $backref Domain]\
                            Class $refing\
                            Instance $value\
                            Component ${relship}__$compname
                        SpecifiedComponentValue create\
                            Domain [dict get $backref Domain]\
                            Class $refing\
                            Instance $value\
                            Component ${relship}__$compname\
                            Value [dict create next $next prev $prev]
                        set prev [list\
                            $refing\
                            $value\
                            ${relship}__$compname\
                        ]
                    }
                }
            }
            proc CreateNilLinkedBackRefs {refedclasses backrefs} {
                set nilbackrefs [FindNilDestBackRefs $refedclasses $backrefs]
                # puts [relformat $nilbackrefs nilbackrefs]
                CreateNilLinkedRefs $nilbackrefs
            }
            proc CreateNilLinkedRefs {nilbackrefs} {
                relation foreach nilbackref $nilbackrefs {
                    relation assign $nilbackref
                    ClassComponentValue create\
                        Domain $Domain\
                        Class $Class\
                        Instance $Instance\
                        Component $Component
                    SpecifiedComponentValue create\
                        Domain $Domain\
                        Class $Class\
                        Instance $Instance\
                        Component $Component\
                        Value [dict create\
                            next [list $Class $Instance $Component]\
                            prev [list $Class $Instance $Component]\
                        ]
                }
            }
            proc CreateNilLinkedForwRefs {srcclasses forwrefs} {
                set nilbackrefs [FindNilSourceForwRefs $srcclasses $forwrefs]
                # puts [relformat $nilbackrefs nilbackrefs]
                CreateNilLinkedRefs $nilbackrefs
            }
            namespace export DeclError
            
            proc DeclError {errcode args} {
                variable errFormats
                set errmsg [format [dict get $errFormats $errcode] {*}$args]
                tailcall throw [list MICCA $errcode {*}$args $errmsg] $errmsg
            }
            proc GenNumber {domain class args} {
                set num [relvar restrictone SeqNumbers Domain $domain ClassName $class\
                    Attrs $args]
                if {[relation isempty $num]} {
                    relvar insert SeqNumbers [list\
                        Domain $domain\
                        ClassName $class\
                        Attrs $args\
                        Number 0\
                    ]
                    return 0
                } else {
                    set result [expr {[relation extract $num Number] + 1}]
                    relvar updateone SeqNumbers sn [list Domain $domain ClassName $class\
                        Attrs $args] {
                        tuple update $sn Number $result
                    }
                    return $result
                }
            }
            if {[info exists ::iswrapped] && $iswrapped} {
                source [file join $::appdir typename typeparser.tcl]
            } else {
                set tpfile [file join [file dirname [info script]]\
                        typename typeparser.tcl]
                if {[file readable $tpfile]} {
                    source $tpfile
                }
            }
            package require typeparser
            
            oo::class create typeverifier {
                superclass typeparser
            
                method verifyTypeName {typename} {
                    try {
                        my parset $typename
                        return true
                    } on error {result} {
                        puts [::pt::util error2readable $result $typename]
                        return false
                    }
                }
            
                method composeDeclaration {typename identifier} {
                    my variable location
            
                    set ast [my parset $typename]
                    set location [lindex $ast 2]
                    ::pt::ast topdown [mymethod TopWalker] $ast
            
                    set decl [string cat\
                        [string range $typename 0 $location]\
                        " $identifier"\
                        [string range $typename $location+1 end]\
                    ]
            
                    return [regsub -all -- {typename\s*\(\s*([[:alnum:]]\w*)\s*\)}\
                        $decl {\1}]
                }
            
                method assignmentType {typename} {
                    set ast [my parset $typename]
            
                    set asgnType [dict create]
                    set adnode [my SearchAST array_declarator $ast]
                    if {[llength $adnode] != 0} {
                        set adchildren [lassign $adnode type start end]
                        if {[llength $adchildren] < 3} {
                            error "data type, \"$typename\", has no dimension"
                        }
                        set dimnode [lindex $adchildren 1]
                        lassign $dimnode dimtype dimstart dimend
                        if {$dimtype eq "STAR"} {
                            error "data type, \"$typename\", has indeterminate dimension"
                        }
                        dict set asgnType dimension\
                                [string range $typename $dimstart $dimend]
            
                        set sqlnode [my SearchAST specifier_qualifier_list $ast]
                        set tsnode [my SearchAST type_specifier $sqlnode]
                        set dtname [lindex $tsnode 3 0]
                        dict set asgnType base $dtname
                        dict set asgnType type [expr {$dtname eq "char" ? "string" : "array"}]
                    } else {
                        dict set asgnType type scalar
                    }
            
                    return $asgnType
                }
            
                method TopWalker {ast} {
                    my variable location
            
                    lassign $ast nodetype start end
                    if {$nodetype eq "pointer"} {
                        set location $end
                    } elseif {$nodetype eq "array_declarator"} {
                        set location [expr {$start - 1}]
                    }
                    return $ast
                }
            
                method SearchAST {nodeName ast} {
                    set children [lassign $ast type start end]
                    # puts "node = $type, children = [llength $children]"
                    if {$type eq $nodeName} {
                        return $ast
                    }
                    set result [list]
                    foreach child $children {
                        set result [my SearchAST $nodeName $child]
                        if {[llength $result] != 0} {
                            break
                        }
                    }
                    return $result
                }
            }
            
            typeverifier create typeCheck
            namespace export typeCheck
            proc CheckDuplicate {class entity args} {
                set ref [$class findById {*}$args]
                if {[isNotEmptyRef $ref]} {
                    EntityError $entity DUPLICATE_ENTITY $args
                }
                return
            }
            proc EntityError {entity error kvs} {
                foreach {key value} $kvs {
                    append ids "$key = \"$value\", "
                }
                set ids [string trimright $ids {, }]
                set lastcomma [string last , $ids]
                if {$lastcomma != -1} {
                    set ids [string replace $ids $lastcomma $lastcomma { and}]
                }
                tailcall DeclError $error $entity $ids
            }
            proc CheckExists {class entity args} {
                set ref [$class findById {*}$args]
                if {[isEmptyRef $ref]} {
                    EntityError $entity MISSING_ENTITY $args
                }
                return
            }
        }
    
        namespace path {::micca ::micca::@Config@::Helpers ::rosea::InstCmds} ; # <1>
        variable configfile {}
        variable evalLambda {{body} {
            upvar #0 ::micca::@Config@::errcount errcount ; # <1>
            upvar #0 ::micca::@Config@::configlineno configlineno
            set lineno $configlineno
            set command {}
            foreach line [split $body \n] { # <2>
                append command $line \n
                incr lineno ; # <3>
                if {[info complete $command]} {
                    try {
                        eval $command
                    } on error {result} {
                        set cleancmd [CleanUpCommand $command]
                        log::error "line $configlineno: \"$cleancmd\":\n\"$result\""
                        incr errcount
                    }
                    set command {} ; # <4>
                    set configlineno $lineno
                }
            }
            if {$command ne {}} {   # <5>
                set cleancmd [CleanUpCommand $command]
                log::error "line [expr {$lineno - 1}]: end of script reached in the\
                    middle of the command starting at line $configlineno: $cleancmd"
                incr errcount
            }
            return $errcount
        }}
        relvar create Config_AssocSpec {
            SpecName    string
            SpecID      string
        } SpecName
        relvar create Config_SpecDetail {
            SpecID              string
            NeedsAssociator     boolean
            ReflexiveAllowed    boolean
            MultipleAllowed     boolean
            ReferringCond       boolean
            ReferringMult       boolean
            ReferencedCond      boolean
            ReferencedMult      boolean
        } SpecID
        relvar association C1\
            Config_AssocSpec SpecID +\
            Config_SpecDetail SpecID 1
        
        relvar eval {
            relvar insert Config_AssocSpec {
                SpecName    1--1
                SpecID      sp0
            } {
                SpecName    0..1--1
                SpecID      sp1
            } {
                SpecName    ?--1
                SpecID      sp1
            } {
                SpecName    0..1--0..1
                SpecID      sp2
            } {
                SpecName    ?--?
                SpecID      sp2
            } {
                SpecName    1..*--1
                SpecID      sp3
            } {
                SpecName    +--1
                SpecID      sp3
            } {
                SpecName    0..*--1
                SpecID      sp4
            } {
                SpecName    *--1
                SpecID      sp4
            } {
                SpecName    1..*--0..1
                SpecID      sp5
            } {
                SpecName    +--?
                SpecID      sp5
            } {
                SpecName    0..*--0..1
                SpecID      sp6
            } {
                SpecName    *--?
                SpecID      sp6
            } {
                SpecName    1..*--1..*
                SpecID      sp7
            } {
                SpecName    +--+
                SpecID      sp7
            } {
                SpecName    0..*--1..*
                SpecID      sp8
            } {
                SpecName    *--+
                SpecID      sp8
            } {
                SpecName    1..*--0..*
                SpecID      sp9
            } {
                SpecName    +--*
                SpecID      sp9
            } {
                SpecName    0..*--0..*
                SpecID      sp10
            } {
                SpecName    *--*
                SpecID      sp10
            }
        
            relvar insert Config_SpecDetail {
                SpecID sp0  NeedsAssociator false ReflexiveAllowed true
                    MultipleAllowed false
                    ReferringCond false ReferringMult false
                    ReferencedCond false ReferencedMult false
            } {
                SpecID sp1 NeedsAssociator false ReflexiveAllowed true
                    MultipleAllowed false
                    ReferringCond true ReferringMult false
                    ReferencedCond false ReferencedMult false
            } {
                SpecID sp2 NeedsAssociator true ReflexiveAllowed true
                    MultipleAllowed false
                    ReferringCond true ReferringMult false
                    ReferencedCond true ReferencedMult false
            } {
                SpecID sp3 NeedsAssociator false ReflexiveAllowed true
                    MultipleAllowed false
                    ReferringCond false ReferringMult true
                    ReferencedCond false ReferencedMult false
            } {
                SpecID sp4 NeedsAssociator false ReflexiveAllowed true
                    MultipleAllowed false
                    ReferringCond true ReferringMult true
                    ReferencedCond false ReferencedMult false
            } {
                SpecID sp5 NeedsAssociator true ReflexiveAllowed false
                    MultipleAllowed false
                    ReferringCond false ReferringMult true
                    ReferencedCond true ReferencedMult false
            } {
                SpecID sp6 NeedsAssociator true ReflexiveAllowed true
                    MultipleAllowed false
                    ReferringCond true ReferringMult true
                    ReferencedCond true ReferencedMult false
            } {
                SpecID sp7 NeedsAssociator true ReflexiveAllowed true
                    MultipleAllowed true
                    ReferringCond false ReferringMult true
                    ReferencedCond false ReferencedMult true
            } {
                SpecID sp8 NeedsAssociator true ReflexiveAllowed false
                    MultipleAllowed true
                    ReferringCond true ReferringMult true
                    ReferencedCond false ReferencedMult true
            } {
                SpecID sp9 NeedsAssociator true ReflexiveAllowed false
                    MultipleAllowed true
                    ReferringCond false ReferringMult true
                    ReferencedCond true ReferencedMult true
            } {
                SpecID sp10 NeedsAssociator true ReflexiveAllowed true
                    MultipleAllowed true
                    ReferringCond true ReferringMult true
                    ReferencedCond true ReferencedMult true
            }
        }
        relvar create Config_DataError {
            Relationship        string
            RefClass            string
            RefType             string
            Format              string
        } {Relationship RefClass RefType}
        relvar insert Config_DataError {
            Relationship        R20
            RefClass            Class
            RefType             notrefed
            Format              {in domain, $Domain, class, $Name,\
                                has no class components}
        } {
            Relationship        R20
            RefClass            ClassComponent
            RefType             refnone
            Format              {in domain, $Domain, class, $Class, does not exist}
        } {
            Relationship        R21
            RefClass            ClassComponent
            RefType             notrefto
            Format              {in domain, $Domain, class, $Class,\
                                 component, $Name, failed to be completed created}
        } {
            Relationship        R41
            RefClass            Relationship
            RefType             notrefed
            Format              {in domain, $Domain, relationship, $Name,\
                                 failed to be completed created}
        } {
            Relationship        R41
            RefClass            ClassRole
            RefType             refnone
            Format              {in domain, $Domain, relationship, $Relationship,\
                                 $Class, participates in the relationship as a $Role,\
                                 but the class was not defined}
        } {
            Relationship        R54
            RefClass            MultipleAssigner
            RefType             refnone
            Format              {in domain, $Domain, relationship, $Association,\
                                 the multi-assigner identifying class, $Class,\
                                 does not exist}
        } {
            Relationship        R58
            RefClass            StateModel
            RefType             refnone
            Format              {in domain, $Domain, the state model for, $Model,\
                                 defines, $InitialState, the default initial state,\
                                 but no such state exists}
        } {
            Relationship        R70
            RefClass            TransitionPlace
            RefType             refnone
            Format              {in domain, $Domain, state model,\
                                 $Model, event, $Event, causes a transition\
                                 out of state, $State, but state $State does not\
                                 exist}
        } {
            Relationship        R72
            RefClass            StateTransition
            RefType             refnone
            Format              {in domain, $Domain, in the state model for,\
                                 $Model, for the transition,\
                                 $State - $Event -> $NewState, state $NewState does\
                                 not exist}
        } {
            Relationship        R86
            RefClass            DeferredEvent
            RefType             notrefed
            Format              {in domain, $Domain, class, $Model,\
                                defines event, $Event as polymorphic, yet\
                                $Model is not a superclass}
        } {
            Relationship        R87
            RefClass            StateModel
            RefType             notrefed
            Format              {in domain, $Domain, class, $Model,\
                                there are no events defined for the state model}
        } {
            Relationship        R87
            RefClass            TransitioningEvent
            RefType             refnone
            Format              {in domain, $Domain, class, $Model,\
                                 event, $Event, is defined, but the class has no\
                                 state model: possible inherited polymorphic event}
        } {
            Relationship        R101
            RefClass            ElementPopulation
            RefType             refnone
            Format              {for domain population, $Domain, class or assigner,\
                                 $Element, does not exist}
        } {
            Relationship        R101
            RefClass            Population
            RefType             notrefed
            Format              {for domain population, $Domain, no values for the\
                                 domain elements are specified}
        } {
            Relationship        R103
            RefClass            ClassComponentValue
            RefType             refnone
            Format              {for domain population, $Domain, class, $Class,\
                                 instance, $Instance, sets the value of\
                                 $Component to $Value,\
                                 but $Component is not a known component of $Class"}
        } {
            Relationship        R103
            RefClass            ClassInstance
            RefType             notrefed
            Format              {for domain population, $Domain, class, $Class,\
                                 instance, $Instance, does not have any values for\
                                 its class components}
        }
        proc miccaConfigure {script} {
            variable errcount
            set errcount 0
        
            variable configlineno
            set configlineno 1
        
            ConfigEvaluate [namespace current] $script
        
            if {$errcount > 0} {
                tailcall DeclError CONFIG_ERRORS $errcount
            }
            return $errcount
        }
        namespace export ConfigEvaluate
        
        proc ConfigEvaluate {ns body} {
            variable evalLambda
            tailcall ::apply [concat $evalLambda [list $ns]] $body ; # <1>
        }
        proc miccaClear {} {
            set preserve {
                ::micca::TransitionRule
            }
            relvar eval {
                foreach var [relvar names {::micca::[A-Z]*}] {
                    if {$var ni $preserve} {
                        relvar set $var [relation empty [relvar set $var]]
                    }
                }
            }
        
            set config {
                ::micca::@Config@::Helpers::SeqNumbers
            }
            foreach var $config {
                relvar set $var [relation empty [relvar set $var]]
            }
        }
        proc domain {name body} {
            if {$name eq {}} {
                tailcall DeclError BAD_NAME $name domain
            }
        
            namespace upvar DomainDef DomainName DomainName ; # <1>
            set DomainName $name
        
            CheckDuplicate Domain domain Name $name ; # <2>
            Domain create Name $name
        
            try {
                ral relvar eval {
                    set errs [ConfigEvaluate [namespace current]::DomainDef $body]
        
                    # No reason to go on if we already have errors in the domain script
                    if {$errs == 0} {
                        upvar #0 ::micca::@Config@::errcount errcount
        
                        # We must compute how polymorphic events are inherited down
                        # generalization hierarchies.
                        # Create Deferral Path instances corresponding to polymorphic events
                        
                        set paths [pipe {
                            PolymorphicEvent findWhere {$Domain eq $name} |
                            findRelated ~ R81 |
                            deRef ~ Domain Model Event |
                            relation join ~ [deRef [Superclass findAll]]\
                                -using {Domain Domain Model Class}
                        }]
                        
                        foreach path [relation body $paths] {
                            DeferralPath create {*}$path
                        }
                        forAllRefs super [FindUltimateSuperclasses $name] {
                            PropagatePolyEvents $super
                        }
                        set trevents [pipe {
                            TransitioningEvent findAll |
                            deRef ~ |
                            relation tag ~ Number -ascending Event -within {Domain Model}
                        }]
                        # puts [relformat $trevents trevents]
                        
                        set trcounts [relation summarizeby $trevents {Domain Model} evts\
                                EventCount int {[relation cardinality $evts]}]
                        # puts [relformat $trcounts trcounts]
                        
                        set dfevents [pipe {
                            DeferredEvent findAll |
                            deRef ~ |
                            relation tag ~ DfNumber -ascending Event -within {Domain Model} |
                            ralutil::rvajoin ~ $trcounts TEvents |
                            relation extend ~ dftup Number int {
                                [relation isempty [tuple extract $dftup TEvents]] ?\
                                [tuple extract $dftup DfNumber] :\
                                [tuple extract $dftup DfNumber] +\
                                [relation extract [tuple extract $dftup TEvents] EventCount]} |
                            relation eliminate ~ DfNumber TEvents
                        }]
                        # puts [relformat $dfevents dfevents]
                        
                        Event update [relation union $trevents $dfevents]
                        # puts [relformat $::micca::Event Event]
                    }
                }
            } on error {result opts} {
                # puts $::errorInfo
                HandleConfigError $result
            }
        }
        proc PropagatePolyEvents {super} {
            variable errcount
            # Starting at the superclass, find all the subclasses along the
            # generalization.
            set subs [instop $super findSubclasses]
        
            # Find the events that are deferred by the superclass. These could be
            # either polymorphic events defined in the superclass or inherited events
            # from another generalization.
            set defrdevents [findRelated $super R86 R80]
        
            # Set up some variables with the superclass attribute values.
            assignAttribute $super {Domain supDomain} {Class supClass}\
                {Relationship supRelationship}
        
            # Iterate over each subclass of the generalization.
            forAllRefs sub $subs {
                assignAttribute $sub {Domain subDomain} {Class subClass}\
                    {Relationship subRelationship} {Role subRole}
        
                # We need to know if this subclass is also a superclass for another
                # generalization. We find that out by querying the ClassRole for all
                # the other relationships the subclass participates in and then
                # filtering those where it serves as a Superclass.
                set multigens [Superclass findWhere {$Domain eq $subDomain &&\
                        $Class eq $subClass && $Relationship ne $subRelationship}]
        
                # Iterate over the deferred events
                forAllRefs defrdevent $defrdevents {
                    # We need the event name and argument signature
                    assignAttribute $defrdevent {Event event} {PSigID psigid}
        
                    # Check if the event already exists
                    set evt [Event findById Domain $subDomain Model $subClass\
                            Event $event]
                    if {[isEmptyRef $evt]} {
                        if {[isEmptyRef $multigens]} {
                            Event create\
                                Domain $subDomain\
                                Model $subClass\
                                Event $event\
                                PSigID $psigid\
                                Number -1
                            TransitioningEvent create\
                                Domain $subDomain\
                                Model $subClass\
                                Event $event
                            MappedEvent create\
                                Domain $subDomain\
                                Model $subClass\
                                Event $event\
                                ParentModel $supClass
                            NonLocalEvent create\
                                Domain $subDomain\
                                Model $subClass\
                                Event $event\
                                Relationship $subRelationship\
                                Role $subRole
                            
                            set trule [findRelated $sub R40 R41 ~R51 R50 R59]
                            # Guard against there being no defined state model.
                            if {[isNotEmptyRef $trule]} {
                                switch -exact -- [readAttribute $trule Name] {
                                    IG {
                                        set phrase "ignoring the event"
                                    }
                                    CH {
                                        set phrase "a system error"
                                    }
                                    default {
                                        set phrase "unknown behavior"
                                    }
                                }
                            
                                log::warn "In domain, \"$subDomain\", class, \"$subClass\", event,\
                                    \"$event\" is polymorphic across, \"$subRelationship\",\
                                    and was not consumed in the state model: signalling $event to\
                                    $subClass or its related superclasses will result in $phrase"
                            }
                        } else {
                            Event create\
                                Domain $subDomain\
                                Model $subClass\
                                Event $event\
                                PSigID $psigid\
                                Number -1
                            DeferredEvent create\
                                Domain $subDomain\
                                Model $subClass\
                                Event $event
                            InheritedEvent create\
                                Domain $subDomain\
                                Model $subClass\
                                Event $event
                            NonLocalEvent create\
                                Domain $subDomain\
                                Model $subClass\
                                Event $event\
                                Relationship $subRelationship\
                                Role $subRole
                            
                            # Note that we need to provide a Deferral Path for all the generalizations that
                            # may stem from this subclass.  So we iterate over all the superclass
                            # relationships this subclass participates in.
                            forAllRefs multigen $multigens {
                                DeferralPath create\
                                    Domain $subDomain\
                                    Model $subClass\
                                    Event $event\
                                    Relationship [readAttribute $multigen Relationship]\
                                    Role target
                            }
                        }
                    } else {
                        set local [findRelated $evt {~R80 TransitioningEvent} {~R82 LocalEvent}]
                        if {[isNotEmptyRef $local]} {
                            delete $local
                            MappedEvent create\
                                Domain $subDomain\
                                Model $subClass\
                                Event $event\
                                ParentModel $supClass
                            NonLocalEvent create\
                                Domain $subDomain\
                                Model $subClass\
                                Event $event\
                                Relationship $subRelationship\
                                Role $subRole
                            updateAttribute $evt PSigID $psigid
                            
                            if {[isNotEmptyRef $multigens]} {
                                set subsusing [pipe {
                                    findSubclassesOf $multigens|
                                    relation tclose ~ |
                                    relation restrictwith ~ {$Super eq $subClass} |
                                    relation project ~ Sub |
                                    relation list ~ Sub
                                }] ; # <1>
                                set usingevent [pipe {
                                    Event findWhere {$Domain eq $subDomain && $Model in $subsusing &&\
                                            $Event == $event} |
                                    deRef ~ |
                                    relation project ~ Model |
                                    relation list ~ Model
                                }] ; # <2>
                            
                                if {[llength $usingevent] != 0} {
                                    log::error "In domain, \"$subDomain\", class, \"$subClass\",\
                                        event, \"$event\", is inherited across, \"$subRelationship\"\
                                        and is consumed in the $subClass state model:\
                                        yet class(es), \"[join $usingevent {, }]\", assume \"$event\"\
                                        is deferred to them"
                                    incr errcount
                                }
                            }
                        } else {
                            set inherit [findRelated $evt {~R80 DeferredEvent} {~R81 InheritedEvent}]
                            if {[isNotEmptyRef $inherit]} {
                            } else {
                                set poly [findRelated $evt {~R80 DeferredEvent} {~R81 PolymorphicEvent}]
                                if {[isNotEmptyRef $poly] && [isNotEmptyRef $multigens]} {
                                    delete $poly
                                    InheritedEvent create\
                                        Domain $subDomain\
                                        Model $subClass\
                                        Event $event
                                    NonLocalEvent create\
                                        Domain $subDomain\
                                        Model $subClass\
                                        Event $event\
                                        Relationship $subRelationship\
                                        Role $subRole
                                }
                            }
                        }
                    }
                }
                # Recursively descend any generalization hierarchies repeating the
                # process for them.
                forAllRefs multigen $multigens {
                    PropagatePolyEvents $multigen
                }
            }
        }
        proc population {domain script} {
            variable errcount
        
            if {$errcount != 0} {
                error "cannot populate with configuration errors"
            }
        
            namespace upvar PopDef DomainName DomainName
            set DomainName $domain
        
            set popref [Population create Domain $domain]
        
            try {
                ral relvar transaction begin
                try {
                    ConfigEvaluate [namespace current]::PopDef $script
        
                    # At this point the population is complete and we can begin the
                    # processing to validate that the population is correct.
        
                    set usubs [pipe {
                        UnionSubclass findWhere {$Domain eq $domain} |
                        deRef ~ |
                        relation project ~ Domain Class |
                        relation rename ~ Class Name
                    }] ; # <1>
                    set massigners [pipe {
                        MultipleAssigner findWhere {$Domain eq $domain} |
                        deRef ~ |
                        relation project ~ Domain Association |
                        relation rename ~ Association Name
                    }]
                    set missing [pipe {
                        findRelated $popref {R101 ElementPopulation} |
                        findUnrelated ~ R101 |
                        deRef ~ |
                        relation minus ~ $usubs |
                        relation minus ~ $massigners
                    }] ; # <2>
                    if {[relation isnotempty $missing]} {
                        tailcall DeclError MISSING_POPULATION $domain\
                            [join [relation list $missing Name] {, }]
                    }
                    # First, we need the set of class component values and class
                    # instances that are part of the population of this domain.
                    set popinstrefs [ClassInstance findWhere {$Domain eq $domain}]
                    set popinsts [deRef $popinstrefs]
                    # puts [relformat $popinsts popinsts]
                    set popvalues [pipe {
                        findRelated $popinstrefs {R103 ClassComponentValue}\
                                {~R109 SpecifiedComponentValue} |
                        deRef %
                    } {} |%]
                    
                    # puts [relformat $popvalues popvalues]
                    set usubClasses [pipe {
                        UnionSubclass findWhere {$Domain eq $domain} |
                        deRef ~ |
                        relation project ~ Class |
                        relation list ~
                    }]
                    set noinsts [pipe {
                        ClassPopulation findWhere {
                                $Domain eq $domain && $Class ni $usubClasses && $Allocation == 0} |
                        deRef ~ |
                        ralutil::rvajoin ~ $popinsts Instances |
                        relation restrictwith ~ {[relation isempty $Instances]}
                    }] ; # <1>
                    
                    if {[relation isnotempty $noinsts]} {
                        tailcall DeclError NO_INSTANCES $domain\
                            [join [relation list $noinsts Class] {, }]
                    }
                    # Next we want to issue warnings for union subclasses that have a non-zero
                    # Allocation value. This value is ignored as the storage for union
                    # subclass instances is always tied to the ultimate superclass of the
                    # generalization. We don't call it an error so that generalizations
                    # can be easily switched from reference to union types of storage.
                    set allocsubs [pipe {
                        UnionSubclass findWhere {$Domain eq $domain} |
                        findRelatedWhere % {R47 R40 R41 R104 {~R101 ElementPopulation}\
                                {~R105 ClassPopulation}} {$Allocation != 0}
                    } {} |%]
                    
                    forAllRefs alloced $allocsubs {
                        assignAttribute $alloced {Class className} {Allocation allocValue}
                        log::warn "In domain, \"$domain\", union-based subclass, \"$className\",\
                                has a non-zero \"allocate\" value, \"$allocValue\":\
                                this value is ignored since union-based subclasses do not have\
                                storage independent of the superclass of the generalization"
                    }
                    set simprefs [pipe {
                        SimpleReferringClass findWhere {$Domain eq $domain} |
                        deRef ~ |
                        relation eliminate ~ Role |
                        relation rename ~ Class ReferringClass\
                            Conditionality ReferringCond Multiplicity ReferringMult|
                        relation join ~ $::micca::SimpleReferencedClass |
                        relation eliminate ~ Role |
                        relation rename ~ Class ReferencedClass Relationship Component |
                        relation join ~ $popvalues -using\
                            {Domain Domain ReferringClass Class Component Component} |
                        relation rename ~ Instance ReferringInstance Value ReferencedInstance
                    }]
                    # puts [relformat $simprefs simprefs]
                    set badrefs [pipe {
                        relation rename $simprefs ReferencedClass Class ReferencedInstance Instance |
                        ralutil::rvajoin ~ $popinsts Instances |
                        relation restrictwith ~ {[relation isempty $Instances]}
                    }] ; # <1>
                    # puts [relformat $badrefs badrefs]
                    relation foreach badref $badrefs {
                        relation assign $badref
                        log::error "for domain population, $Domain,\
                            instance, $ReferringClass.$ReferringInstance, refers to\
                            instance, $Class.$Instance across,\
                            $Component, but $Class.$Instance does not exist"
                        incr errcount
                    }
                    set simprefs [pipe {
                        relation eliminate $badrefs Instances |
                        relation rename ~ Class ReferencedClass Instance ReferencedInstance |
                        relation minus $simprefs ~
                    }]
                    # puts [relformat $simprefs simprefs]
                    set refedmults [pipe {
                        relation eliminate $simprefs ReferringCond |
                        relation group ~ ReferringInstances ReferringInstance |
                        relation restrictwith ~ {!$ReferringMult &&\
                            [relation cardinality $ReferringInstances] > 1}
                    }] ; # <1>
                    # puts [relformat $refedmults refedmults]
                    relation foreach refedmult $refedmults {
                        relation assign $refedmult
                        log::error "for domain population, $Domain,\
                            relationship, $Component, is singular from\
                            $ReferringClass to $ReferencedClass, but instance, $ReferencedInstance,\
                            is referred to by multiple instances:\
                            [join [relation list $ReferringInstances] {, }]"
                        incr errcount
                    }
                    set refingconds [pipe {
                        relation project $simprefs Domain Component ReferringClass ReferringCond\
                            ReferencedClass ReferencedInstance |
                        relation rename ~ ReferencedClass Class ReferencedInstance Instance |
                        relation group ~ ReferencedInstances Instance |
                        ralutil::rvajoin ~ [relation eliminate $popinsts Number] Instances |
                        relation restrictwith ~\
                            {!$ReferringCond && [relation is $ReferencedInstances != $Instances]}
                    }]
                    # puts [relformat $refingconds refingconds]
                    
                    relation foreach refingcond $refingconds {
                        relation assign $refingcond
                        set notrefed [relation minus $Instances $ReferencedInstances]
                        log::error "for domain population, $Domain,\
                            relationship, $Component, is unconditional from\
                            $Class to $ReferringClass, but the\
                            \"[join [relation list $notrefed] {, }]\" instance(s) of $Class\
                            is(are) not referred to by any instance of $ReferringClass"
                        incr errcount
                    }
                    set assocs [pipe {
                        AssociatorClass findWhere {$Domain eq $domain} |
                        deRef ~ |
                        relation project ~ Domain Class Relationship |
                        relation rename ~ Class AssocClass |
                        relation join ~ $::micca::SourceClass |
                        relation eliminate ~ Role |
                        relation rename ~ Class SourceClass Conditionality SourceCond\
                                Multiplicity SourceMult |
                        relation join ~ $::micca::TargetClass |
                        relation eliminate ~ Role |
                        relation rename ~ Class TargetClass Conditionality TargetCond\
                                Multiplicity TargetMult Relationship Component |
                        relation join ~ $popvalues -using\
                            {Domain Domain AssocClass Class Component Component} |
                        relation rename ~ Instance AssocInstance
                    }]
                    # puts [relformat $assocs assocs]
                    set badvalues [relation restrictwith $assocs {[llength $Value] != 4}]
                    relation foreach badvalue $badvalues {
                        relation assign $badvalue
                        log::error "for domain population, $Domain,\
                            instance, $AssocClass.$AssocInstance, has a bad format for the\
                            value of the associative reference for, $Component:\
                            expected a four element list, got: \"$Value\""
                        incr errcount
                    }
                    set assocs [relation minus $assocs $badvalues]
                    set nrassocs [relation restrictwith $assocs {$SourceClass ne $TargetClass}]
                    set rassocs [relation minus $assocs $nrassocs]
                    set nonparts [relation restrictwith $nrassocs {![struct::set equal\
                            [list [lindex $Value 0] [lindex $Value 2]]\
                            [list $SourceClass $TargetClass]]}]
                    # puts [relformat $nonparts nonparts]
                    relation foreach nonpart $nonparts {
                        relation assign $nonpart
                        lassign $Value oneclass oneinst otherclass otherinst
                        if {$oneclass eq $otherclass} {
                            log::error "for domain population, $Domain,\
                                associator instance, $AssocClass.$AssocInstance,
                                the reference value, $Value, duplicates the reference\
                                to class, $oneclass"
                            incr errcount
                        } else {
                            set refedclasses [list $SourceClass $TargetClass]
                            foreach {class instance} $Value {
                                if {![struct::set contains $refedclasses $class]} {
                                    log::error "for domain population, $Domain,\
                                        associator instance, $AssocClass.$AssocInstance,\
                                        references class instance, $class.$instance, across,\
                                        $Component, but $class does not participate in $Component"
                                    incr errcount
                                }
                            }
                        }
                    }
                    set nrassocs [pipe {
                        relation minus $nrassocs $nonparts |
                        relation extend ~ nrtup\
                            TargetInstance string {[dict get [tuple extract $nrtup Value]\
                                [tuple extract $nrtup TargetClass]]}\
                            SourceInstance string {[dict get [tuple extract $nrtup Value]\
                                [tuple extract $nrtup SourceClass]]} |
                        relation eliminate ~ Value
                    }] ; # <1>
                    set baddirs [relation restrictwith $rassocs\
                        {![struct::set equal [dict keys $Value] {forward backward}]}]
                    relation foreach baddir $baddirs {
                        relation assign $baddir
                        log::error "for domain population, $Domain,\
                            instance, $AssocClass.$AssocInstance, has a bad format for the\
                            value of component, $Component: expected a dictionary\
                            with \"forward\" and \"backward\" keys, got: \"$Value\""
                        incr errcount
                    }
                    
                    set rassocs [relation minus $rassocs $baddirs]
                    set rassocs [pipe {
                        relation extend $rassocs rtup\
                            TargetInstance string {[dict get [tuple extract $rtup Value] forward]}\
                            SourceInstance string {[dict get [tuple extract $rtup Value] backward]} |
                        relation eliminate ~ Value
                    }]
                    set assocs [relation union $nrassocs $rassocs]
                    # puts [relformat $assocs assocs]
                    set badsrcrefs [pipe {
                        relation rename $assocs SourceClass Class SourceInstance Instance |
                        relation project ~ Domain Class Component Instance AssocClass AssocInstance |
                        ralutil::rvajoin ~ $popinsts Instances |
                        relation restrictwith ~ {[relation isempty $Instances]}
                    }]
                    set badtrgrefs [pipe {
                        relation rename $assocs TargetClass Class TargetInstance Instance |
                        relation project ~ Domain Class Component Instance AssocClass AssocInstance |
                        ralutil::rvajoin ~ $popinsts Instances |
                        relation restrictwith ~ {[relation isempty $Instances]}
                    }] ; # <1>
                    
                    set badrefs [relation union $badsrcrefs $badtrgrefs]
                    # puts [relformat $badrefs badrefs]
                    relation foreach badref $badrefs {
                        relation assign $badref
                        log::error "for domain population, $Domain,\
                            instance, $AssocClass.$AssocInstance, refers to\
                            instance, $Class.$Instance across,\
                            $Component, but $Class.$Instance does not exist"
                        incr errcount
                    }
                    set assocs [pipe {
                        relation semiminus $badsrcrefs $assocs -using\
                            {Domain Domain Component Component AssocClass AssocClass\
                            AssocInstance AssocInstance Class SourceClass Instance SourceInstance} |
                        relation semiminus $badtrgrefs ~ -using\
                            {Domain Domain Component Component AssocClass AssocClass\
                            AssocInstance AssocInstance Class TargetClass Instance TargetInstance}
                    }]
                    # puts [relformat $assocs assocs]
                    set duprefs [pipe {
                        relation project $assocs Domain Component AssocClass AssocInstance\
                            SourceClass SourceInstance TargetClass TargetInstance |
                        relation group ~ References AssocInstance |
                        relation restrictwith ~ {[relation cardinality $References] > 1}
                    }]
                    # puts [relformat $duprefs duprefs]
                    relation foreach dupref $duprefs {
                        relation assign $dupref
                        log::error "for domain population, $Domain,\
                            associative class, $AssocClass, instances,\
                            [join [relation list $References] {, }],\
                            all refer to both $SourceClass.$SourceInstance and\
                            $TargetClass.$TargetInstance across, $Component:\
                            associative class reference pairs must be unique"
                        incr errcount
                    }
                    # Remove duplicate references
                    set assocs [pipe {
                        relation ungroup $duprefs References |
                        relation semiminus ~ $assocs -using\
                            {Domain Domain Component Component AssocClass AssocClass\
                            AssocInstance AssocInstance}
                    }]
                    set srcreftos [pipe {
                        relation project $assocs Domain Component AssocClass AssocInstance\
                            SourceClass SourceInstance TargetMult |
                        relation rename ~ SourceClass Class SourceInstance Instance\
                            TargetMult Multiplicity |
                        relation group ~ AssocInstances AssocInstance
                    }]
                    # puts [relformat $srcreftos srcreftos]
                    
                    set trgreftos [pipe {
                        relation project $assocs Domain Component AssocClass AssocInstance\
                            TargetClass TargetInstance SourceMult |
                        relation rename ~ TargetClass Class TargetInstance Instance\
                            SourceMult Multiplicity |
                        relation group ~ AssocInstances AssocInstance
                    }]
                    # puts [relformat $trgreftos trgreftos]
                    
                    set reftos [pipe {
                        relation union $srcreftos $trgreftos |
                        relation restrictwith ~ {!$Multiplicity &&\
                            [relation cardinality $AssocInstances] > 1}
                    }]
                    # puts [relformat $reftos reftos]
                    relation foreach refto $reftos {
                        relation assign $refto
                        log::error "for domain population, $Domain,\
                            class based association, $Component, is singular to, $Class,\
                            but instance, $Instance,\
                            is referred to multiple times by associative class, $AssocClass,\
                            instances: [join [relation list $AssocInstances] {, }]"
                        incr errcount
                    }
                    set srcconds [pipe {
                        relation project $assocs Domain Component AssocClass\
                                SourceClass SourceInstance TargetCond |
                        relation rename ~ SourceClass Class SourceInstance Instance\
                                TargetCond Conditionality |
                        relation group ~ ReferencedInstances Instance |
                        ralutil::rvajoin ~ [relation eliminate $popinsts Number] Instances
                    }]
                    # puts [relformat $srcconds srcconds]
                    
                    set trgconds [pipe {
                        relation project $assocs Domain Component AssocClass\
                                TargetClass TargetInstance SourceCond |
                        relation rename ~ TargetClass Class TargetInstance Instance\
                                SourceCond Conditionality |
                        relation group ~ ReferencedInstances Instance |
                        ralutil::rvajoin ~ [relation eliminate $popinsts Number] Instances
                    }]
                    # puts [relformat $trgconds trgconds]
                    
                    set badconds [pipe {
                        relation union $srcconds $trgconds |
                        relation restrictwith ~ {!$Conditionality &&\
                                [relation is $ReferencedInstances != $Instances]}
                    }]
                    # puts [relformat $badconds badconds]
                    relation foreach badcond $badconds {
                        relation assign $badcond
                        set notrefed [relation minus $Instances $ReferencedInstances]
                        log::error "for domain population, $Domain,\
                            class based association, $Component, requires all instances of $Class\
                            to be referenced, but the \"[join [relation list $notrefed] {, }]\"\
                            instance(s) of $Class is(are) not referenced by any instance\
                            of $AssocClass"
                        incr errcount
                    }
                    set subrefs [pipe {
                        Subclass findWhere {$Domain eq $domain} |
                        deRef ~ |
                        relation eliminate ~ Role |
                        relation rename ~ Class SubClass |
                        relation join ~ $::micca::Superclass |
                        relation eliminate ~ Role |
                        relation rename ~ Class SuperClass Relationship Component |
                        relation join ~ $popvalues -using\
                            {Domain Domain SubClass Class Component Component} |
                        relation rename ~ Instance SubClassInstance Value SuperClassInstance
                    }]
                    # puts [relformat $subrefs subrefs]
                    set badrefs [pipe {
                        relation rename $subrefs SuperClass Class SuperClassInstance Instance |
                        ralutil::rvajoin ~ $popinsts Instances |
                        relation restrictwith ~ {[relation isempty $Instances]}
                    }]
                    # puts [relformat $badrefs badrefs]
                    
                    relation foreach badref $badrefs {
                        relation assign $badref
                        log::error "for domain population, $Domain, generalization, $Component,\
                            subclass instance, $SubClass.$SubClassInstance, references\
                            superclass instance, $Class.$Instance, but $Instance does not exist"
                        incr errcount
                    }
                    set subrefs [pipe {
                        relation eliminate $badrefs Instances |
                        relation rename ~ Class SuperClass Instance SuperClassInstance |
                        relation minus $subrefs ~
                    }]
                    # puts [relformat $subrefs subrefs]
                    set multirefs [pipe {
                        relation group $subrefs SubClassReferences SubClass SubClassInstance |
                        relation restrictwith ~ {[relation cardinality $SubClassReferences] > 1}
                    }]
                    # puts [relformat $multirefs multirefs]
                    relation foreach multiref $multirefs {
                        relation assign $multiref
                        relation foreach sref $SubClassReferences {
                            relation assign $sref
                            lappend screfs $SubClass.$SubClassInstance
                        }
                        log::error "for domain population, $Domain, generalization, $Component,\
                            superclass instance, $SuperClass.$SuperClassInstance, is referenced by\
                            multiple subclass instances, \"[join $screfs {, }]\":\
                            this violates the referential integrity of generalizations"
                        incr errcount
                    }
                    set unrefeds [pipe {
                        relation rename $subrefs SuperClass Class SuperClassInstance Instance |
                        relation eliminate ~ SubClass SubClassInstance |
                        relation group ~ ReferencedSupers Instance |
                        ralutil::rvajoin ~ [relation eliminate $popinsts Number] Instances |
                        relation restrictwith ~ {[relation is $ReferencedSupers != $Instances]}
                    }]
                    # puts [relformat $unrefeds unrefeds]
                    
                    relation foreach unrefed $unrefeds {
                        relation assign $unrefed
                        set notrefeds [pipe {
                            relation minus $Instances $ReferencedSupers |
                            relation list ~
                        }]
                        foreach notrefed $notrefeds {
                            log::error "for domain population, $Domain, generalization, $Component,\
                                superclass instance, $Class.$notrefed, is not referenced by any\
                                subclass: this violates the referential integrity of\
                                generalizations"
                            incr errcount
                        }
                    }
        
                    if {$errcount != 0} {
                        ral relvar transaction rollback
                        return
                    }
        
                    # Once we like the populated values supplied by the user we can use
                    # them to set the values of the generated class components.
        
                    set gencomps [GeneratedComponent findWhere {$Domain eq $domain}]
                    
                    set singlerefs [pipe {
                        SingularReference findWhere {$Domain eq $domain} |
                        findRelated % R26 {~R28 BackwardReference} ~R94
                    } {} |%]
                    # puts [relformat [deRef $singlerefs] singlerefs]
                    
                    set simprefedclass [findRelated $singlerefs {~R38 SimpleReferencedClass}]
                    # Compute the referenced made by the refering class instances.
                    set refingrefs [pipe {
                        deRef $simprefedclass |
                        relation eliminate ~ Role |
                        relation rename ~ Class ReferencedClass |
                        relation join ~ $::micca::SimpleReferringClass |
                        relation rename ~ Class ReferringClass Relationship Component |
                        relation eliminate ~ Role Conditionality Multiplicity |
                        relation join ~ $popvalues -using\
                            {Domain Domain Component Component ReferringClass Class} |
                        relation update ~ sbtup {1} {
                            tuple update $sbtup Component "[tuple extract $sbtup Component]__BACK"}
                    }]
                    # puts [relformat $refingrefs refingrefs]
                    
                    # Now we have to split out the nil references
                    # Invert referring and referenced formating a new value to show
                    # which instances referenced by the referring class.
                    set backrefs [pipe {
                        relation restrictwith $refingrefs {$Value ne "@nil@"} |
                        relation extend ~ sbtup NewValue string {[list\
                            [tuple extract $sbtup ReferringClass]\
                            [tuple extract $sbtup Instance]]} |
                        relation eliminate ~ ReferringClass Instance |
                        relation rename ~ ReferencedClass Class Value Instance NewValue Value
                    }]
                    # puts [relformat $backrefs backrefs]
                    
                    foreach backref [relation body $backrefs] {
                        SpecifiedComponentValue create {*}$backref
                        dict unset backref Value
                        ClassComponentValue create {*}$backref
                    }
                    
                    CreateNilDestBackRefs $simprefedclass $backrefs
                    set trgclass [findRelated $singlerefs {~R38 TargetClass}]
                    set trgrefing [pipe {
                        deRef $trgclass |
                        relation eliminate ~ Role Conditionality Multiplicity |
                        relation rename ~ Class TargetClass |
                        relation join ~ $::micca::AssociatorClass |
                        relation rename ~ Class AssociatorClass |
                        relation eliminate ~ Role Multiplicity |
                        relation join ~ $::micca::SourceClass |
                        relation rename ~ Class SourceClass Relationship Component |
                        relation eliminate ~ Role Conditionality Multiplicity |
                        relation rename ~ AssociatorClass Class |
                        ralutil::rvajoin ~ $popvalues Values |
                        relation update ~ sbtup {1} {
                            tuple update $sbtup Component "[tuple extract $sbtup Component]__BACK"}
                    }]
                    # puts [relformat $trgrefing trgrefing]
                    
                    set trgbackrefs [pipe {
                        relation restrictwith $trgrefing {[relation isnotempty $Values]} |
                        relation ungroup ~ Values |
                        relation rename ~ Class AssociatorClass
                    }]
                    # puts [relformat $trgbackrefs trgbackrefs]
                    set nrtrgbackrefs [pipe {
                        relation restrictwith $trgbackrefs {$SourceClass ne $TargetClass} |
                        relation extend ~ tbtup TargetInstance string {[dict get\
                            [tuple extract $tbtup Value] [tuple extract $tbtup TargetClass]]}
                    }]
                    # puts [relformat $nrtrgbackrefs nrtrgbackrefs]
                    set rtrgbackrefs [pipe {
                        relation restrictwith $trgbackrefs {$SourceClass eq $TargetClass} |
                        relation extend ~ tbtup TargetInstance string {[dict get\
                            [tuple extract $tbtup Value] forward]}
                    }]
                    # puts [relformat $rtrgbackrefs rtrgbackrefs]
                    set backrefs [pipe {
                        relation union $nrtrgbackrefs $rtrgbackrefs |
                        relation extend ~ brtup NewValue string {[list\
                            [tuple extract $brtup AssociatorClass]\
                            [tuple extract $brtup Instance]]} |
                        relation eliminate ~ AssociatorClass SourceClass Instance Value |
                        relation rename ~ TargetClass Class TargetInstance Instance NewValue Value
                    }]
                    # puts [relformat $backrefs backrefs]
                    foreach backref [relation body $backrefs] {
                        SpecifiedComponentValue create {*}$backref
                        dict unset backref Value
                        ClassComponentValue create {*}$backref
                    }
                    
                    CreateNilDestBackRefs $trgclass $backrefs
                    set srcclass [pipe {
                        SingularReference findWhere {$Domain eq $domain} |
                        findRelated % R26 {~R28 ForwardReference} ~R95
                    } {} |%]
                    set srcrefing [pipe {
                        deRef $srcclass |
                        relation eliminate ~ Role Conditionality Multiplicity |
                        relation rename ~ Class SourceClass |
                        relation join ~ $::micca::AssociatorClass |
                        relation rename ~ Class AssociatorClass |
                        relation eliminate ~ Role Multiplicity |
                        relation join ~ $::micca::TargetClass |
                        relation rename ~ Class TargetClass Relationship Component |
                        relation eliminate ~ Role Conditionality Multiplicity |
                        relation rename ~ AssociatorClass Class |
                        ralutil::rvajoin ~ $popvalues Values |
                        relation update ~ sbtup {1} {
                            tuple update $sbtup Component "[tuple extract $sbtup Component]__FORW"}
                    }]
                    # puts [relformat $srcforwrefs srcforwrefs]
                    
                    set srcforwrefs [pipe {
                        relation restrictwith $srcrefing {[relation isnotempty $Values]} |
                        relation ungroup ~ Values |
                        relation rename ~ Class AssociatorClass
                    }]
                    set nrsrcforwrefs [pipe {
                        relation restrictwith $srcforwrefs {$SourceClass ne $TargetClass} |
                        relation extend ~ tbtup SourceInstance string {[dict get\
                            [tuple extract $tbtup Value] [tuple extract $tbtup SourceClass]]}
                    }]
                    # puts [relformat $nrsrcforwrefs nrsrcforwrefs]
                    
                    set rsrcforwrefs [pipe {
                        relation restrictwith $srcforwrefs {$SourceClass eq $TargetClass} |
                        relation extend ~ tbtup SourceInstance string {[dict get\
                            [tuple extract $tbtup Value] backward]}
                    }]
                    # puts [relformat $rsrcforwrefs rsrcforwrefs]
                    set forwrefs [pipe {
                        relation union $nrsrcforwrefs $rsrcforwrefs |
                        relation extend ~ frtup NewValue string {[list\
                            [tuple extract $frtup AssociatorClass]\
                            [tuple extract $frtup Instance]]} |
                        relation eliminate ~ AssociatorClass TargetClass Instance Value |
                        relation rename ~ SourceClass Class SourceInstance Instance NewValue Value
                    }]
                    # puts [relformat $forwrefs forwrefs]
                    foreach forwref [relation body $forwrefs] {
                        SpecifiedComponentValue create {*}$forwref
                        dict unset forwref Value
                        ClassComponentValue create {*}$forwref
                    }
                    
                    CreateNilSourceForwRefs $srcclass $forwrefs
                    set arrayrefs [pipe {
                        ArrayReference findWhere {$Domain eq $domain} |
                        findRelated % R26 {~R28 BackwardReference} ~R94
                    } {} |%]
                    # puts [relformat [deRef $arrayrefs] arrayrefs]
                    
                    set arrayrefedclass [findRelated $arrayrefs {~R38 SimpleReferencedClass}]
                    set refingrefs [FindSimpleReferringRefs $arrayrefedclass $popvalues]
                    # puts [relformat $refingrefs refingrefs]
                    set backrefs [pipe {
                        FindSimpleBackRefs $refingrefs |
                        relation eliminate ~ Relationship
                    }]
                    # puts [relformat $backrefs backrefs]
                    
                    foreach backref [relation body $backrefs] {
                        SpecifiedComponentValue create {*}$backref
                        dict unset backref Value
                        ClassComponentValue create {*}$backref
                    }
                    
                    CreateNilDestBackRefs $arrayrefedclass $backrefs
                    set trgclass [findRelated $arrayrefs {~R38 TargetClass}]
                    set refingrefs [FindTargetReferringRefs $trgclass $popvalues]
                    # puts [relformat $refingrefs refingrefs]
                    set backrefs [pipe {
                        FindTargetBackRefs $refingrefs |
                        relation eliminate ~ Relationship
                    }]
                    # puts [relformat $backrefs backrefs]
                    
                    foreach backref [relation body $backrefs] {
                        SpecifiedComponentValue create {*}$backref
                        dict unset backref Value
                        ClassComponentValue create {*}$backref
                    }
                    
                    CreateNilDestBackRefs $trgclass $backrefs
                    set srcclass [pipe {
                        ArrayReference findWhere {$Domain eq $domain} |
                        findRelated % R26 {~R28 ForwardReference} ~R95
                    } {} |%]
                    
                    set refingrefs [FindSourceReferringRefs $srcclass $popvalues]
                    # puts [relformat $refingrefs refingrefs]
                    set forwrefs [pipe {
                        FindSourceForwRefs $refingrefs |
                        relation eliminate ~ Relationship
                    }]
                    # puts [relformat $forwrefs forwrefs]
                    
                    foreach forwref [relation body $forwrefs] {
                        SpecifiedComponentValue create {*}$forwref
                        dict unset forwref Value
                        ClassComponentValue create {*}$forwref
                    }
                    
                    CreateNilSourceForwRefs $srcclass $forwrefs
                    set linkbackrefs [pipe {
                        LinkReference findWhere {$Domain eq $domain} |
                        findRelated % R26 {~R28 BackwardReference} ~R94
                    } {} |%]
                    
                    set linkrefedclass [findRelated $linkbackrefs {~R38 SimpleReferencedClass}]
                    
                    set refingrefs [FindSimpleReferringRefs $linkrefedclass $popvalues]
                    # puts [relformat $refingrefs refingrefs]
                    set backrefs [FindSimpleBackRefs $refingrefs]
                    # puts [relformat $backrefs backrefs]
                    
                    CreateLinkedRefs $backrefs BLINKS
                    
                    CreateNilLinkedBackRefs $linkrefedclass $backrefs
                    set trgclass [findRelated $linkbackrefs {~R38 TargetClass}]
                    set refingrefs [FindTargetReferringRefs $trgclass $popvalues]
                    # puts [relformat $refingrefs refingrefs]
                    set backrefs [FindTargetBackRefs $refingrefs]
                    # puts [relformat $backrefs backrefs]
                    
                    CreateLinkedRefs $backrefs BLINKS
                    
                    CreateNilLinkedBackRefs $trgclass $backrefs
                    set srcclass [pipe {
                        LinkReference findWhere {$Domain eq $domain} |
                        findRelated % R26 {~R28 ForwardReference} ~R95
                    } {} |%]
                    
                    set refingrefs [FindSourceReferringRefs $srcclass $popvalues]
                    set forwrefs [FindSourceForwRefs $refingrefs]
                    CreateLinkedRefs $forwrefs FLINKS
                    
                    CreateNilLinkedForwRefs $srcclass $forwrefs
                    set rsupercomps [pipe {
                        ReferringSubclass findWhere {$Domain eq $domain} |
                        findRelated % R47 R40 R41 ~R20 {~R25 PopulatedComponent} {~R21 Reference}\
                            {~R23 SuperclassReference} R23 R21 R25 {~R103 ClassComponentValue}\
                            {~R109 SpecifiedComponentValue} |
                        deRef % |
                        relation join %\
                            $::micca::ReferenceGeneralization -using {Domain Domain Component Name}\
                            [relation rename $::micca::ReferencedSuperclass Class Superclass]\
                            -using {Domain Domain Component Relationship} |
                        relation extend % rstup NewValue string {
                            [list [tuple extract $rstup Class] [tuple extract $rstup Instance]]} |
                        relation eliminate % Class Instance Role |
                        relation rename % Superclass Class Value Instance NewValue Value
                    } {} |%]
                    # puts [relformat $rsupercomps rsupercomps]
                    
                    foreach subref [relation body $rsupercomps] {
                        SpecifiedComponentValue create {*}$subref
                        dict unset subref Value
                        ClassComponentValue create {*}$subref
                    }
                    set usupercomps [pipe {
                        UnionSubclass findWhere {$Domain eq $domain} |
                        findRelated % R47 R40 R41 ~R20 {~R25 PopulatedComponent} {~R21 Reference}\
                            {~R23 SuperclassReference} R23 R21 R25 {~R103 ClassComponentValue}\
                            {~R109 SpecifiedComponentValue} |
                        deRef % |
                        relation join %\
                            $::micca::UnionGeneralization -using {Domain Domain Component Name}\
                            [relation rename $::micca::UnionSuperclass Class Superclass]\
                            -using {Domain Domain Component Relationship} |
                        relation extend % rstup NewValue string {
                            [list [tuple extract $rstup Class] [tuple extract $rstup Instance]]} |
                        relation eliminate % Class Instance Role |
                        relation rename % Superclass Class Value Instance NewValue Value
                    } {} |%]
                    # puts [relformat $usupercomps usupercomps]
                    
                    foreach subcont [relation body $usupercomps] {
                        SpecifiedComponentValue create {*}$subcont
                        dict unset subcont Value
                        ClassComponentValue create {*}$subcont
                    }
                    set usupers [pipe {
                        FindUltimateSuperclasses $domain |
                        findRelated % {~R48 UnionSuperclass}
                    } {} |%]
                    # puts [relformat [deRef $usupers] usupers]
                    
                    while {[isNotEmptyRef $usupers]} {
                        set subrefs [pipe {
                            deRef $usupers |
                            relation eliminate ~ Role |
                            relation rename ~ Relationship Component |
                            relation join ~ $::micca::SpecifiedComponentValue\
                                    $::micca::ClassInstance |
                            relation rename ~ Class Superclass Instance SuperInstance |
                            relation extend ~ srtup\
                                Class string {[lindex [tuple extract $srtup Value] 0]}\
                                Instance string {[lindex [tuple extract $srtup Value] 1]} |
                            relation project ~ Domain Class Instance Number
                        }]
                        # puts [relformat $subrefs subrefs]
                    
                        # relvar updateper does not update identifying attributes and
                        # Number is a secondary identifier.
                        # So we have to do it the hard way.
                        # And because Number is part of a secondary identifier, we must remove the
                        # old tuples and the add in the new ones or we risk a duplicate identifier
                        # situation.
                        relvar minus ::micca::ClassInstance [pipe {
                            relation eliminate $subrefs Number |
                            relation join ~ $::micca::ClassInstance -using\
                                {Domain Domain Class Class Instance Instance}
                        }]
                        relvar union ::micca::ClassInstance $subrefs
                    
                        set usupers [pipe {
                            findRelated $usupers R44 ~R45 |
                            deRef % |
                            relation semijoin % $::micca::UnionSuperclass\
                                -using {Domain Domain Class Class} |
                            ::rosea::Helpers::ToRef ::micca::UnionSuperclass %
                        } {} |%]
                    }
                } on error {result opts} {
                    ral relvar transaction rollback
                    return -options $opts $result
                }
                ral relvar transaction end
            } on error {result} {
                # puts $::errorInfo
                HandleConfigError $result
                return
            }
        }
        proc HandleConfigError {result} {
            set lines [split [string trimright $result] \n]
            set nlines [llength $lines]
            set lineno 0
            upvar #0 ::micca::@Config@::errcount errcount
            while {$lineno < $nlines} {
                set line [lindex $lines $lineno]
                incr lineno
                if {[regexp {^for[^:]+([^(]+)\(.+\), in relvar (.+)$} $line\
                        match rnum refclass]} {
                    set rnum [namespace tail $rnum]
                    set refclass [namespace tail $refclass]
                
                    # Now iterate over the "tuple" lines that follow the constraint message.
                    while {$lineno < $nlines} {
                        set tupline [lindex $lines $lineno]
                        if {[regexp {^tuple {(.+)} (.+)$} $tupline match tuple phrase]} {
                            incr lineno
                            incr errcount
                            if {[string match {is not referenced*} $phrase]} {
                                set reftype notrefed
                            } elseif {[string match {references no*} $phrase]} {
                                set reftype refnone
                            } elseif {[string match {is referenced by multiple*} $phrase]} {
                                set reftype refedmult
                            } elseif {[string match {*to by multiple*} $phrase]} {
                                set reftype multrefed
                            } elseif {[string match {is not referred to*} $phrase]} {
                                set reftype notrefto
                            } else {
                                log::error "unknown constraint phrasing, \"$phrase\""
                                continue
                            }
                            set cde [relvar restrictone Config_DataError Relationship $rnum RefClass\
                                    $refclass RefType $reftype]
                            if {[relation isnotempty $cde]} {
                                dict with tuple {
                                    log::error [subst -nocommands [relation extract $cde Format]]
                                }
                            } else {
                                log::error "$line\n$tupline"
                            }
                        } else {
                            break
                        }
                    }
                } elseif {[regexp {procedural contraint, "([^"]+)", failed} $line match\
                        constraint]} {
                    # There is only one procedural constraint, R74C.
                    # If an error is detected in the procedural constraint script,
                    # messages will be printed there.
                    log::error $result
                    incr errcount
                } else {
                    log::error $result
                    incr errcount
                }
            }
        
            return
        }
    
        namespace eval DomainDef {
            ::logger::import -all -force -namespace log micca
        
            namespace import\
                ::ral::relation\
                ::ral::tuple\
                ::ral::relformat\
                ::ralutil::pipe
            namespace import ::micca::@Config@::ConfigEvaluate
            namespace import ::micca::@Config@::Helpers::DeclError
            namespace path {::micca ::micca::@Config@::Helpers ::rosea::InstCmds}
            proc interface {text} {
                variable DomainName
                AppendToDomainAttribute $DomainName Interface $text
            }
            proc prologue {text} {
                variable DomainName
                AppendToDomainAttribute $DomainName Prologue $text
            }
            proc epilogue {text} {
                variable DomainName
                AppendToDomainAttribute $DomainName Epilogue $text
            }
            proc AppendToDomainAttribute {domainname attrname text} {
                set domref [Domain findById Name $domainname]
                set value [readAttribute $domref $attrname]
                if {$value ne {} && [string index $value end] ne "\n"} {
                    append value \n ; # <1>
                }
                append value $text
                updateAttribute $domref $attrname $value
                return
            }
            proc class {name {body {}}} {
                variable DomainName ; # <1>
            
                set elemRef [DomainElement findById Domain $DomainName Name $name]
            
                if {[isEmptyRef $elemRef]} {# <2>
                    DomainElement create Domain $DomainName Name $name
                    Class create Domain $DomainName Name $name\
                        Number [GenNumber $DomainName Class [list $DomainName]]
                    ValueElement create Domain $DomainName Name $name
                } else {
                    set classRef [findRelated $elemRef {~R2 Class}]
                    if {[isEmptyRef $classRef]} {
                        EntityError "Domain Element" DUPLICATE_ENTITY\
                            [list Domain $DomainName Name $name]
                    }
                }
            
                namespace upvar ClassDef ClassName ClassName ; # <3>
                set ClassName $name
                ConfigEvaluate [namespace current]::ClassDef $body
            
                return
            }
            proc association {name args} {
                if {$name eq {}} {
                    tailcall DeclError BAD_NAME [list $name] association
                }
                if {[string index $name 0] eq "~"} {
                    tailcall DeclError TILDE_NAME $name
                }
            
                if {[llength $args] < 3} {
                    tailcall DeclError ASSOC_OPTIONS $args
                }
            
                set allargs $args
                set associator {}
                set isstatic false
                set ismultiple false
                while {1} {
                    set args [lassign $args arg]
            
                    if {$arg eq "-associator"} {
                        set args [lassign $args associator]
                    } elseif {$arg eq "-multiple"} {
                        set ismultiple true
                    } elseif {$arg eq "-static"} {
                        set isstatic true
                    } elseif {$arg eq "-dynamic"} {
                        set isstatic false
                    } elseif {$arg eq "--"} {
                        set args [lassign $args source]
                        break
                    } elseif {[string index $arg 0] eq "-"} {
                        tailcall DeclError ASSOC_OPTIONS $allargs
                    } else {
                        set source $arg
                        break
                    }
                }
                if {[llength $args] < 2 || [llength $args] > 3} {
                    tailcall DeclError ASSOC_OPTIONS $allargs
                }
                lassign $args spec target script
            
                # Obtain references to the domain name
                variable DomainName
            
                if {$source eq {}} {
                    tailcall DeclError BAD_NAME [list $source] class
                }
                if {$target eq {}} {
                    tailcall DeclError BAD_NAME [list $target] class
                }
                
                set csd [pipe {
                    relvar restrictone ::micca::@Config@::Config_AssocSpec SpecName $spec |
                    relation semijoin ~ [relvar set ::micca::@Config@::Config_SpecDetail]
                }]
                if {[relation isempty $csd]} {
                    tailcall DeclError BAD_RELATIONSHIP_SPEC $spec
                }
                relation assign $csd
                if {$NeedsAssociator && $associator eq {}} {
                    tailcall DeclError NEED_ASSOCIATOR $spec
                }
                if {!($source ne $target || $ReflexiveAllowed)} {
                    tailcall DeclError REFLEXIVE_NOT_ALLOWED $spec
                }
                if {$ismultiple && !$MultipleAllowed} {
                    tailcall DeclError BAD_MULTIPLE_OPT $name
                }
            
                # Many relvars have tuples with the same heading, so we construct it
                # once here.
                set reltuple [list\
                    Domain  $DomainName\
                    Name $name\
                ]
                CheckDuplicate DomainElement association {*}$reltuple
                DomainElement create {*}$reltuple
            
                # Populate the data for a Relationship and Association since that
                # is what this command defines.
                Relationship create {*}$reltuple\
                    Number [GenNumber $DomainName Relationship [list $DomainName]]
                Association create {*}$reltuple IsStatic $isstatic
            
                # Set up tuple values for later use.
                set sourcetuple [list\
                    Domain          $DomainName\
                    Class           $source\
                    Relationship    $name\
                    Role            source\
                ]
                set targettuple [list\
                    Domain          $DomainName\
                    Class           $target\
                    Relationship    $name\
                    Role            target\
                ]
            
                # Populate the type of association we are dealing with.
                if {$associator eq {}} {
                    
                    SimpleAssociation create {*}$reltuple
                    
                    SimpleReferringClass create {*}$sourcetuple\
                            Conditionality  $ReferringCond\
                            Multiplicity    $ReferringMult
                    ClassRole create {*}$sourcetuple
                    
                    set poptuple [list\
                        Domain          $DomainName\
                        Class           $source\
                        Name            $name\
                    ]
                    AssociationReference create {*}$poptuple
                    Reference create {*}$poptuple
                    PopulatedComponent create {*}$poptuple
                    ClassComponent create {*}$poptuple
                    
                    SimpleReferencedClass create {*}$targettuple
                    DestinationClass create {*}$targettuple
                    ClassRole create {*}$targettuple
                    
                    set gentuple [list\
                        Domain          $DomainName\
                        Class           $target\
                        Name            ${name}__BACK\
                    ]
                    ComplementaryReference create {*}$gentuple
                    BackwardReference create {*}$gentuple Relationship $name
                    if {!$ReferringMult} {
                        SingularReference create {*}$gentuple
                    } elseif {$isstatic} {
                        ArrayReference create {*}$gentuple
                    } else {
                        LinkReference create {*}$gentuple
                        set conttuple [list\
                            Domain      $DomainName\
                            Class       $source\
                            Name        ${name}__BLINKS\
                        ]
                        LinkContainer create {*}$conttuple LinkClass $target LinkComp ${name}__BACK
                        GeneratedComponent create {*}$conttuple
                        ClassComponent create {*}$conttuple
                    }
                    GeneratedComponent create {*}$gentuple
                    ClassComponent create {*}$gentuple
                } else {
                    ClassBasedAssociation create {*}$reltuple
                    
                    SourceClass create {*}$sourcetuple\
                            Conditionality  $ReferringCond\
                            Multiplicity    $ReferringMult
                    ClassRole create {*}$sourcetuple
                    
                    set srccomp [list\
                        Domain          $DomainName\
                        Class           $source\
                        Name            ${name}__FORW\
                    ]
                    ComplementaryReference create {*}$srccomp
                    ForwardReference create {*}$srccomp Relationship $name
                    if {!$ReferencedMult} {
                        SingularReference create {*}$srccomp
                    } elseif {$isstatic} {
                        ArrayReference create {*}$srccomp
                    } else {
                        LinkReference create {*}$srccomp
                        set conttuple [list\
                            Domain      $DomainName\
                            Class       $associator\
                            Name        ${name}__FLINKS\
                        ]
                        LinkContainer create {*}$conttuple LinkClass $source LinkComp ${name}__FORW
                        GeneratedComponent create {*}$conttuple
                        ClassComponent create {*}$conttuple
                    }
                    GeneratedComponent create {*}$srccomp
                    ClassComponent create {*}$srccomp
                    
                    TargetClass create {*}$targettuple\
                        Conditionality  $ReferencedCond\
                        Multiplicity    $ReferencedMult
                    DestinationClass create {*}$targettuple
                    ClassRole create {*}$targettuple
                    
                    set trgcomp [list\
                        Domain          $DomainName\
                        Class           $target\
                        Name            ${name}__BACK\
                    ]
                    ComplementaryReference create {*}$trgcomp
                    BackwardReference create {*}$trgcomp Relationship $name
                    if {!$ReferringMult} {
                        SingularReference create {*}$trgcomp
                    } elseif {$isstatic} {
                        ArrayReference create {*}$trgcomp
                    } else {
                        LinkReference create {*}$trgcomp
                        set conttuple [list\
                            Domain      $DomainName\
                            Class       $associator\
                            Name        ${name}__BLINKS\
                        ]
                        LinkContainer create {*}$conttuple LinkClass $target LinkComp ${name}__BACK
                        GeneratedComponent create {*}$conttuple
                        ClassComponent create {*}$conttuple
                    }
                    GeneratedComponent create {*}$trgcomp
                    ClassComponent create {*}$trgcomp
                    
                    set assoctuple [list\
                        Domain          $DomainName\
                        Class           $associator\
                        Relationship    $name\
                        Role            associator\
                    ]
                    set assoccomp [list\
                        Domain          $DomainName\
                        Class           $associator\
                        Name            $name\
                    ]
                    
                    AssociatorClass create {*}$assoctuple Multiplicity $ismultiple
                    ClassRole create {*}$assoctuple
                    AssociatorReference create {*}$assoccomp
                    Reference create {*}$assoccomp
                    PopulatedComponent create {*}$assoccomp
                    ClassComponent create {*}$assoccomp
                }
            
                if {$script ne {}} {
                    namespace upvar ClassDef ClassName ClassName
                    set ClassName $name
            
                    namespace upvar AssignerDef IdClassName IdClassName
                    set IdClassName {}
            
                    ConfigEvaluate [namespace current]::AssignerDef $script
            
                    if {$IdClassName eq {}} {
                        SingleAssigner create\
                            Domain          $DomainName\
                            Association     $name
                    } else {
                        MultipleAssigner create\
                            Domain          $DomainName\
                            Association     $name\
                            Class           $IdClassName
                        ValueElement create Domain $DomainName Name $name
                    }
                }
            
                return
            }
            proc generalization {name args} {
                if {$name eq {}} {
                    tailcall DeclError BAD_NAME [list $name] generalization
                }
                if {[string index $name 0] eq "~"} {
                    tailcall DeclError TILDE_NAME $name
                }
            
                set allargs $args
                set type reference
                while {1} {
                    set args [lassign $args arg]
            
                    if {$arg eq "-reference"} {
                        set type reference
                    } elseif {$arg eq "-union"} {
                        set type union
                    } elseif {$arg eq "--"} {
                        set args [lassign $args super]
                        break
                    } elseif {[string index $arg 0] eq "-"} {
                        tailcall DeclError GEN_OPTIONS $allargs
                    } else {
                        set super $arg
                        break
                    }
                }
            
                if {[llength $args] < 2} {
                    tailcall DeclError TOO_FEW_SUBCLASSES [llength $args]
                }
                if {$super in $args} {
                    tailcall DeclError SUPER_AS_SUBCLASS $super [join $args {, }]
                }
                if {[llength [lsort -unique $args]] != [llength $args]} {
                    tailcall DeclError DUPLICATE_SUBCLASS $args
                }
            
                variable DomainName
            
                set reltuple [list\
                    Domain  $DomainName\
                    Name $name\
                ]
            
                CheckDuplicate DomainElement generalization {*}$reltuple
                DomainElement create {*}$reltuple
                Relationship create {*}$reltuple\
                    Number [GenNumber $DomainName Relationship [list $DomainName]]
                Generalization create {*}$reltuple
            
                set supertuple [list\
                    Domain          $DomainName\
                    Class           $super\
                    Relationship    $name\
                    Role            target\
                ]
                set subtuple [dict create\
                    Domain          $DomainName\
                    Relationship    $name\
                    Role            source\
                ]
                set reftuple [list\
                    Domain          $DomainName\
                    Class           $super\
                    Name            $name
                ]
                if {$type eq "reference"} {
                    ReferenceGeneralization create {*}$reltuple
                    ReferencedSuperclass create {*}$supertuple
                    SubclassReference create {*}$reftuple
                    GeneratedComponent create {*}$reftuple
                    ClassComponent create {*}$reftuple
            
                    foreach sub $args {
                        dict set subtuple Class $sub
                        ReferringSubclass create {*}$subtuple
                    }
                } elseif {$type eq "union"} {
                    UnionGeneralization create {*}$reltuple
                    UnionSuperclass create {*}$supertuple
                    SubclassContainer create {*}$reftuple
                    GeneratedComponent create {*}$reftuple
                    ClassComponent create {*}$reftuple
            
                    foreach sub $args {
                        set usubRef [UnionSubclass findWhere {$Domain eq $DomainName &&\
                            $Class eq $sub}] ; # <1>
                        if {[isNotEmptyRef $usubRef]} {
                            tailcall DeclError UNION_SUBCLASS_EXISTS $sub\
                                [readAttribute $usubRef Relationship]
                        }
                        dict set subtuple Class $sub
                        UnionSubclass create {*}$subtuple
                    }
                }
                Superclass create {*}$supertuple
                ClassRole create {*}$supertuple
            
                foreach sub $args {
                    dict set subtuple Class $sub
                    Subclass create {*}$subtuple
                    ClassRole create {*}$subtuple
                    dict set reftuple Class $sub
                    SuperclassReference create {*}$reftuple
                    Reference create {*}$reftuple
                    PopulatedComponent create {*}$reftuple
                    ClassComponent create {*}$reftuple
                }
            
                return
            }
            proc eentity {name {body {}}} {
                variable DomainName ; # <1>
            
                set elemRef [DomainElement findById Domain $DomainName Name $name]
            
                if {[isEmptyRef $elemRef]} {# <2>
                    DomainElement create Domain $DomainName Name $name
                    ExternalEntity create Domain $DomainName Name $name
                } else {
                    set eeRef [findRelated $elemRef {~R2 ExternalEntity}]
                    if {[isEmptyRef $eeRef]} {
                        EntityError "Domain Element" DUPLICATE_ENTITY\
                            [list Domain $DomainName Name $name]
                    }
                }
            
                namespace upvar EEntityDef EntityName EntityName ; # <3>
                set EntityName $name
                ConfigEvaluate [namespace current]::EEntityDef $body
            
                return
            }
            proc typealias {aliasname typename} {
                variable DomainName
                CheckDuplicate TypeAlias typealias Domain $DomainName TypeName $aliasname
                TypeAlias create Domain $DomainName TypeName $aliasname\
                    TypeDefinition [string trim $typename]
            
                return
            }
            proc domainop {rettype name parameters body {comment {}}} {
                variable DomainName
                upvar #0\
                        ::micca::@Config@::configfile configfile\
                        ::micca::@Config@::configlineno configlineno
            
                CheckDuplicate DomainOperation {domain operation}\
                        Domain $DomainName Name $name
                DomainOperation create\
                    Domain $DomainName\
                    Name $name\
                    Body $body\
                    ReturnDataType $rettype\
                    Comment [string trim $comment]\
                    File $configfile\
                    Line $configlineno
            
                set paramtuple [dict create Domain $DomainName Operation $name]
                dict for {paramname paramtype} $parameters {
                    dict set paramtuple Name $paramname
                    dict set paramtuple DataType $paramtype
                    dict set paramtuple Number\
                            [GenNumber $DomainName DomainOperationParameter\
                            [list $DomainName $name]]
                    DomainOperationParameter create {*}$paramtuple
                }
            
                return
            }
        
            # Child namespaces for domain commands with additional structure
            namespace eval ClassDef {
                ::logger::import -all -force -namespace log micca
            
                namespace import\
                    ::ral::relation\
                    ::ral::tuple\
                    ::ral::relformat\
                    ::ralutil::pipe
                namespace import ::micca::@Config@::ConfigEvaluate
                namespace path {::micca ::micca::@Config@::Helpers ::rosea::InstCmds}
            
                proc attribute {name type args} {
                    if {$name eq {}} {
                        tailcall DeclError BAD_NAME [list $name] attribute
                    }
                
                    upvar #0\
                            [namespace parent]::DomainName DomainName\
                            ::micca::@Config@::configfile configfile\
                            ::micca::@Config@::configlineno configlineno
                    variable ClassName
                
                    set options [dict create]
                    while {[llength $args] != 0} {
                        set args [lassign $args opt]
                        switch -exact -- $opt {
                            -default {
                                if {[llength $args] != 0} {
                                    set args [lassign $args optValue]
                                    dict set options $opt $optValue
                                } else {
                                    tailcall DeclError ARG_FORMAT $opt
                                }
                            }
                            -dependent {
                                if {[llength $args] != 0} {
                                    set args [lassign $args optValue]
                                    dict set options $opt $optValue
                                } else {
                                    tailcall DeclError ARG_FORMAT $opt
                                }
                            }
                            -zeroinit {
                                dict set options $opt true
                            }
                            default {
                                tailcall DeclError ATTR_OPTIONS $opt
                            }
                        }
                    }
                
                    # The attribute options are mutually exclusive. Make sure more than
                    # did not get set.
                    if {[dict size $options] > 1} {
                        tailcall DeclError ATTR_OPTIONS $options
                    }
                
                    set attrtuple [list\
                        Domain      $DomainName\
                        Class       $ClassName\
                        Name        $name\
                    ]
                    CheckDuplicate Attribute attribute {*}$attrtuple
                    Attribute create {*}$attrtuple DataType $type
                    PopulatedComponent create {*}$attrtuple
                    ClassComponent create {*}$attrtuple
                    if {[dict exists $options -dependent]} {
                        DependentAttribute create {*}$attrtuple\
                            Formula [dict get $options -dependent]\
                            File $configfile\
                            Line $configlineno
                    } else {
                        IndependentAttribute create {*}$attrtuple
                        if {[dict exists $options -zeroinit]} {
                            ZeroInitializedAttribute create {*}$attrtuple
                        } else {
                            ValueInitializedAttribute create {*}$attrtuple
                            if {[dict exists $options -default]} {
                                DefaultValue create\
                                    Domain      $DomainName\
                                    Class       $ClassName\
                                    Attribute   $name\
                                    Value       [dict get $options -default]
                            }
                        }
                    }
                }
                proc polymorphic {name args} {
                    upvar #0 [namespace parent]::DomainName DomainName
                    variable ClassName
                
                    set psigid [expr {[llength $args] != 0 ?\
                            [FindParameterSignature $args] : {}}]
                
                    set eventtuple [list\
                        Domain  $DomainName\
                        Model   $ClassName\
                        Event   $name\
                    ]
                    CheckDuplicate Event {polymorphic event} {*}$eventtuple
                    Event create {*}$eventtuple PSigID $psigid Number -1
                    DeferredEvent create {*}$eventtuple
                    PolymorphicEvent create {*}$eventtuple
                
                    return
                }
                proc classop {rettype name parameters body} {
                    DefineOperation false $rettype $name $parameters $body
                }
                proc instop {rettype name parameters body} {
                    DefineOperation true $rettype $name $parameters $body
                }
                proc DefineOperation {isinst rettype name parameters body} {
                    upvar #0\
                            [namespace parent]::DomainName DomainName\
                            ::micca::@Config@::configfile configfile\
                            ::micca::@Config@::configlineno configlineno
                    variable ClassName
                
                    set entity "[expr {$isinst ? "instance" : "class"}] operation"
                    CheckDuplicate Operation $entity Domain $DomainName Class $ClassName\
                            Name $name
                    Operation create\
                        Domain $DomainName\
                        Class $ClassName\
                        Name $name\
                        Body $body\
                        ReturnDataType $rettype\
                        IsInstance $isinst\
                        File $configfile\
                        Line $configlineno
                
                    set paramtuple [dict create Domain $DomainName Class $ClassName\
                            Operation $name]
                
                    if {$isinst} {
                        dict set paramtuple Name self
                        dict set paramtuple DataType "struct $ClassName *const"
                        dict set paramtuple Number\
                                [GenNumber $DomainName OperationParameter\
                                [list $DomainName $ClassName $name]]
                        OperationParameter create {*}$paramtuple
                    }
                
                    dict for {paramname paramtype} $parameters {
                        dict set paramtuple Name $paramname
                        dict set paramtuple DataType $paramtype
                        dict set paramtuple Number\
                                [GenNumber $DomainName OperationParameter\
                                [list $DomainName $ClassName $name]]
                        OperationParameter create {*}$paramtuple
                    }
                
                    return
                }
                proc constructor {body} {
                    upvar #0\
                            [namespace parent]::DomainName DomainName\
                            ::micca::@Config@::configfile configfile\
                            ::micca::@Config@::configlineno configlineno
                    variable ClassName
                
                    CheckDuplicate Constructor constructor Domain $DomainName Class $ClassName
                    Constructor create\
                        Domain $DomainName\
                        Class $ClassName\
                        Body $body\
                        File $configfile\
                        Line $configlineno
                }
                proc destructor {body} {
                    upvar #0\
                            [namespace parent]::DomainName DomainName\
                            ::micca::@Config@::configfile configfile\
                            ::micca::@Config@::configlineno configlineno
                    variable ClassName
                
                    CheckDuplicate Destructor destructor Domain $DomainName Class $ClassName
                    Destructor create\
                        Domain $DomainName\
                        Class $ClassName\
                        Body $body\
                        File $configfile\
                        Line $configlineno
                }
                proc statemodel {body} {
                    upvar #0 [namespace parent]::DomainName DomainName
                    variable ClassName
                
                    namespace upvar StateModelDef\
                        InitialState InitialState\
                        DefaultTrans DefaultTrans\
                        Finals Finals
                
                    set InitialState {}
                    set DefaultTrans {}
                    set Finals [list]
                
                    ConfigEvaluate [namespace current]::StateModelDef $body
                
                    if {$DefaultTrans eq {}} {
                        set DefaultTrans CH
                    }
                
                    CheckDuplicate StateModel {state model} Domain $DomainName Model $ClassName
                    StateModel create\
                        Domain          $DomainName\
                        Model           $ClassName\
                        InitialState    $InitialState\
                        DefaultTrans    $DefaultTrans
                    InstanceStateModel create\
                        Domain          $DomainName\
                        Class           $ClassName
                
                    # Mark any final states that were defined.
                    set fstates [State findWhere {$Domain eq $DomainName &&\
                            $Model eq $ClassName && $Name in $Finals}]
                    forAllRefs fstate $fstates {
                        updateAttribute $fstate IsFinal true
                        struct::set subtract Finals [readAttribute $fstate Name]
                    }
                    if {![struct::set empty $Finals]} {
                        tailcall DeclError BAD_FINAL [join $Finals {, }]
                    }
                
                    # It is an error to define an outgoing transition for a final state.
                    set finalouts [pipe {
                        deRef $fstates |
                        relation semijoin ~ $::micca::StateTransition\
                            -using {Domain Domain Model Model Name State} |
                        relation list ~ State
                    }]
                    if {[llength $finalouts] != 0} {
                        tailcall DeclError FINAL_OUTTRANS [join $finalouts {, }]
                    }
                
                    # Check for isolated states. These are states with no inbound or
                    # outbound transitions and which are not the default initial state.
                    # Such states are unreachable unless the instance is explicitly
                    # created in the state.
                    set states [pipe {
                        State findWhere {$Domain eq $DomainName && $Model eq $ClassName} |
                        deRef ~
                    }]
                    # puts [relformat $states states]
                    set trans [pipe {
                        StateTransition findWhere\
                                {$Domain eq $DomainName && $Model eq $ClassName} |
                        deRef ~
                    }]
                    # puts [relformat $trans trans]
                    set initialState [pipe {
                        StateModel findWhere {$Domain eq $DomainName && $Model eq $ClassName} |
                        deRef ~ |
                        relation project ~ InitialState |
                        relation rename ~ InitialState Name
                    }]
                    # puts [relformat $initialState initialState]
                
                    set noins [pipe {
                        relation semiminus $trans $states\
                            -using {Domain Domain Model Model NewState Name} |
                        relation project ~ Name
                    }]
                    # puts [relformat $noins noins]
                    set noouts [pipe {
                        relation semiminus $trans $states\
                            -using {Domain Domain Model Model State Name} |
                        relation project ~ Name
                    }]
                    # puts [relformat $noouts noouts]
                    set isolated [pipe {
                        relation intersect $noins $noouts |
                        relation minus ~ $initialState |
                        relation list ~
                    }]
                    if {[llength $isolated] != 0} {
                        log::warn "In domain, \"$DomainName\", class, \"$ClassName\",\
                            state(s), \"[join $isolated {, }]\", have no inbound or outbound\
                            transitions and is(are) not the default initial state; the state(s)\
                            are unreachable unless an instance is explicitly created in\
                            the state"
                    }
                }
            
                namespace eval StateModelDef {
                    ::logger::import -all -force -namespace log micca
                
                    namespace import\
                        ::ral::relation\
                        ::ral::tuple\
                        ::ral::relformat\
                        ::ralutil::pipe
                    namespace import ::micca::@Config@::ConfigEvaluate
                    namespace path {::micca ::micca::@Config@::Helpers ::rosea::InstCmds}
                
                    proc state {name params body} {
                        if {$name eq {}} {
                            tailcall DeclError BAD_NAME [list $name] state
                        }
                        if {$name eq "@" || [isNotEmptyRef [TransitionRule findById Name $name]]} {
                            tailcall DeclError BAD_STATE_NAME $name
                        }
                    
                        upvar #0\
                                ::micca::@Config@::DomainDef::DomainName DomainName\
                                ::micca::@Config@::DomainDef::ClassDef::ClassName ClassName\
                                ::micca::@Config@::configfile configfile\
                                ::micca::@Config@::configlineno configlineno
                    
                        variable InitialState
                    
                        if {$InitialState eq {}} {
                            set InitialState $name
                        }
                    
                        set psigid [FindParameterSignature $params]
                        CheckDuplicate State state Domain $DomainName Model $ClassName Name $name
                        set stateref [State create\
                            Domain          $DomainName\
                            Model           $ClassName\
                            Name            $name\
                            Activity        $body\
                            File            $configfile\
                            Line            $configlineno\
                            IsFinal         false\
                            PSigID          $psigid\
                        ]
                        StatePlace create\
                            Domain          $DomainName\
                            Model           $ClassName\
                            Name            $name\
                            Number          [GenNumber $DomainName StatePlace\
                                                [list $DomainName $ClassName]]
                    
                        if {$psigid ne {}} {
                            set asigid [pipe {
                                findRelated $stateref R78 |
                                readAttribute ~ ASigID
                            }]
                            StateTransition update [pipe {
                                findRelatedWhere $stateref ~R72 {$ASigID eq {}} |
                                deRef % ASigID |
                                relation update % sttuple {1} {
                                    tuple update $sttuple ASigID $asigid
                                }
                            } {} |%]
                            Event update [pipe {
                                findRelatedWhere $stateref {~R72 R71 R70 R80} {$PSigID eq {}} |
                                deRef % PSigID |
                                relation update % utup {1} {
                                    tuple update $utup PSigID $psigid
                                }
                            } {} |%]
                        }
                    
                        return
                    }
                    proc event {name args} {
                        namespace upvar ::micca::@Config@::DomainDef DomainName DomainName
                        namespace upvar ::micca::@Config@::DomainDef::ClassDef ClassName ClassName
                    
                        set psigid [expr {[llength $args] != 0 ?\
                                [FindParameterSignature $args] : {}}]
                    
                        set eventtuple [list\
                            Domain  $DomainName\
                            Model   $ClassName\
                            Event   $name\
                        ]
                        set evtref [Event findById {*}$eventtuple]
                        if {[isEmptyRef $evtref]} {
                            set evtref [Event create {*}$eventtuple PSigID $psigid Number -1]
                            TransitioningEvent create {*}$eventtuple
                            LocalEvent create {*}$eventtuple
                        } else {
                            updateAttribute $evtref PSigID $psigid
                        }
                    
                        if {$psigid ne {}} {
                            set asigid [pipe {
                                findRelated $evtref R69 |
                                readAttribute ~ ASigID
                            }] ; # <1>
                            StateTransition update [pipe {
                                findRelatedWhere $evtref\
                                    {{~R80 TransitioningEvent} {~R70 TransitionPlace}\
                                    {~R71 StateTransition}} {$ASigID eq {}} |
                                deRef % ASigID |
                                relation update % sttuple {1} {
                                    tuple update $sttuple ASigID $asigid
                                }
                            } {} |%] ; # <2>
                        }
                    }
                    proc transition {source - event -> target} {
                        if {$event eq {}} {
                            tailcall DeclError BAD_NAME [list $event] event
                        }
                        if {[isNotEmptyRef [TransitionRule findById Name $source]]} {# <1>
                            tailcall DeclError BAD_STATE_NAME $name
                        }
                        namespace upvar ::micca::@Config@::DomainDef DomainName DomainName
                        namespace upvar ::micca::@Config@::DomainDef::ClassDef ClassName ClassName
                    
                        if {$source eq "@"} {
                            if {[isNotEmptyRef [TransitionRule findById Name $target]]} {
                                tailcall DeclError BAD_CREATION_TARGET $target
                            }
                            set cstuple [list\
                                Domain          $DomainName\
                                Model           $ClassName\
                                Name            @\
                            ]
                            # We have to conditionally create the CreationState instance since we
                            # can have multiple transition commands that use @ as the source state.
                            if {[isEmptyRef [CreationState findById {*}$cstuple]]} {
                                CreationState create {*}$cstuple
                            }
                            if {[isEmptyRef [StatePlace findById {*}$cstuple]]} {
                                StatePlace create {*}$cstuple\
                                    Number [GenNumber $DomainName StatePlace\
                                            [list $DomainName $ClassName]]
                            }
                        }
                    
                        set transtuple [list\
                            Domain  $DomainName\
                            Model   $ClassName\
                            State   $source\
                            Event   $event\
                        ]
                        CheckDuplicate TransitionPlace transition {*}$transtuple
                        TransitionPlace create {*}$transtuple
                    
                        set eventtuple [list\
                            Domain  $DomainName\
                            Model   $ClassName\
                            Event   $event\
                        ]
                        set eventref [Event findById {*}$eventtuple]
                        if {[isEmptyRef $eventref]} {
                            set stateref [State findWhere {$Domain eq $DomainName &&\
                                $Model eq $ClassName && $Name eq $target}]
                            set psigid [expr {[isNotEmptyRef $stateref] ?\
                                    [readAttribute $stateref PSigID] : {}}]
                            Event create {*}$eventtuple PSigID $psigid Number -1
                            TransitioningEvent create {*}$eventtuple
                            LocalEvent create {*}$eventtuple
                        }
                    
                        set trref [TransitionRule findById Name $target]
                        if {[isNotEmptyRef $trref]} {
                            NonStateTransition create {*}$transtuple TransRule $target
                        } else {
                            # Create the state transition instance. If the state or event has
                            # already been created, then use the argument signature from them, else
                            # just leave it empty. Note we only look for states or events that
                            # a non-empty parameter signature.
                            
                            set asigid {}
                            set stateref [State findWhere {$Domain eq $DomainName &&\
                                $Model eq $ClassName && $Name eq $target && $PSigID ne {}}]
                            if {[isNotEmptyRef $stateref]} {
                                set asigid [pipe {
                                    findRelated $stateref R78 |
                                    readAttribute ~ ASigID
                                }]
                            } else {
                                set eventref [Event findWhere {$Domain eq $DomainName &&\
                                    $Model eq $ClassName && $Event eq $event && $PSigID ne {}}]
                                if {[isNotEmptyRef $eventref]} {
                                    set asigid [pipe {
                                        findRelated $eventref R69 |
                                        readAttribute ~ ASigID
                                    }]
                                }
                            }
                    
                            set stref [StateTransition create {*}$transtuple\
                                    NewState $target ASigID $asigid]
                        }
                    
                        return
                    }
                    proc initialstate {name} {
                        if {$name eq {}} {
                            tailcall DeclError BAD_NAME [list $name] initialstate
                        }
                        # The initial state may not be the pseudo-initial state name
                        # nor any of the other transition rule pseudo states (i.e. IG or CH).
                        if {$name eq "@" || [isNotEmptyRef [TransitionRule findById Name $name]]} {
                            tailcall DeclError BAD_STATE_NAME $name
                        }
                        variable InitialState $name
                        return
                    }
                    proc defaulttrans {name} {
                        if {[isEmptyRef [TransitionRule findById Name $name]]} {
                            tailcall DeclError EXPECTED_NONTRANS_STATE $name
                        }
                        variable DefaultTrans $name
                        return
                    }
                    proc final {args} {
                        variable Finals
                        if {"@" in $args} {
                            tailcall DeclError BAD_STATE_NAME @
                        }
                        struct::set add Finals $args
                        return
                    }
                }
            }
            namespace eval AssignerDef {
                ::logger::import -all -force -namespace log micca
            
                namespace import\
                    ::ral::relation\
                    ::ral::tuple\
                    ::ral::relformat\
                    ::ralutil::pipe
                namespace import ::micca::@Config@::ConfigEvaluate
                namespace path {::micca ::micca::@Config@::Helpers ::rosea::InstCmds}
            
                proc statemodel {body} {
                    namespace upvar ::micca::@Config@::DomainDef DomainName DomainName
                    namespace upvar ::micca::@Config@::DomainDef::ClassDef ClassName AssocName
                
                    namespace upvar ::micca::@Config@::DomainDef::ClassDef::StateModelDef\
                        InitialState InitialState\
                        DefaultTrans DefaultTrans\
                        Finals Finals
                
                    set InitialState {}
                    set DefaultTrans {}
                    set Finals [list]
                
                    ConfigEvaluate ::micca::@Config@::DomainDef::ClassDef::StateModelDef $body ; # <1>
                
                    if {$DefaultTrans eq {}} {
                        set DefaultTrans CH
                    }
                    CheckDuplicate StateModel {assigner state model}\
                            Domain $DomainName Model $AssocName
                    StateModel create\
                        Domain          $DomainName\
                        Model           $AssocName\
                        InitialState    $InitialState\
                        DefaultTrans    $DefaultTrans
                
                    set assoctuple [list\
                        Domain          $DomainName\
                        Association     $AssocName
                    ]
                    AssignerStateModel create {*}$assoctuple
                
                    foreach final $Finals {
                        set sref [State findWhere Domain $DomainName Model $ClassName\
                                Name $final]
                        updateAttribute $sref IsFinal true
                    }
                }
                proc identifyby {class} {
                    variable IdClassName $class
                }
            }
            namespace eval EEntityDef {
                ::logger::import -all -force -namespace log micca
            
                namespace import\
                    ::ral::relation\
                    ::ral::tuple\
                    ::ral::relformat\
                    ::ralutil::pipe
                namespace path {::micca ::micca::@Config@::Helpers ::rosea::InstCmds}
            
                proc operation {rettype name parameters {body {}} {comment {}}} {
                    variable EntityName
                    upvar #0\
                            [namespace parent]::DomainName DomainName\
                            ::micca::@Config@::configfile configfile\
                            ::micca::@Config@::configlineno configlineno
                
                    CheckDuplicate ExternalOperation {external operation}\
                            Domain $DomainName Entity $EntityName Name $name
                    ExternalOperation create\
                        Domain $DomainName\
                        Entity $EntityName\
                        Name $name\
                        Body $body\
                        ReturnDataType $rettype\
                        Comment [string trim $comment]\
                        File $configfile\
                        Line $configlineno
                
                    set paramtuple [dict create Domain $DomainName Entity $EntityName\
                            Operation $name]
                    dict for {paramname paramtype} $parameters {
                        dict set paramtuple Name $paramname
                        dict set paramtuple DataType $paramtype
                        dict set paramtuple Number\
                                [GenNumber $DomainName ExternalOperationParameter\
                                [list $DomainName $name]]
                        ExternalOperationParameter create {*}$paramtuple
                    }
                
                    return
                }
            }
        }
        namespace eval PopDef {
            ::logger::import -all -force -namespace log micca
        
            namespace import\
                ::ral::relation\
                ::ral::tuple\
                ::ral::relformat\
                ::ralutil::pipe
            namespace import ::micca::@Config@::ConfigEvaluate
            namespace path {::micca ::micca::@Config@::Helpers ::rosea::InstCmds}
        
            proc class {name script} {
                if {$name eq {}} {
                    tailcall DeclError BAD_NAME $name class
                }
            
                variable DomainName
            
                namespace upvar ClassInstDef ClassName ClassName Allocation Allocation
                set ClassName $name
                set Allocation 0
            
                CheckExists Class class Domain $DomainName Name $ClassName
            
                ConfigEvaluate [namespace current]::ClassInstDef $script
            
                set epRef [ElementPopulation findById Domain $DomainName Element $name]
                if {[isEmptyRef $epRef]} {
                    ElementPopulation create Domain $DomainName Element $name
                }
            
                set cpRef [ClassPopulation findById Domain $DomainName Class $name]
                if {[isEmptyRef $cpRef]} {
                    ClassPopulation create Domain $DomainName Class $name\
                            Allocation $Allocation
                } else {
                    assignAttribute $cpRef {Allocation prevAllocation}
                    updateAttribute $cpRef Allocation\
                            [expr {max($Allocation, $prevAllocation)}]
                }
            
                return
            }
            proc assigner {assoc script} {
                variable DomainName
            
                set maref [MultipleAssigner findById Domain $DomainName Association $assoc]
                if {[isEmptyRef $maref]} {# <1>
                    tailcall DeclError UNKNOWN_MULT_ASSIGNER $assoc
                }
            
                namespace upvar AssignerInstDef AssocName AssocName IdClass IdClass
                set AssocName $assoc
                set IdClass [readAttribute $maref Class]
            
                CheckExists AssignerStateModel assigner Domain $DomainName\
                        Association $AssocName
            
                ConfigEvaluate [namespace current]::AssignerInstDef $script
            
                if {[isEmptyRef [ElementPopulation findById Domain $DomainName\
                        Element $assoc]]} {
                    ElementPopulation create Domain $DomainName Element $assoc
                    AssignerPopulation create Domain $DomainName Association $assoc
                }
            
                return
            }
        
            namespace eval ClassInstDef {
                ::logger::import -all -force -namespace log micca
            
                namespace import\
                    ::ral::relation\
                    ::ral::tuple\
                    ::ral::relformat\
                    ::ralutil::pipe
                namespace import ::micca::@Config@::ConfigEvaluate
                namespace path {::micca ::micca::@Config@::Helpers ::rosea::InstCmds}
            
                proc allocate {{size 0}} {
                    if {![string is integer -strict $size]} {
                        tailcall DeclError EXPECTED_INT size $size
                    }
                    if {$size < 0} {
                        tailcall DeclError EXPECTED_NONNEG size $size
                    }
                
                    variable Allocation $size
                
                    return
                }
                proc instance {name args} {
                    if {[llength $args] % 2 != 0} {
                        tailcall DeclError ARG_FORMAT $args
                    }
                
                    upvar #0 [namespace parent]::DomainName DomainName
                    variable ClassName
                
                    CheckPopAttrs $DomainName $ClassName [dict keys $args]
                
                    set insttuple [list\
                        Domain $DomainName\
                        Class $ClassName\
                        Instance $name\
                    ]
                    CheckDuplicate ClassInstance {class instance} {*}$insttuple
                    ClassInstance create {*}$insttuple\
                        Number [GenNumber $DomainName ClassInstance [list $DomainName $ClassName]]
                
                    CreateRequiredValues $DomainName $ClassName $name $args
                    CreateDefaultedValues $DomainName $ClassName $name $args
                    CreateZeroInitValues $DomainName $ClassName $name $args
                
                    return
                }
                proc table {heading args} {
                    if {[llength $args] % 2 != 0} {
                        tailcall DeclError ARG_FORMAT $args
                    }
                
                    upvar #0 [namespace parent]::DomainName DomainName
                    variable ClassName
                
                    CheckPopAttrs $DomainName $ClassName $heading
                
                    set insttuple [list\
                        Domain $DomainName\
                        Class $ClassName\
                    ]
                
                    dict for {instname compvalues} $args {
                        if {[llength $heading] != [llength $compvalues]} {# <1>
                            tailcall DeclError COMPONENT_MISMATCH $DomainName $ClassName\
                                [llength $compvalues] [llength $heading]
                        }
                        dict set insttuple Instance $instname ; # <2>
                        CheckDuplicate ClassInstance {class instance} {*}$insttuple
                        ClassInstance create {*}$insttuple\
                            Number [GenNumber $DomainName ClassInstance\
                            [list $DomainName $ClassName]]
                
                        set namedValues [dict create] ; # <3>
                        foreach h $heading v $compvalues {
                            dict set namedValues $h $v
                        }
                
                        CreateRequiredValues $DomainName $ClassName $instname $namedValues
                        CreateDefaultedValues $DomainName $ClassName $instname $namedValues
                        CreateZeroInitValues $DomainName $ClassName $instname $namedValues
                    }
                
                    return
                }
            }
            namespace eval AssignerInstDef {
                ::logger::import -all -force -namespace log micca
            
                namespace import\
                    ::ral::relation\
                    ::ral::tuple\
                    ::ral::relformat\
                    ::ralutil::pipe
                namespace import ::micca::@Config@::ConfigEvaluate
                namespace path {::micca ::micca::@Config@::Helpers ::rosea::InstCmds}
            
                proc instance {name idinstance} {
                
                    upvar #0 [namespace parent]::DomainName DomainName
                    variable AssocName
                    variable IdClass
                
                    CheckDuplicate MultipleAssignerInstance {assigner instance}\
                            Domain $DomainName Association $AssocName Instance $name
                    MultipleAssignerInstance create\
                        Domain $DomainName\
                        Association $AssocName\
                        Instance $name\
                        Number [GenNumber $DomainName MultipleAssignerInstance\
                            [list $DomainName $AssocName]]\
                        IdClass $IdClass\
                        IdInstance $idinstance
                
                    return
                }
            }
        }
    }
    namespace eval @Gen@ {
        ::logger::import -all -force -namespace log micca
    
        namespace import\
            ::ral::relation\
            ::ral::tuple\
            ::ral::relformat\
            ::ralutil::pipe
    
        namespace eval Helpers {
            ::logger::import -all -force -namespace log micca
        
            namespace import\
                ::ral::relation\
                ::ral::tuple\
                ::ral::relformat\
                ::ralutil::pipe
        
            namespace path {
                ::micca
                ::rosea::InstCmds
            }
            namespace import ::micca::@Config@::Helpers::typeCheck
        
            proc GatherClassProperties {domain} {
                set assigners [pipe {
                    AssignerStateModel findWhere {$Domain eq $domain} |
                    deRef ~ |
                    ralutil::rvajoin ~ $::micca::SingleAssigner Single |
                    ralutil::rvajoin ~ $::micca::MultipleAssigner Multiple |
                    relation tag ~ Number -ascending Association |
                    relation extend ~ stup\
                        Declaration string {"struct [tuple extract $stup Association]"}\
                        Reference string {"struct [tuple extract $stup Association] *"}\
                        ConstReference string\
                                {"struct [tuple extract $stup Association] const *"}\
                        StorageVariable string {"[tuple extract $stup Association]__POOL"}\
                        ClassVariable string {"${domain}__ASSIGNERS"}
                }]
                set sassigners [pipe {
                    relation restrictwith $assigners {[relation isnotempty $Single]} |
                    relation eliminate ~ Domain Single Multiple |
                    relation rename ~ Association Name |
                    relation extend ~ stup\
                        Allocation int {0}\
                        InitialInstance int {1}\
                        TotalInstance int {1}
                }]
                # puts [relformat $sassigners sassigners]
                # First we need the total instances for the paritioning class.
                
                set partClassPop [pipe {
                    MultipleAssigner findWhere {$Domain eq $domain} |
                    findRelated % R54 R104 {~R101 ElementPopulation} {~R105 ClassPopulation} |
                    deRef % |
                    ralutil::rvajoin % $::micca::ClassInstance Instances |
                    relation extend %  itup TotalInstance int {
                            [tuple extract $itup Allocation] +\
                                [relation cardinality [tuple extract $itup Instances]]} |
                    relation eliminate % Instances Allocation
                } {} |%]
                # puts [relformat $partClassPop partClassPop]
                
                # Then we can find the number of intial instances of the multiple assigner
                # and deduce what the "implied" allocation for non-initial instances
                # would have been.
                set massigners [pipe {
                    relation restrictwith $assigners {[relation isnotempty $Multiple]} |
                    relation rename ~ Number AssignerNumber |
                    ralutil::rvajoin ~ $::micca::MultipleAssignerInstance Instances |
                    relation ungroup ~ Multiple |
                    relation join ~ $partClassPop |
                    relation extend ~ stup\
                        InitialInstance int\
                            {[relation cardinality [tuple extract $stup Instances]]} |
                    relation extend ~ atup\
                        Allocation int {[tuple extract $atup TotalInstance] -\
                            [tuple extract $atup InitialInstance]} |
                    relation eliminate ~ Domain Single Class Instances |
                    relation rename ~ Association Name AssignerNumber Number
                }]
                # puts [relformat $massigners massigners]
                set classRefs [FindNonUnionSubclasses $domain]
                set cpopRefs [findRelated $classRefs R104 {~R101 ElementPopulation}\
                        {~R105 ClassPopulation}]
                
                set allocs [pipe {
                    deRef $cpopRefs |
                    relation project % Class Allocation |
                    relation rename % Class Name
                } {} |%]
                
                set insts [pipe {
                    findRelated $cpopRefs ~R102 |
                    deRef % |
                    relation project % Class Number |
                    relation rename % Class Name
                } {} |%]
                
                set classes [pipe {
                    deRef $classRefs |
                    relation project ~ Name Number |
                    relation rename ~ Number ClassNumber |
                    relation extend ~ stup\
                        Declaration string {"struct [tuple extract $stup Name]"}\
                        Reference string {"struct [tuple extract $stup Name] *"}\
                        ConstReference string {"struct [tuple extract $stup Name] const *"}\
                        StorageVariable string {"[tuple extract $stup Name]__POOL"}\
                        ClassVariable string {"${domain}__CLASSES"} |
                    relation join ~ $allocs |
                    ralutil::rvajoin ~ $insts Instances |
                    relation extend ~ itup\
                        InitialInstance int {
                            [relation cardinality [tuple extract $itup Instances]]} \
                        TotalInstance int {
                            [relation cardinality [tuple extract $itup Instances]] +
                            [tuple extract $itup Allocation]} |
                    relation eliminate ~ Instances |
                    relation rename ~ ClassNumber Number
                }]
                # puts [relformat $classes classes]
                set usubRefs [UnionSubclass findWhere {$Domain eq $domain}]
                set usubs [pipe {
                    deRef $usubRefs |
                    relation eliminate ~ Domain Role
                }]
                # puts [relformat $usubs "Union Subclasses"]
                set usupers [pipe {
                    UnionSuperclass findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation eliminate ~ Domain Role |
                    relation rename ~ Class Superclass
                }]
                # puts [relformat $usupers "Union Superclasses"]
                set ultimate_supers [pipe {
                    relation semiminus $usubs $usupers -using {Class Superclass} |
                    relation join ~ $classes -using {Superclass Name} |
                    relation project ~ Superclass TotalInstance
                }]
                # puts [relformat $ultimate_supers "Ultimate Union Superclasses"]
                
                # We need this to join back on the class number after the transitive closure
                set domclasses [pipe {
                    Class findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation eliminate ~ Domain
                }]
                
                set subinsts [pipe {
                    findRelated $usubRefs R47 R40 R41 R104 {~R101 ElementPopulation}\
                        {~R105 ClassPopulation} ~R102 |
                    deRef % |
                    relation project % Class Number |
                    relation rename % Class Name
                } {} |%]
                # puts [relformat $subinsts "Union Subclass instances"]
                
                set subclasses [pipe {
                    relation join $usubs $usupers\
                            -using {Relationship Relationship} |
                    relation project ~ Class Superclass |
                    relation tclose ~ |
                    relation join ~ $ultimate_supers |
                    relation eliminate ~ Superclass |
                    relation join $domclasses ~ -using {Name Class} |
                    relation extend ~ stup\
                        Declaration string {"struct [tuple extract $stup Name]"}\
                        Reference string {"struct [tuple extract $stup Name] *"}\
                        ConstReference string {"struct [tuple extract $stup Name] const *"}\
                        StorageVariable string {""}\
                        ClassVariable string {"${domain}__CLASSES"} |
                    relation rename ~ Number ClassNumber |
                    ralutil::rvajoin ~ $subinsts Instances |
                    relation extend ~ itup\
                        Allocation int {"0"}\
                        InitialInstance int {
                            [relation cardinality [tuple extract $itup Instances]]} |
                    relation eliminate ~ Instances |
                    relation rename ~ ClassNumber Number
                }]
                # puts [relformat $subclasses "Union Subclass"]
                variable ClassProperties
                
                set ClassProperties [relation union $classes $subclasses\
                        $sassigners $massigners]
                # puts [relformat $ClassProperties ClassProperties]
            
                return
            }
            proc GetClassProperty {class prop} {
                variable ClassProperties
                set cprop [relation restrictwith $ClassProperties {$Name eq $class}]
                if {[relation isnotempty $cprop]} {
                    return [relation extract $cprop $prop]
                }
            
                error "unknown property, \"$prop\", for class, \"$class\""
            }
            proc GetClassDescriptor {domain className} {
                return [string cat\
                    [GetClassProperty $className ClassVariable]\
                    \[ [GetClassProperty $className Number] \]
            
                ]
            }
            proc FindInterfaceTypeAliases {domain} {
                set domRef [Domain findWhere {$Name eq $domain}]
            
                set aliases [pipe {
                    findRelated $domRef ~R7 |
                    deRef %
                } {} |%]
                # puts [relformat $aliases aliases]
                set doRefs [pipe {
                    findRelated $domRef ~R5 |
                    deRef % |
                    relation semijoin % $aliases\
                            -using {Domain Domain ReturnDataType TypeName}
                } {} |%]
                # puts [relformat $doRefs doRefs]
                set dopRefs [pipe {
                    findRelated $domRef ~R5 ~R6 |
                    deRef % |
                    relation semijoin % $aliases\
                            -using {Domain Domain DataType TypeName}
                } {} |%]
                # puts [relformat $dopRefs dopRefs]
                set eops [findRelated $domRef ~R1 {~R2 ExternalEntity} ~R10]
                set eoRefs [relation semijoin [deRef $eops] $aliases\
                            -using {Domain Domain ReturnDataType TypeName}]
                # puts [relformat $eoRefs eoRefs]
                set eopRefs [pipe {
                    findRelated $eops ~R11 |
                    deRef % |
                    relation semijoin % $aliases\
                            -using {Domain Domain DataType TypeName}
                } {} |%]
                # puts [relformat $eopRefs eopRefs]
                set argRefs [pipe {
                    Argument findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation semijoin ~ $aliases\
                            -using {Domain Domain DataType TypeName}
                }]
                # puts [relformat $argRefs argRefs]
                return [relation union $doRefs $dopRefs $eoRefs $eopRefs $argRefs]
            }
            proc FindNonUnionSubclasses {domain} {
                set usubs [UnionSubclass findWhere {$Domain eq $domain}]
                return [pipe {
                    Class findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation semiminus [deRef $usubs] ~ -using {Domain Domain Class Name} |
                    ::rosea::Helpers::ToRef ::micca::Class ~
                }]
            }
            proc FindReferencedClass {compRef} {
                set destRef [findRelated $compRef {~R28 BackwardReference} ~R94]
            
                # backward, simple
                set refing [findRelated $destRef {~R38 SimpleReferencedClass} R33 ~R32]
                if {[isNotEmptyRef $refing]} {
                    set refedClass [readAttribute $refing Class]
                } else {
                    # backward, target
                    set src [findRelated $destRef {~R38 TargetClass} R35 ~R42]
                    if {[isNotEmptyRef $src]} {
                        set refedClass [readAttribute $src Class]
                    } else {
                        # forward, source
                        set trg [findRelated $compRef {~R28 ForwardReference} ~R95 R34 ~R42]
                        if {[isNotEmptyRef $trg]} {
                            set refedClass [readAttribute $trg Class]
                        }
                    }
                }
                return $refedClass
            }
            proc DefineIABMembers {classRef isUnionSubclass} {
                assignAttribute $classRef {Name className}
            
                set linkRefs [findRelated $classRef ~R20 {~R25 GeneratedComponent}\
                    {~R24 ComplementaryReference} {~R26 LinkReference}]
                if {[isEmptyRef $linkRefs]} {
                    set linkOffsets NULL
                } else {
                    set linkOffsets ${className}__LINKS
                    set linkCount [refMultiplicity $linkRefs]
                    append result\
                        "static MRT_AttrOffset const $linkOffsets\[$linkCount\] = \{\n"
                    set linkMembers [relation list [deRef $linkRefs] Name]
                    foreach linkMember $linkMembers {
                        append result\
                            "    "\
                            "offsetof\([GetClassProperty $className Declaration],\
                            $linkMember\),\n"
                    }
                    append result "\} ;\n"
                }
            
                append result\
                    "static MRT_iab ${className}__IAB = \{\n"
            
                if {$isUnionSubclass} {
                    append result\
                        "    .storageStart = NULL,\n"\
                        "    .storageFinish = NULL,\n"\
                        "    .storageLast = NULL,\n"
                } else {
                    set nelements [GetClassProperty $className TotalInstance]
                    append result\
                        "    .storageStart = &${className}__POOL\[0\],\n"\
                        "    .storageFinish = &${className}__POOL\[$nelements\],\n"\
                        "    .storageLast = &${className}__POOL\[[expr {$nelements - 1}]\],\n"
                }
                set ctor [pipe {
                    findRelated $classRef ~R8 |
                    expr {[isEmptyRef %] ? "NULL" : "[readAttribute % Class]__CTOR"}
                } {} |%]
                set dtor [pipe {
                    findRelated $classRef ~R9 |
                    expr {[isEmptyRef %] ? "NULL" : "[readAttribute % Class]__DTOR"}
                } {} |%]
                append result\
                    "    .alloc = [GetClassProperty $className InitialInstance],\n"\
                    "    .instanceSize = sizeof\([GetClassProperty $className Declaration]\),\n"\
                    "    .construct = $ctor,\n"\
                    "    .destruct = $dtor,\n"\
                    "    .linkCount = [refMultiplicity $linkRefs],\n"\
                    "    .linkOffsets = $linkOffsets\n"\
                    "\} ;\n"
            
                return $result
            }
            proc FindRelOffsets {complRef} {
                set typeRef [findRelated $complRef {~R26 SingularReference}]
                set offset 0
                if {[isNotEmptyRef $typeRef]} {
                    set type mrtSingular
                } else {
                    set typeRef [findRelated $complRef {~R26 ArrayReference}]
                    if {[isNotEmptyRef $typeRef]} {
                        set type mrtArray
                    } else {
                        set typeRef [findRelated $complRef {~R26 LinkReference}]
                        set type mrtLinkedList
                        assignAttribute [findRelated $typeRef ~R27]\
                            {Class lClass} {Name lcomp}
                        set offset "offsetof([GetClassProperty $lClass Declaration], $lcomp)"
                    }
                }
                return [list $type $offset]
            }
            proc FindParamsFromSig {psigRef} {
                return [pipe {
                    findRelated $psigRef ~R79 |
                    deRef % |
                    relation join % $::micca::Argument |
                    relation extend % ptup Declaration string {\
                        [typeCheck composeDeclaration\
                            [tuple extract $ptup DataType]\
                            [tuple extract $ptup Name]]}
                } {} |%]
            }
            proc GenValueAssignment {domain dest src datatype} {
                set asgnType [typeCheck assignmentType [UnaliasType $domain $datatype]]
                switch -exact -- [dict get $asgnType type] {
                    scalar {
                        append result "$dest = $src ;\n"
                    }
                    string {
                        set dimension [dict get $asgnType dimension]
                        set maxchars [expr {$dimension - 1}]
                        append result\
                            "strncpy($dest, $src, $maxchars) ;\n"\
                            "$dest\[$maxchars\] = '\\0' ;\n"
                    }
                    array {
                        append result "memcpy($dest, $src, sizeof($dest)) ;\n"
                    }
                    default {
                        error "unknown assignment type, \"[dict get $asgnType type]\""
                    }
                }
                return $result
            }
            
            proc GenParamAssignment {domain param} {
                relation assign $param Name Declaration DataType
            
                set asgnType [typeCheck assignmentType [UnaliasType $domain $DataType]]
                switch -exact -- [dict get $asgnType type] {
                    scalar {
                        set result [string cat\
                            "$Declaration ;\n"\
                            "$Name = pp__PARAMS->$Name ;\n"\
                        ]
                    }
                    string -
                    array {
                        set result "[dict get $asgnType base] const *const $Name =\
                                pp__PARAMS->$Name ;\n"
                    }
                    default {
                        error "unknown assignment type, \"[dict get $asgnType type]\""
                    }
                }
                return $result
            }
            proc UnaliasType {domain typename} {
                set aliasRef [TypeAlias findById Domain $domain TypeName $typename]
                return [expr {[isEmptyRef $aliasRef] ? $typename :\
                    [readAttribute $aliasRef TypeDefinition]}]
            }
            proc banner {} {
                set marker [string repeat - 70]
                string cat\
                    "/*\n"\
                    " * $marker\n"\
                    " * THIS FILE IS AUTOMATICALLY GENERATED. DO NOT EDIT.\n"\
                    " * Created by: $::argv0 $::argv\n"\
                    " * Created on: [clock format [clock seconds]]\n"\
                    " * This is micca version $::micca::version\n"\
                    " * $marker\n"\
                    " */\n"
            }
            proc comment {args} {
                set result "/*\n"
                foreach c $args {
                    append result [::textutil::adjust::indent\
                        [::textutil::adjust::adjust $c] { * }]\n
                }
                append result " */\n"
            
                return $result
            }
            proc linecomment {text} {
                set result {}
                foreach line [split $text \n] {
                    append result "// $line\n"
                }
                return $result
            }
            proc blockcomment {block} {
                return [textutil::adjust::indent [textutil::adjust::undent\
                        [string trim $block \n]] {// }]\n
            }
            proc linedirective {line file} {
                upvar #0 ::micca::@Gen@::options options
                set result {}
                if {[dict get $options lines]} {
                    append result "#line [expr {$line + 1}]"
                    if {$file ne {}} {
                        append result " \"$file\""
                    }
                    append result "\n"
                }
                return $result
            }
            proc indentCode {code {indent 4}} {
                return [textutil::adjust::indent [textutil::adjust::undent $code]\
                        [string repeat { } $indent]]\n
            }
            proc GenInstanceAddress {domainName className instName} {
                set path {}
                set usubRef [UnionSubclass findWhere {$Domain eq $domainName &&\
                    $Class eq $className}]
                if {[isNotEmptyRef $usubRef]} {
                    # puts [relformat [deRef $usubRef] usubRef]
                    while {[isNotEmptyRef $usubRef]} {
                        assignAttribute $usubRef {Relationship rship} {Class subName}
                        set path .$rship.${subName}$path
            
                        set usuperRef [findRelated $usubRef R45 ~R44]
                        set superClass [readAttribute $usuperRef Class]
            
                        set usubRef [pipe {
                            deRef $usuperRef |
                            relation semijoin ~ $::micca::UnionSubclass\
                                -using {Domain Domain Class Class} |
                            ::rosea::Helpers::ToRef ::micca::UnionSubclass ~
                        }]
                        # puts [relformat [deRef $usubRef] usubRef]
                    }
            
                    # puts "path = \"$path\""
                    set storageClass $superClass
                } else {
                    set storageClass $className
                }
                set instNumber [readAttribute\
                        [ClassInstance findById Domain $domainName Class $className\
                            Instance $instName]\
                    Number]
                return &${storageClass}__POOL\[$instNumber\]$path
            }
        }
        namespace eval GenSupport {
            ::logger::import -all -force -namespace log micca
        
            namespace import\
                ::ral::relation\
                ::ral::tuple\
                ::ral::relformat\
                ::ralutil::pipe
            namespace import ::ral::relvar
        
            namespace export ExpandActivity
        
            namespace path {
                ::micca
                ::micca::@Gen@::Helpers
                ::micca::@Config@::Helpers
                ::rosea::InstCmds
            }
            upvar #0 ::micca::@Gen@::errcount errcount
        
            textutil::expander actexpand
            actexpand setbrackets <% %> ; # <1>
            actexpand evalcmd "namespace eval [namespace parent]::GenActivity"
            actexpand errmode fail
            actexpand textcmd [namespace current]::ProcessCodeLines
        
            relvar create Symbol {
                Name string
                Ctype string
                Type string
                Class string
                Block int
            } Name
            variable symcounter 0
            variable labelcounter 0
            proc LookUpSymbol {name} {
                set sym [relvar restrictone Symbol Name $name]
                if {[relation isnotempty $sym]} {
                    return [tuple get [relation tuple $sym]]
                }
            
                return
            }
            proc DeleteSymbol {name} {
                relvar deleteone Symbol Name $name
            }
            proc InsertSymbol {args} {
                variable block
                dict set args Block $block
                try {
                    set sym [relvar insert Symbol $args]
                    return [tuple get [relation tuple $sym]]
                } trap {RAL relvar insert DUPLICATE_TUPLE*} {result} {
                    error "duplicate symbol, [dict get $args Name], $result" ; # <1>
                } on error {result opts} {
                    return -options $opts $result
                }
            }
            proc CheckSymbol {name args} {
                set sym [LookUpSymbol $name]
                if {[dict size $sym] == 0} {
                    error "unknown symbol, $name"
                }
                if {[llength $args] != 0} {
                    CheckSymProperties $sym {*}$args
                }
                return $sym
            }
            proc CheckSymProperties {sym args} {
                foreach {prop value} $args {
                    # If the value of the property is the empty string, then we will assume
                    # the value that is checked first. This lets us pass parameters where
                    # we don't quite know the data type needs.
                    if {[dict get $sym $prop] eq {}} {
                        dict set sym $prop $value
                        relvar update Symbol stup {
                                [tuple extract $stup Name] eq [dict get $sym Name] &&\
                                [tuple extract $stup $prop] eq {}
                            } {
                                tuple update $stup $prop $value
                            }
                    }
                    if {[dict get $sym $prop] ne $value} {
                        error "for variable, [dict get $sym Name], expected $prop to be,\
                                $value: got, [dict get $sym $prop], instead"
                    }
                }
                return
            }
            proc CheckInstRefSymbol {varName args} {
                tailcall CheckSymbol $varName Type Reference {*}$args
            }
            proc CheckInstSetSymbol {varName args} {
                tailcall CheckSymbol $varName Type InstanceSet {*}$args
            }
            proc CreateTempSymbolName {} {
                variable symcounter
                return t__T[incr symcounter]
            }
            
            proc CreateTempSymbol {args} {
                set name [CreateTempSymbolName]
                InsertSymbol Name $name {*}$args
                return $name
            }
            
            proc CreateLabelName {} {
                variable labelcounter
                return l__L[incr labelcounter]
            }
            proc CreateTempRefSymbol {className} {
                set reftype [GetClassProperty $className Reference]
                set symName [CreateTempSymbol Ctype $reftype Type Reference Class $className]
                return [list $reftype $symName]
            }
            proc CreateInstRefSymbol {className varName} {
                set sym [LookUpSymbol $varName]
                if {$sym ne {}} {
                    CheckSymProperties $sym Class $className Type Reference
                    return
                }
                set creftype [GetClassProperty $className Reference]
                InsertSymbol Name $varName Ctype $creftype Type Reference Class $className
                return "$creftype$varName ;\n"
            }
            proc CreateInstSetSymbol {className varName} {
                set sym [LookUpSymbol $varName]
                if {$sym ne {}} {
                    CheckSymProperties $sym Class $className Type InstanceSet
                    return
                }
                set ctype MRT_InstSet
                InsertSymbol Name $varName Ctype $ctype Type InstanceSet Class $className
                return "$ctype $varName ;\n"
            }
            proc PushBlock {{by 1}} {
                variable block
                incr block $by
            }
            proc GetBlock {} {
                variable block
                return $block
            }
            proc PopBlock {{by -1}} {
                variable block
                relvar delete Symbol stup {[tuple extract $stup Block] == $block}
                incr block $by
            }
            proc ProcessCodeLines {text} {
                variable block
            
                # puts "text = \"$text\""
                set newlines [list]
            
                foreach line [split $text \n] {
                    if {[string is space $line]} {
                        if {[llength $newlines] != 0 && [lindex $newlines end] ne {}} {
                            lappend newlines {}
                        }
                    } else {
                        if {[string first \} $line] != -1} {
                            incr block -1
                        }
                        if {[regsub -- {\A\s{4,}} $line {} newline] != 0} {
                            set line [string repeat { } [expr {$block * 4}]]$newline
                        }
                        lappend newlines $line
                        if {[string first \{ $line] != -1} {
                            incr block
                        }
                    }
                }
                set newtext [join $newlines \n]
                # puts "newtext = \"$newtext\""
            
                return $newtext
            }
            proc IndentToBlock {code} {
                variable block
                # indent seems to swallow a trailing new line
                return [::textutil::adjust::indent $code\
                    [string repeat { } [expr {$block * 4}]]]\n
            }
            proc PushContext {context startblock} {
                actexpand cpush $context
            
                variable block
                actexpand cset depth [expr {$block - $startblock}]
                return
            }
            proc End {} {
                set result {}
            
                set context [actexpand cname] ; # <1>
                switch -exact -- $context {
                    InstanceSetForeachInstance -
                    InstanceForeachRelated -
                    InstanceForeachRelatedWhere -
                    ClassForeachInstance -
                    ClassForeachWhere {
                        set result [CloseBlocks]
                    }
                    GenClassify {
                        set subclasses [actexpand cget subclasses]
                        set foundsubs [actexpand cget foundsubs]
                        set gotdefault [actexpand cget gotdefault]
            
                        set unused [::struct::set difference $subclasses $foundsubs]
                        if {!([::struct::set empty $unused] || $gotdefault)} {
                            set relname [actexpand cget relname]
                            log::warn "subclass(es), \"[join $unused {, }]\", were\
                                not present in the \"$relname classify\" statement\
                                and no default case was given"
                        }
            
                        set result [CloseBlocks]
                    }
                    Subclass {
                        set result [CloseBlocks]
                        append result [IndentToBlock "break ;\n"]
                    }
                    default {
                        error "unknown context, \"$context\""
                    }
                }
                append result [IndentToBlock [linecomment end]]
            
                return $result
            }
            proc CloseBlocks {} {
                set depth [actexpand cget depth]
                set result [actexpand cpop [actexpand cname]] ; # <2>
                for {set i 0} {$i < $depth} {incr i} {
                    PopBlock
                    append result [IndentToBlock "\}\n"]
                }
                return $result
            }
            proc ExpandActivity {name body parameters} {
                # parameters is a relation value with heading:
                # Name string Ctype string Type string Class string
            
                variable block 1
                try {
                    foreach param [relation body $parameters] {
                        InsertSymbol {*}$param
                    }
                    return [actexpand expand $body]
                } on error {result} {
                    # puts $::errorInfo
                    log::error "$name: $result"
                    variable errcount
                    incr errcount
                    set msg [pipe {
                        split $result \n |
                        lrange ~ 1 2 |
                        string map [list \" {}] ~ |
                        join ~
                    }] ; # <1>
                    return "#error \"$msg\"\n" ; <2>
                } finally {
                    relvar set Symbol [relation emptyof [relvar set Symbol]]
                    variable symcounter 0
                    variable labelcounter 0
                }
            }
            proc InvokeExternalOp {entity opName args} {
                if {[llength $args] % 2 != 0} {
                    error "operation parameters must be given as name / value pairs"
                }
                variable domain
            
                set opRef [ExternalOperation findWhere {$Domain eq $domain &&\
                        $Entity eq $entity && $Name eq $opName}]
                if {[isEmptyRef $opRef]} {
                    error "unknown external operation, $opName, for domain, $domain\
                            and external entity, $entity"
                }
            
                set provided [dict keys $args]
                set params [deRef [findRelated $opRef ~R11]]
                set required [relation list $params Name -ascending Number]
                CheckSuppliedParams $opName $provided $required
            
                set pset {}
                foreach pname $required {
                    append pset "[dict get $args $pname], "
                }
                set pset [string trimright $pset {, }]
            
                return "${domain}_${entity}_${opName}__EOP\($pset\)"
            }
            proc InstanceAttrRead {instref attr} {
                variable domain
            
                set sym [CheckInstRefSymbol $instref]
                set className [dict get $sym Class]
                set attrRef [Attribute findById Domain $domain Class $className Name $attr]
                if {[isNotEmptyRef $attrRef]} {
                    set depRef [findRelated $attrRef {~R29 DependentAttribute}]
                    if {[isNotEmptyRef $depRef]} {
                        error "cannot use \"attr\" command for dependent attribute:\
                            use \"assign\" command instead"
                    }
                    return "$instref->$attr" ; # <1>
                } else {
                    set massRef [MultipleAssigner findById Domain $domain\
                        Association $className]
                    if {[isNotEmptyRef $massRef] && $attr eq "idinstance"} {
                        return "$instref->$attr"
                    }
                    error "instance reference, $instref, refers to an instance of\
                        class, $className, which does not have an attribute\
                        named, $attr"
                }
            }
            proc InstanceAttrUpdate {instref args} {
                variable domain
            
                if {[llength $args] % 2 != 0} {
                    error "attribute name / values must be given in pairs, got:\
                        \"$args\""
                }
            
                set sym [CheckInstRefSymbol $instref]
                set className [dict get $sym Class]
            
                set result [linecomment "instance $instref update $args"]
                foreach {attr value} $args {
                    set attrRef [Attribute findById Domain $domain Class $className Name $attr]
                    if {[isEmptyRef $attrRef]} {
                        error "instance reference, $instref, refers to an instance of\
                            class, $className, which does not have an attribute\
                            named, $attr"
                    }
            
                    set depRef [findRelated $attrRef {~R29 DependentAttribute}] ; # <1>
                    if {[isNotEmptyRef $depRef]} {
                        error "cannot update dependent attribute"
                    }
            
                    append result [GenValueAssignment $domain $instref->$attr\
                            $value [readAttribute $attrRef DataType]]
                }
            
                return [IndentToBlock $result]
            }
            proc InstanceAssign {instref args} {
                variable domain
            
                set sym [CheckInstRefSymbol $instref]
                set className [dict get $sym Class]
            
                set attrProps [pipe {
                    Attribute findWhere {$Domain eq $domain && $Class eq $className} |
                    deRef ~ |
                    relation project ~ Name DataType
                }]
            
                set attrNames [relation list $attrProps Name]
                set attrTypes [relation dict $attrProps Name DataType]
            
                if {[llength $args] == 0} {
                    set attrspecs $attrNames
                } else {
                    foreach spec $args {
                        if {[lindex $spec 0] ni $attrNames} {
                            error "instance reference, $instref, refers to an instance of\
                                class, $className, which does not have an attribute\
                                named, [lindex $spec 0]"
                        }
                    }
                    set attrspecs $args
                }
            
                set result [linecomment "instance $instref assign [list $args]"]
                foreach attrspec $attrspecs {
                    if {[llength $attrspec] == 1} {
                        set attrname [lindex $attrspec 0]
                        set varname $attrname
                    } elseif {[llength $attrspec] == 2} {
                        lassign $attrspec attrname varname
                        if {![isIdentifier $varname]} {
                            error "\"$varname\" is not a valid \"C\" identifier"
                        }
                    } else {
                        error "bad attribute specification, \"$attrspec\":\
                            expected 1 or 2 element list"
                    }
                    set attrtype [dict get $attrTypes $attrname]
            
                    set varsym [LookUpSymbol $varname]
                    if {[dict size $varsym] != 0} {
                        CheckSymProperties $varsym Ctype $attrtype
                    } else {
                        InsertSymbol Name $varname Ctype $attrtype Type {} Class {}
                        append result "[typeCheck composeDeclaration $attrtype $varname] ;\n"
                    }
            
                    set indepRef [IndependentAttribute findById\
                            Domain $domain Class $className Name $attrname]
                    if {[isNotEmptyRef $indepRef]} {
                        append result [GenValueAssignment $domain $varname\
                                $instref->$attrname $attrtype]
                    } else {
                        set asgnType [typeCheck assignmentType\
                                [UnaliasType $domain $attrtype]]
                        set varref [expr {[dict get $asgnType type] ne "scalar" ?\
                                "$varname" : "&$varname"}]
                        append result\
                            "${className}_${attrname}__FORMULA($instref, $varref,\
                            sizeof($varname)) ;\n"
                    }
                }
            
                return [IndentToBlock $result]
            }
            proc InstanceDelete {instref} {
                CheckInstRefSymbol $instref
                return [IndentToBlock [string cat\
                    [linecomment "instance $instref delete"]\
                    "mrt_DeleteInstance($instref) ;\n"\
                ]]
            }
            proc InstanceOperation {instref opName args} {
                set instsym [CheckInstRefSymbol $instref]
                if {[llength $args] % 2 != 0} {
                    error "operation parameters must be given as name / value pairs"
                }
                variable domain
            
                set className [dict get $instsym Class]
                set opRef [Operation findWhere {$Domain eq $domain && $Class eq $className\
                    && $Name eq $opName && $IsInstance}]
                if {[isEmptyRef $opRef]} {
                    error "unknown instance operation, $opName, for class, $className"
                }
            
                dict set args self $instref ; # <1>
                set provided [dict keys $args]
                set params [deRef [findRelated $opRef ~R4]]
                set required [relation list $params Name -ascending Number] ; # <2>
                CheckSuppliedParams $opName $provided $required
            
                set pset {}
                foreach pname $required {
                    append pset "[dict get $args $pname], "
                }
                set pset [string trimright $pset {, }]
            
                return "${className}_$opName\($pset\)"
            }
            proc CheckSuppliedParams {name provided required} {
                if {![struct::set equal $provided $required]} {
                    lassign [struct::set intersect3 $provided $required]\
                        p_inter_r p_minus_r r_minus_p
                    if {![struct::set empty $p_minus_r]} {
                        error "provided parameter(s), \"[join $p_minus_r ,]\", which are\
                            not parameters to, $name"
                    }
                    if {![struct::set empty $r_minus_p]} {
                        error "parameter(s), \"[join $r_minus_p ,]\", are required for,\
                            $name, but were not provided"
                    }
                }
            }
            proc InstanceForeachRelated {startref instref args} {
                set startblock [GetBlock]
                set result [IndentToBlock\
                    [linecomment "instance $startref foreachRelated $instref $args"]\
                ]
            
                append result [TraverseRelChain $startref $instref $args]
            
                PushContext InstanceForeachRelated $startblock
            
                return $result
            }
            proc TraverseRelChain {startref endref relspecs} {
                variable domain
            
                if {[llength $relspecs] == 0} {
                    error "empty relationship chain specification"
                }
            
                set result {}
                set startsym [CheckInstRefSymbol $startref]
                set startClass [dict get $startsym Class]
            
                foreach relspec $relspecs {
                    set relinfo [LookUpRelationship $startClass $relspec]
                    while {[llength $relinfo] != 0} {
                        # puts "relinfo = \"$relinfo\""
                        set relinfo [lassign $relinfo sourceclass targetclass reftype cond\
                            comp]
                        switch -exact -- $reftype {
                            reference {
                                lassign [CreateTempRefSymbol $targetclass] targettype targetref
                                set refcode "$targettype$targetref = $startref->$comp ; // $relspec \n"
                                if {$cond} { # <1>
                                    append refcode "if ($targetref != NULL) \{\n"
                                    append result [IndentToBlock $refcode]
                                    PushBlock
                                } else {
                                    append result [IndentToBlock $refcode]
                                }
                            }
                            array {
                                set itervar [CreateTempSymbol\
                                    Ctype "struct $targetclass *const *"\
                                    Type "ReferenceArray" Class $targetclass]
                                set cntvar [CreateTempSymbol Ctype size_t\
                                    Type ArrayCounter Class $targetclass]
                                set refcode "struct $targetclass *const *$itervar =\
                                        $startref->$comp.links ; // $relspec\n"
                                append refcode\
                                    "for (size_t $cntvar = $startref->$comp.count ;\
                                        $cntvar != 0 ; $cntvar--, $itervar++) \{" ; # <1>
                                append result [IndentToBlock $refcode]
                                PushBlock
                                lassign [CreateTempRefSymbol $targetclass] targettype targetref
                                append result [IndentToBlock "$targettype$targetref = *$itervar ;"]
                            }
                            linked {
                                set itervar [CreateTempSymbol Ctype "MRT_LinkRef *"\
                                    Type "ReferenceLink" Class $targetclass]
                                lassign $comp termcomp linkcomp
                                append result [IndentToBlock\
                                    "for (MRT_LinkRef *$itervar =\
                                        mrtLinkRefBegin(&$startref->$termcomp) ;\
                                        $itervar != mrtLinkRefEnd(&$startref->$termcomp) ;)\
                                        \{\n"] ; # <1>
                                PushBlock
                                lassign [CreateTempRefSymbol $targetclass] targettype targetref
                                append result [IndentToBlock [string cat\
                                    "$targettype$targetref =\
                                        ($targettype)((uintptr_t)$itervar -\
                                        offsetof(struct $targetclass, $linkcomp)) ;\n"\
                                    "$itervar = $itervar->next ;\n"\
                                ]] ; # <2>
                            }
                            reftosuper {
                                lassign [CreateTempRefSymbol $targetclass] targettype targetref
                                append result [IndentToBlock\
                                    "$targettype$targetref = $startref->$comp ; // $relspec \n"\
                                ]
                            }
                            reftosub {
                                lassign [CreateTempRefSymbol $targetclass] targettype targetref
                                set classDesc [GetClassDescriptor $domain $targetclass]
                                set refcode "$targettype$targetref = $startref->$comp ; // $relspec\n"
                                append refcode "if ($targetref->base__INST.classDesc == &$classDesc) \{\n"
                                append result [IndentToBlock $refcode]
                                PushBlock
                            }
                            uniontosuper {
                                lassign [CreateTempRefSymbol $targetclass] targettype targetref
                                append result [IndentToBlock\
                                    "$targettype$targetref = ($targettype)((uintptr_t)$startref -\
                                    offsetof(struct $targetclass, $comp.$startClass)) ;\
                                    // $relspec \n"]
                            }
                            uniontosub {
                                lassign [CreateTempRefSymbol $targetclass] targettype targetref
                                set classDesc [GetClassDescriptor $domain $targetclass]
                                set refcode "$targettype$targetref = &$startref->$comp.$targetclass ;\
                                        // $relspec\n"
                                append refcode\
                                    "if ($targetref->base__INST.classDesc == &$classDesc) \{\n"
                                append result [IndentToBlock $refcode]
                                PushBlock
                            }
                        }
                        set startClass $targetclass
                        set startref $targetref
                    }
                }
                append result [IndentToBlock [string cat\
                    [CreateInstRefSymbol $targetclass $endref]\
                    "$endref = $targetref ;\n"]]
            
                return $result
            }
            proc LookUpRelationship {startclass relspec} {
                variable domain
            
                lassign $relspec relname destclass
                if {[string index $relname 0] eq "~"} {
                    set dir back
                    set relname [string range $relname 1 end]
                } else {
                    set dir forw
                }
            
                set relRef [Relationship findById Domain $domain Name $relname]
                set assocRef [findRelated $relRef {~R30 Association}]
                if {[isNotEmptyRef $assocRef]} {
                    set isstatic [readAttribute $assocRef IsStatic]
                    set sassocRef [findRelated $assocRef {~R31 SimpleAssociation}]
                    if {[isNotEmptyRef $sassocRef]} {
                        if {$destclass ne {}} {
                            error "simple association, $relname, cannot have a\
                                destination specifier"
                        }
                        assignAttribute [findRelated $sassocRef ~R32]\
                            {Class srcclass} {Conditionality srccond} {Multiplicity srcmult}
                        assignAttribute [findRelated $sassocRef ~R33] {Class trgclass}
                        if {$dir eq "forw"} {
                            if {$startclass ne $srcclass} {
                                error "relationship, $relname, is from\
                                    $srcclass to $trgclass: got, $startclass,\
                                    as the traversal start"
                            }
                            return [list $srcclass $trgclass reference false $relname]
                        } else {
                            if {$startclass ne $trgclass} {
                                error "relationship, ~$relname, is from\
                                    $trgclass to $srcclass: got, $startclass,\
                                    as the traversal start"
                            }
                            if {!$srcmult} {
                                set type reference
                                set comp ${relname}__BACK
                            } else {
                                if {$isstatic} {
                                    set type array
                                    set comp ${relname}__BACK
                                } else {
                                    set type linked
                                    set comp [list ${relname}__BACK ${relname}__BLINKS]
                                }
                            }
                            return [list $trgclass $srcclass $type $srccond $comp]
                        }
                    } else {
                        
                        set cassocRef [findRelated $assocRef {~R31 ClassBasedAssociation}]
                        assignAttribute [findRelated $cassocRef ~R34]\
                            {Class srcclass} {Conditionality srccond} {Multiplicity srcmult}
                        assignAttribute [findRelated $cassocRef ~R35]\
                            {Class trgclass} {Conditionality trgcond} {Multiplicity trgmult}
                        assignAttribute [findRelated $cassocRef ~R42]\
                            {Class assocclass}
                        if {!$trgmult} {
                            set srctype reference
                            set srccomp ${relname}__FORW
                        } else {
                            if {$isstatic} {
                                set srctype array
                                set srccomp ${relname}__FORW
                            } else {
                                set srctype linked
                                set srccomp [list ${relname}__FORW ${relname}__FLINKS]
                            }
                        }
                        if {!$srcmult} {
                            set trgtype reference
                            set trgcomp ${relname}__BACK
                        } else {
                            if {$isstatic} {
                                set trgtype array
                                set trgcomp ${relname}__BACK
                            } else {
                                set trgtype linked
                                set trgcomp [list ${relname}__BACK ${relname}__BLINKS]
                            }
                        }
                        
                        if {$destclass eq {}} {
                            if {$dir eq "forw"} {
                                if {$startclass eq $srcclass} {
                                    return [list\
                                        $srcclass $assocclass $srctype $trgcond $srccomp\
                                        $assocclass $trgclass reference false ${relname}.forward\
                                    ]
                                } elseif {$startclass eq $assocclass} {
                                    return [list\
                                        $assocclass $trgclass reference false ${relname}.forward\
                                    ]
                                } else {
                                    error "relationship, $relname, is from class based from\
                                        $srcclass to $trgclass via $assocclass: got, $startclass,\
                                        as the traversal start"
                                }
                            } else {
                                if {$startclass eq $trgclass} {
                                    return [list\
                                        $trgclass $assocclass $trgtype $srccond $trgcomp\
                                        $assocclass $srcclass reference false ${relname}.backward\
                                    ]
                                } elseif {$startclass eq $assocclass} {
                                    return [list\
                                        $assocclass $srcclass reference false ${relname}.backward\
                                    ]
                                } else {
                                    error "relationship, ~$relname, is from class based from\
                                        $trgclass to $srcclass via $assocclass: got, $startclass,\
                                        as the traversal start"
                                }
                            }
                        } else {
                            if {$destclass eq $assocclass} {
                                if {$dir eq "forw"} {
                                    return [list $srcclass $assocclass $srctype $trgcond $srccomp]
                                } else {
                                    return [list $trgclass $assocclass $trgtype $srccond $trgcomp]
                                }
                            } elseif {$destclass eq $trgclass} {
                                if {$dir eq "forw"} {
                                    return [list $assocclass $trgclass reference false ${relname}.forward]
                                } else {
                                    error "navigating forward from $assocclass arrives at\
                                        $trgclass: got $destclass"
                                }
                            } elseif {$destclass eq $srcclass} {
                                if {$dir eq "back"} {
                                    return [list $assocclass $srcclass reference false ${relname}.backward]
                                } else {
                                    error "navigating backward from $assocclass arrives at\
                                        $srcclass: got $destclass"
                                }
                            } else {
                                error "$destclass does not participate in $relname"
                            }
                        }
                    }
                } else {
                    set genRef [findRelated $relRef {~R30 Generalization}]
                    set refGenRef [findRelated $genRef {~R43 ReferenceGeneralization}]
                    if {[isNotEmptyRef $refGenRef]} {
                        set super [readAttribute [findRelated $refGenRef ~R36] Class]
                        set subs [findRelated $refGenRef ~R37]
                        set subnames [relation list [deRef $subs] Class]
                        set isRefGen true
                    } else {
                        set uGenRef [findRelated $genRef {~R43 UnionGeneralization}]
                        set super [readAttribute [findRelated $uGenRef ~R44] Class]
                        set subs [findRelated $uGenRef ~R45]
                        set subnames [relation list [deRef $subs] Class]
                        set isRefGen false
                    }
                    if {$dir eq "forw"} {
                        if {$destclass ne {}} {
                            error "generalization, $relname, cannot have a\
                                destination specifier when traversing to the superclass"
                        } elseif {$startclass ni $subnames} {
                            error "relationship, $relname, is from\
                                \"[join $subnames {, }]\", to $super,\
                                got, $startclass, as the traversal start"
                        }
                        set reftype [expr {$isRefGen ? "reftosuper" : "uniontosuper"}]
                        return [list $startclass $super $reftype false $relname]
                    } else {
                        if {$destclass eq {}} {
                            error "generalization, ~$relname, must specify a\
                                destination when traversing to a subclass"
                        } elseif {$startclass ne $super} {
                            error "relationship, ~$relname, is from\
                                $super to \"[join $subnames {, }]\", got, $startclass,\
                                as the traversal start"
                        } elseif {$destclass ni $subnames} {
                            error "generalization, ~$relname, cannot traverse to\
                                class, $destclass: should be one of:\
                                \"[join $subnames {, }]\""
                        }
                        set reftype [expr {$isRefGen ? "reftosub" : "uniontosub"}]
                        return [list $super $destclass $reftype false $relname]
                    }
                }
            }
            proc InstanceForeachRelatedWhere {startref instref where args} {
                set startblock [GetBlock]
                set where [string trim $where]
                set result [IndentToBlock\
                    [linecomment "instance $startref foreachRelatedWhere\
                            $instref [list $where] $args"]\
                ]
            
                append result [TraverseRelChain $startref $instref $args]
                append result [IndentToBlock "if ($where) \{\n"]
                PushBlock
            
                PushContext InstanceForeachRelatedWhere $startblock
            
                return $result
            }
            proc InstanceFindRelatedWhere {startref instref where args} {
                set startlevel [GetBlock]
                set where [string trim $where]
                set endref [CreateTempSymbolName]
                set endlabel [CreateLabelName]
            
                set chaincode [TraverseRelChain $startref $endref $args]
                set endsym [LookUpSymbol $endref]
            
                append chaincode [IndentToBlock [string cat\
                    "$instref = $endref ;\n"\
                    "if ($where) \{\n"\
                ]]
                PushBlock
            
                append chaincode [IndentToBlock "goto $endlabel ;\n"] ; # <1>
                PopBlock
            
                append chaincode [IndentToBlock "\} else \{\n"]
                PushBlock
            
                append chaincode [IndentToBlock "$instref = NULL ;\n"]
            
                set depth [expr {[GetBlock] - $startlevel}]
                for {set i 0} {$i < $depth} {incr i} {
                    PopBlock
                    append chaincode [IndentToBlock "\}\n"]
                }
                append chaincode [IndentToBlock "${endlabel}: ;\n"] ;   # <2>
            
                set result [IndentToBlock [string cat\
                    [linecomment "instance $startref findRelatedWhere\
                            $instref [list [string trim $where]] $args"]\
                    [CreateInstRefSymbol [dict get $endsym Class] $instref]\
                    "$instref = NULL ;\n"\
                ]]
            
                return [append result $chaincode]
            }
            proc InstanceFindOneRelated {startref instref args} {
                variable domain
            
                if {[llength $args] == 0} {
                    error "empty relationship chain specification"
                }
            
                set startsym [CheckInstRefSymbol $startref]
                set startClass [dict get $startsym Class]
                set heading [IndentToBlock\
                    [linecomment "instance $startref findOneRelated $instref $args"]\
                ]
                set startlevel [GetBlock]
                set isCond false
            
                foreach relspec $args {
                    set relinfo [LookUpRelationship $startClass $relspec]
                    while {[llength $relinfo] != 0} {
                        set relinfo [lassign $relinfo sourceclass targetclass reftype cond\
                            comp]
                        switch -exact -- $reftype {
                            reference {
                                if {$startClass ne $sourceclass} {
                                    error "relationship, [lindex $relspec 0], is from\
                                        $sourceclass to $targetclass, got, $startClass,\
                                        as the traversal start"
                                }
                                lassign [CreateTempRefSymbol $targetclass]\
                                    targettype targetref
                                set refcode "$targettype$targetref = $startref->$comp ;\
                                // $relspec \n"
                                if {$cond} {
                                    set isCond true
                                    append refcode "if ($targetref != NULL) \{\n"
                                    append result [IndentToBlock $refcode]
                                    PushBlock
                                } else {
                                    append result [IndentToBlock $refcode]
                                }
                            }
                            array -
                            linked {
                                error "relationship, [lindex $relspec 0], is\
                                    multiple from $sourceclass to $targetclass"
                            }
                            reftosuper {
                                if {$startClass ni $sourceclass} {
                                    error "relationship, [lindex $relspec 0], is from\
                                        \"[join $sourceclass {, }]\", to $targetclass,\
                                        got, $startClass, as the traversal start"
                                }
                                lassign [CreateTempRefSymbol $targetclass] targettype\
                                        targetref
                                append result [IndentToBlock\
                                    "$targettype$targetref = $startref->$comp ;\
                                    // $relspec \n"]
                            }
                            reftosub {
                                set isCond true
                                lassign [CreateTempRefSymbol $targetclass] targettype\
                                        targetref
                                set classDesc [GetClassDescriptor $domain $targetclass]
                                set refcode "$targettype$targetref = $startref->$comp ;\
                                        // $relspec\n"
                                append refcode\
                                    "if ($targetref->base__INST.classDesc == &$classDesc) \{\n"
                                append result [IndentToBlock $refcode]
                                PushBlock
                            }
                            uniontosuper {
                                if {$startClass ni $sourceclass} {
                                    error "relationship, [lindex $relspec 0], is from\
                                        \"[join $sourceclass {, }]\", to $targetclass,\
                                        got, $startClass, as the traversal start"
                                }
                                lassign [CreateTempRefSymbol $targetclass] targettype\
                                        targetref
                                append result [IndentToBlock\
                                    "$targettype$targetref =\
                                    ($targettype)((uintptr_t)$startref -\
                                    offsetof(struct $targetclass, $comp.$startClass)) ;\
                                    // $relspec \n"]
                            }
                            uniontosub {
                                set isCond true
                                lassign [CreateTempRefSymbol $targetclass] targettype\
                                        targetref
                                set classDesc [GetClassDescriptor $domain $targetclass]
                                set refcode\
                                    "$targettype$targetref = &$startref->$comp.$targetclass ;\
                                        // $relspec\n"
                                append refcode\
                                    "if ($targetref->base__INST.classDesc == &$classDesc) \{\n"
                                append result [IndentToBlock $refcode]
                                PushBlock
                            }
                        }
                        set startClass $targetclass
                        set startref $targetref
                    }
                }
                append result [IndentToBlock "$instref = $targetref ;\n"]
            
                for {set i [expr {[GetBlock] - $startlevel}]} {$i > 0} {incr i -1} {
                    PopBlock
                    append result [IndentToBlock "\}\n"]
                }
                append heading [IndentToBlock [CreateInstRefSymbol $targetclass $instref]]
                if {$isCond} {
                    append heading [IndentToBlock "$instref = NULL ;\n"]
                }
            
                return [string cat $heading $result]
            }
            proc InstanceSetSelectRelated {startref set args} {
                variable domain
            
                set startlevel [GetBlock]
            
                set endref [CreateTempSymbolName]
                set chaincode [TraverseRelChain $startref $endref $args]
                set targetclass [dict get [LookUpSymbol $endref] Class]
                set targetclassDesc [GetClassDescriptor $domain $targetclass]
            
                append chaincode\
                    [IndentToBlock "mrt_InstSetAddInstance(&$set, $endref) ;\n"]
            
                set depth [expr {[GetBlock] - $startlevel}]
                for {set i 0} {$i < $depth} {incr i} {
                    PopBlock
                    append chaincode [IndentToBlock "\}\n"]
                }
            
                set result [IndentToBlock [string cat\
                    [linecomment "instance $startref selectedRelated $set $args"]\
                    [CreateInstSetSymbol $targetclass $set]\
                    "mrt_InstSetInitialize(&$set, &$targetclassDesc) ;\n"]]
            
                return [append result $chaincode]
            }
            proc InstanceSetSelectRelatedWhere {startref set instref where args} {
                variable domain
            
                set startlevel [GetBlock]
                set where [string trim $where]
            
                set chaincode [TraverseRelChain $startref $instref $args]
                set targetclass [dict get [LookUpSymbol $instref] Class]
                set targetclassDesc [GetClassDescriptor $domain $targetclass]
                append chaincode [IndentToBlock "if ($where) \{\n"]
                PushBlock
                append chaincode [IndentToBlock\
                    "mrt_InstSetAddInstance(&$set, $instref) ;\n"]
            
                set depth [expr {[GetBlock] - $startlevel}]
                for {set i 0} {$i < $depth} {incr i} {
                    PopBlock
                    append chaincode [IndentToBlock "\}\n"]
                }
            
                set result [IndentToBlock [string cat\
                    [linecomment "instance $startref selectRelatedWhere $set $instref\
                            [list $where] $args"]\
                    [CreateInstSetSymbol $targetclass $set]\
                    "mrt_InstSetInitialize(&$set, &$targetclassDesc) ;\n"]]
            
                return [append result $chaincode]
            }
            proc InstanceSignal {instref event args} {
                set result [linecomment "instance $instref signal $event [list $args]"]
                set eventRef [VerifyEvent $event $instref]
                set params [VerifyEventParams $eventRef $args]
                if {[relation isempty $params]} {                       ; # <1>
                    set eventNum [readAttribute $eventRef Number]
                    set sourceinst [expr {[LookUpSymbol self] eq {} ? "NULL" : "self"}]
                    append result "mrt_SignalEvent($eventNum, $instref, $sourceinst,\
                            NULL, 0) ; // $event\n"
                } else {
                    set ecbvar [ECBAllocAndFill $instref $eventRef $params $args]
                    append result "mrt_PostEvent($ecbvar) ;\n"
                }
                return [IndentToBlock $result]
            }
            proc VerifyEvent {event targetinst} {
                variable domain
            
                set targetsym [CheckInstRefSymbol $targetinst]
                set className [dict get $targetsym Class]
                set eventRef [Event findById Domain $domain Model $className Event $event]
                if {[isEmptyRef $eventRef]} {
                    error "event, $event, is not a known event for class, $className"
                }
                return $eventRef
            }
            proc VerifyEventParams {eventRef supplied} {
                if {[llength $supplied] % 2 != 0} {
                    error "event parameters must be given as name / value pairs, got:\
                        \"$supplied\""
                }
                set psig [findRelated $eventRef R69]
                set params [FindParamsFromSig $psig]
                set suppliedNames [dict keys $supplied]
                set requiredNames [relation list $params Name -ascending Position]
                CheckSuppliedParams [readAttribute $eventRef Event]\
                        $suppliedNames $requiredNames
                return $params
            }
            proc ECBAllocAndFill {targetinst eventRef params arglist {resultRef result}} {
                upvar 1 $resultRef result
                variable domain
            
                set className [readAttribute $eventRef Model]
                set eventName [readAttribute $eventRef Event]
                set eventNum [readAttribute $eventRef Number]
                set sourceinst [expr {[LookUpSymbol self] eq {} ? "NULL" : "self"}]
            
                set ecbvar [CreateTempSymbol Ctype {MRT_ecb *} Type ECB Class $className]
                append result "MRT_ecb *$ecbvar =\
                        mrt_NewEvent($eventNum, $targetinst, $sourceinst) ; // $eventName\n"
                if {[relation isnotempty $params]} {
                    set eparamsname ${domain}_${className}_${eventName}__EPARAMS
                    set ptrparams [CreateTempSymbol Ctype "struct *$eparamsname"\
                        Type EventParams Class $className]
                    append result\
                        "struct $eparamsname *const $ptrparams =\n"\
                        "    (struct $eparamsname *)$ecbvar->eventParameters ;\n"
                    relation foreach param $params -ascending Position {
                        relation assign $param {Name pname} {DataType datatype}
                        append result [GenValueAssignment $domain $ptrparams->$pname\
                                [dict get $arglist $pname] $datatype]
                    }
                }
                return $ecbvar
            }
            proc InstanceDelaySignal {instref time event args} {
                set result\
                    [linecomment "instance $instref delaysignal $time $event [list $args]"]
                set eventRef [VerifyEvent $event $instref]
                set params [VerifyEventParams $eventRef $args]
                if {[relation isempty $params]} {
                    set eventNum [readAttribute $eventRef Number]
                    set sourceinst [expr {[LookUpSymbol self] eq {} ? "NULL" : "self"}]
                    append result "mrt_SignalDelayedEvent($time, $eventNum, $instref,\
                            $sourceinst, NULL, 0) ; // $event\n"
                } else {
                    set ecbvar [ECBAllocAndFill $instref $eventRef $params $args]
                    append result "mrt_PostDelayedEvent($ecbvar, $time) ;\n"
                }
                return [IndentToBlock $result]
            }
            proc InstanceCancelSignal {instref event {sourceref {}}} {
                variable domain
            
                append result [linecomment "instance $instref canceldelayed $event\
                    [list $sourceref]"]
                set target [CheckInstRefSymbol $instref]
                set eventNum [FindEventNumber [dict get $target Class] $event]
                if {$sourceref ne {}} {
                    CheckInstRefSymbol $sourceref
                    set sourceinst $sourceref
                } else {
                    try {
                        CheckInstRefSymbol self
                        set sourceinst self
                    } on error {} {
                        set sourceinst NULL
                    }
                }
                append result\
                    "mrt_CancelDelayedEvent($eventNum, $instref, $sourceinst) ;\n"
                return [IndentToBlock $result]
            }
            proc FindEventNumber {class event} {
                variable domain
                set eventRef [Event findById Domain $domain Model $class Event $event]
                if {[isEmptyRef $eventRef]} {
                    error "event, $event, is not a known event for class, $class"
                }
                return [readAttribute $eventRef Number]
            }
            proc InstanceRemainingTime {instref event {sourceref {}}} {
                variable domain
            
                set target [CheckInstRefSymbol $instref]
                set eventNum [FindEventNumber [dict get $target Class] $event]
                if {$sourceref ne {}} {
                    CheckInstRefSymbol $sourceref
                    set sourceinst $sourceref
                } else {
                    try {
                        CheckInstRefSymbol self
                        set sourceinst self
                    } on error {} {
                        set sourceinst NULL
                    }
                }
                return "mrt_RemainingDelayTime($eventNum, $instref, $sourceinst)"
            }
            proc InstanceRefToId {instref} {
                CheckInstRefSymbol $instref
                return "mrt_InstanceIndex($instref)"
            }
            proc InstanceSetForeachInstance {set inst} {
                set setsym [CheckInstSetSymbol $set]
            
                set startlevel [GetBlock]
                set iter [CreateTempSymbol Ctype MRT_InstSetIterator Type SetIterator\
                        Class [dict get $setsym Class]]
                append result [IndentToBlock [string cat\
                    [linecomment "instset $set foreachInstance $inst"]\
                    "MRT_InstSetIterator $iter ;\n"\
                    "for (mrt_InstSetIterBegin(&$set, &$iter) ;\
                    mrt_InstSetIterMore(&$iter) ; mrt_InstSetIterNext(&$iter)) \{\n"\
                ]]
                PushBlock
            
                append result [IndentToBlock [string cat\
                    [CreateInstRefSymbol [dict get $setsym Class] $inst]\
                    "$inst = mrt_InstSetIterGet(&$iter) ;\n"\
                ]]
            
                PushContext InstanceSetForeachInstance $startlevel
            
                return $result
            }
            proc InstanceSetSelectOneInstance {set inst} {
                set setsym [CheckInstSetSymbol $set]
                set iter [CreateTempSymbol Ctype MRT_InstSetIterator Type SetIterator\
                        Class [dict get $setsym Class]]
            
                set result [IndentToBlock [string cat\
                    [linecomment "instset $set selectOneInstance $inst"]\
                    "MRT_InstSetIterator $iter ;\n"\
                    "mrt_InstSetIterBegin(&$set, &$iter) ;\n"\
                    [CreateInstRefSymbol [dict get $setsym Class] $inst]\
                    "$inst = mrt_InstSetIterMore(&$iter) ? mrt_InstSetIterGet(&$iter) :\
                            NULL ;\n"\
                ]]
            
                return $result
            }
            proc InstanceSetEmpty {set} {
                CheckInstSetSymbol $set
                return "mrt_InstSetEmpty(&$set)"
            }
            proc InstanceSetNotEmpty {set} {
                return (![InstanceSetEmpty $set])
            }
            proc InstanceSetCardinality {set} {
                CheckInstSetSymbol $set
                return "mrt_InstSetCardinality(&$set)"
            }
            proc InstanceSetEqual {set1 set2} {
                set sym1 [CheckInstSetSymbol $set1]
                CheckInstSetSymbol $set2 Class [dict get $sym1 Class]
                return "mrt_InstSetEqual(&$set1, &$set2)"
            }
            proc InstanceSetNotEqual {set1 set2} {
                return (![InstanceSetEqual $set1 $set2])
            }
            proc InstanceSetAdd {set inst} {
                set setsym [CheckInstSetSymbol $set]
                CheckInstRefSymbol $inst Class [dict get $setsym Class]
                return [IndentToBlock [string cat\
                    [linecomment "instset $set add $inst"]\
                    "mrt_InstSetAddInstance(&$set, $inst) ;\n"\
                ]]
            }
            proc InstanceSetRemove {set inst} {
                set setsym [CheckInstSetSymbol $set]
                CheckInstRefSymbol $inst Class [dict get $setsym Class]
                return [IndentToBlock [string cat\
                    [linecomment "instset $set remove $inst"]\
                    "mrt_InstSetRemoveInstance(&$set, $inst) ;\n"\
                ]]
            }
            proc InstanceSetContains {set inst} {
                set setsym [CheckInstSetSymbol $set]
                CheckInstRefSymbol $inst Class [dict get $setsym Class]
                return "mrt_InstSetMember(&$set, $inst)"
            }
            proc InstanceSetUnion {opset set1 set2 args} {
                tailcall InstanceSetOperation union mrt_InstSetUnion $opset $set1 $set2\
                        {*}$args
            }
            proc InstanceSetIntersect {opset set1 set2 args} {
                tailcall InstanceSetOperation intersect mrt_InstSetIntersect $opset\
                        $set1 $set2 {*}$args
            }
            proc InstanceSetOperation {label op opset set1 set2 args} {
                variable domain
            
                set sym1 [CheckInstSetSymbol $set1]
                set className [dict get $sym1 Class]
                CheckInstSetSymbol $set2 Class $className
            
                if {$opset in [concat [list $set1 $set2] $args]} {
                    error "result set, \"$opset\", may not be one of the operation\
                        arguments"
                }
            
                set classDesc [GetClassDescriptor $domain $className]
                append result\
                    [linecomment "instset $opset $label $set1 [list $args]"]\
                    [CreateInstSetSymbol $className $opset]\
                    "mrt_InstSetInitialize(&$opset, &$classDesc) ;\n"\
                    "$op\(&$set1, &$set2, &$opset\) ;\n"
                foreach set $args {
                    CheckInstSetSymbol $set Class $className
                    append result "$op\(&$opset, &$set, &$opset\) ;\n"
                }
                return [IndentToBlock $result]
            }
            proc InstanceSetMinus {diffset set1 set2} {
                variable domain
            
                if {$diffset in [list $set1 $set2]} {
                    error "result set, \"$diffset\", may not be one of the minus\
                        operation arguments"
                }
            
                set sym1 [CheckInstSetSymbol $set1]
                set className [dict get $sym1 Class]
                set sym2 [CheckInstSetSymbol $set2 Class $className]
            
                set classDesc [GetClassDescriptor $domain $className]
                append result\
                    [linecomment "instset $diffset minus $set1 $set2"]\
                    [CreateInstSetSymbol $className $diffset]\
                    "mrt_InstSetInitialize(&$diffset, &$classDesc) ;\n"\
                    "mrt_InstSetMinus(&$set1, &$set2, &$diffset) ;\n"
                return [IndentToBlock $result]
            }
            proc ClassCreate {className instref args} {
                variable domain
                if {[llength $args] % 2 != 0} {
                    error "initializers must be given as name / value pairs"
                }
            
                set classDesc [GetClassDescriptor $domain $className]
                append result\
                    [linecomment "$className create $instref [list $args]"]\
                    [CreateInstRefSymbol $className $instref]\
                    "$instref = mrt_CreateInstance(&$classDesc, MRT_StateCode_IG) ;\n"\
                    [AssignComponentValues $className $instref $args]
            
                return [IndentToBlock $result]
            }
            proc USubClassCreate {className instref args} {
                variable domain
                if {[llength $args] % 2 != 0} {
                    error "initializers must be given as name / value pairs"
                }
            
                # Find the relationship for which the class is a union subclass.
                set usubclass [UnionSubclass findWhere\
                        {$Domain eq $domain && $Class eq $className && $Role eq "source"}]
                if {[isEmptyRef $usubclass]} {
                    error "\"$className\" is not a union subclass"
                }
            
                # Get the superclass name.
                set supername [readAttribute [findRelated $usubclass R45 ~R44] Class]
                set relName [readAttribute $usubclass Relationship]
                set relDesc [GetRelationshipDescriptor $domain $relName]
            
                # Find the super class instance reference among the arguments.
                if {![dict exists $args $relName]} {
                    error "no value supplied for superclass reference, \"$relName\""
                }
                set superinst [dict get $args $relName]
                CheckInstRefSymbol $superinst Class $supername
            
                set classDesc [GetClassDescriptor $domain $className]
                append result\
                    [linecomment "$className create $instref [list $args]"]\
                    [CreateInstRefSymbol $className $instref]\
                    "$instref = mrt_CreateUnionInstance(&$classDesc, MRT_StateCode_IG, "\
                    "$relDesc, $superinst) ;\n"\
                    [AssignComponentValues $className $instref $args]
            
                return [IndentToBlock $result]
            }
            proc AssignComponentValues {className instref suppliedvalues} {
                variable domain
                set result {}
            
                set popcomps [GetPopComponents $className]
                relation foreach popcomp $popcomps {
                    relation assign $popcomp
                    switch -exact -- $Type {
                    association {
                        if {![dict exists $suppliedvalues $Name]} {
                            error "no value supplied for association reference, \"$Name\""
                        } else {
                            set assocrefvar [dict get $suppliedvalues $Name]
                        }
                        set refclass [pipe {
                            AssociationReference findById Domain $Domain Class $Class\
                                    Name $Name |
                            findRelated % ~R90 R32 ~R33 |
                            readAttribute % Class
                        } {} |%]
                        CheckInstRefSymbol $assocrefvar Class $refclass
            
                        set relDesc [GetRelationshipDescriptor $Domain $Name]
                        append result "mrt_CreateSimpleLinks($relDesc, $instref,\
                                $assocrefvar, true) ;\n"
                    }
                    associator {
                        if {![dict exists $suppliedvalues $Name]} {
                            error "no value supplied for associator reference, \"$Name\""
                        } else {
                            set atorrefs [dict get $suppliedvalues $Name]
                        }
                        set atorclass [pipe {
                            AssociatorReference findById Domain $Domain Class $Class\
                                    Name $Name |
                            findRelated % ~R93
                        } {} |%]
                        set srcclass [pipe {
                            findRelated $atorclass R42 ~R34 |
                            readAttribute % Class
                        } {} |%]
                        set trgclass [pipe {
                            findRelated $atorclass R42 ~R35 |
                            readAttribute % Class
                        } {} |%]
            
                        # Reflexive case
                        if {$srcclass eq $trgclass} {
                            if {[dict exists $atorrefs backward]} {
                                set srcinstref [dict get $atorrefs backward]
                            } else {
                                error "for reflexive associator references, expected\
                                    \"backward\" reference: got \"$atorrefs\""
                            }
                            if {[dict exists $atorrefs forward]} {
                                set trginstref [dict get $atorrefs forward]
                            } else {
                                error "for reflexive associator references, expected\
                                    \"forward\" reference: got \"$atorrefs\""
                            }
                        } else {
                            if {[dict exists $atorrefs $srcclass]} {
                                set srcinstref [dict get $atorrefs $srcclass]
                            } else {
                                error "for associator references, expected\
                                    \"$srcclass\" reference: got \"$atorrefs\""
                            }
                            if {[dict exists $atorrefs $trgclass]} {
                                set trginstref [dict get $atorrefs $trgclass]
                            } else {
                                error "for associator references, expected\
                                    \"$trgclass\" reference: got \"$atorrefs\""
                            }
                        }
                        CheckInstRefSymbol $srcinstref Class $srcclass
                        CheckInstRefSymbol $trginstref Class $trgclass
            
                        set relDesc [GetRelationshipDescriptor $Domain $Name]
                        append result "mrt_CreateAssociatorLinks($relDesc, $instref,\
                                $srcinstref, $trginstref) ;\n"
                    }
                    superclass {
                        if {![dict exists $suppliedvalues $Name]} {
                            error "no value supplied for superclass reference, \"$Name\""
                        } else {
                            set superrefvar [dict get $suppliedvalues $Name]
                            if {$superrefvar eq {}} {
                                dict unset suppliedvalues $Name
                                continue
                            }
                        }
                        set superref [pipe {
                            SuperclassReference findById Domain $Domain Class $Class\
                                    Name $Name |
                            findRelated % ~R91 {~R47 ReferringSubclass} R37 ~R36
                        } {} |%]
                        if {[isNotEmptyRef $superref]} {
                            CheckInstRefSymbol $superrefvar\
                                    Class [readAttribute $superref Class]
            
                            set relDesc [GetRelationshipDescriptor $Domain $Name]
                            append result "mrt_CreateSimpleLinks($relDesc, $instref,\
                                    $superrefvar, true) ;\n"
                        }
                    }
                    attribute {
                        if {![dict exists $suppliedvalues $Name]} {
                            set defvalueref [DefaultValue findById Domain $Domain\
                                    Class $Class Attribute $Name]
                            if {[isEmptyRef $defvalueref]} {
                                error "attribute, \"$Name\", has no supplied value and\
                                    no default value"
                            }
                            set attrValue [readAttribute $defvalueref Value]
                        } else {
                            set attrValue [dict get $suppliedvalues $Name]
                        }
                        set attrref [Attribute findById Domain $Domain Class $Class\
                                Name $Name]
                        assignAttribute $attrref {DataType datatype}
                        append result [GenValueAssignment $domain $instref->$Name\
                                $attrValue $datatype]
                    }
                    }
                    dict unset suppliedvalues $Name
                }
            
                if {[dict size $suppliedvalues] != 0} {
                    error "class, $Class, has no attribute(s) named,\
                        \"[join [dict keys $suppliedvalues] {, }]\"\
                        or the attribute(s) is zero initialized"
                }
            
                return $result
            }
            
            proc GetPopComponents {className} {
                variable domain
            
                set popcomps [PopulatedComponent findWhere\
                        {$Domain eq $domain && $Class eq $className}]
                set typedcomps [pipe {
                    findRelated $popcomps {~R21 Reference} {~R23 AssociationReference} |
                    deRef % |
                    relation extend % artup Type string {"association"}
                } {} |%]
            
                set typedcomps [pipe {
                    findRelated $popcomps {~R21 Reference} {~R23 AssociatorReference} |
                    deRef % |
                    relation extend % artup Type string {"associator"} |
                    relation union $typedcomps %
                } {} |%]
            
                set typedcomps [pipe {
                    findRelated $popcomps {~R21 Reference} {~R23 SuperclassReference} |
                    deRef % |
                    relation extend % artup Type string {"superclass"} |
                    relation union $typedcomps %
                } {} |%]
            
                set typedcomps [pipe {
                    findRelated $popcomps {~R21 Attribute} {~R29 IndependentAttribute}\
                            {~R19 ValueInitializedAttribute} |
                    deRef % |
                    relation extend % artup Type string {"attribute"} |
                    relation union $typedcomps %
                } {} |%]
                # puts [relformat $typedcomps typedcomps]
            
                return $typedcomps
            }
            
            proc GetRelationshipDescriptor {domain name} {
                set relnum [pipe {
                    Relationship findById Domain $domain Name $name |
                    readAttribute ~ Number
                }]
                return &${domain}__RSHIPS\[$relnum\]
            }
            proc ClassCreateIn {className instref state args} {
                variable domain
                if {[llength $args] % 2 != 0} {
                    error "initializers must be given as name / value pairs"
                }
            
                if {$state eq "@"} {
                    error "instances may not be synchronously created\
                            in the pseudo-initial state, \"@\""
                }
            
                set statenum [GetStateNumber $domain $className $state]
                set classDesc [GetClassDescriptor $domain $className]
            
                append result\
                    [linecomment "$className createin $instref [list $args]"]\
                    [CreateInstRefSymbol $className $instref]\
                    "$instref = mrt_CreateInstance(&$classDesc, $statenum) ;\n"\
                    [AssignComponentValues $className $instref $args]
            
                return [IndentToBlock $result]
            }
            proc USubClassCreateIn {className instref state args} {
                variable domain
                if {[llength $args] % 2 != 0} {
                    error "initializers must be given as name / value pairs"
                }
            
                if {$state eq "@"} {
                    error "instances may not be synchronously created\
                            in the pseudo-initial state, \"@\""
                }
            
                # Find the relationship for which the class is a union subclass.
                set usubclass [UnionSubclass findWhere\
                        {$Domain eq $domain && $Class eq $className && $Role eq "source"}]
                if {[isEmptyRef $usubclass]} {
                    error "\"$className\" is not a union subclass"
                }
            
                # Get the superclass name.
                set supername [readAttribute [findRelated $usubclass R45 ~R44] Class]
                set relName [readAttribute $usubclass Relationship]
                set relDesc [GetRelationshipDescriptor $domain $relName]
            
                # Find the super class instance reference among the arguments.
                if {![dict exists $args $relName]} {
                    error "no value supplied for superclass reference, \"$relName\""
                }
                set superinst [dict get $args $relName]
                CheckInstRefSymbol $superinst Class $supername
            
                set statenum [GetStateNumber $domain $className $state]
                set classDesc [GetClassDescriptor $domain $className]
            
                append result\
                    [linecomment "$className createin $instref [list $args]"]\
                    [CreateInstRefSymbol $className $instref]\
                    "$instref = mrt_CreateUnionInstance(&$classDesc, $statenum, "\
                    "$relDesc, $superinst) ;\n"\
                    [AssignComponentValues $className $instref $args]
            
                return [IndentToBlock $result]
            }
            proc GetStateNumber {domain className state} {
                set stateRef [StatePlace findById Domain $domain Model $className\
                        Name $state]
                if {[isEmptyRef $stateRef]} {
                    error "class, $className, has no state named, $state"
                }
                return [readAttribute $stateRef Number]
            }
            proc ClassCreateAsync {className event eventparams args} {
                variable domain
            
                if {[llength $eventparams] % 2 != 0} {
                    error "event parameters must be given as name / value pairs, got:\
                        \"$eventparams\""
                }
                if {[llength $args] % 2 != 0} {
                    error "initializers must be given as name / value pairs"
                }
                set eventRef [Event findById Domain $domain Model $className Event $event]
                if {[isEmptyRef $eventRef]} {
                    error "class, $className, has no event named, $event"
                }
                set eventNum [readAttribute $eventRef Number]
            
                append result\
                    [linecomment "$className createasync $event [list $eventparams]\
                        [list $args]"]
            
                lassign [GenCreationEventParams $className $eventRef $eventparams]\
                    paramptr paramsize
            
                set sourceinst [expr {[LookUpSymbol self] eq {} ? "NULL" : "self"}]
            
                lassign [CreateTempRefSymbol $className] reftype refvar
                set classDesc [GetClassDescriptor $domain $className]
                append result\
                    "$reftype$refvar = mrt_CreateInstanceAsync(&$classDesc, $eventNum,\
                        $paramptr, $paramsize, $sourceinst) ;\n"\
                    [AssignComponentValues $className $refvar $args]
            
                return [IndentToBlock $result]
            }
            proc GenCreationEventParams {className eventRef eventparams {resultRef result}} {
                variable domain
                upvar 1 $resultRef result
            
                set psig [findRelated $eventRef R69]
                set params [FindParamsFromSig $psig]
                if {[relation isnotempty $params]} {
                    set required [relation list $params Name]
                    set supplied [dict keys $eventparams]
                    if {![::struct::set equal $required $supplied]} {
                        error "event, $event, requires parameters,\
                            \"[join $required {, }]\", got:\
                            \"[join $supplied {, }]\""
                    }
            
                    set event [readAttribute $eventRef Event]
                    set eparamsname ${domain}_${className}_${event}__EPARAMS
                    set paramvar [CreateTempSymbol Ctype "struct *$eparamsname"\
                        Type EventParams Class $className]
            
                    append result\
                        "struct $eparamsname $paramvar = \{\n"
                    relation foreach param $params -ascending Position {
                        relation assign $param Name
                        append result "    .$Name = [dict get $eventparams $Name],\n"
                    }
                    append result "\} ;\n"
            
                    set paramptr &$paramvar
                    set paramsize sizeof($paramvar)
                } else {
                    set paramptr NULL
                    set paramsize 0
                }
            
                return [list $paramptr $paramsize]
            }
            proc USubClassCreateAsync {className event eventparams args} {
                variable domain
            
                if {[llength $eventparams] % 2 != 0} {
                    error "event parameters must be given as name / value pairs, got:\
                        \"$eventparams\""
                }
                if {[llength $args] % 2 != 0} {
                    error "initializers must be given as name / value pairs"
                }
            
                # Find the relationship for which the class is a union subclass.
                set usubclass [UnionSubclass findWhere\
                        {$Domain eq $domain && $Class eq $className && $Role eq "source"}]
                if {[isEmptyRef $usubclass]} {
                    error "\"$className\" is not a union subclass"
                }
            
                # Get the superclass name.
                set supername [readAttribute [findRelated $usubclass R45 ~R44] Class]
                set relName [readAttribute $usubclass Relationship]
                set relDesc [GetRelationshipDescriptor $domain $relName]
            
                # Find the super class instance reference among the arguments.
                if {![dict exists $args $relName]} {
                    error "no value supplied for superclass reference, \"$relName\""
                }
                set superinst [dict get $args $relName]
                CheckInstRefSymbol $superinst Class $supername
            
                set eventRef [Event findById Domain $domain Model $className Event $event]
                if {[isEmptyRef $eventRef]} {
                    error "class, $className, has no event named, $event"
                }
                set eventNum [readAttribute $eventRef Number]
            
                append result\
                    [linecomment "$className createasync $event [list $eventparams]\
                        [list $args]"]
            
                lassign [GenCreationEventParams $className $eventRef $eventparams]\
                    paramptr paramsize
            
                set sourceinst [expr {[LookUpSymbol self] eq {} ? "NULL" : "self"}]
            
                lassign [CreateTempRefSymbol $className] reftype refvar
                set classDesc [GetClassDescriptor $domain $className]
                append result\
                    "$reftype$refvar = mrt_CreateUnionInstanceAsync(&$classDesc, $eventNum,\
                        $paramptr, $paramsize, $sourceinst, $relDesc, $superinst) ;\n"\
                    [AssignComponentValues $className $refvar $args]
            
                return [IndentToBlock $result]
            }
            proc ClassForeachInstance {className instref} {
                variable domain
            
                set iter [CreateTempSymbol Ctype {MRT_InstIterator}\
                        Type InstanceIterator Class $className]
            
                set startlevel [GetBlock]
            
                set classDesc [GetClassDescriptor $domain $className]
                set result [IndentToBlock [string cat\
                    [linecomment "$className foreachInstance $instref"]\
                    "MRT_InstIterator $iter ;\n"\
                    "for (mrt_InstIteratorStart(&$iter, &$classDesc) ;\
                        mrt_InstIteratorMore(&$iter) ;\
                        mrt_InstIteratorNext(&$iter)) \{\n"\
                ]]
                PushBlock
                append result [IndentToBlock [string cat\
                    [CreateInstRefSymbol $className $instref]\
                    "$instref = mrt_InstIteratorGet(&$iter) ;\n"\
                ]]
            
                PushContext ClassForeachInstance $startlevel
            
                return $result
            }
            proc ClassForeachWhere {className instref where} {
                variable domain
            
                set startlevel [GetBlock]
                set where [string trim $where]
            
                set classDesc [GetClassDescriptor $domain $className]
                set iter [CreateTempSymbol Ctype {MRT_InstIterator}\
                        Type InstanceIterator Class $className]
                set result [IndentToBlock [string cat\
                    [linecomment "$className foreachWhere $instref [list $where]"]\
                    "MRT_InstIterator $iter ;\n"\
                    "for (mrt_InstIteratorStart(&$iter, &$classDesc) ;\
                        mrt_InstIteratorMore(&$iter) ;\
                        mrt_InstIteratorNext(&$iter)) \{\n"\
                ]]
                PushBlock
                append result [IndentToBlock [string cat\
                    [CreateInstRefSymbol $className $instref]\
                    "$instref = mrt_InstIteratorGet(&$iter) ;\n"\
                    "if ($where) \{\n"\
                ]]
                PushBlock
            
                PushContext ClassForeachWhere $startlevel
            
                return $result
            }
            proc ClassFindWhere {className instref where} {
                variable domain
                set where [string trim $where]
            
                set classDesc [GetClassDescriptor $domain $className]
                set iter [CreateTempSymbol Ctype {MRT_InstIterator}\
                        Type InstanceIterator Class $className]
                set result [IndentToBlock [string cat\
                    [linecomment "$className findWhere $instref [list $where]"]\
                    [CreateInstRefSymbol $className $instref]\
                    "$instref = NULL ;\n"\
                    "MRT_InstIterator $iter ;\n"\
                    "for (mrt_InstIteratorStart(&$iter, &$classDesc) ;\
                        mrt_InstIteratorMore(&$iter) ;\
                        mrt_InstIteratorNext(&$iter)) \{\n"\
                ]]
                PushBlock
                append result [IndentToBlock [string cat\
                    "$instref = mrt_InstIteratorGet(&$iter) ;\n"\
                    "if ($where) \{\n"\
                ]]
                PushBlock
            
                append result [IndentToBlock "break ;\n"]
                PopBlock
            
                append result [IndentToBlock "\} else \{\n"]
                PushBlock
            
                append result [IndentToBlock "$instref = NULL ;\n"]
                PopBlock
            
                append result [IndentToBlock "\}\n"]
                PopBlock
            
                append result [IndentToBlock "\}\n"]
            
                return $result
            }
            proc ClassSelectWhere {className instref where instset} {
                variable domain
                set where [string trim $where]
                set result [IndentToBlock\
                    [linecomment "$className selectWhere $instref [list $where] $instset"]\
                ]
            
                set startlevel [GetBlock]
            
                set classDesc [GetClassDescriptor $domain $className]
                append result [IndentToBlock [string cat\
                    [CreateInstSetSymbol $className $instset]\
                    "mrt_InstSetInitialize(&$instset, &$classDesc) ;\n"]\
                ]
            
                set iter [CreateTempSymbol Ctype {MRT_InstIterator}\
                        Type InstanceIterator Class $className]
                append result [IndentToBlock [string cat\
                    "MRT_InstIterator $iter ;\n"\
                    "for (mrt_InstIteratorStart(&$iter, &$classDesc) ;\
                        mrt_InstIteratorMore(&$iter) ;\
                        mrt_InstIteratorNext(&$iter)) \{\n"\
                ]]
                PushBlock
            
                append result [IndentToBlock [string cat\
                    [CreateInstRefSymbol $className $instref]\
                    "$instref = mrt_InstIteratorGet(&$iter) ;\n"\
                    "if ($where) \{\n"\
                ]]
                PushBlock
            
                append result [IndentToBlock\
                    "mrt_InstSetAddInstance(&$instset, $instref) ;\n"\
                ]
            
                set depth [expr {[GetBlock] - $startlevel}]
                for {set i 0} {$i < $depth} {incr i} {
                    PopBlock
                    append result [IndentToBlock "\}\n"]
                }
            
                return $result
            }
            proc ClassInstanceReference {className varName} {
                return [IndentToBlock [string cat\
                    [linecomment "$className instref $varName"]\
                    "[CreateInstRefSymbol $className $varName]"\
                    "$varName = NULL ;\n"\
                ]]
            }
            proc ClassIdToRef {className instid instref} {
                variable domain
            
                set classDesc [GetClassDescriptor $domain $className]
            
                return [IndentToBlock [string cat\
                    [linecomment "$className idtoref $instref"]\
                    [CreateInstRefSymbol $className $instref]\
                    "$instref = mrt_InstanceReference(&$classDesc, $instid) ;\n"\
                ]]
            }
            proc ClassFindByName {className instName instref} {
                variable domain
                set instRef [ClassInstance findById Domain $domain Class $className\
                    Instance $instName]
                if {[isEmptyRef $instRef]} {
                    error "class, $className, has no instance named, $instName"
                }
                set classDesc [GetClassDescriptor $domain $className]
                set instNum [readAttribute $instRef Number]
            
                return [IndentToBlock [string cat\
                    [linecomment "$className findByName $instName $instref"]\
                    [CreateInstRefSymbol $className $instref]\
                    "$instref = mrt_InstanceReference(&$classDesc, $instNum) ;\n"\
                ]]
            }
            proc ClassOperation {className opName args} {
                if {[llength $args] % 2 != 0} {
                    error "operation parameters must be given as name / value pairs"
                }
                variable domain
            
                set opRef [Operation findWhere {$Domain eq $domain && $Class eq $className\
                    && $Name eq $opName && !$IsInstance}]
                if {[isEmptyRef $opRef]} {
                    error "unknown class operation, $opName, for class, $className"
                }
            
                set provided [dict keys $args]
                set params [deRef [findRelated $opRef ~R4]]
                set required [relation list $params Name -ascending Number]
                CheckSuppliedParams $opName $provided $required
            
                set pset {}
                foreach pname $required {
                    append pset "[dict get $args $pname], "
                }
                set pset [string trimright $pset {, }]
            
                return "${className}_$opName\($pset\)"
            }
            proc ClassInstanceSet {className varName} {
                variable domain
                set classDesc [GetClassDescriptor $domain $className]
                return [IndentToBlock [string cat\
                    [linecomment "$className instset $varName"]\
                    [CreateInstSetSymbol $className $varName]\
                    "mrt_InstSetInitialize(&$varName, &$classDesc) ;\n"\
                ]]
            }
            proc RelSimpleAssocSwap {relName sourceref targetref} {
                variable domain
                set relRef [SimpleAssociation findById Domain $domain Name $relName]
                set rship [GetRelationshipDescriptor $domain $relName]
            
                set sourceClass [readAttribute [findRelated $relRef ~R32] Class]
                CheckInstRefSymbol $sourceref Class $sourceClass
            
                set targetClass [readAttribute [findRelated $relRef ~R33] Class]
                CheckInstRefSymbol $targetref Class $targetClass
            
                return [IndentToBlock [string cat\
                    [linecomment "$relName reference $sourceref $targetref"]\
                    "mrt_CreateSimpleLinks($rship, $sourceref, $targetref, true) ;\n"\
                ]]
            }
            proc RelClassAssocSwap {relName assocref partref {dir {}}} {
                variable domain
                set relRef [ClassBasedAssociation findById Domain $domain Name $relName]
                set rship [GetRelationshipDescriptor $domain $relName]
            
                set assocClass [readAttribute [findRelated $relRef ~R42] Class]
                set assocsym [CheckInstRefSymbol $assocref Class $assocClass]
            
                set sourceClass [readAttribute [findRelated $relRef ~R34] Class]
                set targetClass [readAttribute [findRelated $relRef ~R35] Class]
            
                set partrefSym [LookUpSymbol $partref]
                if {$partrefSym eq {}} {
                    error "unknown participant reference symbol, \"$partref\""
                }
                set partClass [dict get $partrefSym Class]
                if {!($partClass eq $sourceClass || $partClass eq $targetClass)} {
                    error "$partref is a reference to an instance of class, $partClass,\
                        which does not participate in relationship, $relName"
                }
            
                set result [linecomment "$relName reference $assocref $partref $dir"]
            
                # Check for reflexive case
                if {$sourceClass eq $targetClass} {
                    if {$dir eq {}} {
                        error "for reflexive association, \"$relName\", the direction\
                            of the reference must be specified"
                    }
                    switch -exact -- $dir {
                        forward {
                            set isForward true
                        }
                        backward {
                            set isForward false
                        }
                        default {
                            error "unknown association direction, \"$dir\""
                        }
                    }
                } else {
                    set isForward true
                }
                append result\
                    "mrt_CreateSimpleLinks($rship, $assocref, $partref, $isForward) ;\n"
            
                return [IndentToBlock $result]
            }
            proc RelRefGenReclassify {relName subref newSubclass newref args} {
                if {[llength $args] % 2 != 0} {
                    error "initializers must be given as name / value pairs"
                }
                set result [linecomment "$relName reclassify $subref $newSubclass\
                        $newref [list $args]"]
            
                variable domain
                set relRef [ReferenceGeneralization findById Domain $domain Name $relName]
            
                set subclasses [findRelated $relRef ~R37]
                CheckSubClassName $newSubclass $subclasses
            
                set subrefClass [dict get [CheckSymbol $subref] Class]
                CheckSubClassName $subrefClass $subclasses
            
                set classDesc [GetClassDescriptor $domain $newSubclass]
                set relDesc [GetRelationshipDescriptor $domain $relName]
                lappend args $relName {}
                append result\
                    [CreateInstRefSymbol $newSubclass $newref]\
                    "$newref = mrt_Reclassify\($relDesc, $subref, &$classDesc\) ;\n"\
                    [AssignComponentValues $newSubclass $newref $args]
            
                if {$subref ne "self"} {
                    append result "$subref = NULL ;\n" ;                # <1>
                }
            
                return [IndentToBlock $result]
            }
            proc CheckSubClassName {subclass subRefs} {
                set subclassnames [pipe {
                    deRef $subRefs |
                    relation list ~ Class
                }]
                if {$subclass ni $subclassnames} {
                    error "bad subclass, $subclass, should be one of:\
                            [join $subclassnames {, }]"
                }
            }
            proc RelUnionGenReclassify {relName subref newSubclass newref args} {
                if {[llength $args] % 2 != 0} {
                    error "initializers must be given as name / value pairs"
                }
                set result [linecomment "$relName reclassify $subref $newSubclass\
                        $newref [list $args]"]
            
                variable domain
                set relRef [UnionGeneralization findById Domain $domain Name $relName]
            
                set subclasses [findRelated $relRef ~R45]
                CheckSubClassName $newSubclass $subclasses
            
                set subrefClass [dict get [CheckSymbol $subref] Class]
                CheckSubClassName $subrefClass $subclasses
            
                set classDesc [GetClassDescriptor $domain $newSubclass]
                set relDesc [GetRelationshipDescriptor $domain $relName]
                lappend args $relName {}
                append result\
                    [CreateInstRefSymbol $newSubclass $newref]\
                    "$newref = mrt_Reclassify\($relDesc, $subref, &$classDesc\) ;\n"\
                    [AssignComponentValues $newSubclass $newref $args]
            
                if {$subref ne "self"} {
                    append result "$subref = NULL ;\n" ;            # <1>
                }
            
                return [IndentToBlock $result]
            }
            proc GenClassify {relName superref subref} {
                variable domain
            
                if {[llength [LookUpSymbol $subref]] != 0} {
                    error "subclass reference symbol, \"$subref\", already exists:\
                        this variable name must not already exist"
                }
            
                set startblock [GetBlock]
            
                set result [linecomment "$relName classify $superref $subref"]
            
                set relRef [Generalization findById Domain $domain Name $relName]
            
                set superclassref [Superclass findWhere {$Domain eq $domain &&\
                        $Relationship eq $relName && $Role eq "target"}]
                set supername [readAttribute $superclassref Class]
                CheckInstRefSymbol $superref Class $supername
            
                set subclassref [Subclass findWhere {$Domain eq $domain &&\
                        $Relationship eq $relName && $Role eq "source"}]
                set subclasses [pipe {
                    deRef $subclassref |
                    relation project ~ Class |
                    relation list ~
                }]
            
                # calculate the address to the subclass,
                # calculation depends upon whether we are reference generalization
                # or union generalization
                set tinst [CreateTempSymbol Ctype {MRT_Instance *} Type Reference Class {}]
                append result "MRT_Instance *$tinst = "
            
                set rgref [findRelated $relRef {~R43 ReferenceGeneralization}]
                if {[isNotEmptyRef $rgref]} {
                    set gentype reference
                    append result "$superref->$relName ;\n"
                } else {
                    set gentype union
                    append result "(MRT_Instance *)&$superref->$relName ;\n"
                }
                set cindex [CreateTempSymbol Ctype ptrdiff_t Type Index Class {}]
                append result\
                    "ptrdiff_t $cindex = $tinst->classDesc - ${domain}__CLASSES ;\n"\
                    "switch ($cindex) \{\n"
            
                set result [IndentToBlock $result]
            
                PushBlock
            
                PushContext GenClassify $startblock
                actexpand cset subclasses $subclasses
                actexpand cset foundsubs [list]
                actexpand cset superref $superref
                actexpand cset subref $subref
                actexpand cset relname $relName
                actexpand cset gentype $gentype
                actexpand cset gotdefault false
            
                return $result
            }
            proc SubclassCase {subclassname} {
                variable domain
                set startblock [GetBlock]
            
                set context [actexpand cname]
                if {$context ne "GenClassify"} {
                    error "invoked subclass command outside of a classify context"
                }
                set subclasses [actexpand cget subclasses]
                if {![::struct::set contains $subclasses $subclassname]} {
                    error "unknown subclass, \"$subclassname\""
                }
            
                set foundsubs [actexpand cget foundsubs]
                if {[::struct::set contains $foundsubs $subclassname]} {
                    error "duplicate subclass, \"$subclassname\""
                }
                ::struct::set include foundsubs $subclassname
                actexpand cset foundsubs $foundsubs
            
                set classnum [GetClassProperty $subclassname Number]
            
                set result [IndentToBlock [string cat\
                    [linecomment "subclass $subclassname"]\
                    "case ${classnum}: \{\n"\
                ]]
            
                PushBlock
            
                set superref [actexpand cget superref]
                set subref [actexpand cget subref]
                set gentype [actexpand cget gentype]
                set relname [actexpand cget relname]
                set refResult [CreateInstRefSymbol $subclassname $subref]
                if {$gentype eq "reference"} {
                    append refResult "$subref = $superref->$relname ;\n"
                } else {
                    append refResult "$subref = &$superref->$relname.$subclassname ;\n"
                }
            
                append result [IndentToBlock $refResult]
            
                PushContext Subclass $startblock
            
                return $result
            }
            proc DefaultSubclass {} {
                set startblock [GetBlock]
            
                set context [actexpand cname]
                if {$context ne "GenClassify"} {
                    error "invoked default command outside of a classify context"
                }
            
                append result "default: \{\n"
                set result [IndentToBlock $result]
            
                PushBlock
            
                actexpand cset gotdefault true
                PushContext Subclass $startblock
            
                return $result
            }
            proc SingleAssignerSignal {relName event args} {
                set reftype "struct $relName *"
                set instref [CreateTempSymbol Ctype $reftype Type Reference Class $relName]
            
                append result\
                    [linecomment "$relName signal $event [list $args]"]\
                    "$reftype$instref = &${relName}__POOL\[0\] ;\n"
            
                return [string cat\
                    [IndentToBlock $result]\
                    [InstanceSignal $instref $event {*}$args]\
                ]
            }
            proc MultiAssignerFindIdInstance {relName idinst instref} {
                variable domain
            
                set maRef [MultipleAssigner findWhere {$Domain eq $domain &&\
                        $Association eq $relName}]
                set idClass [readAttribute $maRef Class]
                CheckInstRefSymbol $idinst Class $idClass
            
                set startlevel [GetBlock]
            
                set classDesc [GetClassDescriptor $domain $relName]
                set iter [CreateTempSymbol Ctype {MRT_InstIterator}\
                        Type InstanceIterator Class $relName]
                set asgnref [CreateTempSymbolName]
                set result [IndentToBlock [string cat\
                    [linecomment "$relName findByIdInstance $idinst $instref"]\
                    [CreateInstRefSymbol $relName $instref]\
                    "$instref = NULL ;\n"\
                    "MRT_InstIterator $iter ;\n"\
                    "for (mrt_InstIteratorStart(&$iter, &$classDesc) ;\
                        mrt_InstIteratorMore(&$iter) ;\
                        mrt_InstIteratorNext(&$iter)) \{\n"\
                ]]
                PushBlock
                append result [IndentToBlock [string cat\
                    [CreateInstRefSymbol $relName $asgnref]\
                    "$asgnref = mrt_InstIteratorGet(&$iter) ;\n"\
                    "if ($asgnref->idinstance == $idinst) \{\n"\
                ]]
            
                PushBlock
                append result [IndentToBlock [string cat\
                    "$instref = $asgnref ;\n"\
                    "break ;\n"\
                ]]
                PopBlock
                append result [IndentToBlock "\}\n"]
                PopBlock
                append result [IndentToBlock "\}\n"]
            
                return $result
            }
            proc MultiAssignerCreate {relName instref idinst} {
                variable domain
            
                set maRef [MultipleAssigner findWhere {$Domain eq $domain &&\
                        $Association eq $relName}]
                set idClass [readAttribute $maRef Class]
                CheckInstRefSymbol $idinst Class $idClass
            
                set assignerClass [GetClassDescriptor $domain $relName]
                append result\
                    [linecomment "$relName create $instref $idinst"]\
                    [CreateInstRefSymbol $relName $instref]\
                    "$instref = mrt_CreateInstance(&$assignerClass, MRT_StateCode_IG) ;\n"\
                    "$instref->idinstance = $idinst ;\n"
            
                return [IndentToBlock $result]
            }
        }
        namespace eval GenHeader {
            ::logger::import -all -force -namespace log micca
        
            namespace import\
                ::ral::relation\
                ::ral::tuple\
                ::ral::relformat\
                ::ralutil::pipe
        
            namespace path {
                ::micca
                ::micca::@Gen@::Helpers
                ::micca::@Config@::Helpers
                ::rosea::InstCmds
            }
        
            proc headerFileGuard {} {
                variable domain
                return [string toupper [string trim $domain]]_H_
            }
            proc interface {} {
                variable interface
            
                return [string cat\
                    [comment "Domain Interface Contents"]\
                    [textutil::adjust::undent [string trim $interface]]\
                ]
            }
            proc interfaceTypeAliases {} {
                variable domain
                append result [comment "Type Aliases"]
                relation foreach taRef [FindInterfaceTypeAliases $domain] {
                    relation assign $taRef TypeName TypeDefinition
                    append result "typedef "\
                        [typeCheck composeDeclaration $TypeDefinition $TypeName] " ;\n"
                }
            
                return $result
            }
            proc domainOpDeclarations {} {
                variable domain
                set result [comment "Domain Operations External Declarations"]
            
                set opRefs [DomainOperation findWhere {$Domain eq $domain}]
                set params [deRef [findRelated $opRefs ~R6]]
                set ops [pipe {
                    deRef $opRefs |
                    relation project ~ Domain Name ReturnDataType Comment |
                    relation rename ~ Name Operation |
                    ralutil::rvajoin ~ $params Parameters
                }]
                # puts [relformat $ops ops]
            
                relation foreach op $ops {
                    relation assign $op
                    if {$Comment ne {}} {
                        append result [comment $Comment]
                    }
                    set plist [relation list $Parameters DataType -ascending Number]
                    set pdecl [expr {[llength $plist] == 0 ? "void" : [join $plist {, }]}]
                    append result "extern $ReturnDataType\
                            ${Domain}_${Operation}\($pdecl\) ;\n" ; # <1>
                }
            
                return $result
            }
            proc externalOpDeclarations {} {
                variable domain
                set result [comment "External Operations Declarations"]
            
                set opRefs [ExternalOperation findWhere {$Domain eq $domain}]
                set params [deRef [findRelated $opRefs ~R11]]
                set ops [pipe {
                    deRef $opRefs |
                    relation project ~ Domain Entity Name ReturnDataType Comment |
                    relation rename ~ Name Operation |
                    ralutil::rvajoin ~ $params Parameters
                }]
                # puts [relformat $ops ops]
            
                relation foreach op $ops {
                    relation assign $op
                    if {$Comment ne {}} {
                        append result [comment [string trim $Comment \n]]
                    }
                    set plist [relation list $Parameters DataType -ascending Number]
                    set pdecl [expr {[llength $plist] == 0 ? "void" : [join $plist {, }]}]
                    append result "extern $ReturnDataType\
                            ${Domain}_${Entity}_${Operation}__EOP\($pdecl\) ;\n" ; # <1>
                }
            
                return $result
            }
            proc eventParamDeclarations {} {
                variable domain
            
                set result [comment "Event Parameter Structure Declarations"]
                set evtparams [pipe {
                    Event findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation join $::micca::ParameterSignature |
                    relation eliminate ~ ASigID |
                    relation join ~ $::micca::Parameter $::micca::Argument |
                    relation project ~ Model Event Name Position DataType |
                    relation group ~ Params Name Position DataType |
                    relation group ~ Events Event Params
                }]
                relation foreach evtparam $evtparams -ascending Model {
                    relation assign $evtparam
                    relation foreach event $Events {
                        relation assign $event
                        set pstructname "struct ${domain}_${Model}_${Event}__EPARAMS"
                        append result "$pstructname \{\n"
                        relation foreach param $Params -ascending Position {
                            relation assign $param DataType Name
                            append result\
                                "    [typeCheck composeDeclaration $DataType $Name] ;\n"
                        }
                        append result "\} ;\n"
                        append result\
                            "#if __STDC_VERSION__ >= 201112L\n"\
                            "static_assert(sizeof($pstructname) <= sizeof(MRT_EventParams), "\
                            "\"Parameters for class or assigner, $Model, event,\
                                $Event, are too large\") ;\n"\
                            "#endif /* __STDC_VERSION__ >= 201112L */\n" ; # <1>
                    }
                }
            
                return $result
            }
            proc portalIds {} {
                variable domain
            
                append result [comment "Numeric encoding of classes, attributes and\
                        instances used by the portal functions"]
                set classRefs [Class findWhere {$Domain eq $domain}]
                append result "#define [string toupper ${domain}_CLASSCOUNT]\
                        [refMultiplicity $classRefs]\n"
                forAllRefs classRef $classRefs {
                    assignAttribute $classRef
                    append result [comment "Class: $Name Attribute Encoding"]
                    set classid [string toupper ${Domain}_${Name}_CLASSID]
                    append result "#define $classid $Number\n"
                    set attrRefs [findRelated $classRef ~R20 {~R25 PopulatedComponent}\
                            {~R21 Attribute}]
                    append result "#define [string toupper ${Domain}_${Name}_ATTRCOUNT]\
                            [refMultiplicity $attrRefs]\n"
                    set attrNumber -1
                    relation foreach attr [deRef $attrRefs] -ascending Name {
                        relation assign $attr {Name attrName}
                        set attrid [string toupper ${Domain}_${Name}_${attrName}_ATTRID]
                        append result "#define $attrid [incr attrNumber]\n"
                    }
                    set instRefs [findRelated $classRef ~R20 ~R103]
                    append result [comment "Class: $Name Instance Encoding"]
                    append result "#define [string toupper ${Domain}_${Name}_INSTCOUNT]\
                            [GetClassProperty $Name TotalInstance]\n"
                    forAllRefs inst $instRefs {
                        assignAttribute $inst Instance {Number InstNumber}
                        set instid [string toupper ${Domain}_${Name}_${Instance}_INSTID]
                        append result "#define $instid $InstNumber\n"
                    }
                }
                set assigners [pipe {
                    AssignerStateModel findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation tag ~ Number -ascending Association
                }]
                relation foreach assigner $assigners {
                    relation assign $assigner
                    append result [comment "Assigner: $Association"]
                    set prefix [string toupper ${Domain}_${Association}]
                    append result\
                        "#define ${prefix}_ASSIGNERID $Number\n"\
                        "#define ${prefix}_INSTCOUNT\
                            [GetClassProperty $Association TotalInstance]\n"
                }
                set mevents [pipe {
                    Event findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation eliminate ~ Domain PSigID |
                    relation group ~ Events Event Number
                }]
                relation foreach mevent $mevents -ascending Model {
                    relation assign $mevent
                    append result [comment "Class: $Model Event Encoding"]
                    append result "#define [string toupper ${domain}_${Model}_EVENTCOUNT]\
                        [relation cardinality $Events]\n"
                    relation foreach event $Events -ascending Number {
                        relation assign $event
                        append result "#define\
                            [string toupper ${domain}_${Model}_${Event}_EVENT] $Number\n"
                    }
                }
                set mstates [pipe {
                    StatePlace findWhere {$Domain eq $domain && $Name ne "@"} |
                    deRef ~ |
                    relation project ~ Model Name Number |
                    relation group ~ States Name Number
                }]
                relation foreach mstate $mstates -ascending Model {
                    relation assign $mstate
                    append result [comment "Class: $Model State Encoding"]
                    append result "#define [string toupper ${domain}_${Model}_STATECOUNT]\
                        [relation cardinality $States]\n"
                    relation foreach state $States -ascending Name {
                        relation assign $state
                        append result "#define\
                            [string toupper ${domain}_${Model}_${Name}_STATE] $Number\n"
                    }
                }
            
                return $result
            }
            proc portalDeclaration {} {
                variable domain
                append result\
                    [comment "Domain Portal Declaration"]\
                    "extern MRT_DomainPortal const ${domain}__PORTAL ;\n"
            }
        }
        namespace eval GenCode {
            ::logger::import -all -force -namespace log micca
        
            namespace import\
                ::ral::relation\
                ::ral::tuple\
                ::ral::relformat\
                ::ralutil::pipe
        
            namespace path {
                ::micca
                ::micca::@Gen@::Helpers
                ::micca::@Config@::Helpers
                ::rosea::InstCmds
            }
        
            namespace import [namespace parent]::expand
            namespace import [namespace parent]::GenSupport::ExpandActivity
        
            proc domainInclude {} {
                variable domain
            
                return "#include \"$domain.h\"\n"
            }
            proc domainNameString {} {
                variable domain
            
                return "\"$domain\""
            }
            proc prologueDeclarations {} {
                variable prologue
            
                return [string cat\
                    [comment "Domain Prologue"]\
                    [textutil::adjust::undent [string trim $prologue \n]]\
                ]
            }
            proc implementationTypeAliases {} {
                variable domain
                set aliases [pipe {
                    Domain findWhere {$Name eq $domain} |
                    findRelated % ~R7 |
                    deRef %
                } {} |%]
            
                set impaliases [relation minus $aliases [FindInterfaceTypeAliases $domain]] ; # <1>
                append result [comment "Type Aliases"]
                relation foreach taRef $impaliases {
                    relation assign $taRef TypeName TypeDefinition
                    append result\
                        "typedef "\
                        [typeCheck composeDeclaration $TypeDefinition $TypeName]\
                        " ;\n"
                }
            
                return $result
            }
            proc forwardClassDeclarations {} {
                variable domain
            
                set classNames [pipe {
                    Class findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation list ~ Name -ascending Number
                }]
                set result [comment "Class structure forward declarations"]
                foreach className $classNames {
                    append result "struct $className ;\n"
                }
            
                return $result
            }
            proc forwardRelationshipDeclaration {} {
                variable domain
                if {[isNotEmptyRef [Relationship findAll]]} {
                    set fwrd "static MRT_Relationship const ${domain}__RSHIPS\[\] ;\n"
                } else {
                    set fwrd {}
                }
                return [string cat\
                    [comment "Relationship descriptors forward declaration"]\
                    $fwrd\
                ]
            }
            proc classDeclarations {} {
                variable domain
            
                set result [comment "Class structure declarations"]
            
                set ultimates [pipe {
                    FindUltimateSuperclasses $domain |
                    findRelated % {~R48 UnionSuperclass}
                } {} |%]
                append result [DeclareUnionSubclassStructures $ultimates]
            
                set remaining [FindNonUnionSubclasses $domain]
                forAllRefs classRef $remaining {
                    append result [DeclareClassStructure $classRef]
                }
            
                return $result
            }
            proc DeclareUnionSubclassStructures {superRefs} {
                if {[isEmptyRef $superRefs]} {
                    return
                }
            
                set subRefs [findRelated $superRefs R44 ~R45]
                forAllRefs subRef $subRefs {
                    set newsupers [pipe {
                        deRef $subRef |
                        relation semijoin ~ $::micca::UnionSuperclass\
                            -using {Domain Domain Class Class} |
                        ::rosea::Helpers::ToRef ::micca::UnionSuperclass ~
                    }] ; # <1>
            
                    append result [DeclareUnionSubclassStructures $newsupers] ; # <2>
            
                    append result [DeclareClassStructure [findRelated $subRef R47 R40 R41]] ; # <3>
                }
            
                return $result
            }
            proc DeclareClassStructure {classRef} {
                assignAttribute $classRef {Name className}
            
                append result\
                    "struct $className \{\n"\
                    "    MRT_Instance base__INST ;\n"
            
                set compRefs [findRelated $classRef ~R20] ; # <1>
            
                set attrRefs [findRelated $compRefs {~R25 PopulatedComponent}\
                    {~R21 Attribute} {~R29 IndependentAttribute} R29] ; # <1>
                forAllRefs attrRef $attrRefs {
                    assignAttribute $attrRef {Name attrName} DataType
                    append result "    [typeCheck composeDeclaration $DataType $attrName] ;\n"
                }
                set refRefs [findRelated $compRefs {~R25 PopulatedComponent} {~R21 Reference}] ; # <1>
                set superRefs [findRelated $refRefs {~R23 SuperclassReference} ~R91\
                        {~R47 ReferringSubclass} R37 ~R36]
                forAllRefs superRef $superRefs {
                    assignAttribute $superRef {Relationship attrName} {Class className}
                    append result "    [GetClassProperty $className Reference]$attrName ;\n"
                }
                set atorRefs [findRelated $refRefs {~R23 AssociatorReference} ~R93 R42]
                forAllRefs atorRef $atorRefs {
                    assignAttribute $atorRef {Name attrName}
                
                    set sourceDecl [pipe {
                        findRelated $atorRef ~R34 |
                        readAttribute % Class |
                        GetClassProperty % Reference
                    } {} |%]
                    set targetDecl [pipe {
                        findRelated $atorRef ~R35 |
                        readAttribute % Class |
                        GetClassProperty % Reference
                    } {} |%]
                
                    append result\
                        "    struct \{\n"\
                        "        ${targetDecl}forward ;\n"\
                        "        ${sourceDecl}backward ;\n"\
                        "    \} $attrName ;\n"
                }
                set assocRefs [findRelated $refRefs {~R23 AssociationReference} ~R90 R32 ~R33]
                forAllRefs assocRef $assocRefs {
                    assignAttribute $assocRef {Relationship attrName} {Class className}
                    append result "    [GetClassProperty $className Reference]$attrName ;\n"
                }
                
                set genRefs [findRelated $compRefs {~R25 GeneratedComponent}] ; # <2>
                set subRefs [findRelated $genRefs {~R24 SubclassReference}]
                forAllRefs subRef $subRefs {
                    assignAttribute $subRef {Name attrName}
                    append result "    void *$attrName ;\n"
                }
                set contRefs [findRelated $genRefs {~R24 SubclassContainer}]
                forAllRefs contRef $contRefs {
                    assignAttribute $contRef {Name attrName}
                
                    set subRefs [findRelated $contRef ~R96 R44 ~R45]
                    append result "    union \{\n"
                    foreach subName [relation list [deRef $subRefs] Class] {
                        append result "        "\
                            "[GetClassProperty $subName Declaration] $subName ;\n"
                    }
                    append result "    \} $attrName ;\n"
                }
                set linkRefs [findRelated $genRefs {~R24 LinkContainer}]
                forAllRefs linkRef $linkRefs {
                    append result "    MRT_LinkRef [readAttribute $linkRef Name] ;\n"
                }
                set complRefs [findRelated $genRefs {~R24 ComplementaryReference}]
                forAllRefs complRef $complRefs {
                    set singRef [findRelated $complRef {~R26 SingularReference} R26]
                    if {[isNotEmptyRef $singRef]} {
                        set attrName [readAttribute $singRef Name]
                        set refedClass [FindReferencedClass $singRef]
                        append result\
                            "    [GetClassProperty $refedClass Reference]$attrName ;\n"
                        continue
                    }
                
                    set arrayRef [findRelated $complRef {~R26 ArrayReference} R26]
                    if {[isNotEmptyRef $arrayRef]} {
                        set attrName [readAttribute $arrayRef Name]
                        set classref [GetClassProperty [FindReferencedClass $arrayRef] Reference]
                        append result\
                            "    struct \{\n"\
                            "        ${classref}const *links ;\n"\
                            "        unsigned count ;\n"\
                            "    \} $attrName ;\n"
                        continue
                    }
                
                    set linkRef [findRelated $complRef {~R26 LinkReference} R26]
                    if {[isNotEmptyRef $linkRef]} {
                        set attrName [readAttribute $linkRef Name]
                        append result "    MRT_LinkRef $attrName ;\n"
                        continue
                    }
                }
            
                append result "\} ;\n"
            }
            proc assignerDeclarations {} {
                variable domain
            
                append result [comment "Single Assigner Structure Declarations"]
            
                set singles [SingleAssigner findWhere {$Domain eq $domain}]
                forAllRefs assigner $singles {
                    assignAttribute $assigner
                    append result\
                        "struct $Association \{\n"\
                        "    MRT_Instance base__INST ;\n"\
                        "\} ;\n"
                }
            
                append result [comment "Multiple Assigner Structure Declarations"]
            
                set multis [MultipleAssigner findWhere {$Domain eq $domain}]
                forAllRefs assigner $multis {
                    assignAttribute $assigner
                    append result\
                        "struct $Association \{\n"\
                        "    MRT_Instance base__INST ;\n"\
                        "    [GetClassProperty $Class Reference] idinstance ;\n"\
                        "\} ;\n"
                }
            
                return $result
            }
            proc stateParamDeclarations {} {
                variable domain
                set result [comment "State Parameter Structure Declarations"]
            
                set stateargs [pipe {
                    State findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation rename ~ Name State |
                    relation join $::micca::ParameterSignature $::micca::Parameter\
                            $::micca::Argument |
                    relation project ~ Model State Name Position DataType |
                    relation group ~ Params Name Position DataType
                }]
            
                relation foreach statearg $stateargs -ascending {Model State} {
                    relation assign $statearg
                    set pstructname "struct ${Model}_${State}__SPARAMS"
                    append result "$pstructname \{\n"
                    relation foreach param $Params -ascending Position {
                        relation assign $param DataType Name
                        append result\
                            "    [typeCheck composeDeclaration $DataType $Name] ;\n"
                    }
                    append result "\} ;\n"
                    append result\
                        "#if __STDC_VERSION__ >= 201112L\n"\
                        "static_assert(sizeof($pstructname) <= sizeof(MRT_EventParams), "\
                        "\"Parameters for class or assigner, $Model, state,\
                            $State, are too large\") ;\n"\
                        "#endif /* __STDC_VERSION__ >= 201112L */\n"
                }
            
                return $result
            }
            proc operationDeclarations {} {
                variable domain
                set result [comment "Operation Forward Declarations"]
            
                set ops [pipe {
                    Operation findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation rename ~ Name Operation |
                    ralutil::rvajoin ~ $::micca::OperationParameter Parameters
                }]
            
                relation foreach op $ops {
                    relation assign $op
                    append result\
                        "static $ReturnDataType ${Class}_$Operation\("
            
                    if {[relation isempty $Parameters]} {
                        append result void
                    } else {
                        append result [join\
                            [relation list $Parameters DataType -ascending Number] {, }]
                    }
            
                    append result "\) ;\n"
                }
            
                return $result
            }
            proc ctorDeclarations {} {
                variable domain
                set result [comment "Class Constructor Forward Declarations"]
            
                set ctors [Constructor findWhere {$Domain eq $domain}]
                forAllRefs ctor $ctors {
                    assignAttribute $ctor {Class className}
                    append result\
                        "static void ${className}__CTOR\(void *const) ;\n"
                }
            
                return $result
            }
            proc dtorDeclarations {} {
                variable domain
                set result [comment "Class Destructor Forward Declarations"]
            
                set dtors [Destructor findWhere {$Domain eq $domain}]
                forAllRefs dtor $dtors {
                    assignAttribute $dtor {Class className}
                    append result\
                        "static void ${className}__DTOR\(void *const) ;\n"
                }
            
                return $result
            }
            proc formulaDeclarations {} {
                variable domain
                set result [comment "Dependent Attribute Formula Forward Declarations"]
            
                set deps [DependentAttribute findWhere {$Domain eq $domain}]
                forAllRefs dep $deps {
                    assignAttribute $dep {Class className} {Name attrName}
                    append result\
                        "static void ${className}_${attrName}__FORMULA\(void const *const,\
                            void *const, MRT_AttrSize) ;\n"
                }
            
                return $result
            }
            proc activityDeclarations {} {
                variable domain
                set result [comment "State Activities Forward Declarations"]
            
                set classes [pipe {
                    State findWhere {$Domain eq $domain && [string trim $Activity] ne {}} |
                    deRef ~ |
                    relation eliminate ~ Domain Activity File Line IsFinal PSigID |
                    relation group ~ States Name
                }]
            
                relation foreach class $classes -ascending Model {
                    relation assign $class
                    relation foreach state $States {
                        relation assign $state
                        append result "static void ${Model}_${Name}__ACTIVITY\("\
                            "void *const s__SELF, "\
                            "void const *const p__PARAMS) ;\n"
                    }
                }
            
                return $result
            }
            proc storageDeclarations {} {
                variable domain
                set result [comment "Class Instance Storage Forward Declarations"]
            
                set cpops [pipe {
                    FindNonUnionSubclasses $domain |
                    findRelated % R104 {~R101 ElementPopulation} {~R105 ClassPopulation}
                } {} |%]
            
                forAllRefs cpop $cpops {
                    assignAttribute $cpop {Class className}
                    set var [GetClassProperty $className StorageVariable]
                    set totalinsts [GetClassProperty $className TotalInstance]
                    append result "static struct $className $var \[$totalinsts\] ;\n"
                }
            
                set singles [SingleAssigner findWhere {$Domain eq $domain}]
                forAllRefs single $singles {
                    assignAttribute $single Association
                    set var [GetClassProperty $Association StorageVariable]
                    set totalinsts [GetClassProperty $Association TotalInstance]
                    append result "static struct ${Association} $var\[$totalinsts\] ;\n"
                }
            
                set multis [MultipleAssigner findWhere {$Domain eq $domain}]
                forAllRefs multi $multis {
                    assignAttribute $multi Association
                    set var [GetClassProperty $Association StorageVariable]
                    set totalinsts [GetClassProperty $Association TotalInstance]
                    append result "static struct ${Association} $var\[$totalinsts\] ;\n"
                }
            
                return $result
            }
            proc nameDefinitions {} {
                variable domain
                append result\
                    [comment "Domain Naming Definitions"]\
                    "#ifndef MRT_NO_NAMES\n"
            
                set storageType "static char const"
            
                set classRefs [Class findWhere {$Domain eq $domain}]
                forAllRefs classRef $classRefs {
                    set className [readAttribute $classRef Name]
                    append result "$storageType ${className}__NAME\[\] = \"$className\" ;\n"
                }
            
                set relRefs [Relationship findWhere {$Domain eq $domain}]
                forAllRefs relRef $relRefs {
                    set relName [readAttribute $relRef Name]
                    append result "$storageType ${relName}__NAME\[\] = \"$relName\" ;\n"
                }
            
                set stateRefs [StatePlace findWhere {$Domain eq $domain}]
                forAllRefs stateRef $stateRefs {
                    assignAttribute $stateRef {Model modelName} {Name stateName}
                    set namevar [expr {$stateName eq "@" ? "AT" : $stateName}]
                    append result "$storageType ${modelName}_${namevar}__SNAME\[\] =\
                            \"$stateName\" ;\n"
                }
            
                set eventRefs [Event findWhere {$Domain eq $domain}]
                forAllRefs eventRef $eventRefs {
                    assignAttribute $eventRef {Model modelName} {Event eventName}
                    append result "$storageType ${modelName}_${eventName}__ENAME\[\] =\
                            \"$eventName\" ;\n"
                }
            
                set saRefs [SingleAssigner findWhere {$Domain eq $domain}]
                if {[isNotEmptyRef $saRefs]} {
                    append result "$storageType single_assigner_instance__NAME\[\] =\
                            \"assigner\" ;\n"
                }
            
                set maRefs [MultipleAssigner findWhere {$Domain eq $domain}]
                if {[isNotEmptyRef $maRefs]} {
                    append result "$storageType multi_assigner_attribute__NAME\[\] =\
                            \"idinstance\" ;\n"
                }
            
                append result "#endif /* MRT_NO_NAMES */\n"
            
                return $result
            }
            proc iabDefinitions {} {
                variable domain
                set result [comment "Instance Allocation Block Definitions"]
            
                forAllRefs classRef [FindNonUnionSubclasses $domain] {
                    append result [DefineIABMembers $classRef false]
                }
            
                set unionRefs [pipe {
                    UnionSubclass findWhere {$Domain eq $domain} |
                    findRelated ~ R47 R40 R41
                }]
                forAllRefs classRef $unionRefs {
                    append result [DefineIABMembers $classRef true]
                }
            
                set singles [SingleAssigner findWhere {$Domain eq $domain}]
                forAllRefs single $singles {
                    assignAttribute $single Association
                    append result\
                        "static MRT_iab ${Association}__IAB = \{\n"\
                        "    .storageStart = &${Association}__POOL\[0\],\n"\
                        "    .storageFinish = &${Association}__POOL\[1\],\n"\
                        "    .storageLast = &${Association}__POOL\[0\],\n"\
                        "    .alloc = 1,\n"\
                        "    .instanceSize = sizeof\(struct ${Association}\),\n"\
                        "    .construct = NULL,\n"\
                        "    .destruct = NULL,\n"\
                        "    .linkCount = 0,\n"\
                        "    .linkOffsets = NULL\n"\
                        "\} ;\n"
                }
            
                set multis [MultipleAssigner findWhere {$Domain eq $domain}]
                forAllRefs multi $multis {
                    set initial [refMultiplicity [findRelated $multi ~R106]]
                    assignAttribute $multi Association {Class idclass}
                    set total [GetClassProperty $idclass TotalInstance]
            
                    append result\
                        "static MRT_iab ${Association}__IAB = \{\n"\
                        "    .storageStart = &${Association}__POOL\[0\],\n"\
                        "    .storageFinish = &${Association}__POOL\[$total\],\n"\
                        "    .storageLast = &${Association}__POOL\[[expr {$total - 1}]\],\n"\
                        "    .alloc = $initial,\n"\
                        "    .instanceSize = sizeof\(struct ${Association}\),\n"\
                        "    .construct = NULL,\n"\
                        "    .destruct = NULL,\n"\
                        "    .linkCount = 0,\n"\
                        "    .linkOffsets = NULL\n"\
                        "\} ;\n"
                }
            
                return $result
            }
            proc edbDefinitions {} {
                variable domain
                set result [comment "Event Dispatch Block Definitions"]
            
                upvar #0 ::micca::@Gen@::options options
            
                forAllRefs smodel [StateModel findWhere {$Domain eq $domain}] {
                    assignAttribute $smodel {Model className}
            
                    append result [GenerateTransitionTable $smodel]
                    append result [GenerateActivityTable $smodel]
                    set finalstates [GenerateFinalStates $smodel result]
            
                    append result [GenerateStateNames $smodel]
            
                    append result "static MRT_edb const ${className}__EDB = \{\n"
            
                    set stateRefs [findRelated $smodel ~R55]
                    set cstateRef [findRelated $smodel ~R56]
                    append result\
                        "    .stateCount = [expr {[refMultiplicity $stateRefs] +\
                            [refMultiplicity $cstateRef]}],\n"
            
                    set eventRefs [findRelated $smodel ~R87]
                    append result\
                        "    .eventCount = [refMultiplicity $eventRefs],\n"\
                        "    .initialState = [readAttribute [findRelated $smodel R58 R57]\
                                    Number],\n"
                    set crstate [expr {[isNotEmptyRef $cstateRef] ?\
                        [readAttribute [findRelated $cstateRef R57] Number] :\
                        "MRT_StateCode_IG"}]
                    append result\
                        "    .creationState = $crstate,\n"\
                        "    .transitionTable = ${className}__TTAB,\n"\
                        "    .activityTable = ${className}__ATAB,\n"\
                        "    .finalStates = $finalstates,\n"
            
                    append result\
                        "        #ifndef MRT_NO_NAMES\n"\
                        "    .stateNames = ${className}__SNAMES,\n"\
                        "        #endif /* MRT_NO_NAMES */\n"
            
                    append result\
                        "\} ;\n"
                }
            
                return $result
            }
            proc GenerateTransitionTable {smodelref} {
                variable domain
                assignAttribute $smodelref {Model className}
            
                set tplaces [pipe {
                    TransitionPlace findWhere {$Domain eq $domain && $Model eq $className} |
                    deRef ~
                }]
                # puts [relformat $tplaces tplaces]
                
                set statetrans [pipe {
                    relation join $tplaces $::micca::StateTransition |
                    relation eliminate ~ ASigID |
                    relation join ~ $::micca::StatePlace\
                        -using {Domain Domain Model Model NewState Name} |
                    relation extend ~ stup\
                        NewStateNumber string {[tuple extract $stup Number]} |
                    relation eliminate ~ Number
                }] ; # <1>
                # puts [relformat $statetrans statetrans]
                
                set nontrans [pipe {
                    relation join $tplaces $::micca::NonStateTransition |
                    relation extend ~ ntup\
                        NewState string {[tuple extract $ntup TransRule]}\
                        NewStateNumber string {"MRT_StateCode_[tuple extract $ntup TransRule]"} |
                    relation eliminate ~ TransRule
                }] ; # <2>
                # puts [relformat $nontrans nontrans]
                set smodel [deRef $smodelref]
                set srcstates [pipe {
                    relation semijoin $smodel $::micca::StatePlace |
                    relation eliminate ~ Number |
                    relation rename ~ Name State
                }] ; # <1>
                # puts [relformat $srcstates srcstates]
                
                set events [pipe {
                    findRelated $smodelref ~R87 |
                    deRef %
                } {} |%]
                # puts [relformat $events events]
                
                set defrule [readAttribute $smodelref DefaultTrans]
                # puts "defrule = \"$defrule\""
                
                set deftrans [pipe {
                    relation join $srcstates $events |
                    relation minus ~ $tplaces |
                    relation extend ~ dtup NewState string {$defrule} |
                    relation update ~ ftup {[tuple extract $ftup State] eq "@"}\
                        {tuple update $ftup NewState CH} |
                    relation extend ~ ttup\
                        NewStateNumber string {"MRT_StateCode_[tuple extract $ttup NewState]"}
                }] ; # <2>
                # puts [relformat $deftrans deftrans]
                set transmatrix [pipe {
                    relation union $statetrans $nontrans $deftrans |
                    relation join ~ $::micca::StatePlace\
                        -using {Domain Domain Model Model State Name} |
                    relation rename ~ Number StateNumber |
                    relation join ~ $::micca::Event |
                    relation eliminate ~ PSigID |
                    relation rename ~ Number EventNumber |
                    relation eliminate ~ Domain Model
                }]
                # puts [relformat $transmatrix transmatrix]
            
                set result "static MRT_StateCode const ${className}__TTAB\[\] = \{\n"
                relation foreach transition $transmatrix -ascending {StateNumber EventNumber} {
                    relation assign $transition
                    append result "    $NewStateNumber, // $State - $Event -> $NewState\n"
                } ; # <1>
                append result "\} ;\n"
            
                return $result
            }
            proc GenerateActivityTable {smodel} {
                variable domain
                assignAttribute $smodel {Model className}
            
                set result "static MRT_PtrActivityFunction const ${className}__ATAB\[\] = \{\n"
            
                set places [pipe {
                    StatePlace findWhere {$Domain eq $domain && $Model eq $className} |
                    deRef ~
                }]
                relation foreach place $places -ascending Number {
                    set state [relation semijoin $place $::micca::State]
                    if {[relation isnotempty $state]} {
                        relation assign $state Name Activity
                        if {[string trim $Activity] eq {}} {
                            append result "    NULL, // $Name\n"
                        } else {
                            append result "    ${className}_${Name}__ACTIVITY, // $Name\n"
                        }
                    } else {
                        set cstate [relation semijoin $place $::micca::CreationState]
                        if {[relation isnotempty $cstate]} {
                            append result "    NULL, // [relation extract $cstate Name]\n"
                        }
                    }
                }
            
                append result "\} ;\n"
            }
            proc GenerateFinalStates {smodel resultVar} {
                set tstates [findRelatedWhere $smodel ~R55 {$IsFinal}]
                if {[isEmptyRef $tstates]} {
                    return NULL
                }
                upvar 1 $resultVar result
                variable domain
                assignAttribute $smodel {Model className}
                set places [pipe {
                    StatePlace findWhere {$Domain eq $domain && $Model eq $className} |
                    deRef ~
                }]
            
                append result "static bool const ${className}__TSTATES\[\] = \{\n"
                relation foreach place $places -ascending Number {
                    set state [relation semijoin $place $::micca::State]
                    if {[relation isnotempty $state]} {
                        relation assign $state Name IsFinal
                        append result "    "\
                            [expr {$IsFinal ? "true" : "false"}]\
                            ", // $Name\n"
                    } else {
                        set cstate [relation semijoin $place $::micca::CreationState]
                        if {[relation isnotempty $cstate]} {
                            append result "    false, // [relation extract $cstate Name]\n"
                        }
                    }
                }
            
                append result "\} ;\n"
                return ${className}__TSTATES
            }
            proc GenerateStateNames {smodel} {
                variable domain
                assignAttribute $smodel {Model className}
            
                set states [pipe {
                    StatePlace findWhere {$Domain eq $domain && $Model eq $className} |
                    deRef ~
                }]
            
                append result\
                    "#ifndef MRT_NO_NAMES\n"\
                    "static char const * const ${className}__SNAMES\[\] = \{\n"
            
                relation foreach state $states -ascending Number {
                    relation assign $state Name
                    set Name [string map {@ AT} $Name]
                    append result "    ${className}_${Name}__SNAME,\n"
                }
            
                append result\
                    "\} ;\n"\
                    "#endif /* MRT_NO_NAMES */\n"
            
                return $result
            }
            proc pdbDefinitions {} {
                variable domain
            
                set rnames {}
                set pmaps {}
                set gdbs {}
                set pdbs {}
            
                set deRefs [DeferredEvent findWhere {$Domain eq $domain}]
                set superRefs [findRelated $deRefs ~R86]
                if {[isEmptyRef $superRefs]} {
                    return
                }
            
                set deferred [pipe {
                    findRelated $superRefs {R86 DeferralPath} |
                    deRef ~ |
                    relation join ~ $::micca::DeferredEvent $::micca::Event |
                    relation eliminate ~ Domain Role PSigID |
                    relation rename ~ Model Superclass Number SuperNumber
                }]
                # puts [relformat $deferred deferred]
            
                set nonlocals [pipe {
                    NonLocalEvent findWhere {$Domain eq $domain} |
                    deRef % |
                    relation join % $::micca::Relationship\
                        -using {Domain Domain Relationship Name} |
                    relation rename % Number RelNumber
                } {} |%]
                # puts [relformat $nonlocals nonlocals]
            
                set polys [relation join $nonlocals\
                        $::micca::DeferredEvent $::micca::Event]
                # puts [relformat $polys polys]
            
                set trans [relation join $nonlocals\
                        $::micca::TransitioningEvent $::micca::Event]
                # puts [relformat $trans trans]
            
                set supers [pipe {
                    relation union $polys $trans |
                    relation eliminate ~ Domain Role PSigID |
                    relation join ~ $deferred |
                    relation group ~ EventMap Event SuperNumber Number |
                    relation group ~ SubMap Model EventMap |
                    relation group ~ Generalizations Relationship RelNumber SubMap
                }]
                # puts [relformat $supers supers]
            
                relation foreach super $supers {
                    relation assign $super
            
                    set gdbvar ${Superclass}__GDBS
                    append gdbs "static MRT_gdb $gdbvar\[\] = \{\n"
            
                    set rnamesvar ${Superclass}__RNAMES
                    append rnames "static char const *const $rnamesvar\[\] = \{\n"
            
                    relation foreach gen $Generalizations -ascending Relationship {
                        relation assign $gen
            
                        append rnames "    ${Relationship}__NAME,\n"
            
                        set pmapvar ${Superclass}_${Relationship}__PMAP
                        append pmaps "static MRT_EventCode const $pmapvar\[\] = \{\n"
            
                        relation foreach submap $SubMap -ascending Model {
                            relation assign $submap
                            relation foreach eventmap $EventMap -ascending Number {
                                relation assign $eventmap
                                append pmaps "    $Number, // $Event for $Model\n"
                            }
                        }
                        append pmaps "\} ;\n"
            
                        append gdbs\
                            "    \{\n"\
                            "        .relship = &${domain}__RSHIPS\[$RelNumber\],\n"\
                            "        .eventMap = $pmapvar,\n"\
                            "    \},\n"
                    }
                    append rnames "\} ;\n"
                    append gdbs "\} ;\n"
            
                    append pdbs\
                        "static MRT_pdb const ${Superclass}__PDB = \{\n"\
                        "    .eventCount = [relation cardinality $EventMap],\n"\
                        "    .genCount = [relation cardinality $Generalizations],\n"\
                        "    .genDispatch = $gdbvar,\n"\
                        "        #ifndef MRT_NO_NAMES\n"\
                        "    .genNames = $rnamesvar,\n"\
                        "        #endif /* MRT_NO_NAMES */\n"\
                        "\} ;\n"
                }
            
            
                append result\
                    [comment "Polymorphic Event Dispatch Block Definitions"]\
                    "#ifndef MRT_NO_NAMES\n"\
                    $rnames\
                    "#endif /* MRT_NO_NAMES */\n"\
                    $pmaps $gdbs $pdbs
            
                return $result
            }
            proc classDefinitions {} {
                variable domain
                set front [comment "Class Description Definitions"]
            
                set classRefs [Class findWhere {$Domain eq $domain}]
            
                set classinrel [pipe {
                    findRelated $classRefs {~R41 ClassRole} |
                    deRef % |
                    relation eliminate % Role
                } {} |%]
                set assocrels [pipe {
                    relation join $classinrel $::micca::Association -using\
                        {Domain Domain Relationship Name} |
                    relation eliminate ~ IsStatic
                }]
                set genrels [relation join $classinrel $::micca::Generalization\
                        -using {Domain Domain Relationship Name}]
            
                set rels [pipe {
                    relation union $assocrels $genrels |
                    relation join ~ $::micca::Relationship\
                        -using {Domain Domain Relationship Name} |
                    relation rename ~ Class Name Number RelNumber
                }]
                # puts [relformat $rels rels]
            
                set attrs [pipe {
                    findRelated $classRefs ~R20 {~R25 PopulatedComponent} {~R21 Attribute} |
                    deRef % |
                    ralutil::rvajoin % $::micca::IndependentAttribute Indep |
                    ralutil::rvajoin % $::micca::DependentAttribute Dep |
                    relation rename % Name Attribute Class Name
                } {} |%]
                # puts [relformat $attrs attrs]
            
                set usubs [pipe {
                    findRelated $classRefs {~R41 ClassRole} {~R40 Subclass}\
                        {~R47 UnionSubclass} |
                    deRef % |
                    relation join % $::micca::Relationship\
                        -using {Domain Domain Relationship Name} |
                    relation rename % Class Name Number SuperNumber |
                    relation eliminate % Role Relationship
                } {} |%]
                # puts [relformat $usubs usubs]
            
                set allevents [pipe {
                    Event findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation rename ~ Model Name Number EvtNumber |
                    relation eliminate ~ PSigID
                }]
                # puts [relformat $allevents allevents]
            
                set classes [pipe {
                    deRef $classRefs |
                    relation extend ~ ctup IAB string {"&[tuple extract $ctup Name]__IAB"} |
                    ralutil::rvajoin ~ $allevents AEvents |
                    ralutil::rvajoin ~\
                        [relation rename $::micca::TransitioningEvent Model Name] TEvents |
                    ralutil::rvajoin ~\
                        [relation rename $::micca::DeferredEvent Model Name] PEvents |
                    relation extend ~ etup\
                        EDB string {
                            [relation isempty [tuple extract $etup TEvents]] ?\
                            "NULL" : "&[tuple extract $etup Name]__EDB"}\
                        PDB string {
                            [relation isempty [tuple extract $etup PEvents]] ?\
                            "NULL" : "&[tuple extract $etup Name]__PDB"}\
                        eventNames string {
                            [relation isempty [tuple extract $etup AEvents]] ? "NULL" :\
                            "[tuple extract $etup Name]__ENAMES"} |
                    relation eliminate ~ TEvents PEvents |
                    ralutil::rvajoin ~ $rels Relationships |
                    relation extend ~ rtup\
                        relCount int {
                            [relation cardinality [tuple extract $rtup Relationships]]}\
                        classRels string {
                            [relation cardinality [tuple extract $rtup Relationships]] == 0 ?\
                            "NULL" : "[tuple extract $rtup Name]__CRELS"} |
                    ralutil::rvajoin ~ $attrs Attributes |
                    relation extend ~ atup\
                        attrCount int {
                            [relation cardinality [tuple extract $atup Attributes]]}\
                        classAttrs string {
                            [relation isempty [tuple extract $atup Attributes]] ?\
                            "NULL" : "[tuple extract $atup Name]__CATTRS"} |
                    ralutil::rvajoin ~ $usubs UnionSubs |
                    relation extend ~ utup\
                        containment string {
                            [relation isempty [tuple extract $utup UnionSubs]] ?\
                            "NULL" :\
                            "&${domain}__RSHIPS\[[relation extract\
                                [tuple extract $utup UnionSubs]\
                                SuperNumber]\].relInfo.unionGeneralization.superclass"} |
                    relation eliminate ~ Domain
            
                }]
                # puts [relformat $classes classes]
            
                append result "static MRT_Class const\
                        ${domain}__CLASSES\[[relation cardinality $classes]\] = \{\n"
            
                set relrefs {}
                set attrrefs {}
                set namerefs "#ifndef MRT_NO_NAMES\n"
                relation foreach class $classes -ascending Number {
                    relation assign $class
            
                    if {[relation isnotempty $Relationships]} {
                        append relrefs\
                            "static MRT_Relationship const *const\
                                ${Name}__CRELS\[\] = \{\n"
            
                        relation foreach rel $Relationships {
                            relation assign $rel
                            append relrefs\
                                "    &${domain}__RSHIPS\[$RelNumber\], // $Relationship\n"
                        }
            
                        append relrefs "\} ;\n"
                    }
            
                    if {[relation isnotempty $Attributes]} {
                        append attrrefs\
                            "static MRT_Attribute const ${Name}__CATTRS\["\
                            [relation cardinality $Attributes]\
                            "\] = \{\n"
            
                        relation foreach attr $Attributes -ascending Attribute {
                            relation assign $attr
                            append attrrefs\
                                "    \{\n"\
                                "        .size = sizeof($DataType),\n"
                            if {[relation isnotempty $Indep]} {
                                set offset "offsetof([GetClassProperty $Name Declaration],\
                                        $Attribute)"
                                append attrrefs\
                                    "        .type = mrtIndependentAttr,\n"\
                                    "        .access.offset = $offset,\n"
                            } else {
                                set formfunc "${Name}_${Attribute}__FORMULA"
                                append attrrefs\
                                    "        .type = mrtDependentAttr,\n"\
                                    "        .access.formula = $formfunc,\n"
                            }
                            append attrrefs\
                                "            #ifndef MRT_NO_NAMES\n"\
                                "        .name = \"$Attribute\"\n"\
                                "            #endif /* MRT_NO_NAMES */\n"\
                                "    \},\n"
                        }
            
                        append attrrefs "\} ;\n"
                    }
            
                    if {[relation isnotempty $AEvents]} {
                        append namerefs\
                            "static char const *const ${Name}__ENAMES\["\
                            [relation cardinality $AEvents]\
                            "\] = \{\n"
            
                        relation foreach event $AEvents -ascending EvtNumber {
                            relation assign $event {Event eventName}
                            append namerefs "    ${Name}_${eventName}__ENAME,\n"
                        }
            
                        append namerefs "\} ;\n"
                    }
            
                    append result\
                        "    \{ // $Name\n"\
                        "        .iab = $IAB,\n"\
                        "        .eventCount = [relation cardinality $AEvents],\n"\
                        "        .edb = $EDB,\n"\
                        "        .pdb = $PDB,\n"\
                        "        .relCount = $relCount,\n"\
                        "        .classRels = $classRels,\n"\
                        "        .attrCount = $attrCount,\n"\
                        "        .classAttrs = $classAttrs,\n"\
                        "        .instCount = [GetClassProperty $Name TotalInstance],\n"\
                        "        .containment = $containment,\n"\
                        "            #ifndef MRT_NO_NAMES\n"\
                        "        .name = ${Name}__NAME,\n"\
                        "        .eventNames = $eventNames,\n"\
                        "            #endif /* MRT_NO_NAMES */\n"\
                        "    \},\n"
                }
                append namerefs "#endif /* MRT_NO_NAMES */\n"
            
                append result "\} ;\n"
            
                return [string cat $front $namerefs $relrefs $attrrefs $result]
            }
            proc assignerDefinitions {} {
                variable domain
            
                append result [comment "Assigner Class Description Definitions"]
            
                set events [pipe {
                    TransitioningEvent findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation join ~ $::micca::Event |
                    relation eliminate ~ PSigID |
                    relation rename ~ Model Association
                }]
                set assigners [pipe {
                    AssignerStateModel findWhere {$Domain eq $domain} |
                    deRef ~ |
                    ralutil::rvajoin ~ $::micca::SingleAssigner Single |
                    ralutil::rvajoin ~ $::micca::MultipleAssigner Multiple |
                    relation join ~ $events |
                    relation group ~ Events Event Number
                }]
            
                set result {}
                set attrResult {}
                set enameResult {}
                if {[relation isnotempty $assigners]} {
                    append enameResult "#ifndef MRT_NO_NAMES\n"
            
                    set nassign [relation cardinality $assigners]
                    append result\
                        "static MRT_Class const ${domain}__ASSIGNERS\[$nassign\]= \{\n"\
            
                    relation foreach assigner $assigners -ascending Association {
                        relation assign $assigner
            
                        append enameResult\
                            "static char const *const ${Association}__ENAMES\["\
                            [relation cardinality $Events]\
                            "\] = \{\n"
            
                        relation foreach event $Events -ascending Number {
                            relation assign $event {Event eventName}
                            append enameResult "    ${Association}_${eventName}__ENAME,\n"
                        }
            
                        append enameResult "\} ;\n"
            
                        append result\
                            "    \{ // $Association\n"\
                            "        .iab = &${Association}__IAB,\n"\
                            "        .eventCount = [relation cardinality $Events],\n"\
                            "        .edb = &${Association}__EDB,\n"\
                            "        .pdb = NULL,\n"
                        if {[relation isnotempty $Single]} {
                            append result\
                                "        .attrCount = 0,\n"\
                                "        .classAttrs = NULL,\n"\
                        } else {
                            relation assign $Multiple
                            append attrResult\
                                "static MRT_Attribute const ${Association}__CATTRS\[1\] = \{\n"\
                                "    \{\n"\
                                "        .size = sizeof([GetClassProperty $Class Reference]),\n"\
                                "        .type = mrtIndependentAttr,\n"\
                                "        .access.offset = offsetof(struct $Association,\
                                            idinstance),\n"\
                                "            #ifndef MRT_NO_NAMES\n"\
                                "        .name = multi_assigner_attribute__NAME\n"\
                                "            #endif /* MRT_NO_NAMES */\n"\
                                "    \}\n"\
                                "\} ;\n"
                            append result\
                                "        .attrCount = 1,\n"\
                                "        .classAttrs = ${Association}__CATTRS,\n"\
                        }
                        set ninst [GetClassProperty $Association TotalInstance]
                        append result\
                            "        .instCount = $ninst,\n"\
                            "        .relCount = 0,\n"\
                            "        .classRels = NULL,\n"\
                            "        .containment = NULL,\n"\
                            "            #ifndef MRT_NO_NAMES\n"\
                            "        .name = ${Association}__NAME,\n"\
                            "        .eventNames = ${Association}__ENAMES,\n"\
                            "            #endif /* MRT_NO_NAMES */\n"\
                            "    \},\n"
                    }
                    append enameResult "#endif /* MRT_NO_NAMES */\n"
            
                    append result "\} ;\n"
                }
            
                return [string cat $enameResult $attrResult $result]
            }
            proc relationshipDefinitions {} {
                variable domain
                set subroles {}
            
                set relRefs [Relationship findWhere {$Domain eq $domain}]
                if {[isEmptyRef $relRefs]} {
                    return
                }
                append result "static MRT_Relationship const\
                    ${domain}__RSHIPS\[[refMultiplicity $relRefs]\] = \{\n"
            
                set indent [string repeat { } 4]
                set indent2 [string repeat $indent 2]
                set indent3 [string repeat $indent 3]
                set indent4 [string repeat $indent 4]
            
                forAllRefs relRef $relRefs {
                    assignAttribute $relRef {Name relName} Number
                    append result "$indent\[$Number\] = \{ // $relName\n"
            
                    set typeRef [findRelated $relRef {~R30 Association} {~R31 SimpleAssociation}]
                    if {[isNotEmptyRef $typeRef]} {
                        set sourceRef [findRelated $typeRef ~R32]
                        assignAttribute $sourceRef {Class sClass} {Conditionality sCond}\
                            {Multiplicity sMult}
                        set sNum [readAttribute [findRelated $sourceRef R40 R41] Number]
                    
                        set targetRef [findRelated $typeRef ~R33]
                        assignAttribute $targetRef {Class tClass}
                        set tNum [readAttribute [findRelated $targetRef R38 R40 R41] Number]
                    
                        set tCond false
                        set tMult false
                        set stype mrtSingular
                        set slink 0
                    
                        set tcomp [findRelated $targetRef R38 R94 R28]
                        lassign [FindRelOffsets $tcomp] ttype tlink
                    
                        set sstore "offsetof([GetClassProperty $sClass Declaration],\
                                $relName)"
                        set tstore "offsetof([GetClassProperty $tClass Declaration],\
                                [readAttribute $tcomp Name])"
                    
                        append result\
                            "$indent2.relType = mrtSimpleAssoc,\n"\
                            "$indent2.relInfo.simpleAssociation = \{\n"
                    
                        append result\
                            "$indent3.source = \{\n"\
                            "$indent4.classDesc = &${domain}__CLASSES\[$sNum\], // $sClass\n"\
                            "$indent4.cardinality = [MapToCardinality $tCond $tMult],\n"\
                            "$indent4.storageType = $stype,\n"\
                            "$indent4.storageOffset = $sstore,\n"\
                            "$indent4.linkOffset = $slink\n"\
                            "$indent3\},\n"
                    
                        append result\
                            "$indent3.target = \{\n"\
                            "$indent4.classDesc = &${domain}__CLASSES\[$tNum\], // $tClass\n"\
                            "$indent4.cardinality = [MapToCardinality $sCond $sMult],\n"\
                            "$indent4.storageType = $ttype,\n"\
                            "$indent4.storageOffset = $tstore,\n"\
                            "$indent4.linkOffset = $tlink\n"\
                            "$indent3\}\n"
                    
                        append result\
                            "$indent2\},\n"\
                            "${indent3}#ifndef MRT_NO_NAMES\n"\
                            "$indent2.name = ${relName}__NAME\n"\
                            "${indent3}#endif /* MRT_NO_NAMES */\n"\
                            "$indent\},\n"
                        continue
                    }
                    set typeRef [findRelated $relRef\
                            {~R30 Association} {~R31 ClassBasedAssociation}]
                    if {[isNotEmptyRef $typeRef]} {
                        set sourceRef [findRelated $typeRef ~R34]
                        assignAttribute $sourceRef {Class sClass} {Conditionality sCond}\
                            {Multiplicity sMult}
                        set sNum [readAttribute [findRelated $sourceRef R40 R41] Number]
                    
                        set targetRef [findRelated $typeRef ~R35]
                        assignAttribute $targetRef {Class tClass} {Conditionality tCond}\
                            {Multiplicity tMult}
                        set tNum [readAttribute [findRelated $targetRef R38 R40 R41] Number]
                    
                        set asstorRef [findRelated $typeRef ~R42]
                        assignAttribute $asstorRef {Class aClass} {Multiplicity aMult}
                        set aNum [readAttribute [findRelated $asstorRef R40 R41] Number]
                    
                        set scomp [findRelated $sourceRef R95 R28]
                        lassign [FindRelOffsets $scomp] stype slink
                    
                        set tcomp [findRelated $targetRef R38 R94 R28]
                        lassign [FindRelOffsets $tcomp] ttype tlink
                    
                        set sstore "offsetof([GetClassProperty $sClass Declaration],\
                                [readAttribute $scomp Name])"
                        set tstore "offsetof([GetClassProperty $tClass Declaration],\
                                [readAttribute $tcomp Name])"
                    
                        append result\
                            "$indent2.relType = mrtClassAssoc,\n"\
                            "$indent2.relInfo.classAssociation = \{\n"
                    
                        append result\
                            "$indent3.source = \{\n"\
                            "$indent4.classDesc = &${domain}__CLASSES\[$sNum\], // $sClass\n"\
                            "$indent4.cardinality = [MapToCardinality $tCond $tMult],\n"\
                            "$indent4.storageType = $stype,\n"\
                            "$indent4.storageOffset = $sstore,\n"\
                            "$indent4.linkOffset = $slink,\n"\
                            "$indent3\},\n"
                    
                        append result\
                            "$indent3.target = \{\n"\
                            "$indent4.classDesc = &${domain}__CLASSES\[$tNum\], // $tClass\n"\
                            "$indent4.cardinality = [MapToCardinality $sCond $sMult],\n"\
                            "$indent4.storageType = $ttype,\n"\
                            "$indent4.storageOffset = $tstore,\n"\
                            "$indent4.linkOffset = $tlink\n"\
                            "$indent3\},\n"
                    
                        set aClassDecl [GetClassProperty $aClass Declaration]
                        set aClassForw "offsetof($aClassDecl, ${relName}.forward)"
                        set aClassBack "offsetof($aClassDecl, ${relName}.backward)"
                        append result\
                            "$indent3.associator = \{\n"\
                            "$indent4.classDesc = &${domain}__CLASSES\[$aNum\], // $aClass\n"\
                            "$indent4.forwardOffset = $aClassForw,\n"\
                            "$indent4.backwardOffset = $aClassBack,\n"\
                            "$indent4.multiple = $aMult,\n"\
                            "$indent3\}\n"
                    
                        append result\
                            "$indent2\},\n"\
                            "${indent3}#ifndef MRT_NO_NAMES\n"\
                            "$indent2.name = ${relName}__NAME\n"\
                            "${indent3}#endif /* MRT_NO_NAMES */\n"\
                            "$indent\},\n"
                        continue
                    }
                    set typeRef [findRelated $relRef\
                            {~R30 Generalization} {~R43 ReferenceGeneralization}]
                    if {[isNotEmptyRef $typeRef]} {
                        set superRef [findRelated $typeRef ~R36]
                        assignAttribute $superRef {Class superClass}
                        set supNum [readAttribute [findRelated $superRef R48 R40 R41] Number]
                    
                        set subRefs [findRelated $typeRef ~R37]
                        set subClasses [findRelated $subRefs R47 R40 R41]
                    
                        set subs [pipe {
                            deRef $subRefs |
                            relation join ~ [deRef $subClasses]\
                                -using {Domain Domain Class Name} |
                            relation extend ~ stup\
                                classDesc string {
                                    "&${domain}__CLASSES\[[tuple extract $stup Number]\],\
                                    // [tuple extract $stup Class]"}\
                                storageOffset string {
                                    "offsetof([GetClassProperty\
                                        [tuple extract $stup Class] Declaration],\
                                        $relName)"} |
                            relation project ~ Class classDesc storageOffset
                        }]
                    
                        append subroles "static struct mrtrefsubclassrole const\
                                ${relName}__SROLES\[[refMultiplicity $subRefs]\] = \{\n"
                        relation foreach sub $subs -ascending Class {
                            relation assign $sub
                            append subroles\
                                "    \{\n"\
                                "        .classDesc = $classDesc,\n"\
                                "        .storageOffset = $storageOffset\n"\
                                "    \},\n"
                        }
                        append subroles "\} ;\n"
                    
                        append result\
                            "$indent2.relType = mrtRefGeneralization,\n"\
                            "$indent2.relInfo.refGeneralization = \{\n"
                    
                        append result\
                            "$indent3.superclass = \{\n"\
                            "$indent4.classDesc = &${domain}__CLASSES\[$supNum\], // $superClass\n"\
                            "$indent4.storageOffset =\
                                offsetof([GetClassProperty $superClass Declaration],\
                                $relName)\n"\
                            "$indent3\},\n"
                    
                        append result\
                            "$indent3.subclassCount = [refMultiplicity $subRefs],\n"\
                            "$indent3.subclasses = ${relName}__SROLES\n"
                    
                        append result\
                            "$indent2\},\n"\
                            "${indent3}#ifndef MRT_NO_NAMES\n"\
                            "$indent2.name = ${relName}__NAME\n"\
                            "${indent3}#endif /* MRT_NO_NAMES */\n"\
                            "$indent\},\n"
                        continue
                    }
                    set typeRef [findRelated $relRef\
                            {~R30 Generalization} {~R43 UnionGeneralization}]
                    if {[isNotEmptyRef $typeRef]} {
                        set superRef [findRelated $typeRef ~R44]
                        assignAttribute $superRef {Class superClass}
                        set supNum [readAttribute [findRelated $superRef R48 R40 R41] Number]
                        set subRefs [findRelated $typeRef ~R45]
                        set subClasses [findRelated $subRefs R47 R40 R41]
                        set subs [pipe {
                            deRef $subRefs |
                            relation join ~ [deRef $subClasses]\
                                -using {Domain Domain Class Name} |
                            relation extend ~ stup\
                                classDesc string {
                                    "&${domain}__CLASSES\[[tuple extract $stup Number]\],\
                                    // [tuple extract $stup Class]"} |
                            relation project ~ Class classDesc
                        }]
                    
                        append subroles "static MRT_Class const * const\
                                ${relName}__SROLES\[[refMultiplicity $subRefs]\] = \{\n"
                        relation foreach sub $subs -ascending Class {
                            relation assign $sub
                            append subroles "    $classDesc\n"
                        }
                        append subroles "\} ;\n"
                    
                        append result\
                            "$indent2.relType = mrtUnionGeneralization,\n"\
                            "$indent2.relInfo.unionGeneralization = \{\n"
                    
                        append result\
                            "$indent3.superclass = \{\n"\
                            "$indent4.classDesc = &${domain}__CLASSES\[$supNum\], // $superClass\n"\
                            "$indent4.storageOffset =\
                                offsetof([GetClassProperty $superClass Declaration],\
                                $relName)\n"\
                            "$indent3\},\n"
                    
                        append result\
                            "$indent3.subclassCount = [refMultiplicity $subRefs],\n"\
                            "$indent3.subclasses = ${relName}__SROLES\n"
                    
                        append result\
                            "$indent2\},\n"\
                            "${indent3}#ifndef MRT_NO_NAMES\n"\
                            "$indent2.name = ${relName}__NAME\n"\
                            "${indent3}#endif /* MRT_NO_NAMES */\n"\
                            "$indent\},\n"
                        continue
                    }
                }
            
                append result "\} ;\n"
            
                return [string cat\
                    [comment "Relationship Description Definitions"]\
                    $subroles\
                    $result\
                ]
            }
            proc MapToCardinality {cond mult} {
                if {$cond && !$mult} {
                    return mrtAtMostOne
                } elseif {!$cond && !$mult} {
                    return mrtExactlyOne
                } elseif {$cond && $mult} {
                    return mrtZeroOrMore
                } elseif {!$cond && $mult} {
                    return mrtOneOrMore
                }
            }
            proc classInstanceDefinitions {} {
                variable domain
                variable staticMultiRefs {}
            
                set classRefs [FindNonUnionSubclasses $domain]
                set classpops [FindClassPopulation $classRefs]
            
                set result [comment "Instance Pool Definitions"]
                relation foreach classpop $classpops -ascending ClassNumber {
                    relation assign $classpop
            
                    append result\
                        "static struct $Class "\
                        [GetClassProperty $Class StorageVariable]\
                        "\[[GetClassProperty $Class TotalInstance]\] = \{\n"
            
                    relation foreach inst $Instances -ascending InstNumber {
                        append result [GenInstanceInitializers $Class $ClassNumber $inst]
                    }
            
                    append result "\} ;\n"
                }
            
                if {$staticMultiRefs ne {}} {
                    set staticMultiRefs [string cat\
                        [comment "Static Reference Definitions"] $staticMultiRefs]
                }
                return [string cat $staticMultiRefs $result]
            }
            proc FindClassPopulation {classRefs} {
                set classes [pipe {
                    deRef $classRefs |
                    relation rename ~ Name Class Number ClassNumber
                }]
            
                set compRefs [findRelated $classRefs ~R20]
            
                # Populated Components
                set popCompRefs [findRelated $compRefs {~R25 PopulatedComponent}]
            
                # Attribute Components
                set attrs [pipe {
                    findRelated $popCompRefs {~R21 Attribute} {~R29 IndependentAttribute}\
                            {~R19 ValueInitializedAttribute} R19 R29 |
                    deRef % |
                    relation rename % Name Component
                } {} |%]
                # puts [relformat $attrs attrs]
            
                # Reference Components
                # For the populated reference components we will go ahead and
                # compute the class to which the reference is made.
                set refCompRefs [findRelated $popCompRefs {~R21 Reference}]
            
                # Superclass Reference Component
                set screfs [findRelated $refCompRefs {~R23 SuperclassReference}]
                set refedsuper [pipe {
                    findRelated $screfs ~R91 {~R47 ReferringSubclass} R37 ~R36 |
                    deRef % |
                    relation eliminate % Role |
                    relation rename % Class SuperClass Relationship Component
                } {} |%]
                set superrefs [pipe {
                    deRef $screfs |
                    relation rename ~ Name Component |
                    relation join ~ $refedsuper
                }]
                # puts [relformat $superrefs superrefs]
            
                # Associator Reference Components
                set arrefs [findRelated $refCompRefs {~R23 AssociatorReference}]
                set cbainfo [pipe {
                    findRelated $arrefs ~R93 |
                    deRef % |
                    relation project % Domain Class Relationship |
                    relation rename % Class AssociatorClass |
                    relation join % $::micca::SourceClass |
                    relation eliminate % Role Conditionality Multiplicity |
                    relation rename % Class SourceClass |
                    relation join % $::micca::TargetClass |
                    relation eliminate % Role Conditionality Multiplicity |
                    relation rename % Class TargetClass AssociatorClass Class\
                            Relationship Component
                } {} |%]
                set atorrefs [pipe {
                    deRef $arrefs |
                    relation rename ~ Name Component |
                    relation join ~ $cbainfo
                }]
                # puts [relformat $atorrefs atorrefs]
            
                # Association Reference Components
                set asrrefs [findRelated $refCompRefs {~R23 AssociationReference}]
                set srcinfo [pipe {
                    findRelated $asrrefs ~R90 R32 ~R33 |
                    deRef % |
                    relation eliminate % Role |
                    relation rename % Class ReferencedClass Relationship Component
                } {} |%]
                set assocrefs [pipe {
                    deRef $asrrefs |
                    relation rename ~ Name Component |
                    relation join ~ $srcinfo
                }]
                # puts [relformat $assocrefs assocrefs]
            
                # Generated components
                set genCompRefs [findRelated $compRefs {~R25 GeneratedComponent}]
            
                # Subclass Reference Components
                set subrefs [pipe {
                    findRelated $genCompRefs {~R24 SubclassReference} |
                    deRef % |
                    relation rename % Name Component
                } {} |%]
                # puts [relformat $subrefs subrefs]
            
                # Subclass Container
                set subconts [pipe {
                    findRelated $genCompRefs {~R24 SubclassContainer} |
                    deRef % |
                    relation rename % Name Component
                } {} |%]
                # puts [relformat $subconts subconts]
            
                # Link Container
                set linkconts [pipe {
                    findRelated $genCompRefs {~R24 LinkContainer} |
                    deRef % |
                    relation rename % Name Component
                } {} |%]
                # puts [relformat $linkconts linkconts]
            
                # Complementary Reference
                set complRefs [findRelated $genCompRefs {~R24 ComplementaryReference}]
            
                # Singular Reference
                set singRefs [pipe {
                    findRelated $complRefs {~R26 SingularReference} |
                    deRef % |
                    relation rename % Name Component
                } {} |%]
                # puts [relformat $singRefs singRefs]
            
                # Array Reference
                set arrayRefs [pipe {
                    findRelated $complRefs {~R26 ArrayReference} |
                    deRef % |
                    relation rename % Name Component
                } {} |%]
                # puts [relformat $arrayRefs arrayRefs]
            
                # Link Reference
                set linkRefs [pipe {
                    findRelated $complRefs {~R26 LinkReference} |
                    deRef % |
                    relation rename % Name Component
                } {} |%]
                # puts [relformat $linkRefs linkRefs]
            
                set classpops [pipe {
                    findRelated $classRefs R104 {~R101 ElementPopulation}\
                        {~R105 ClassPopulation} ~R102 |
                    deRef % |
                    relation rename % Number InstNumber |
                    relation join % $classes $::micca::SpecifiedComponentValue |
                    ralutil::rvajoin % $attrs Attributes |
                    ralutil::rvajoin % $superrefs SuperRefs |
                    ralutil::rvajoin % $atorrefs AssociatorRefs |
                    ralutil::rvajoin % $assocrefs AssociationRefs |
                    ralutil::rvajoin % $subrefs SubRefs |
                    ralutil::rvajoin % $subconts SubclassContainers |
                    ralutil::rvajoin % $linkconts LinkContainers |
                    ralutil::rvajoin % $singRefs SingularRefs |
                    ralutil::rvajoin % $arrayRefs ArrayRefs |
                    ralutil::rvajoin % $linkRefs LinkRefs |
                    relation group % Components Component Value Attributes SuperRefs\
                        AssociatorRefs AssociationRefs SubRefs SubclassContainers\
                        LinkContainers SingularRefs ArrayRefs LinkRefs |
                    relation group % Instances Instance InstNumber Components |
                    relation eliminate % Domain
                } {} |%]
                # puts [relformat $classpops classpops]
            
                return $classpops
            }
            proc GenInstanceInitializers {className classNumber inst} {
                variable domain
                set indent [string repeat { } 4]
                set indent2 [string repeat $indent 2]
                set indent3 [string repeat $indent 3]
                set indent4 [string repeat $indent 4]
            
                relation assign $inst
            
                set sp [pipe {
                    StateModel findById Domain $domain Model $className |
                    findRelated ~ R58 R57
                }]
                set initstate [expr {[isNotEmptyRef $sp] ?\
                    [readAttribute $sp Number] : "MRT_StateCode_IG"}]
            
                append result\
                    "$indent\{ // $Instance\n"\
                    "$indent2.base__INST = \{\n"\
                    "$indent3.classDesc = &${domain}__CLASSES\[$classNumber\],\n"\
                    "$indent3.alloc = [expr {$InstNumber + 1}],\n"\
                    "$indent3.currentState = $initstate,\n"\
                    "$indent3.refCount = 0,\n"\
                    "${indent4}#ifndef MRT_NO_NAMES\n"\
                    "$indent3.name = \"$Instance\"\n"\
                    "${indent4}#endif /* MRT_NO_NAMES */\n"\
                    " $indent2\},\n"
            
                relation foreach comp $Components {
                    relation assign $comp
                    if {[relation isnotempty $Attributes]} {
                        append result "$indent2.$Component = $Value,\n"
                        continue
                    }
            
                    if {[relation isnotempty $SuperRefs]} {
                        set superclass [relation extract $SuperRefs SuperClass]
                        append result\
                            "$indent2.$Component = "\
                            [GenInstanceAddress $domain $superclass $Value],\n
                        continue
                    }
            
                    if {[relation isnotempty $AssociatorRefs]} {
                        relation assign $AssociatorRefs
                        # the painful reflexive case again!
                        if {$SourceClass eq $TargetClass} {
                            # N.B. the inversion. the target instance is the
                            # one referenced in the forward direction
                            set sinstname [dict get $Value backward]
                            set tinstname [dict get $Value forward]
                        } else {
                            set sinstname [dict get $Value $SourceClass]
                            set tinstname [dict get $Value $TargetClass]
                        }
                        set sourceaddr [GenInstanceAddress $domain $SourceClass\
                            $sinstname]
                        set targetaddr [GenInstanceAddress $domain $TargetClass\
                            $tinstname]
            
                        append result\
                            "$indent2.$Component = \{\n"\
                            "$indent3.forward = $targetaddr,\n"\
                            "$indent3.backward = $sourceaddr\n"\
                            "$indent2\},\n"
                        continue
                    }
            
                    if {[relation isnotempty $AssociationRefs]} {
                        set refvalue [GenInstanceAddress $domain\
                                [relation extract $AssociationRefs ReferencedClass]\
                                $Value]
                        append result "$indent2.$Component = $refvalue,\n"
                        continue
                    }
            
                    if {[relation isnotempty $SubRefs]} {
                        lassign $Value subclass subinstname
                        set subinstaddr [GenInstanceAddress $domain $subclass $subinstname]
                        append result "$indent2.$Component = $subinstaddr,\n"
                        continue
                    }
            
                    if {[relation isnotempty $SubclassContainers]} {
                        lassign $Value subclass subinst
            
                        set subRef [Class findWhere {$Domain eq $domain &&\
                            $Name eq $subclass}]
                        set subpops [FindClassPopulation $subRef]
                        # puts [relformat $subpops subpops]
            
                        relation assign $subpops {Class subclassName}\
                            {ClassNumber subclassNumber} {Instances subInstances}
                        set instpop [relation restrictwith $subInstances\
                            {$Instance eq $subinst}]
            
                        append result\
                            "$indent2.$Component.$subclass = "\
                            [string trimleft [indentCode [GenInstanceInitializers\
                                $subclassName $subclassNumber $instpop] 8]]
                        continue
                    }
            
                    if {[relation isnotempty $LinkContainers]} {
                        lassign [dict get $Value next] nclass ninst ncomp
                        set nextaddr [GenInstanceAddress $domain $nclass $ninst]
                        lassign [dict get $Value prev] pclass pinst pcomp
                        set prevaddr [GenInstanceAddress $domain $pclass $pinst]
                        append result\
                            "$indent2.$Component = \{\n"\
                            "$indent3.next = $nextaddr.$ncomp,\n"\
                            "$indent3.prev = $prevaddr.$pcomp\n"\
                            "$indent2\},\n"
                        continue
                    }
            
                    if {[relation isnotempty $SingularRefs]} {
                        if {$Value eq "@nil@"} {
                            set refaddr NULL
                        } else {
                            lassign $Value refclass refinst
                            set refaddr [GenInstanceAddress $domain $refclass $refinst]
                        }
                        append result "$indent2.$Component = $refaddr,\n"
                        continue
                    }
            
                    if {[relation isnotempty $ArrayRefs]} {
                        if {$Value eq "@nil@"} {
                            set refcount 0
                            set refaddr NULL
                        } else {
                            lassign $Value refclass refinsts
                            set refcount [llength $refinsts]
                            set refaddr ${Component}_${className}_${InstNumber}
            
                            # Build reference array
                            variable staticMultiRefs
                            append staticMultiRefs\
                                "static [GetClassProperty $refclass Reference]\
                                    const $refaddr\[$refcount\] = \{\n"
                            foreach inst $refinsts {
                                append staticMultiRefs\
                                    "$indent[GenInstanceAddress $domain $refclass $inst],\n"
                            }
                            append staticMultiRefs "\} ;\n"
                        }
                        append result\
                            "$indent2.$Component = \{\n"\
                            "$indent3.links = $refaddr,\n"\
                            "$indent3.count = $refcount\n"\
                            "$indent2\},\n"
                        continue
                    }
            
                    if {[relation isnotempty $LinkRefs]} {
                        lassign [dict get $Value next] nclass ninst ncomp
                        set nextaddr [GenInstanceAddress $domain $nclass $ninst]
                        lassign [dict get $Value prev] pclass pinst pcomp
                        set prevaddr [GenInstanceAddress $domain $pclass $pinst]
                        append result\
                            "$indent2.$Component = \{\n"\
                            "$indent3.next = $nextaddr.$ncomp,\n"\
                            "$indent3.prev = $prevaddr.$pcomp\n"\
                            "$indent2\},\n"
                        continue
                    }
                }
            
                append result "$indent\},\n"
            
                return $result
            }
            proc assignerInstanceDefinitions {} {
                variable domain
                set result {}
            
                append result [comment "Single Assigner Instance Definitions"]
                set singles [SingleAssigner findWhere {$Domain eq $domain}]
                forAllRefs assigner $singles {
                    set initstate [pipe {
                        findRelated $assigner R53 R50 R58 R57 |
                        readAttribute ~ Number
                    }]
                    assignAttribute $assigner
                    set instnum [GetClassProperty $Association Number]
                    append result\
                        "static struct $Association ${Association}__POOL\[1\] = \{\n"\
                        "    \{\n"\
                        "        .base__INST = \{\n"\
                        "            .classDesc = &${domain}__ASSIGNERS\[$instnum\],\n"\
                        "            .alloc = 1,\n"\
                        "            .currentState = $initstate,\n"\
                        "            .refCount = 0,\n"\
                        "                #ifndef MRT_NO_NAMES\n"\
                        "            .name = single_assigner_instance__NAME\n"\
                        "                #endif /* MRT_NO_NAMES */\n"\
                        "        \}\n"\
                        "    \}\n"\
                        "\} ;\n"
                }
            
                append result [comment "Multiple Assigner Instance Definitions"]
                set multis [MultipleAssigner findWhere {$Domain eq $domain}]
                forAllRefs multi $multis {
                    assignAttribute $multi
                    set initstate [pipe {
                        findRelated $multi R53 R50 R58 R57 |
                        readAttribute ~ Number
                    }]
            
                    set multiinsts [findRelated $multi ~R106]
                    if {[isNotEmptyRef $multiinsts]} {
                        set totalinsts [GetClassProperty $Class TotalInstance]
                        set instnum [GetClassProperty $Association Number]
                        append result "static struct $Association\
                                ${Association}__POOL\[$totalinsts\] = \{\n"
                        forAllRefs assigner $multiinsts {
                            assignAttribute $assigner
                            set allocnum 0
                            append result\
                                "    \[$Number\] = \{\n"\
                                "        .base__INST = \{\n"\
                                "            .classDesc = &${domain}__ASSIGNERS\[$instnum\],\n"\
                                "            .alloc = [incr allocnum],\n"\
                                "            .currentState = $initstate,\n"\
                                "            .refCount = 0,\n"\
                                "                #ifndef MRT_NO_NAMES\n"\
                                "            .name = \"$Instance\"\n"\
                                "                #endif /* MRT_NO_NAMES */\n"\
                                "        \},\n"\
                                "        .idinstance = [GenInstanceAddress $domain $IdClass\
                                        $IdInstance]\n"\
                                "    \},\n"\
                        }
                        append result "\} ;\n"
                    }
                }
            
                return $result
            }
            proc operationDefinitions {} {
                variable domain
            
                set ops [pipe {
                    Operation findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation rename ~ Name Operation |
                    ralutil::rvajoin ~ $::micca::OperationParameter Parameters
                }]
            
                set result [comment "Operation Definitions"]
                relation foreach op $ops {
                    relation assign $op
                    append result\
                        "static $ReturnDataType\n${Class}_$Operation"
            
                    if {[relation isempty $Parameters]} {
                        append result "\(void\)\n"
                        set syms [relation create {
                            Name string Ctype string Type string Class string
                        }]
                    } else {
                        set pdecls {}
                        relation foreach param $Parameters -ascending Number {
                            relation assign $param
                            append pdecls\
                                [typeCheck composeDeclaration $DataType $Name]\
                                ,\n
                        }
                        set pdecls [string trimright $pdecls ",\n"]\)\n
                        append result\
                            "\(\n"\
                            [indentCode $pdecls]
            
                        set syms [pipe {
                            relation project $Parameters Name DataType |
                            relation rename ~ DataType Ctype |
                            relation extend ~ stup\
                                Type string {{}}\
                                Class string {{}} |
                            relation update ~ utup {
                                [tuple extract $utup Name] eq "self"} {
                                tuple update $utup Type Reference Class $Class
                            }
                        }]
                    }
            
                    append result\
                        [blockcomment $Body]\
                        "\{\n"\
                        "    MRT_INSTRUMENT_ENTRY\n"\
                        [linedirective $Line $File]\
                        [ExpandActivity "$Operation operation" $Body $syms]\
                        "\}\n"
                }
            
                return $result
            }
            proc ctorDefinitions {} {
                return [TorDefinitions Constructor]
            }
            proc TorDefinitions {which} {
                variable domain
                set suffixmap [dict create\
                    Constructor CTOR\
                    Destructor DTOR\
                ]
                set result [comment "$which Definitions"]
            
                set tors [$which findWhere {$Domain eq $domain}]
            
                forAllRefs tor $tors {
                    assignAttribute $tor
            
                    set selfdecl [GetClassProperty $Class Reference]const
                    set syms [relation create {
                        Name string Ctype string Type string Class string
                    } [list Name self Ctype $selfdecl Type Reference Class $Class]]
                    append result\
                        "static void\n${Class}__[dict get $suffixmap $which]\(\n"\
                        "    void *const s__SELF\)\n"\
                        [blockcomment $Body]\
                        "\{\n"\
                        "    MRT_INSTRUMENT_ENTRY\n"\
                        "    $selfdecl self = s__SELF ;\n"\
                        [linedirective $Line $File]\
                        [ExpandActivity "$Class $which" $Body $syms]\
                        "\}\n"
                }
            
                return $result
            }
            proc dtorDefinitions {} {
                return [TorDefinitions Destructor]
            }
            proc formulaDefinitions {} {
                variable domain
                set result [comment "Dependent Attribute Formula Definitions"]
            
                set deps [DependentAttribute findWhere {$Domain eq $domain}]
            
                forAllRefs dep $deps {
                    assignAttribute $dep
                    set type [readAttribute [findRelated $dep R29] DataType]
            
                    set selfdecl [GetClassProperty $Class ConstReference]const
                    set syms [relation create {
                        Name string Ctype string Type string Class string
                    }\
                        [list Name self Ctype $selfdecl Type Reference Class $Class]\
                        [list Name $Name Ctype "void *const" Type {} Class {}]\
                        [list Name size Ctype MRT_AttrSize Type {} Class {}]\
                    ]
                    set asgnType [typeCheck assignmentType [UnaliasType $domain $type]]
                    switch -exact -- [dict get $asgnType type] {
                        scalar {
                            set attrDecl "$type *const $Name"
                        }
                        string -
                        array {
                            set attrDecl "[dict get $asgnType base] *const $Name"
                        }
                        default {
                            error "unknown assignment type, \"[dict get $asgnType type]\""
                        }
                    }
                    append result\
                        "static void\n${Class}_${Name}__FORMULA\(\n"\
                        "    void const *const s__,\n"\
                        "    void *const v__,\n"\
                        "    MRT_AttrSize size\)\n"\
                        [blockcomment $Formula]\
                        "\{\n"\
                        "    MRT_INSTRUMENT_ENTRY\n"\
                        "    $selfdecl self = s__ ;\n"\
                        "    $attrDecl = v__ ;\n"\
                        [linedirective $Line $File]\
                        [ExpandActivity "$Class $Name Formula" $Formula $syms]\
                        "\}\n"
                }
            
                return $result
            }
            proc activityDefinitions {} {
                variable domain
                set result {}
            
                set classes [pipe {
                    State findWhere {$Domain eq $domain && [string trim $Activity] ne {}} |
                    deRef ~ |
                    relation eliminate ~ Domain IsFinal |
                    relation group ~ States Name Activity File Line PSigID
                }]
                # puts [relformat $classes classes]
            
                if {[relation isnotempty $classes]} {
                    append result [comment "State Activities Definitions"]
            
                    relation foreach class $classes -ascending Model {
                        relation assign $class
                        append result "#define MRT_CLASS_NAME \"$Model\"\n"
                        relation foreach state $States {
                            relation assign $state
                            set selfdecl [GetClassProperty $Model Reference]const
                            append result\
                                "static void\n${Model}_${Name}__ACTIVITY\(\n"\
                                "    void *const s__SELF,\n"\
                                "    void const *const p__PARAMS)\n"\
                                [blockcomment $Activity]\
                                "\{\n"\
                                "        #define MRT_STATE_NAME \"$Name\"\n"\
                                "    MRT_INSTRUMENT_ENTRY\n"\
                                "    $selfdecl self = s__SELF ;\n"
                            if {$PSigID ne {}} {
                                set signame ${Model}_${Name}__SPARAMS
                                append result\
                                    "    struct $signame const *const pp__PARAMS = p__PARAMS ;\n"
                                set params [pipe {
                                    ParameterSignature findById Domain $domain PSigID $PSigID |
                                    FindParamsFromSig ~
                                }]
                                relation foreach param $params -ascending Position {
                                    set asgnment [GenParamAssignment $domain $param]
                                    append result [indentCode $asgnment]
                                }
            
                                set syms [pipe {
                                    relation project $params Name Declaration |
                                    relation rename ~ Declaration Ctype |
                                    relation extend ~ stup\
                                        Type string {{}}\
                                        Class string {{}}
                                }]
                            } else {
                                set syms [relation create {
                                    Name string Ctype string Type string Class string
                                }]
                            }
                            set syms [relation insert $syms [list Name self Ctype $selfdecl\
                                    Type Reference Class $Model]]
            
                            append result\
                                [linedirective $Line $File]\
                                [ExpandActivity "$Model $Name activity" $Activity $syms]
            
                            append result\
                                "        #undef MRT_STATE_NAME\n"\
                                "\}\n"
                        }
                        append result "#undef MRT_CLASS_NAME\n"
                    }
                }
            
                return $result
            }
            proc domainCtorDefinition {} {
                variable domain
                set result [comment "Definition of Function to Construct Initial Instances"]
            
                set ctorinsts [pipe {
                    Constructor findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation eliminate ~ Body |
                    relation join ~ $::micca::ClassInstance |
                    relation group ~ Instances Instance Number
                }]
            
                if {[relation isnotempty $ctorinsts]} {
                    relation foreach ctorinst $ctorinsts {
                        relation assign $ctorinst
                        relation foreach instance $Instances -ascending Number {
                            relation assign $instance
                            append invocations\
                                "${Class}__CTOR\("\
                                [GenInstanceAddress $domain $Class $Instance]\
                                "\) ;\n"
                        }
                    }
                    append result\
                        "static void\n${domain}__INIT\(void\)\n"\
                        "\{\n"\
                        [indentCode $invocations]\
                        "\}\n"
                }
            
                return $result
            }
            proc domainOpDefinitions {} {
                variable domain
                set result [comment "Domain Operation Definitions"]
            
                set ops [pipe {
                    DomainOperation findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation rename ~ Name Operation |
                    ralutil::rvajoin ~ $::micca::DomainOperationParameter Parameters
                }]
            
                relation foreach op $ops {
                    relation assign $op
                    append result\
                        "$ReturnDataType\n${domain}_${Operation}"
            
                    if {[relation isempty $Parameters]} {
                        set decl "\(void\)\n"
                        append result $decl
                        set syms [relation create {
                            Name string Ctype string Type string Class string
                        }]
                    } else {
                        set pdecls {}
                        relation foreach param $Parameters -ascending Number {
                            relation assign $param
                            append pdecls\
                                [typeCheck composeDeclaration $DataType $Name]\
                                ,\n
                        }
                        set pdecls [string trimright $pdecls ",\n"]\)\n
                        set decl [string cat\
                            "\(\n"\
                            [indentCode $pdecls]\
                        ]
                        append result $decl
                        set syms [pipe {
                            relation project $Parameters Name DataType |
                            relation rename ~ DataType Ctype |
                            relation extend ~ stup\
                                Type string {{}}\
                                Class string {{}}
                        }]
                    }
            
                    append result\
                        [blockcomment $Body]\
                        "\{\n"\
                        "    MRT_INSTRUMENT_ENTRY\n"\
                        [linedirective $Line $File]\
                        [ExpandActivity "$Operation domain operation" $Body $syms]\
                        "\}\n"
                }
            
                return $result
            }
            proc externalOpDefinitions {} {
                upvar #0 [namespace parent]::options options
                if {![dict get $options stubexternalops]} {
                    return
                }
            
                variable domain
                set result [comment "External Operation Stub Definitions"]
            
                set ops [pipe {
                    ExternalOperation findWhere {$Domain eq $domain} |
                    deRef ~ |
                    relation rename ~ Name Operation |
                    ralutil::rvajoin ~ $::micca::ExternalOperationParameter Parameters
                }]
            
                relation foreach op $ops {
                    relation assign $op
                    append result\
                        "$ReturnDataType\n${domain}_${Entity}_${Operation}__EOP"
            
                    if {[relation isempty $Parameters]} {
                        append result "\(void\)\n"
                        set syms [relation create {
                            Name string Ctype string Type string Class string
                        }]
                    } else {
                        set pdecls {}
                        relation foreach param $Parameters -ascending Number {
                            relation assign $param
                            append pdecls\
                                [typeCheck composeDeclaration $DataType $Name]\
                                ,\n
                        }
                        set pdecls [string trimright $pdecls ",\n"]\)\n
                        append result\
                            "\(\n"\
                            [indentCode $pdecls]
                        set syms [pipe {
                            relation project $Parameters Name DataType |
                            relation rename ~ DataType Ctype |
                            relation extend ~ stup\
                                Type string {{}}\
                                Class string {{}}
                        }]
                    }
            
                    append result\
                        [blockcomment $Body]\
                        "\{\n"\
                        "    MRT_INSTRUMENT_ENTRY\n"\
                        [linedirective $Line $File]\
                        [ExpandActivity "$Operation external operation" $Body $syms]\
                        "\}\n"
                }
            
                return $result
            }
            proc portalDefinition {} {
                variable domain
            
                set classRefs [Class findWhere {$Domain eq $domain}]
                set assignRefs [AssignerStateModel findWhere {$Domain eq $domain}]
                set acount [refMultiplicity $assignRefs]
                set aptr [expr {$acount == 0 ? "NULL" : "${domain}__ASSIGNERS"}]
                append result\
                    [comment "Domain Portal Definition"]\
                    "MRT_DomainPortal const ${domain}__PORTAL = \{\n"\
                    "    .classCount = [refMultiplicity $classRefs],\n"\
                    "    .classes = ${domain}__CLASSES,\n"\
                    "    .assignerCount = $acount,\n"\
                    "    .assigners = $aptr,\n"\
                    "        #ifndef MRT_NO_NAMES\n"\
                    "    .name = \"$domain\"\n"\
                    "        #endif /* MRT_NO_NAMES */\n"\
                    "\} ;\n"
            }
            proc epilogueDeclarations {} {
                variable epilogue
            
                return [string cat\
                    [comment "Domain Epilogue"]\
                    [indentCode [string trim $epilogue] 0]\
                ]
            }
        }
    
        namespace path {
            ::micca
            ::micca::@Config@::Helpers
            ::micca::@Gen@::Helpers
            ::rosea::InstCmds
        }
    
        set headerTemplate [textutil::adjust::undent {
            <%banner%>
            #ifndef <%headerFileGuard%>
            #define <%headerFileGuard%>
            <%interface%>
            #include "micca_rt.h"
            <%interfaceTypeAliases%>
            <%domainOpDeclarations%>
            <%externalOpDeclarations%>
            <%eventParamDeclarations%>
            <%portalIds%>
            <%portalDeclaration%>
            #endif /* <%headerFileGuard%> */
        }]
        set codeTemplate [textutil::adjust::undent {
            <%banner%>
            #include "micca_rt.h"
            #include "micca_rt_internal.h"
            <%domainInclude%>
            <%prologueDeclarations%>
        
            #ifndef MRT_NO_NAMES
                #define MRT_DOMAIN_NAME <%domainNameString%>
            #endif /* MRT_NO_NAMES */
        
            #if (defined(MRT_INSTRUMENT) && defined(MRT_NO_NAMES))
                #error "cannot define both MRT_INSTRUMENT and MRT_NO_NAMES"
            #endif /* (defined(MRT_INSTRUMENT) && defined(MRT_NO_NAMES)) */
        
            #ifdef MRT_INSTRUMENT
            static char const mrtDomainName[] = MRT_DOMAIN_NAME ;
                #ifdef BOSAL
                    #include "bosal.h"
                    #ifndef MRT_INSTRUMENT_ENTRY
                        #define MRT_INSTRUMENT_ENTRY\
                            bsl_Printf("%s: %s: %s %d\n", mrtDomainName,\
                                    __func__, __FILE__, __LINE__) ;
                    #endif /* MRT_INSTRUMENT_ENTRY */
                    #ifndef MRT_DEBUG
                        #define MRT_DEBUG(...) bsl_Printf(__VA_ARGS__)
                    #endif /* MRT_DEBUG */
                #endif /* BOSAL */
                #ifndef MRT_INSTRUMENT_ENTRY
                    #define MRT_INSTRUMENT_ENTRY\
                        printf("%s: %s: %s %d\n", mrtDomainName, __func__, __FILE__,\
                                __LINE__) ;
                #endif /* MRT_INSTRUMENT_ENTRY */
                #ifndef MRT_DEBUG
                    #define MRT_DEBUG(...) printf(__VA_ARGS__)
                #endif /* MRT_DEBUG */
            #else
                #define MRT_INSTRUMENT_ENTRY
                #define MRT_DEBUG(...)
            #endif /* MRT_INSTRUMENT */
            <%implementationTypeAliases%>
            <%forwardClassDeclarations%>
            <%forwardRelationshipDeclaration%>
            <%classDeclarations%>
            <%assignerDeclarations%>
            <%stateParamDeclarations%>
            <%operationDeclarations%>
            <%ctorDeclarations%>
            <%dtorDeclarations%>
            <%formulaDeclarations%>
            <%activityDeclarations%>
            <%storageDeclarations%>
            <%nameDefinitions%>
            <%iabDefinitions%>
            <%edbDefinitions%>
            <%pdbDefinitions%>
            <%classDefinitions%>
            <%assignerDefinitions%>
            <%relationshipDefinitions%>
            <%classInstanceDefinitions%>
            <%assignerInstanceDefinitions%>
            <%operationDefinitions%>
            <%ctorDefinitions%>
            <%dtorDefinitions%>
            <%formulaDefinitions%>
            <%activityDefinitions%>
            <%domainCtorDefinition%>
            <%domainOpDefinitions%>
            <%externalOpDefinitions%>
            <%portalDefinition%>
            <%epilogueDeclarations%>
        }]
        proc miccaGenerate {arglist} {
            variable errcount 0
        
            variable options
            set options [dict create\
                expanderror     fail\
                stubexternalops false\
                lines           false\
            ]
            set options [dict merge $options $arglist]
            set badpops [pipe {
                Population findAll |
                findUnrelated ~ R100
            }]
            
            forAllRefs badpop $badpops {
                set domainName [readAttribute $badpop Name]
                log::error "for domain, \"$domainName\", no population is given"
                incr errcount
            }
            
            if {$errcount > 0} {
                tailcall DeclError GENERATE_ERRORS $errcount
            }
            textutil::expander expand
            expand setbrackets <% %>
            expand errmode [dict get $options expanderror]
            set genfiles [list]
            try {
                forAllRefs domainRef [Domain findAll] {
                    assignAttribute $domainRef {Name domain} {Interface interface}\
                        {Prologue prologue} {Epilogue epilogue}
            
                    GatherClassProperties $domain
            
                    lappend genfiles $domain.h
                    set GenHeader::domain $domain
                    set GenHeader::interface $interface
                    set GenSupport::domain $domain
                    
                    expand evalcmd "namespace eval [namespace current]::GenHeader"
                    set hchan [::open $domain.h w]
                    try {
                        variable headerTemplate
                        puts $hchan [expand expand $headerTemplate]
                    } on error {result opts} {
                        # puts $::errorInfo
                        return -options $opts $result
                    } finally {
                        chan close $hchan
                    }
                    lappend genfiles $domain.c
                    set GenCode::domain $domain
                    set GenCode::prologue $prologue
                    set GenCode::epilogue $epilogue
                    
                    CreateActivityCommands $domain
                    
                    expand evalcmd "namespace eval [namespace current]::GenCode"
                    set cchan [::open $domain.c w]
                    try {
                        variable codeTemplate
                        puts $cchan [expand expand $codeTemplate]
                    } on error {result opts} {
                        # puts $::errorInfo
                        return -options $opts $result
                    } finally {
                        chan close $cchan
                        namespace delete GenActivity
                    }
                }
            } finally {
                rename expand {} ; # <1>
            }
        
            if {$errcount > 0} {
                tailcall DeclError GENERATE_ERRORS $errcount
            }
            return $genfiles
        }
        proc CreateActivityCommands {domain} {
            namespace eval GenActivity {
                ::logger::import -all -force -namespace log micca
            }
        
            set currns [namespace current]
            set actns ${currns}::GenActivity
            set suppns ${currns}::GenSupport
        
            set classInfo [pipe {
                Class findWhere {$Domain eq $domain} |
                deRef ~ |
                ralutil::rvajoin ~ [relation rename $::micca::StateModel Model Name]\
                    StateModels |
                relation extend ~ itup HasStateModel boolean {
                    [relation isnotempty [tuple extract $itup StateModels]]} |
                ralutil::rvajoin ~\
                    [relation rename $::micca::CreationState Name State Model Name]\
                    CreationStates |
                relation extend ~ ctup HasCreationState boolean {
                    [relation isnotempty [tuple extract $ctup CreationStates]]} |
                relation project ~ Name HasStateModel HasCreationState
            }]
            set usubnames [pipe {
                UnionSubclass findWhere {$Domain eq $domain} |
                deRef ~ |
                relation list ~ Class
            }]
            set cmdmap [dict create]
            relation foreach info $classInfo {
                relation assign $info
                set cmdmap [dict create\
                    foreachInstance [list ${suppns}::ClassForeachInstance $Name]\
                    foreachWhere [list ${suppns}::ClassForeachWhere $Name]\
                    findWhere [list ${suppns}::ClassFindWhere $Name]\
                    selectWhere [list ${suppns}::ClassSelectWhere $Name]\
                    refvar [list ${suppns}::ClassInstanceReference $Name]\
                    idtoref [list ${suppns}::ClassIdToRef $Name]\
                    instset [list ${suppns}::ClassInstanceSet $Name]\
                    findByName [list ${suppns}::ClassFindByName $Name]\
                    operation [list ${suppns}::ClassOperation $Name]\
                ]
                if {$Name ni $usubnames} {
                    dict set cmdmap create [list ${suppns}::ClassCreate $Name]
                    if {$HasStateModel} {
                        dict set cmdmap createin [list ${suppns}::ClassCreateIn $Name]
                    }
                    if {$HasCreationState} {
                        dict set cmdmap createasync [list ${suppns}::ClassCreateAsync $Name]
                    }
                } else {
                    dict set cmdmap create [list ${suppns}::USubClassCreate $Name]
                    if {$HasStateModel} {
                        dict set cmdmap createin [list ${suppns}::USubClassCreateIn $Name]
                    }
                    if {$HasCreationState} {
                        dict set cmdmap createasync\
                            [list ${suppns}::USubClassCreateAsync $Name]
                    }
                }
                namespace ensemble create\
                    -command ${actns}::$Name\
                    -map $cmdmap
            }
            set relRefs [Relationship findWhere {$Domain eq $domain}]
            
            set assocs [findRelatedWhere $relRefs {{~R30 Association}} {!$IsStatic}]
            
            set simpassocs [findRelated $assocs {~R31 SimpleAssociation}]
            forAllRefs simpassoc $simpassocs {
                set simpname [readAttribute $simpassoc Name]
                set cmdmap [dict create\
                    reference [list ${suppns}::RelSimpleAssocSwap $simpname]\
                ]
                set assigner [findRelated $simpassoc R31 ~R52]
                if {[isNotEmptyRef $assigner]} {
                    if {[isNotEmptyRef [findRelated $assigner {~R53 SingleAssigner}]]} {
                        dict set cmdmap signal\
                            [list ${suppns}::SingleAssignerSignal $simpname]
                    } else {
                        dict set cmdmap findByIdInstance\
                                [list ${suppns}::MultiAssignerFindIdInstance $simpname]
                        dict set cmdmap create [list ${suppns}::MultiAssignerCreate $simpname]
                    }
                }
                namespace ensemble create\
                    -command ${actns}::$simpname\
                    -map $cmdmap
            }
            set classassocs [findRelated $assocs {~R31 ClassBasedAssociation}]
            forAllRefs classassoc $classassocs {
                set cbname [readAttribute $classassoc Name]
                set cmdmap [dict create\
                    reference [list ${suppns}::RelClassAssocSwap $cbname]\
                ]
                set assigner [findRelated $classassoc R31 ~R52]
                if {[isNotEmptyRef $assigner]} {
                    if {[isNotEmptyRef [findRelated $assigner {~R53 SingleAssigner}]]} {
                        dict set cmdmap signal\
                            [list ${suppns}::SingleAssignerSignal $cbname]
                    } else {
                        dict set cmdmap findByIdInstance\
                                [list ${suppns}::MultiAssignerFindIdInstance $cbname]
                        dict set cmdmap create [list ${suppns}::MultiAssignerCreate $cbname]
                    }
                }
                namespace ensemble create\
                    -command ${actns}::$cbname\
                    -map $cmdmap
            }
            set gens [findRelated $relRefs {~R30 Generalization}]
            
            set refgens [findRelated $gens {~R43 ReferenceGeneralization}]
            foreach rgname [relation list [deRef $refgens] Name] {
                set cmdmap [dict create\
                    classify [list ${suppns}::GenClassify $rgname]\
                    reclassify [list ${suppns}::RelRefGenReclassify $rgname]\
                ]
                namespace ensemble create\
                    -command ${actns}::$rgname\
                    -map $cmdmap
            }
            set uniongens [findRelated $gens {~R43 UnionGeneralization}]
            foreach ugname [relation list [deRef $uniongens] Name] {
                set cmdmap [dict create\
                    classify [list ${suppns}::GenClassify $ugname]\
                    reclassify [list ${suppns}::RelUnionGenReclassify $ugname]\
                ]
                namespace ensemble create\
                    -command ${actns}::$ugname\
                    -map $cmdmap
            }
            set cmdmap [dict create\
                attr ${suppns}::InstanceAttrRead\
                update ${suppns}::InstanceAttrUpdate\
                assign ${suppns}::InstanceAssign\
                signal ${suppns}::InstanceSignal\
                delaysignal ${suppns}::InstanceDelaySignal\
                canceldelayed ${suppns}::InstanceCancelSignal\
                delayremaining ${suppns}::InstanceRemainingTime\
                delete ${suppns}::InstanceDelete\
                operation ${suppns}::InstanceOperation\
                foreachRelated ${suppns}::InstanceForeachRelated\
                foreachRelatedWhere ${suppns}::InstanceForeachRelatedWhere\
                findRelatedWhere ${suppns}::InstanceFindRelatedWhere\
                findOneRelated ${suppns}::InstanceFindOneRelated\
                selectRelated ${suppns}::InstanceSetSelectRelated\
                selectRelatedWhere ${suppns}::InstanceSetSelectRelatedWhere\
                instid ${suppns}::InstanceRefToId\
            ]
            namespace ensemble create\
                -command ${actns}::instance\
                -parameters instref\
                -map $cmdmap
            set cmdmap [dict create\
                attr [list ${suppns}::InstanceAttrRead self]\
                update [list ${suppns}::InstanceAttrUpdate self]\
                assign [list ${suppns}::InstanceAssign self]\
                signal [list ${suppns}::InstanceSignal self]\
                delaysignal [list ${suppns}::InstanceDelaySignal self]\
                canceldelayed [list ${suppns}::InstanceCancelSignal self]\
                delayremaining [list ${suppns}::InstanceRemainingTime self]\
                delete [list ${suppns}::InstanceDelete self]\
                operation [list ${suppns}::InstanceOperation self]\
                foreachRelated [list ${suppns}::InstanceForeachRelated self]\
                foreachRelatedWhere [list ${suppns}::InstanceForeachRelatedWhere self]\
                findRelatedWhere [list ${suppns}::InstanceFindRelatedWhere self]\
                findOneRelated [list ${suppns}::InstanceFindOneRelated self]\
                selectRelated [list ${suppns}::InstanceSetSelectRelated self]\
                selectRelatedWhere [list ${suppns}::InstanceSetSelectRelatedWhere self]\
                instid [list ${suppns}::InstanceRefToId self]\
            ]
            namespace ensemble create\
                -command ${actns}::my\
                -map $cmdmap
            set cmdmap [dict create\
                foreachInstance ${suppns}::InstanceSetForeachInstance\
                selectOneInstance ${suppns}::InstanceSetSelectOneInstance\
                empty ${suppns}::InstanceSetEmpty\
                cardinality ${suppns}::InstanceSetCardinality\
                notempty ${suppns}::InstanceSetNotEmpty\
                equal ${suppns}::InstanceSetEqual\
                notequal ${suppns}::InstanceSetNotEqual\
                add ${suppns}::InstanceSetAdd\
                remove ${suppns}::InstanceSetRemove\
                contains ${suppns}::InstanceSetContains\
                union ${suppns}::InstanceSetUnion\
                intersect ${suppns}::InstanceSetIntersect\
                minus ${suppns}::InstanceSetMinus\
            ]
            namespace ensemble create\
                -command ${actns}::instset\
                -parameters instset\
                -map $cmdmap
            set ops [pipe {
                ExternalOperation findWhere {$Domain eq $domain} |
                deRef ~ |
                relation project ~ Domain Entity Name
            }]
            set eops [pipe {
                ExternalEntity findWhere {$Domain eq $domain} |
                deRef ~ |
                relation rename ~ Name Entity |
                ralutil::rvajoin ~ $ops Operations
            }]
            
            relation foreach eop $eops {
                relation assign $eop
            
                set cmdmap [dict create]
                relation foreach op $Operations {
                    relation assign $op Name
                    dict set cmdmap $Name\
                            [list ${suppns}::InvokeExternalOp $Entity $Name]
                }
            
                namespace ensemble create\
                    -command ${actns}::$Entity\
                    -map $cmdmap
            }
        
            interp alias {} ${actns}::end {} ${suppns}::End
            interp alias {} ${actns}::subclass {} ${suppns}::SubclassCase
            interp alias {} ${actns}::default {} ${suppns}::DefaultSubclass
        }
    }
}

rosea populate {
    domain micca {
        class TransitionRule    {
            Name                } {
            IG
            CH
        }
    }
}

package provide micca $::micca::version

