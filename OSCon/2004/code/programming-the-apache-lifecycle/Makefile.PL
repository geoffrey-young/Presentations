
# toggle this line on and off to switch between
# testing mod_perl 1.0 and 2.0, then re-run 
# perl Makefile.pl -apxs ...
use Apache2;

# you shouldn't need to worry about anything else
# in this test suite
use ExtUtils::MakeMaker;

use Apache::TestMM qw(test clean);
use Apache::TestRunPerl ();

Apache::TestMM::filter_args();

Apache::TestRunPerl->generate_script();

WriteMakefile(
  NAME      => 'lifecycle',
  VERSION   => 'oscon2004',
);
