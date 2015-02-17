use Test;
use Grammar::EBNF::MetaSyntax;

my $m = Grammar::EBNF::MetaSyntax.parsefile("t/003_ansi_c.ebnf")
  or die "Basic match failed, aborting all other tests";

is($m{"syntax_rule"}.elems, 129, "129 rules");
ok($m{"syntax_rule"}.grep({$_{"meta_identifier"} eq "Pointer"}), "Find the pointer rule");

done();
