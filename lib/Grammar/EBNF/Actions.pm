use QAST:from<NQP>;
class Grammar::EBNF::Actions {
  method main_syntax(Mu $/ is rw) {
    my %rules;
    for map *.made, @($/<syntax_rule>) -> $d {
      my $name = $d<rule_name>;
      my $regex = $d<regex>;
      %rules{$name} ||= [];
      %rules{$name}.push($regex);
    };
    for %rules.keys -> $name {
      my @a = @(%rules{$name});
      if (@a.elems == 1) {
        %rules{$name} = @a[0];
      } else {
        %rules{$name} = /|@a/;
      }
    };
    $/.make(%rules);
  }
  method syntax_rule(Mu $/ is rw) {
    my $d = $/<definitions_list>.made;
    my $s =
      { rule_name => $/<meta_identifier>.made,
        regex => $d,
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
      my @regexes = $<syntactic_term>>>.made;
      my $regexstr = '/';
      for 0..(@regexes.elems-1) -> $i {
        $regexstr ~= '$(@regexes['~$i~'])'
      } 
      $regexstr ~= '/';
      my $regex = EVAL $regexstr;
      $/.make($regex);
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
      $/.make($<terminal_string>.made);
    } elsif ($<meta_identifier>) {
      my $name = $<meta_identifier>.made;
      my $faux_regex = -> $invocant: *@args {
        $invocant."$name"(|@args);
      };
      $/.make(EVAL '/$<'~$name~'>=$faux_regex/');
    } elsif ($<repeated_sequence>) {
      !!! "Repeated sequenc nyi"; 
    } else {
      !!! "Only terminal_string implemented so far";
    }
  }
  method meta_identifier(Mu $/ is rw) {
    $/.make($/.Str);
  }
  method terminal_string(Mu $/ is rw) {
    my $str;
    if ($<second_quote_symbol>) {
      $str = join "", map *.Str, @($<second_terminal_character>);
    } else {
      $str = join "", map *.Str, @($<first_terminal_character>);
    }
    $/.make(/$str/);
  }
}
