use Grammar::EBNF::MetaSyntax;
use Grammar::EBNF::Actions;
use QAST:from<NQP>;
sub EXPORT(|) {
    role Grammar::EBNF::Slang {
        rule statement_control:sym<ebnf-grammar> {
            <sym> <longname> \{ <EBNF=.FOREIGN_LANG('Grammar::EBNF::MetaSyntax', 'main_syntax')> \} 
        }
    }
    role Grammar::EBNF::Slang::Actions {
        my sub lk(Mu \h, \k) {
            nqp::atkey(nqp::findmethod(h, 'hash')(h), k)
        }
        method statement_control:sym<ebnf-grammar>(Mu $/ is rw) {
            my $package = lk($/,"longname").Str;
            my $ebnf = lk($/,"EBNF").made();
            $/.'make'(QAST::CompUnit.new(:hll('grammar-ebnf'), $ebnf));
        }
    }
    nqp::bindkey(%*LANG, 'MAIN', %*LANG<MAIN>.HOW.mixin(%*LANG<MAIN>, Grammar::EBNF::Slang));
    nqp::bindkey(%*LANG, 'MAIN-actions', %*LANG<MAIN-actions>.HOW.mixin(%*LANG<MAIN-actions>, Grammar::EBNF::Slang::Actions));
    nqp::bindkey(%*LANG, 'Grammar::EBNF::MetaSyntax', Grammar::EBNF::MetaSyntax);
    nqp::bindkey(%*LANG, 'Grammar::EBNF::MetaSyntax-actions', Grammar::EBNF::Actions);
    {}
}
