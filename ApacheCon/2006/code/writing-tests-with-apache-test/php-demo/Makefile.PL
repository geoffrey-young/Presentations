use 5.00501;

use ExtUtils::MakeMaker;

use Apache::TestMM qw(test clean);
use Apache::TestRunPHP ();

# configure tests based on incoming arguments
Apache::TestMM::filter_args();

# generate the test harness (t/TEST)
Apache::TestRunPHP->generate_script();

WriteMakefile(
  NAME      => 'perl-php',
  VERSION   => 'test',
);
