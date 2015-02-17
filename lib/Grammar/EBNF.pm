use Grammar::EBNF::MetaSyntax;
sub EXPORT(|) {
    role Grammar::EBNF::Slang {
        rule statement_control:sym<ebnf-grammar> {
            <sym> <longname> \{ <EBNF=.FOREIGN_LANG: 'Grammar::EBNF::MetaSyntax', 'TOP'> \} 
        }
    }
    role Grammar::EBNF::Actions {
        method statement_control:sym<ebnf-grammar>(Mu $/ is rw) {
            print "HERE!";
        }
    }
    nqp::bindkey(%*LANG, 'MAIN', %*LANG<MAIN>.HOW.mixin(%*LANG<MAIN>, Grammar::EBNF::Slang));
    nqp::bindkey(%*LANG, 'MAIN-actions', %*LANG<MAIN-actions>.HOW.mixin(%*LANG<MAIN-actions>, Grammar::EBNF::Actions));
    nqp::bindkey(%*LANG, 'Grammar::EBNF::MetaSyntax', Grammar::EBNF::MetaSyntax);
    {}
}
