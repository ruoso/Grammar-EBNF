
# Found on the Grammar Zoo
#   http://slps.github.io/zoo/#metasyntax
# Source: ISO/IEC 14977:1996(E), Information Technology—Syntactic
#   Metalanguage—Extended BNF, (1996), §8.1 “The syntax of Extended
#   BNF”, pages 8–10
# This is a Perl 6 grammar translation of the EBNF described above.
#
# Even though it would be possible to express this in a more concise
# way in Perl 6, I use the same rules here to make it easier to
# compare against the original for correctness.
grammar Grammar::EBNF::MetaSyntax {
    token letter {
        <[a..zA..Z]>
    }
    token decimal_digit {
        <[0..9]>
    }
    token concatenate_symbol {
        \,
    }
    token defining_symbol {
        \=
    }
    token definition_separator_symbol {
        <[\|\/\!]>
    }
    token end_comment_symbol {
        \*\)
    }
    token end_group_symbol {
        \)
    }
    token end_option_symbol {
        (\]|\/\))
    }
    token end_repeat_symbol {
        (\}|\:\))
    }
    token except_symbol {
        \-
    }
    token escape_symbol {
        \\
    }
    token first_quote_symbol {
        \'
    }
    token repetition_symbol {
        \*
    }
    token second_quote_symbol {
        \"
    }
    token escaped_first_quote_symbol {
        <escape_symbol> <first_quote_symbol>
    }
    token escaped_second_quote_symbol {
        <escape_symbol> <second_quote_symbol>
    }
    token special_sequence_symbol {
        \?
    }
    token start_comment_symbol {
        \(\*
    }
    token start_group_symbol {
        \(
    }
    token start_option_symbol {
        (\[|\(\/)
    }
    token start_repeat_symbol {
        (\{|\(\:)
    }
    token terminator_symbol {
        <[;.]>
    }
    token other_character {
        <[ \:\+\_\%\@\&\#\$\<\>\\\^\‘\~]>
    }
    token space_character {
        <[ ]> 
    }
    token horizontal_tabulation_character {
        \t
    }
    token new_line {
        \r* \n \r*
    }
    token vertical_tabulation_character {
        \v
    }
    token form_feed {
        \f
    }
    token terminal_character {
        ( <letter>|
          <decimal_digit>|
          <concatenate_symbol>|
          <defining_symbol>|
          <definition_separator_symbol>|
          <end_comment_symbol>|
          <end_group_symbol>|
          <end_option_symbol>|
          <end_repeat_symbol>|
          <except_symbol>|
          <escaped_first_quote_symbol>|
          <repetition_symbol>|
          <escaped_second_quote_symbol>|
          <special_sequence_symbol>|
          <start_comment_symbol>|
          <start_group_symbol>|
          <start_option_symbol>|
          <start_repeat_symbol>|
          <terminator_symbol>|
          <other_character> )
    }
    token gap_free_symbol {
        ( <terminal_character>|
          <terminal_string> )
    }
    token terminal_string {
        ( ( <first_quote_symbol> <first_terminal_character>+ <first_quote_symbol> )|
          ( <second_quote_symbol> <second_terminal_character>+ <second_quote_symbol> ))
    }
    token first_terminal_character {
        <terminal_character>
    }
    token second_terminal_character {
        <terminal_character>
    }
    token gap_separator {
        ( <space_character>|
          <horizontal_tabulation_character>|
          <new_line>|
          <vertical_tabulation_character>|
          <form_feed> )
    }
    token syntax_symbol {
        <gap_separator>* (<gap_free_symbol> <gap_separator>*)+
    }
    token syntax_comment {
        <bracketed_textual_comment>* <commentless_symbol> <bracketed_textual_comment>* (<commentless_symbol> <bracketed_textual_comment>*)*
    }
    token commentless_symbol {
        ( <terminal_character>|
          <meta_identifier>|
          <integer>|
          <terminal_string>|
          <special_sequence> )
    }
    token integer {
        <decimal_digit>+
    }
    token meta_identifier {
        <letter> <meta_identifier_character>*
    }
    token meta_identifier_character {
        (<letter>|<decimal_digit>)
    }
    token special_sequence {
        <special_sequence_symbol> <special_sequence_character>* <special_sequence_symbol>
    }
    token special_sequence_character {
        <terminal_character>
    }
    token comment_symbol {
        ( <bracketed_textual_comment>|
          <other_character>|
          <commentless_symbol> )
    }
    token bracketed_textual_comment {
        <start_comment_symbol> <comment_symbol>* <end_comment_symbol>
    }
    rule syntax_rule {
        <meta_identifier> <defining_symbol> <definitions_list> <terminator_symbol>
    }
    rule definitions_list {
        <single_definition> (<definition_separator_symbol> <single_definition>)*
    }
    rule single_definition {
        <syntactic_term> (<concatenate_symbol> <syntactic_term>)*
    }
    rule syntactic_term {
        <syntactic_factor> (<except_symbol> <syntactic_exception>)?
    }
    rule syntactic_exception {
        <syntactic_factor>
    }
    rule syntactic_factor {
        (<integer> <repetition_symbol>)? <syntactic_primary>
    }
    rule syntactic_primary {
        ( <optional_sequence>|
          <repeated_sequence>|
          <grouped_sequence>|
          <meta_identifier>|
          <terminal_string>|
          <special_sequence>|
          <empty_sequence> )
    }
    rule optional_sequence {
        <start_option_symbol> <definitions_list> <end_option_symbol>
    }
    rule repeated_sequence {
        <start_repeat_symbol> <definitions_list> <end_repeat_symbol>
    }
    rule grouped_sequence {
        <start_group_symbol> <definitions_list> <end_group_symbol>
    }
    rule empty_sequence {
        ""
    }
    rule TOP {
        [ <syntax_rule>
        ]+
    }
}
