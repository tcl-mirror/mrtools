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
        # x
        #     (LBRACKET)
        #     ?
        #         (assignment_expression)
        #     (RBRACKET)
    
        my si:value_symbol_start array_declarator
        my sequence_84
        my si:reduce_symbol_end array_declarator
        return
    }
    
    method sequence_84 {} {
        # x
        #     (LBRACKET)
        #     ?
        #         (assignment_expression)
        #     (RBRACKET)
    
        my si:void_state_push
        my sym_LBRACKET
        my si:voidvalue_part
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
    
    #
    # leaf Symbol 'ARROW'
    #
    
    method sym_ARROW {} {
        # x
        #     "->"
        #     (WHITESPACE)
    
        my si:void_symbol_start ARROW
        my sequence_89
        my si:void_leaf_symbol_end ARROW
        return
    }
    
    method sequence_89 {} {
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
        my choice_98
        my si:reduce_symbol_end assignment_expression
        return
    }
    
    method choice_98 {} {
        # /
        #     x
        #         (unary_expression)
        #         (assignment_operator)
        #         (assignment_expression)
        #     (conditional_expression)
    
        my si:value_state_push
        my sequence_95
        my si:valuevalue_branch
        my sym_conditional_expression
        my si:value_state_merge
        return
    }
    
    method sequence_95 {} {
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
        my choice_112
        my si:reduce_symbol_end assignment_operator
        return
    }
    
    method choice_112 {} {
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
        my sequence_117
        my si:void_leaf_symbol_end auto
        return
    }
    
    method sequence_117 {} {
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
        my sequence_122
        my si:void_leaf_symbol_end BAR
        return
    }
    
    method sequence_122 {} {
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
        my sequence_127
        my si:void_leaf_symbol_end BARBAR
        return
    }
    
    method sequence_127 {} {
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
        my sequence_132
        my si:void_leaf_symbol_end BAREQUAL
        return
    }
    
    method sequence_132 {} {
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
        my sequence_140
        my si:reduce_symbol_end binary_exponent_part
        return
    }
    
    method sequence_140 {} {
        # x
        #     [pP]
        #     ?
        #         (sign)
        #     (digit_sequence)
    
        my si:void_state_push
        my si:next_class pP
        my si:voidvalue_part
        my optional_137
        my si:valuevalue_part
        my sym_digit_sequence
        my si:value_state_merge
        return
    }
    
    method optional_137 {} {
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
        my sequence_145
        my si:void_leaf_symbol_end bool
        return
    }
    
    method sequence_145 {} {
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
        my choice_150
        my si:reduce_symbol_end c_char
        return
    }
    
    method choice_150 {} {
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
        my choice_158
        my si:reduce_symbol_end c_char_sequence
        return
    }
    
    method choice_158 {} {
        # /
        #     (c_char)
        #     x
        #         (c_char_sequence)
        #         (c_char)
    
        my si:value_state_push
        my sym_c_char
        my si:valuevalue_branch
        my sequence_156
        my si:value_state_merge
        return
    }
    
    method sequence_156 {} {
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
        my choice_168
        my si:reduce_symbol_end cast_expression
        return
    }
    
    method choice_168 {} {
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
        my sequence_166
        my si:value_state_merge
        return
    }
    
    method sequence_166 {} {
        # x
        #     (LPAREN)
        #     (type_name)
        #     (RPAREN)
        #     (cast_expression)
    
        my si:void_state_push
        my sym_LPAREN
        my si:voidvalue_part
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
        my sequence_173
        my si:void_leaf_symbol_end char
        return
    }
    
    method sequence_173 {} {
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
        my sequence_182
        my si:reduce_symbol_end character_constant
        return
    }
    
    method sequence_182 {} {
        # x
        #     ?
        #         'L'
        #     '''
        #     (c_char_sequence)
        #     '''
    
        my si:void_state_push
        my optional_177
        my si:voidvoid_part
        my si:next_char '
        my si:voidvalue_part
        my sym_c_char_sequence
        my si:valuevalue_part
        my si:next_char '
        my si:value_state_merge
        return
    }
    
    method optional_177 {} {
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
        my sequence_187
        my si:void_leaf_symbol_end COLON
        return
    }
    
    method sequence_187 {} {
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
        my sequence_192
        my si:void_clear_symbol_end COMMA
        return
    }
    
    method sequence_192 {} {
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
        my sequence_204
        my si:reduce_symbol_end conditional_expression
        return
    }
    
    method sequence_204 {} {
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
        my kleene_202
        my si:value_state_merge
        return
    }
    
    method kleene_202 {} {
        # *
        #     x
        #         (QUERY)
        #         (expression)
        #         (COLON)
        #         (conditional_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_200
            my si:kleene_close
        }
        return
    }
    
    method sequence_200 {} {
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
        my sequence_209
        my si:void_leaf_symbol_end const
        return
    }
    
    method sequence_209 {} {
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
        my choice_216
        my si:reduce_symbol_end constant
        return
    }
    
    method choice_216 {} {
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
        my sequence_225
        my si:reduce_symbol_end decimal_constant
        return
    }
    
    method sequence_225 {} {
        # x
        #     (nonzero_digit)
        #     *
        #         (digit)
    
        my si:value_state_push
        my sym_nonzero_digit
        my si:valuevalue_part
        my kleene_223
        my si:value_state_merge
        return
    }
    
    method kleene_223 {} {
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
        my choice_243
        my si:reduce_symbol_end decimal_floating_constant
        return
    }
    
    method choice_243 {} {
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
        my sequence_235
        my si:valuevalue_branch
        my sequence_241
        my si:value_state_merge
        return
    }
    
    method sequence_235 {} {
        # x
        #     (fractional_constant)
        #     ?
        #         (exponent_part)
        #     ?
        #         (floating_suffix)
    
        my si:value_state_push
        my sym_fractional_constant
        my si:valuevalue_part
        my optional_230
        my si:valuevalue_part
        my optional_233
        my si:value_state_merge
        return
    }
    
    method optional_230 {} {
        # ?
        #     (exponent_part)
    
        my si:void2_state_push
        my sym_exponent_part
        my si:void_state_merge_ok
        return
    }
    
    method optional_233 {} {
        # ?
        #     (floating_suffix)
    
        my si:void2_state_push
        my sym_floating_suffix
        my si:void_state_merge_ok
        return
    }
    
    method sequence_241 {} {
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
        my optional_233
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
        my choice_267
        my si:reduce_symbol_end declaration_specifiers
        return
    }
    
    method choice_267 {} {
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
        my sequence_250
        my si:valuevalue_branch
        my sequence_255
        my si:valuevalue_branch
        my sequence_260
        my si:valuevalue_branch
        my sequence_265
        my si:value_state_merge
        return
    }
    
    method sequence_250 {} {
        # x
        #     (storage_class_specifier)
        #     ?
        #         (declaration_specifiers)
    
        my si:value_state_push
        my sym_storage_class_specifier
        my si:valuevalue_part
        my optional_248
        my si:value_state_merge
        return
    }
    
    method optional_248 {} {
        # ?
        #     (declaration_specifiers)
    
        my si:void2_state_push
        my sym_declaration_specifiers
        my si:void_state_merge_ok
        return
    }
    
    method sequence_255 {} {
        # x
        #     (type_specifier)
        #     ?
        #         (declaration_specifiers)
    
        my si:value_state_push
        my sym_type_specifier
        my si:valuevalue_part
        my optional_248
        my si:value_state_merge
        return
    }
    
    method sequence_260 {} {
        # x
        #     (type_qualifier)
        #     ?
        #         (declaration_specifiers)
    
        my si:value_state_push
        my sym_type_qualifier
        my si:valuevalue_part
        my optional_248
        my si:value_state_merge
        return
    }
    
    method sequence_265 {} {
        # x
        #     (function_specifier)
        #     ?
        #         (declaration_specifiers)
    
        my si:value_state_push
        my sym_function_specifier
        my si:valuevalue_part
        my optional_248
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
        my sequence_273
        my si:reduce_symbol_end declarator
        return
    }
    
    method sequence_273 {} {
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
        my sequence_278
        my si:reduce_symbol_end designation
        return
    }
    
    method sequence_278 {} {
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
        my choice_290
        my si:reduce_symbol_end designator
        return
    }
    
    method choice_290 {} {
        # /
        #     x
        #         (LBRACKET)
        #         (constant_expression)
        #         (RBRACKET)
        #     x
        #         (DOT)
        #         (identifier)
    
        my si:value_state_push
        my sequence_284
        my si:valuevalue_branch
        my sequence_288
        my si:value_state_merge
        return
    }
    
    method sequence_284 {} {
        # x
        #     (LBRACKET)
        #     (constant_expression)
        #     (RBRACKET)
    
        my si:void_state_push
        my sym_LBRACKET
        my si:voidvalue_part
        my sym_constant_expression
        my si:valuevalue_part
        my sym_RBRACKET
        my si:value_state_merge
        return
    }
    
    method sequence_288 {} {
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
        my poskleene_294
        my si:reduce_symbol_end designator_list
        return
    }
    
    method poskleene_294 {} {
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
        my poskleene_300
        my si:void_leaf_symbol_end digit_sequence
        return
    }
    
    method poskleene_300 {} {
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
        my sequence_307
        my si:reduce_symbol_end direct_abstract_declarator
        return
    }
    
    method sequence_307 {} {
        # x
        #     (direct_abstract_declarator_head)
        #     *
        #         (direct_abstract_declarator_tail)
    
        my si:value_state_push
        my sym_direct_abstract_declarator_head
        my si:valuevalue_part
        my kleene_305
        my si:value_state_merge
        return
    }
    
    method kleene_305 {} {
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
        my choice_316
        my si:reduce_symbol_end direct_abstract_declarator_head
        return
    }
    
    method choice_316 {} {
        # /
        #     x
        #         (LPAREN)
        #         (abstract_declarator)
        #         (RPAREN)
        #     (direct_abstract_declarator_tail)
    
        my si:value_state_push
        my sequence_313
        my si:valuevalue_branch
        my sym_direct_abstract_declarator_tail
        my si:value_state_merge
        return
    }
    
    method sequence_313 {} {
        # x
        #     (LPAREN)
        #     (abstract_declarator)
        #     (RPAREN)
    
        my si:void_state_push
        my sym_LPAREN
        my si:voidvalue_part
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
        #         (LBRACKET)
        #         (STAR)
        #         (RBRACKET)
        #     x
        #         (LPAREN)
        #         ?
        #             (parameter_type_list)
        #         (RPAREN)
    
        my si:value_symbol_start direct_abstract_declarator_tail
        my choice_332
        my si:reduce_symbol_end direct_abstract_declarator_tail
        return
    }
    
    method choice_332 {} {
        # /
        #     (array_declarator)
        #     x
        #         (LBRACKET)
        #         (STAR)
        #         (RBRACKET)
        #     x
        #         (LPAREN)
        #         ?
        #             (parameter_type_list)
        #         (RPAREN)
    
        my si:value_state_push
        my sym_array_declarator
        my si:valuevoid_branch
        my sequence_323
        my si:voidvalue_branch
        my sequence_330
        my si:value_state_merge
        return
    }
    
    method sequence_323 {} {
        # x
        #     (LBRACKET)
        #     (STAR)
        #     (RBRACKET)
    
        my si:void_state_push
        my sym_LBRACKET
        my si:voidvoid_part
        my sym_STAR
        my si:voidvoid_part
        my sym_RBRACKET
        my si:void_state_merge
        return
    }
    
    method sequence_330 {} {
        # x
        #     (LPAREN)
        #     ?
        #         (parameter_type_list)
        #     (RPAREN)
    
        my si:void_state_push
        my sym_LPAREN
        my si:voidvalue_part
        my optional_327
        my si:valuevalue_part
        my sym_RPAREN
        my si:value_state_merge
        return
    }
    
    method optional_327 {} {
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
        my sequence_339
        my si:reduce_symbol_end direct_declarator
        return
    }
    
    method sequence_339 {} {
        # x
        #     (direct_declarator_head)
        #     ?
        #         (direct_declarator_tail)
    
        my si:value_state_push
        my sym_direct_declarator_head
        my si:valuevalue_part
        my optional_337
        my si:value_state_merge
        return
    }
    
    method optional_337 {} {
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
        my choice_348
        my si:reduce_symbol_end direct_declarator_head
        return
    }
    
    method choice_348 {} {
        # /
        #     (identifier)
        #     x
        #         (LPAREN)
        #         (declarator)
        #         (RPAREN)
    
        my si:value_state_push
        my sym_identifier
        my si:valuevalue_branch
        my sequence_346
        my si:value_state_merge
        return
    }
    
    method sequence_346 {} {
        # x
        #     (LPAREN)
        #     (declarator)
        #     (RPAREN)
    
        my si:void_state_push
        my sym_LPAREN
        my si:voidvalue_part
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
        my choice_394
        my si:reduce_symbol_end direct_declarator_tail
        return
    }
    
    method choice_394 {} {
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
        my sequence_358
        my si:valuevalue_branch
        my sequence_366
        my si:valuevalue_branch
        my sequence_373
        my si:valuevalue_branch
        my sequence_380
        my si:valuevalue_branch
        my sequence_385
        my si:valuevalue_branch
        my sequence_392
        my si:value_state_merge
        return
    }
    
    method sequence_358 {} {
        # x
        #     (LBRACKET)
        #     ?
        #         (type_qualifier_list)
        #     ?
        #         (assignment_expression)
        #     (RBRACKET)
    
        my si:void_state_push
        my sym_LBRACKET
        my si:voidvalue_part
        my optional_353
        my si:valuevalue_part
        my optional_81
        my si:valuevalue_part
        my sym_RBRACKET
        my si:value_state_merge
        return
    }
    
    method optional_353 {} {
        # ?
        #     (type_qualifier_list)
    
        my si:void2_state_push
        my sym_type_qualifier_list
        my si:void_state_merge_ok
        return
    }
    
    method sequence_366 {} {
        # x
        #     (LBRACKET)
        #     (static)
        #     ?
        #         (type_qualifier_list)
        #     (assignment_expression)
        #     (RBRACKET)
    
        my si:void_state_push
        my sym_LBRACKET
        my si:voidvalue_part
        my sym_static
        my si:valuevalue_part
        my optional_353
        my si:valuevalue_part
        my sym_assignment_expression
        my si:valuevalue_part
        my sym_RBRACKET
        my si:value_state_merge
        return
    }
    
    method sequence_373 {} {
        # x
        #     (LBRACKET)
        #     (type_qualifier_list)
        #     (static)
        #     (assignment_expression)
        #     (RBRACKET)
    
        my si:void_state_push
        my sym_LBRACKET
        my si:voidvalue_part
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
    
    method sequence_380 {} {
        # x
        #     (LBRACKET)
        #     ?
        #         (type_qualifier_list)
        #     (STAR)
        #     (RBRACKET)
    
        my si:void_state_push
        my sym_LBRACKET
        my si:voidvalue_part
        my optional_353
        my si:valuevalue_part
        my sym_STAR
        my si:valuevalue_part
        my sym_RBRACKET
        my si:value_state_merge
        return
    }
    
    method sequence_385 {} {
        # x
        #     (LPAREN)
        #     (parameter_type_list)
        #     (RPAREN)
    
        my si:void_state_push
        my sym_LPAREN
        my si:voidvalue_part
        my sym_parameter_type_list
        my si:valuevalue_part
        my sym_RPAREN
        my si:value_state_merge
        return
    }
    
    method sequence_392 {} {
        # x
        #     (LPAREN)
        #     ?
        #         (identifier_list)
        #     (RPAREN)
    
        my si:void_state_push
        my sym_LPAREN
        my si:voidvalue_part
        my optional_389
        my si:valuevalue_part
        my sym_RPAREN
        my si:value_state_merge
        return
    }
    
    method optional_389 {} {
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
        my sequence_399
        my si:void_leaf_symbol_end DOT
        return
    }
    
    method sequence_399 {} {
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
        my sequence_404
        my si:void_leaf_symbol_end double
        return
    }
    
    method sequence_404 {} {
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
        my sequence_409
        my si:void_leaf_symbol_end ELLIPSIS
        return
    }
    
    method sequence_409 {} {
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
        my sequence_414
        my si:void_leaf_symbol_end enum
        return
    }
    
    method sequence_414 {} {
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
        my choice_439
        my si:reduce_symbol_end enum_specifier
        return
    }
    
    method choice_439 {} {
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
        my sequence_424
        my si:valuevalue_branch
        my sequence_433
        my si:valuevalue_branch
        my sequence_437
        my si:value_state_merge
        return
    }
    
    method sequence_424 {} {
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
        my optional_419
        my si:valuevalue_part
        my sym_LBRACE
        my si:valuevalue_part
        my sym_enumerator_list
        my si:valuevalue_part
        my sym_RBRACE
        my si:value_state_merge
        return
    }
    
    method optional_419 {} {
        # ?
        #     (identifier)
    
        my si:void2_state_push
        my sym_identifier
        my si:void_state_merge_ok
        return
    }
    
    method sequence_433 {} {
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
        my optional_419
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
    
    method sequence_437 {} {
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
        my sequence_451
        my si:reduce_symbol_end enumerator
        return
    }
    
    method sequence_451 {} {
        # x
        #     (enumeration_constant)
        #     ?
        #         x
        #             (EQUAL)
        #             (constant_expression)
    
        my si:value_state_push
        my sym_enumeration_constant
        my si:valuevalue_part
        my optional_449
        my si:value_state_merge
        return
    }
    
    method optional_449 {} {
        # ?
        #     x
        #         (EQUAL)
        #         (constant_expression)
    
        my si:void2_state_push
        my sequence_447
        my si:void_state_merge_ok
        return
    }
    
    method sequence_447 {} {
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
        my sequence_461
        my si:reduce_symbol_end enumerator_list
        return
    }
    
    method sequence_461 {} {
        # x
        #     (enumerator)
        #     *
        #         x
        #             (COMMA)
        #             (enumerator)
    
        my si:value_state_push
        my sym_enumerator
        my si:valuevalue_part
        my kleene_459
        my si:value_state_merge
        return
    }
    
    method kleene_459 {} {
        # *
        #     x
        #         (COMMA)
        #         (enumerator)
    
        while {1} {
            my si:void2_state_push
        my sequence_457
            my si:kleene_close
        }
        return
    }
    
    method sequence_457 {} {
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
        my notahead_465
        my si:void_clear_symbol_end EOF
        return
    }
    
    method notahead_465 {} {
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
        my sequence_470
        my si:void_leaf_symbol_end EQUAL
        return
    }
    
    method sequence_470 {} {
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
        my sequence_475
        my si:void_leaf_symbol_end EQUALEQUAL
        return
    }
    
    method sequence_475 {} {
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
        my sequence_488
        my si:reduce_symbol_end equality_expression
        return
    }
    
    method sequence_488 {} {
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
        my kleene_486
        my si:value_state_merge
        return
    }
    
    method kleene_486 {} {
        # *
        #     x
        #         /
        #             (EQUALEQUAL)
        #             (PLINGEQUAL)
        #         (relational_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_484
            my si:kleene_close
        }
        return
    }
    
    method sequence_484 {} {
        # x
        #     /
        #         (EQUALEQUAL)
        #         (PLINGEQUAL)
        #     (relational_expression)
    
        my si:value_state_push
        my choice_481
        my si:valuevalue_part
        my sym_relational_expression
        my si:value_state_merge
        return
    }
    
    method choice_481 {} {
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
        my choice_495
        my si:reduce_symbol_end escape_sequence
        return
    }
    
    method choice_495 {} {
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
        my sequence_505
        my si:reduce_symbol_end exclusive_OR_expression
        return
    }
    
    method sequence_505 {} {
        # x
        #     (AND_expression)
        #     *
        #         x
        #             (HAT)
        #             (AND_expression)
    
        my si:value_state_push
        my sym_AND_expression
        my si:valuevalue_part
        my kleene_503
        my si:value_state_merge
        return
    }
    
    method kleene_503 {} {
        # *
        #     x
        #         (HAT)
        #         (AND_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_501
            my si:kleene_close
        }
        return
    }
    
    method sequence_501 {} {
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
        my sequence_512
        my si:reduce_symbol_end exponent_part
        return
    }
    
    method sequence_512 {} {
        # x
        #     [eE]
        #     ?
        #         (sign)
        #     (digit_sequence)
    
        my si:void_state_push
        my si:next_class eE
        my si:voidvalue_part
        my optional_137
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
        my sequence_524
        my si:void_leaf_symbol_end extern
        return
    }
    
    method sequence_524 {} {
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
        my sequence_529
        my si:void_leaf_symbol_end float
        return
    }
    
    method sequence_529 {} {
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
        my choice_534
        my si:reduce_symbol_end floating_constant
        return
    }
    
    method choice_534 {} {
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
        my choice_550
        my si:reduce_symbol_end fractional_constant
        return
    }
    
    method choice_550 {} {
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
        my sequence_544
        my si:valuevalue_branch
        my sequence_548
        my si:value_state_merge
        return
    }
    
    method sequence_544 {} {
        # x
        #     ?
        #         (digit_sequence)
        #     '.'
        #     (digit_sequence)
    
        my si:value_state_push
        my optional_540
        my si:valuevalue_part
        my si:next_char .
        my si:valuevalue_part
        my sym_digit_sequence
        my si:value_state_merge
        return
    }
    
    method optional_540 {} {
        # ?
        #     (digit_sequence)
    
        my si:void2_state_push
        my sym_digit_sequence
        my si:void_state_merge_ok
        return
    }
    
    method sequence_548 {} {
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
        my sequence_557
        my si:void_leaf_symbol_end GREATER
        return
    }
    
    method sequence_557 {} {
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
        my sequence_562
        my si:void_leaf_symbol_end GREATEREQUAL
        return
    }
    
    method sequence_562 {} {
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
        my sequence_567
        my si:void_leaf_symbol_end GREATERGREATER
        return
    }
    
    method sequence_567 {} {
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
        my sequence_572
        my si:void_leaf_symbol_end GREATERGREATEREQUAL
        return
    }
    
    method sequence_572 {} {
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
        my sequence_577
        my si:void_leaf_symbol_end HAT
        return
    }
    
    method sequence_577 {} {
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
        my sequence_582
        my si:void_leaf_symbol_end HATEQUAL
        return
    }
    
    method sequence_582 {} {
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
        my sequence_589
        my si:reduce_symbol_end hexadecimal_constant
        return
    }
    
    method sequence_589 {} {
        # x
        #     (hexadecimal_prefix)
        #     +
        #         (hexadecimal_digit)
    
        my si:value_state_push
        my sym_hexadecimal_prefix
        my si:valuevalue_part
        my poskleene_587
        my si:value_state_merge
        return
    }
    
    method poskleene_587 {} {
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
        my choice_599
        my si:reduce_symbol_end hexadecimal_digit_sequence
        return
    }
    
    method choice_599 {} {
        # /
        #     (hexadecimal_digit)
        #     x
        #         (hexadecimal_digit_sequence)
        #         (hexadecimal_digit)
    
        my si:value_state_push
        my sym_hexadecimal_digit
        my si:valuevalue_branch
        my sequence_597
        my si:value_state_merge
        return
    }
    
    method sequence_597 {} {
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
        my sequence_605
        my si:reduce_symbol_end hexadecimal_escape_sequence
        return
    }
    
    method sequence_605 {} {
        # x
        #     "\x"
        #     +
        #         (hexadecimal_digit)
    
        my si:void_state_push
        my si:next_str \134x
        my si:voidvalue_part
        my poskleene_587
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
        my choice_622
        my si:reduce_symbol_end hexadecimal_floating_constant
        return
    }
    
    method choice_622 {} {
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
        my sequence_613
        my si:valuevalue_branch
        my sequence_620
        my si:value_state_merge
        return
    }
    
    method sequence_613 {} {
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
        my optional_233
        my si:value_state_merge
        return
    }
    
    method sequence_620 {} {
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
        my optional_233
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
        my choice_636
        my si:reduce_symbol_end hexadecimal_fractional_constant
        return
    }
    
    method choice_636 {} {
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
        my sequence_630
        my si:valuevalue_branch
        my sequence_634
        my si:value_state_merge
        return
    }
    
    method sequence_630 {} {
        # x
        #     ?
        #         (hexadecimal_digit_sequence)
        #     '.'
        #     (hexadecimal_digit_sequence)
    
        my si:value_state_push
        my optional_626
        my si:valuevalue_part
        my si:next_char .
        my si:valuevalue_part
        my sym_hexadecimal_digit_sequence
        my si:value_state_merge
        return
    }
    
    method optional_626 {} {
        # ?
        #     (hexadecimal_digit_sequence)
    
        my si:void2_state_push
        my sym_hexadecimal_digit_sequence
        my si:void_state_merge_ok
        return
    }
    
    method sequence_634 {} {
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
        my choice_641
        my si:void_leaf_symbol_end hexadecimal_prefix
        return
    }
    
    method choice_641 {} {
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
        #     <alpha>
        #     *
        #         /
        #             <alnum>
        #             '_'
        #     (WHITESPACE)
    
        my si:void_symbol_start identifier
        my sequence_652
        my si:void_leaf_symbol_end identifier
        return
    }
    
    method sequence_652 {} {
        # x
        #     <alpha>
        #     *
        #         /
        #             <alnum>
        #             '_'
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_alpha
        my si:voidvoid_part
        my kleene_649
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    method kleene_649 {} {
        # *
        #     /
        #         <alnum>
        #         '_'
    
        while {1} {
            my si:void2_state_push
        my choice_647
            my si:kleene_close
        }
        return
    }
    
    method choice_647 {} {
        # /
        #     <alnum>
        #     '_'
    
        my si:void_state_push
        my si:next_alnum
        my si:voidvoid_branch
        my si:next_char _
        my si:void_state_merge
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
        my sequence_662
        my si:reduce_symbol_end identifier_list
        return
    }
    
    method sequence_662 {} {
        # x
        #     (identifier)
        #     *
        #         x
        #             (COMMA)
        #             (identifier)
    
        my si:value_state_push
        my sym_identifier
        my si:valuevalue_part
        my kleene_660
        my si:value_state_merge
        return
    }
    
    method kleene_660 {} {
        # *
        #     x
        #         (COMMA)
        #         (identifier)
    
        while {1} {
            my si:void2_state_push
        my sequence_658
            my si:kleene_close
        }
        return
    }
    
    method sequence_658 {} {
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
        my sequence_672
        my si:reduce_symbol_end inclusive_OR_expression
        return
    }
    
    method sequence_672 {} {
        # x
        #     (exclusive_OR_expression)
        #     *
        #         x
        #             (BAR)
        #             (exclusive_OR_expression)
    
        my si:value_state_push
        my sym_exclusive_OR_expression
        my si:valuevalue_part
        my kleene_670
        my si:value_state_merge
        return
    }
    
    method kleene_670 {} {
        # *
        #     x
        #         (BAR)
        #         (exclusive_OR_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_668
            my si:kleene_close
        }
        return
    }
    
    method sequence_668 {} {
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
        my sequence_687
        my si:reduce_symbol_end initializer_list
        return
    }
    
    method sequence_687 {} {
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
        my optional_676
        my si:valuevalue_part
        my i_status_fail ; # Undefined symbol 'initializer'
        my si:valuevalue_part
        my kleene_685
        my si:value_state_merge
        return
    }
    
    method optional_676 {} {
        # ?
        #     (designation)
    
        my si:void2_state_push
        my sym_designation
        my si:void_state_merge_ok
        return
    }
    
    method kleene_685 {} {
        # *
        #     x
        #         (COMMA)
        #         ?
        #             (designation)
        #         (initializer)
    
        while {1} {
            my si:void2_state_push
        my sequence_683
            my si:kleene_close
        }
        return
    }
    
    method sequence_683 {} {
        # x
        #     (COMMA)
        #     ?
        #         (designation)
        #     (initializer)
    
        my si:void_state_push
        my sym_COMMA
        my si:voidvalue_part
        my optional_676
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
        my sequence_692
        my si:void_leaf_symbol_end inline
        return
    }
    
    method sequence_692 {} {
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
        my sequence_697
        my si:void_leaf_symbol_end int
        return
    }
    
    method sequence_697 {} {
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
        my sequence_702
        my si:void_leaf_symbol_end int8_t
        return
    }
    
    method sequence_702 {} {
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
        my sequence_707
        my si:void_leaf_symbol_end int16_t
        return
    }
    
    method sequence_707 {} {
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
        my sequence_712
        my si:void_leaf_symbol_end int32_t
        return
    }
    
    method sequence_712 {} {
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
        my sequence_717
        my si:void_leaf_symbol_end int64_t
        return
    }
    
    method sequence_717 {} {
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
        my sequence_722
        my si:void_leaf_symbol_end int_fast8_t
        return
    }
    
    method sequence_722 {} {
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
        my sequence_727
        my si:void_leaf_symbol_end int_fast16_t
        return
    }
    
    method sequence_727 {} {
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
        my sequence_732
        my si:void_leaf_symbol_end int_fast32_t
        return
    }
    
    method sequence_732 {} {
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
        my sequence_737
        my si:void_leaf_symbol_end int_fast64_t
        return
    }
    
    method sequence_737 {} {
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
        my sequence_742
        my si:void_leaf_symbol_end int_least8_t
        return
    }
    
    method sequence_742 {} {
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
        my sequence_747
        my si:void_leaf_symbol_end int_least16_t
        return
    }
    
    method sequence_747 {} {
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
        my sequence_752
        my si:void_leaf_symbol_end int_least32_t
        return
    }
    
    method sequence_752 {} {
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
        my sequence_757
        my si:void_leaf_symbol_end int_least64_t
        return
    }
    
    method sequence_757 {} {
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
        my choice_776
        my si:reduce_symbol_end integer_constant
        return
    }
    
    method choice_776 {} {
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
        my sequence_764
        my si:valuevalue_branch
        my sequence_769
        my si:valuevalue_branch
        my sequence_774
        my si:value_state_merge
        return
    }
    
    method sequence_764 {} {
        # x
        #     (decimal_constant)
        #     ?
        #         (integer_suffix)
    
        my si:value_state_push
        my sym_decimal_constant
        my si:valuevalue_part
        my optional_762
        my si:value_state_merge
        return
    }
    
    method optional_762 {} {
        # ?
        #     (integer_suffix)
    
        my si:void2_state_push
        my sym_integer_suffix
        my si:void_state_merge_ok
        return
    }
    
    method sequence_769 {} {
        # x
        #     (octal_constant)
        #     ?
        #         (integer_suffix)
    
        my si:value_state_push
        my sym_octal_constant
        my si:valuevalue_part
        my optional_762
        my si:value_state_merge
        return
    }
    
    method sequence_774 {} {
        # x
        #     (hexadecimal_constant)
        #     ?
        #         (integer_suffix)
    
        my si:value_state_push
        my sym_hexadecimal_constant
        my si:valuevalue_part
        my optional_762
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
        my choice_800
        my si:reduce_symbol_end integer_suffix
        return
    }
    
    method choice_800 {} {
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
        my sequence_783
        my si:valuevalue_branch
        my sequence_787
        my si:valuevalue_branch
        my sequence_793
        my si:valuevalue_branch
        my sequence_798
        my si:value_state_merge
        return
    }
    
    method sequence_783 {} {
        # x
        #     (unsigned_suffix)
        #     ?
        #         (long_suffix)
    
        my si:value_state_push
        my sym_unsigned_suffix
        my si:valuevalue_part
        my optional_781
        my si:value_state_merge
        return
    }
    
    method optional_781 {} {
        # ?
        #     (long_suffix)
    
        my si:void2_state_push
        my sym_long_suffix
        my si:void_state_merge_ok
        return
    }
    
    method sequence_787 {} {
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
    
    method sequence_793 {} {
        # x
        #     (long_suffix)
        #     ?
        #         (unsigned_suffix)
    
        my si:value_state_push
        my sym_long_suffix
        my si:valuevalue_part
        my optional_791
        my si:value_state_merge
        return
    }
    
    method optional_791 {} {
        # ?
        #     (unsigned_suffix)
    
        my si:void2_state_push
        my sym_unsigned_suffix
        my si:void_state_merge_ok
        return
    }
    
    method sequence_798 {} {
        # x
        #     (long_long_suffix)
        #     ?
        #         (unsigned_suffix)
    
        my si:value_state_push
        my sym_long_long_suffix
        my si:valuevalue_part
        my optional_791
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
        my sequence_805
        my si:void_leaf_symbol_end intmax_t
        return
    }
    
    method sequence_805 {} {
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
        my sequence_810
        my si:void_leaf_symbol_end intptr_t
        return
    }
    
    method sequence_810 {} {
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
    # void Symbol 'LBRACE'
    #
    
    method sym_LBRACE {} {
        # x
        #     '\{'
        #     (WHITESPACE)
    
        my si:void_void_symbol_start LBRACE
        my sequence_815
        my si:void_clear_symbol_end LBRACE
        return
    }
    
    method sequence_815 {} {
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
    # void Symbol 'LBRACKET'
    #
    
    method sym_LBRACKET {} {
        # x
        #     '['
        #     (WHITESPACE)
    
        my si:void_void_symbol_start LBRACKET
        my sequence_820
        my si:void_clear_symbol_end LBRACKET
        return
    }
    
    method sequence_820 {} {
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
        my sequence_825
        my si:void_leaf_symbol_end LESS
        return
    }
    
    method sequence_825 {} {
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
        my sequence_830
        my si:void_leaf_symbol_end LESSEQUAL
        return
    }
    
    method sequence_830 {} {
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
        my sequence_835
        my si:void_leaf_symbol_end LESSLESS
        return
    }
    
    method sequence_835 {} {
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
        my sequence_840
        my si:void_leaf_symbol_end LESSLESSEQUAL
        return
    }
    
    method sequence_840 {} {
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
        my sequence_850
        my si:reduce_symbol_end logical_AND_expression
        return
    }
    
    method sequence_850 {} {
        # x
        #     (inclusive_OR_expression)
        #     *
        #         x
        #             (ANDAND)
        #             (inclusive_OR_expression)
    
        my si:value_state_push
        my sym_inclusive_OR_expression
        my si:valuevalue_part
        my kleene_848
        my si:value_state_merge
        return
    }
    
    method kleene_848 {} {
        # *
        #     x
        #         (ANDAND)
        #         (inclusive_OR_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_846
            my si:kleene_close
        }
        return
    }
    
    method sequence_846 {} {
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
        my sequence_860
        my si:reduce_symbol_end logical_OR_expression
        return
    }
    
    method sequence_860 {} {
        # x
        #     (logical_AND_expression)
        #     *
        #         x
        #             (BARBAR)
        #             (logical_AND_expression)
    
        my si:value_state_push
        my sym_logical_AND_expression
        my si:valuevalue_part
        my kleene_858
        my si:value_state_merge
        return
    }
    
    method kleene_858 {} {
        # *
        #     x
        #         (BARBAR)
        #         (logical_AND_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_856
            my si:kleene_close
        }
        return
    }
    
    method sequence_856 {} {
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
        my sequence_865
        my si:void_leaf_symbol_end long
        return
    }
    
    method sequence_865 {} {
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
        my choice_870
        my si:void_leaf_symbol_end long_long_suffix
        return
    }
    
    method choice_870 {} {
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
    # void Symbol 'LPAREN'
    #
    
    method sym_LPAREN {} {
        # x
        #     '\('
        #     (WHITESPACE)
    
        my si:void_void_symbol_start LPAREN
        my sequence_877
        my si:void_clear_symbol_end LPAREN
        return
    }
    
    method sequence_877 {} {
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
        my sequence_882
        my si:void_leaf_symbol_end MINUS
        return
    }
    
    method sequence_882 {} {
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
        my sequence_887
        my si:void_leaf_symbol_end MINUSEQUAL
        return
    }
    
    method sequence_887 {} {
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
        my sequence_892
        my si:void_leaf_symbol_end MINUSMINUS
        return
    }
    
    method sequence_892 {} {
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
        my sequence_906
        my si:reduce_symbol_end multiplicative_expression
        return
    }
    
    method sequence_906 {} {
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
        my kleene_904
        my si:value_state_merge
        return
    }
    
    method kleene_904 {} {
        # *
        #     x
        #         /
        #             (STAR)
        #             (SLASH)
        #             (PERCENT)
        #         (cast_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_902
            my si:kleene_close
        }
        return
    }
    
    method sequence_902 {} {
        # x
        #     /
        #         (STAR)
        #         (SLASH)
        #         (PERCENT)
        #     (cast_expression)
    
        my si:value_state_push
        my choice_899
        my si:valuevalue_part
        my sym_cast_expression
        my si:value_state_merge
        return
    }
    
    method choice_899 {} {
        # /
        #     (STAR)
        #     (SLASH)
        #     (PERCENT)
    
        my si:void_state_push
        my sym_STAR
        my si:voidvalue_branch
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
        my sequence_915
        my si:reduce_symbol_end octal_constant
        return
    }
    
    method sequence_915 {} {
        # x
        #     '0'
        #     *
        #         (octal_digit)
    
        my si:void_state_push
        my si:next_char 0
        my si:voidvalue_part
        my kleene_913
        my si:value_state_merge
        return
    }
    
    method kleene_913 {} {
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
        my choice_935
        my si:reduce_symbol_end octal_escape_sequence
        return
    }
    
    method choice_935 {} {
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
        my sequence_922
        my si:valuevalue_branch
        my sequence_927
        my si:valuevalue_branch
        my sequence_933
        my si:value_state_merge
        return
    }
    
    method sequence_922 {} {
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
    
    method sequence_927 {} {
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
    
    method sequence_933 {} {
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
        my choice_948
        my si:reduce_symbol_end parameter_declaration
        return
    }
    
    method choice_948 {} {
        # /
        #     x
        #         (declaration_specifiers)
        #         (declarator)
        #     x
        #         (declaration_specifiers)
        #         ?
        #             (abstract_declarator)
    
        my si:value_state_push
        my sequence_940
        my si:valuevalue_branch
        my sequence_946
        my si:value_state_merge
        return
    }
    
    method sequence_940 {} {
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
    
    method sequence_946 {} {
        # x
        #     (declaration_specifiers)
        #     ?
        #         (abstract_declarator)
    
        my si:value_state_push
        my sym_declaration_specifiers
        my si:valuevalue_part
        my optional_944
        my si:value_state_merge
        return
    }
    
    method optional_944 {} {
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
        my sequence_958
        my si:reduce_symbol_end parameter_list
        return
    }
    
    method sequence_958 {} {
        # x
        #     (parameter_declaration)
        #     *
        #         x
        #             (COMMA)
        #             (parameter_declaration)
    
        my si:value_state_push
        my sym_parameter_declaration
        my si:valuevalue_part
        my kleene_956
        my si:value_state_merge
        return
    }
    
    method kleene_956 {} {
        # *
        #     x
        #         (COMMA)
        #         (parameter_declaration)
    
        while {1} {
            my si:void2_state_push
        my sequence_954
            my si:kleene_close
        }
        return
    }
    
    method sequence_954 {} {
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
        my sequence_968
        my si:reduce_symbol_end parameter_type_list
        return
    }
    
    method sequence_968 {} {
        # x
        #     (parameter_list)
        #     ?
        #         x
        #             (COMMA)
        #             (ELLIPSIS)
    
        my si:value_state_push
        my sym_parameter_list
        my si:valuevalue_part
        my optional_966
        my si:value_state_merge
        return
    }
    
    method optional_966 {} {
        # ?
        #     x
        #         (COMMA)
        #         (ELLIPSIS)
    
        my si:void2_state_push
        my sequence_964
        my si:void_state_merge_ok
        return
    }
    
    method sequence_964 {} {
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
        my sequence_973
        my si:void_leaf_symbol_end PERCEN
        return
    }
    
    method sequence_973 {} {
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
        my sequence_978
        my si:void_leaf_symbol_end PERCENTEQUAL
        return
    }
    
    method sequence_978 {} {
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
        my sequence_983
        my si:void_leaf_symbol_end PLING
        return
    }
    
    method sequence_983 {} {
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
        my sequence_988
        my si:void_leaf_symbol_end PLINGEQUAL
        return
    }
    
    method sequence_988 {} {
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
        my sequence_993
        my si:void_leaf_symbol_end PLUS
        return
    }
    
    method sequence_993 {} {
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
        my sequence_998
        my si:void_leaf_symbol_end PLUSEQUAL
        return
    }
    
    method sequence_998 {} {
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
        my sequence_1003
        my si:void_leaf_symbol_end PLUSPLUS
        return
    }
    
    method sequence_1003 {} {
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
        my poskleene_1011
        my si:reduce_symbol_end pointer
        return
    }
    
    method poskleene_1011 {} {
        # +
        #     x
        #         (STAR)
        #         ?
        #             (type_qualifier_list)
    
        my i_loc_push
        my sequence_1009
        my si:kleene_abort
        while {1} {
            my si:void2_state_push
        my sequence_1009
            my si:kleene_close
        }
        return
    }
    
    method sequence_1009 {} {
        # x
        #     (STAR)
        #     ?
        #         (type_qualifier_list)
    
        my si:void_state_push
        my sym_STAR
        my si:voidvalue_part
        my optional_353
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
        my sequence_1018
        my si:reduce_symbol_end postfix_expression
        return
    }
    
    method sequence_1018 {} {
        # x
        #     (postfix_expression_head)
        #     *
        #         (postfix_expression_tail)
    
        my si:value_state_push
        my sym_postfix_expression_head
        my si:valuevalue_part
        my kleene_1016
        my si:value_state_merge
        return
    }
    
    method kleene_1016 {} {
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
        my choice_1039
        my si:reduce_symbol_end postfix_expression_head
        return
    }
    
    method choice_1039 {} {
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
        my sequence_1028
        my si:valuevalue_branch
        my sequence_1037
        my si:value_state_merge
        return
    }
    
    method sequence_1028 {} {
        # x
        #     (LPAREN)
        #     (type_name)
        #     (RPAREN)
        #     (LBRACE)
        #     (initializer_list)
        #     (RBRACE)
    
        my si:void_state_push
        my sym_LPAREN
        my si:voidvalue_part
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
    
    method sequence_1037 {} {
        # x
        #     (LPAREN)
        #     (type_name)
        #     (RPAREN)
        #     (LBRACE)
        #     (initializer_list)
        #     (COMMA)
        #     (RBRACE)
    
        my si:void_state_push
        my sym_LPAREN
        my si:voidvalue_part
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
        my choice_1063
        my si:reduce_symbol_end postfix_expression_tail
        return
    }
    
    method choice_1063 {} {
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
        my sequence_1045
        my si:valuevalue_branch
        my sequence_1052
        my si:valuevalue_branch
        my sequence_288
        my si:valuevalue_branch
        my sequence_1059
        my si:valuevalue_branch
        my sym_PLUSPLUS
        my si:valuevalue_branch
        my sym_MINUSMINUS
        my si:value_state_merge
        return
    }
    
    method sequence_1045 {} {
        # x
        #     (LBRACKET)
        #     (expression)
        #     (RBRACKET)
    
        my si:void_state_push
        my sym_LBRACKET
        my si:voidvalue_part
        my sym_expression
        my si:valuevalue_part
        my sym_RBRACKET
        my si:value_state_merge
        return
    }
    
    method sequence_1052 {} {
        # x
        #     (LPAREN)
        #     ?
        #         (argument_expression_list)
        #     (RPAREN)
    
        my si:void_state_push
        my sym_LPAREN
        my si:voidvalue_part
        my optional_1049
        my si:valuevalue_part
        my sym_RPAREN
        my si:value_state_merge
        return
    }
    
    method optional_1049 {} {
        # ?
        #     (argument_expression_list)
    
        my si:void2_state_push
        my sym_argument_expression_list
        my si:void_state_merge_ok
        return
    }
    
    method sequence_1059 {} {
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
        my choice_1074
        my si:reduce_symbol_end primary_expression
        return
    }
    
    method choice_1074 {} {
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
        my sequence_1072
        my si:value_state_merge
        return
    }
    
    method sequence_1072 {} {
        # x
        #     (LPAREN)
        #     (expression)
        #     (RPAREN)
    
        my si:void_state_push
        my sym_LPAREN
        my si:voidvalue_part
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
        my sequence_1079
        my si:void_leaf_symbol_end ptrdiff_t
        return
    }
    
    method sequence_1079 {} {
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
        my sequence_1084
        my si:void_leaf_symbol_end QUERY
        return
    }
    
    method sequence_1084 {} {
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
    # void Symbol 'RBRACE'
    #
    
    method sym_RBRACE {} {
        # x
        #     '\}'
        #     (WHITESPACE)
    
        my si:void_void_symbol_start RBRACE
        my sequence_1089
        my si:void_clear_symbol_end RBRACE
        return
    }
    
    method sequence_1089 {} {
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
    # void Symbol 'RBRACKET'
    #
    
    method sym_RBRACKET {} {
        # x
        #     ']'
        #     (WHITESPACE)
    
        my si:void_void_symbol_start RBRACKET
        my sequence_1094
        my si:void_clear_symbol_end RBRACKET
        return
    }
    
    method sequence_1094 {} {
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
        my sequence_1099
        my si:void_leaf_symbol_end register
        return
    }
    
    method sequence_1099 {} {
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
        my sequence_1114
        my si:reduce_symbol_end relational_expression
        return
    }
    
    method sequence_1114 {} {
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
        my kleene_1112
        my si:value_state_merge
        return
    }
    
    method kleene_1112 {} {
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
        my sequence_1110
            my si:kleene_close
        }
        return
    }
    
    method sequence_1110 {} {
        # x
        #     /
        #         (LESSEQUAL)
        #         (GREATEREQUAL)
        #         (LESS)
        #         (GREATER)
        #     (shift_expression)
    
        my si:value_state_push
        my choice_1107
        my si:valuevalue_part
        my sym_shift_expression
        my si:value_state_merge
        return
    }
    
    method choice_1107 {} {
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
        my sequence_1119
        my si:void_leaf_symbol_end restrict
        return
    }
    
    method sequence_1119 {} {
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
    # void Symbol 'RPAREN'
    #
    
    method sym_RPAREN {} {
        # x
        #     '\)'
        #     (WHITESPACE)
    
        my si:void_void_symbol_start RPAREN
        my sequence_1124
        my si:void_clear_symbol_end RPAREN
        return
    }
    
    method sequence_1124 {} {
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
        my choice_1129
        my si:reduce_symbol_end s_char
        return
    }
    
    method choice_1129 {} {
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
        my sequence_1134
        my si:void_clear_symbol_end SEMICOLON
        return
    }
    
    method sequence_1134 {} {
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
        my sequence_1147
        my si:reduce_symbol_end shift_expression
        return
    }
    
    method sequence_1147 {} {
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
        my kleene_1145
        my si:value_state_merge
        return
    }
    
    method kleene_1145 {} {
        # *
        #     x
        #         /
        #             (LESSLESS)
        #             (GREATERGREATER)
        #         (additive_expression)
    
        while {1} {
            my si:void2_state_push
        my sequence_1143
            my si:kleene_close
        }
        return
    }
    
    method sequence_1143 {} {
        # x
        #     /
        #         (LESSLESS)
        #         (GREATERGREATER)
        #     (additive_expression)
    
        my si:value_state_push
        my choice_1140
        my si:valuevalue_part
        my sym_additive_expression
        my si:value_state_merge
        return
    }
    
    method choice_1140 {} {
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
        my sequence_1152
        my si:void_leaf_symbol_end short
        return
    }
    
    method sequence_1152 {} {
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
        my sequence_1159
        my si:void_leaf_symbol_end signed
        return
    }
    
    method sequence_1159 {} {
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
        my sequence_1164
        my si:void_leaf_symbol_end simple_escape_sequence
        return
    }
    
    method sequence_1164 {} {
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
        my sequence_1169
        my si:void_leaf_symbol_end size_t
        return
    }
    
    method sequence_1169 {} {
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
        my sequence_1174
        my si:void_leaf_symbol_end sizeof
        return
    }
    
    method sequence_1174 {} {
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
        my sequence_1179
        my si:void_leaf_symbol_end SLASH
        return
    }
    
    method sequence_1179 {} {
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
        my sequence_1184
        my si:void_leaf_symbol_end SLASHEQUAL
        return
    }
    
    method sequence_1184 {} {
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
        my poskleene_1191
        my si:reduce_symbol_end specifier_qualifier_list
        return
    }
    
    method poskleene_1191 {} {
        # +
        #     /
        #         (type_specifier)
        #         (type_qualifier)
    
        my i_loc_push
        my choice_1189
        my si:kleene_abort
        while {1} {
            my si:void2_state_push
        my choice_1189
            my si:kleene_close
        }
        return
    }
    
    method choice_1189 {} {
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
    # void Symbol 'STAR'
    #
    
    method sym_STAR {} {
        # x
        #     '*'
        #     (WHITESPACE)
    
        my si:void_void_symbol_start STAR
        my sequence_1196
        my si:void_clear_symbol_end STAR
        return
    }
    
    method sequence_1196 {} {
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
        my sequence_1201
        my si:void_leaf_symbol_end STAREQUAL
        return
    }
    
    method sequence_1201 {} {
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
        my sequence_1206
        my si:void_leaf_symbol_end static
        return
    }
    
    method sequence_1206 {} {
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
        my choice_1214
        my si:reduce_symbol_end storage_class_specifier
        return
    }
    
    method choice_1214 {} {
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
        my sequence_1224
        my si:reduce_symbol_end string_literal
        return
    }
    
    method sequence_1224 {} {
        # x
        #     ?
        #         'L'
        #     '\"'
        #     *
        #         (s_char)
        #     '\"'
    
        my si:void_state_push
        my optional_177
        my si:voidvoid_part
        my si:next_char \42
        my si:voidvalue_part
        my kleene_1221
        my si:valuevalue_part
        my si:next_char \42
        my si:value_state_merge
        return
    }
    
    method kleene_1221 {} {
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
        my sequence_1229
        my si:void_leaf_symbol_end struct
        return
    }
    
    method sequence_1229 {} {
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
        my sequence_1235
        my si:reduce_symbol_end struct_declaration
        return
    }
    
    method sequence_1235 {} {
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
        my poskleene_1239
        my si:reduce_symbol_end struct_declaration_list
        return
    }
    
    method poskleene_1239 {} {
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
        my choice_1250
        my si:reduce_symbol_end struct_declarator
        return
    }
    
    method choice_1250 {} {
        # /
        #     x
        #         ?
        #             (declarator)
        #         (COLON)
        #         (constant_expression)
        #     (declarator)
    
        my si:value_state_push
        my sequence_1247
        my si:valuevalue_branch
        my sym_declarator
        my si:value_state_merge
        return
    }
    
    method sequence_1247 {} {
        # x
        #     ?
        #         (declarator)
        #     (COLON)
        #     (constant_expression)
    
        my si:value_state_push
        my optional_1243
        my si:valuevalue_part
        my sym_COLON
        my si:valuevalue_part
        my sym_constant_expression
        my si:value_state_merge
        return
    }
    
    method optional_1243 {} {
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
        my sequence_1260
        my si:reduce_symbol_end struct_declarator_list
        return
    }
    
    method sequence_1260 {} {
        # x
        #     (struct_declarator)
        #     *
        #         x
        #             (COMMA)
        #             (struct_declarator)
    
        my si:value_state_push
        my sym_struct_declarator
        my si:valuevalue_part
        my kleene_1258
        my si:value_state_merge
        return
    }
    
    method kleene_1258 {} {
        # *
        #     x
        #         (COMMA)
        #         (struct_declarator)
    
        while {1} {
            my si:void2_state_push
        my sequence_1256
            my si:kleene_close
        }
        return
    }
    
    method sequence_1256 {} {
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
        my choice_1265
        my si:reduce_symbol_end struct_or_union
        return
    }
    
    method choice_1265 {} {
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
        my choice_1280
        my si:reduce_symbol_end struct_or_union_specifier
        return
    }
    
    method choice_1280 {} {
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
        my sequence_1274
        my si:valuevalue_branch
        my sequence_1278
        my si:value_state_merge
        return
    }
    
    method sequence_1274 {} {
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
        my optional_419
        my si:valuevalue_part
        my sym_LBRACE
        my si:valuevalue_part
        my sym_struct_declaration_list
        my si:valuevalue_part
        my sym_RBRACE
        my si:value_state_merge
        return
    }
    
    method sequence_1278 {} {
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
        my sequence_1285
        my si:void_leaf_symbol_end TILDE
        return
    }
    
    method sequence_1285 {} {
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
        my sequence_1292
        my si:reduce_symbol_end type_name
        return
    }
    
    method sequence_1292 {} {
        # x
        #     (specifier_qualifier_list)
        #     ?
        #         (abstract_declarator)
        #     (EOF)
    
        my si:value_state_push
        my sym_specifier_qualifier_list
        my si:valuevalue_part
        my optional_944
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
        my choice_1298
        my si:reduce_symbol_end type_qualifier
        return
    }
    
    method choice_1298 {} {
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
        my poskleene_1302
        my si:reduce_symbol_end type_qualifier_list
        return
    }
    
    method poskleene_1302 {} {
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
        #     (_Complex)
        #     (_Imaginary)
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
        #     (bool)
        #     (typedef_name)
    
        my si:value_symbol_start type_specifier
        my choice_1351
        my si:reduce_symbol_end type_specifier
        return
    }
    
    method choice_1351 {} {
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
        #     (_Complex)
        #     (_Imaginary)
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
        #     (bool)
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
        my sym__Complex
        my si:valuevalue_branch
        my sym__Imaginary
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
        my sym_bool
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
        my sequence_1356
        my si:void_leaf_symbol_end typedef
        return
    }
    
    method sequence_1356 {} {
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
        # x
        #     <upper>
        #     *
        #         <alnum>
        #     "_t"
        #     (WHITESPACE)
    
        my si:void_symbol_start typedef_name
        my sequence_1365
        my si:void_leaf_symbol_end typedef_name
        return
    }
    
    method sequence_1365 {} {
        # x
        #     <upper>
        #     *
        #         <alnum>
        #     "_t"
        #     (WHITESPACE)
    
        my si:void_state_push
        my si:next_upper
        my si:voidvoid_part
        my kleene_1361
        my si:voidvoid_part
        my si:next_str _t
        my si:voidvoid_part
        my sym_WHITESPACE
        my si:void_state_merge
        return
    }
    
    method kleene_1361 {} {
        # *
        #     <alnum>
    
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
        my sequence_1370
        my si:void_leaf_symbol_end uint8_t
        return
    }
    
    method sequence_1370 {} {
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
        my sequence_1375
        my si:void_leaf_symbol_end uint16_t
        return
    }
    
    method sequence_1375 {} {
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
        my sequence_1380
        my si:void_leaf_symbol_end uint32_t
        return
    }
    
    method sequence_1380 {} {
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
        my sequence_1385
        my si:void_leaf_symbol_end uint64_t
        return
    }
    
    method sequence_1385 {} {
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
        my sequence_1390
        my si:void_leaf_symbol_end uint_fast8_t
        return
    }
    
    method sequence_1390 {} {
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
        my sequence_1395
        my si:void_leaf_symbol_end uint_fast16_t
        return
    }
    
    method sequence_1395 {} {
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
        my sequence_1400
        my si:void_leaf_symbol_end uint_fast32_t
        return
    }
    
    method sequence_1400 {} {
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
        my sequence_1405
        my si:void_leaf_symbol_end uint_fast64_t
        return
    }
    
    method sequence_1405 {} {
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
        my sequence_1410
        my si:void_leaf_symbol_end uint_least8_t
        return
    }
    
    method sequence_1410 {} {
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
        my sequence_1415
        my si:void_leaf_symbol_end uint_least16_t
        return
    }
    
    method sequence_1415 {} {
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
        my sequence_1420
        my si:void_leaf_symbol_end uint_least32_t
        return
    }
    
    method sequence_1420 {} {
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
        my sequence_1425
        my si:void_leaf_symbol_end uint_least64_t
        return
    }
    
    method sequence_1425 {} {
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
        my sequence_1430
        my si:void_leaf_symbol_end uintmax_t
        return
    }
    
    method sequence_1430 {} {
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
        my sequence_1435
        my si:void_leaf_symbol_end uintptr_t
        return
    }
    
    method sequence_1435 {} {
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
        #         (type_name)
        #         (RPAREN)
    
        my si:value_symbol_start unary_expression
        my choice_1461
        my si:reduce_symbol_end unary_expression
        return
    }
    
    method choice_1461 {} {
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
        #         (type_name)
        #         (RPAREN)
    
        my si:value_state_push
        my sym_postfix_expression
        my si:valuevalue_branch
        my sequence_1441
        my si:valuevalue_branch
        my sequence_1445
        my si:valuevalue_branch
        my sequence_1449
        my si:valuevalue_branch
        my sequence_1453
        my si:valuevalue_branch
        my sequence_1459
        my si:value_state_merge
        return
    }
    
    method sequence_1441 {} {
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
    
    method sequence_1445 {} {
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
    
    method sequence_1449 {} {
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
    
    method sequence_1453 {} {
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
    
    method sequence_1459 {} {
        # x
        #     (sizeof)
        #     (LPAREN)
        #     (type_name)
        #     (RPAREN)
    
        my si:value_state_push
        my sym_sizeof
        my si:valuevalue_part
        my sym_LPAREN
        my si:valuevalue_part
        my sym_type_name
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
        my choice_1470
        my si:reduce_symbol_end unary_operator
        return
    }
    
    method choice_1470 {} {
        # /
        #     (AMPERSAND)
        #     (STAR)
        #     (PLUS)
        #     (MINUS)
        #     (TILDE)
        #     (PLING)
    
        my si:value_state_push
        my sym_AMPERSAND
        my si:valuevoid_branch
        my sym_STAR
        my si:voidvalue_branch
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
        my sequence_1475
        my si:void_leaf_symbol_end union
        return
    }
    
    method sequence_1475 {} {
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
        my sequence_1480
        my si:void_leaf_symbol_end unsigned
        return
    }
    
    method sequence_1480 {} {
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
        my sequence_1487
        my si:void_leaf_symbol_end void
        return
    }
    
    method sequence_1487 {} {
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
        my sequence_1492
        my si:void_leaf_symbol_end volatile
        return
    }
    
    method sequence_1492 {} {
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
        my kleene_1496
        my si:void_clear_symbol_end WHITESPACE
        return
    }
    
    method kleene_1496 {} {
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