use Test;
use Grammar::EBNF;
ebnf-grammar A::B {
  TOP = a; 
  a = "2", ( b );
  b = { "3" };
};
ok(!A::B.parse("32"), "Parse fails when it doesn't match");
ok(A::B.parse("23333"), "Parse succeeds when it matches");
my $m = A::B.parse("23333");
is($m<a>, "23333", "m->a");
is($m<a>[0], "3333", "m->a->[0]");
is($m<a>[0]<b>, "3333", "m->a->[0]->b");


done();
