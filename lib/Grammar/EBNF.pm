use Grammar::EBNF::MetaSyntax;
use Grammar::EBNF::Actions;
use QAST:from<NQP>;
sub EXPORT(|) {
    my sub lk(Mu \h, \k) {
        nqp::atkey(nqp::findmethod(h, 'hash')(h), k)
    }
    role Grammar::EBNF::Slang {
        rule package_declarator:sym<ebnf-grammar> {
            <sym> <longname> \{
            <EBNF=.FOREIGN_LANG('Grammar::EBNF::MetaSyntax', 'main_syntax')>
            \}
        }
    }
    role Grammar::EBNF::Slang::Actions {
        method package_declarator:sym<ebnf-grammar>(Mu $/ is rw) {
            # Bits extracted from rakudo/src/Perl6/Grammar.nqp (package_def)
            my $longname := $*W.dissect_longname(lk($/,'longname'));
            my $outer := $*W.cur_lexpad();
            my $ebnf = lk($/,"EBNF").made();
            # Locate any existing symbol. Note that it's only a match
            # with "my" if we already have a declaration in this scope.
            my $exists := 0;
            my @name = $longname.type_name_parts('package name', :decl(1));
            my $target_package := $longname && $longname.is_declared_in_global()
                ?? $*GLOBALish
                !! $*OUTERPACKAGE;
            # Construct meta-object for this package.
            my %args;
            if @name {
                %args<name> := $longname.name();
            }
            my $*PACKAGE := $*W.pkg_create_mo($/, $*W.resolve_mo($/, 'grammar'), |%args);
            $*W.install_package($/, @name, 'our', 'ebnf-grammar', $target_package, $outer, $*PACKAGE);
            for $ebnf.keys -> $d {
                $*W.pkg_add_method($/, $*PACKAGE, 'add_method', $d, EVAL '/'~$ebnf{$d}~'/');
            }
            $*W.pkg_compose($*PACKAGE);
            $/.'make'(QAST::IVal.new(:value(1)));
        }
    }
    nqp::bindkey(%*LANG, 'MAIN', %*LANG<MAIN>.HOW.mixin(%*LANG<MAIN>, Grammar::EBNF::Slang));
    nqp::bindkey(%*LANG, 'MAIN-actions', %*LANG<MAIN-actions>.HOW.mixin(%*LANG<MAIN-actions>, Grammar::EBNF::Slang::Actions));
    nqp::bindkey(%*LANG, 'Grammar::EBNF::MetaSyntax', Grammar::EBNF::MetaSyntax);
    nqp::bindkey(%*LANG, 'Grammar::EBNF::MetaSyntax-actions', Grammar::EBNF::Actions);
    {}
}
