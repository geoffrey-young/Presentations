use ExtUtils::MakeMaker;

# this is required unless we use ModPerl::MM::WriteMakefile
use Apache2;

# create 'test' and 'clean' make targets
use Apache::TestMM qw(test clean);

# grab Makefile.PL arguments, such as -apxs or -httpd
Apache::TestMM::filter_args();

# write out t/TEST
use Apache::TestRunPerl ();
Apache::TestRunPerl->generate_script();

WriteMakefile(
  NAME      => 'test-driven-development',
  VERSION   => 'example01',
);
