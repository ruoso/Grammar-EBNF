use QAST:from<NQP>;
class Grammar::EBNF::Actions {
  method syntax_rule(Mu $/ is rw) {
    { name => $/<meta_identifier>,
      definitions_List => $/<definitions_list>,
    }
  }

  method terminal_string(Mu $/ is rw) {
    my $terminal_string;
    if ($/<second_quote_symbol>) {
      $terminal_string := $/<second_terminal_character>.join('');
    } else {
      $terminal_string := $/<first_terminal_character>.join('');
    }
    make(QAST::Regex.new( ~$/, :rxtype<literal> ));
  }
}
