use Test;
use Grammar::EBNF;
ebnf-grammar A::B {
  TOP = "2", ( { "3" } );
};
ok(!A::B.parse("32"), "Parse fails when it doesn't match");
ok(A::B.parse("23333"), "Parse succeeds when it matches");
warn A::B.parse("23333").gist;
is(A::B.parse("23333")[0], '3333', "grouping shows up as a capture");

done();
