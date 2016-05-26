use ExtUtils::MakeMaker;

# create 'test' and 'clean' make targets
use Apache::TestMM qw(test clean);

# grab Makefile.PL arguments, such as -apxs or -httpd
Apache::TestMM::filter_args();

# write out t/TEST
use Apache::TestRun ();
Apache::TestRun->generate_script();

WriteMakefile(
  NAME      => 'mod_example_ipc',
  VERSION   => 'install',
);
