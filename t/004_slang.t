use Test;
use Grammar::EBNF;
ebnf-grammar A::B {
  TOP = "42";
  a = "2";
};
ok(A::B.^can('parse'), "It can parse");
ok(A::B.^can('TOP'), "The syntax rule becomes a method");
ok(A::B.^can('a'), "The syntax rule becomes a method");
ok(A::B.parse("42"), "Parse succeeds");
ok(!A::B.parse("2"), "Parse fails when it doesn't match");
ok(A::B.parse("2", :rule<a>), "Parse succeeds");
ok(!A::B.parse("42", :rule<a>), "Parse fails when it doesn't match");
done-testing;
