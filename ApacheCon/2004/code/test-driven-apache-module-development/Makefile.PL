use ExtUtils::MakeMaker;

my @examples = qw(Apache-SSLLookup
                  c-authen-auto-compile
                  c-authen-local-install
                  c-authen-self-install
                  digest-MSIE
                  mod_example_ipc-auto
                  mod_example_ipc-install
                  mod_example_ipc-other
                  mod_example_ipc-self
                  perl-authen-all
                  perl-authen-handler);

WriteMakefile(
  NAME      => 'T07-2004',
  VERSION   => 'code',
  DIR       => \@examples, 
);
