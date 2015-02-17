use Test;
use Grammar::EBNF::MetaSyntax;

my $text = '
numberZero = "0";
letterA = "a";
';
my $m = Grammar::EBNF::MetaSyntax.parse($text)
  or die "Basic match failed, aborting all other tests";

is($m{"syntax_rule"}.elems, 2, "Two rules found");
is($m{"syntax_rule"}[0]{"meta_identifier"}, "numberZero", "first meta identfier");
is($m{"syntax_rule"}[1]{"meta_identifier"}, "letterA", "second meta identfier");
is($m{"syntax_rule"}[0]{"definitions_list"}, '"0"', "first definition list");
is($m{"syntax_rule"}[1]{"definitions_list"}, '"a"', "second definition list");
is($m{"syntax_rule"}[0]{"definitions_list"}{"single_definition"}, '"0"', "first single definition");
is($m{"syntax_rule"}[1]{"definitions_list"}{"single_definition"}, '"a"', "second single definition");

done()
