use Test;
use Grammar::EBNF;
ebnf-grammar A::B {
  TOP = "42";
  TOP = "2";
};
ok(A::B.parse("42"), "Parse succeeds");
ok(A::B.parse("2"), "Parse succeeds");
ok(!A::B.parse("3"), "Parse fails when it doesn't match");
ok(!A::B.parse("43"), "Parse fails when it doesn't match");
done();
