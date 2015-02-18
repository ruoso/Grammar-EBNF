class Grammar::EBNF::Actions {
  my sub lk(Mu \h, \k) {
    nqp::atkey(nqp::findmethod(h, 'hash')(h), k);
  }
  method syntax_rule(Mu $/ is rw) {
    #$/.'!make'({ name => lk($/, "meta_identifier"),
    #             definitions_List => lk($/, "definitions_list "),
    #           });
  }

  method terminal_string(Mu $/ is rw) {
    #$/.'!make'(QAST::Regex.new( $/.Str, :rxtype<literal>, :node($/) ));
  }
}
