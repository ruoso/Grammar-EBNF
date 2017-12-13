use Test;
use Grammar::EBNF::MetaSyntax;
my $g := Grammar::EBNF::MetaSyntax;
is($g.parse("a", :rule<letter>), "a", "lowecase letter");
is($g.parse("c", :rule<letter>), "c", "lowecase letter");
is($g.parse("A", :rule<letter>), "A", "uppercase letter");
is($g.parse("C", :rule<letter>), "C", "uppercase letter");
ok(!$g.parse("#", :rule<decimal_digit>), "not a letter");
is($g.parse("1", :rule<decimal_digit>), "1", "decimal digit");
is($g.parse("9", :rule<decimal_digit>), 9, "decimal digit");
ok(!$g.parse("a", :rule<decimal_digit>), "not a digit");
is($g.parse("'foo'", :rule<terminal_string>), "'foo'", 'first quote terminal string');
is($g.parse('"foo"', :rule<terminal_string>), '"foo"', 'second quote terminal string');
is($g.parse('"0"', :rule<terminal_string>), '"0"', 'second quote terminal string');
is($g.parse('numberZero', :rule<meta_identifier>), 'numberZero', 'meta identifier');
ok(!$g.parse('number_zero', :rule<meta_identifier>), 'meta identifier cannot have underscores');
is($g.parse('numberZero="0";', :rule<syntax_rule>), 'numberZero="0";', 'rule without spaces');
is($g.parse('numberZero = "0" ;', :rule<syntax_rule>), 'numberZero = "0" ;', 'rule with spaces');
is($g.parse('numberZero = "0"; letterA = "a";'), 'numberZero = "0"; letterA = "a";', 'two rules in TOP');
is($g.parse('
numberZero = "0";
letterA = "a";
'), '
numberZero = "0";
letterA = "a";
', 'two rules in TOP with newlines');
is($g.parse('{ ExternalDeclaration }', :rule<definitions_list>), '{ ExternalDeclaration }', 'repetition');
done-testing;
