use QAST:from<NQP>;
class Grammar::EBNF::Actions {
  method main_syntax(Mu $/ is rw) {
    my %rules;
    for map *.made, @($/<syntax_rule>) -> $d {
      my $name = $d<rule_name>;
      my $regex = $d<regex>;
      if (%rules{$name}) {
        !!! "Implicit alternatives not supported yet";
      } else {
        %rules{$name} = $regex;
      }
    };
    my @ops;
    for %rules.keys -> $m {
        ??? "What should we do with $m here?"
    };
    $/.make(QAST::Block.new(|@ops));
  }
  method syntax_rule(Mu $/ is rw) {
    my @d = map *.made, $/<definitions_list>;
    my $s =
      { rule_name => $/<meta_identifier>.made,
        regex => @d,
      };
    $/.make($s);
  }
  method definitions_list(Mu $/ is rw) {
    if ($/<single_definition>.elems > 1) {
      !!! "No alternations yet";
    } else {
      $/.make($<single_definition>[0].made);
    }
  }
  method single_definition(Mu $/ is rw) {
    if ($/<syntactic_term>.elems > 1) {
      !!! "No concatenations yet";
    } else {
      $/.make($<syntactic_term>[0].made);
    }
  }
  method syntactic_term(Mu $/ is rw) {
    if ($<except_symbol>) {
      !!! "No exceptions yet";
    } else {
      $/.make($<syntactic_factor>.made);
    }
  }
  method syntactic_factor(Mu $/ is rw) {
    if ($<repetition_symbol>) {
      !!! "No repetitions yet";
    } else {
      $/.make($/<syntactic_primary>.made);
    }
  }
  method syntactic_primary(Mu $/ is rw) {
    if ($<terminal_string>) {
      return $<terminal_string>.made;
    } else {
      !!! "Only terminal_string implemented so far";
    }
  }
  method meta_identifier(Mu $/ is rw) {
    $/.make($/.Str);
  }
  method terminal_string(Mu $/ is rw) {
    if ($<second_quote_symbol>) {
      my $str = join "", map *.Str, @($<second_terminal_character>);
      $/.make(QAST::Regex.new( $str, :rxtype<literal>, :node($/) ));
    } else {
      !!! "Single quote not implemented yet";
    }
  }
}
