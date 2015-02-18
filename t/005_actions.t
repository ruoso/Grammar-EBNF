use Test;
use Grammar::EBNF::MetaSyntax;
use Grammar::EBNF::Actions;
use QAST:from<NQP>;

my $g := Grammar::EBNF::MetaSyntax;
my $a := Grammar::EBNF::Actions;

my $t = $g.parse('"abc"', :rule<terminal_string>, :actions($a));
ok($t, 'matched terminal_string');
say $t;
ok($t ~~ QAST::Regex, 'is a regular expression');
