use Grammar::EBNF::MetaSyntax;
sub EXPORT(|) {
    role Grammar::EBNF::Slang {
        rule statement_control:sym<ebnf-grammar> {
            <sym> <longname> \{ numerozero \= \"0\" \; \} 
        }
    }
    nqp::bindkey(%*LANG, 'MAIN', %*LANG<MAIN>.HOW.mixin(%*LANG<MAIN>, Grammar::EBNF::Slang));
    {}
}
