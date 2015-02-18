use Test;
use Grammar::EBNF;
ebnf-grammar A::B {
  numerozero = "0";
  numeroum = "1";
};
is(A::B.HOW(), Grammar::EBNF::MetaSyntax.HOW(), "A ebnf-grammar shows up as a regular grammar");
done();
