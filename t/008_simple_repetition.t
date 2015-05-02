use Test;
use Grammar::EBNF;
ebnf-grammar A::B {
  TOP = "2", { "3" };
};
ok(!A::B.parse("32"), "Parse fails when it doesn't match");
ok(A::B.parse("2"), "Matches with 0 occurrences");
ok(A::B.parse("23"), "Matches with 1 occurrences");
ok(A::B.parse("233"), "Matches with 2 occurrences");
ok(A::B.parse("2333"), "Matches with 3 occurrences");
ok(A::B.parse("23333"), "Matches with 4 occurrences");
ok(!A::B.parse("23334"), "Fails when wrong character after 3 occurrences");

done();
