use Test;
use Grammar::EBNF;
ebnf-grammar A::B {
  TOP = "2", "3";
};
ok(!A::B.parse("32"), "Parse fails when it doesn't match");
ok(A::B.parse("23"), "Parse succeeds when it matches");

done();
