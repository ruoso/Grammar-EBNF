# This test is failing because of
# https://rt.perl.org/Public/Bug/Display.html?id=117397

use Test;
use Grammar::EBNF;
ebnf-grammar A::B {
  TOP = a;
  a = "2";
};
ok(!A::B.parse("3"), "Parse fails when it doesn't match");
my $m = A::B.parse("2")
  or die "Parse fails, aborting remaining tests";
is($m<a>, "2", "Generates a parse tree");

done();
