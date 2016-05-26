use ExtUtils::MakeMaker;

# this is just uses Apache-Test in ./lib
# in case you don't actually have it installed
use lib qw(lib);

use Apache::TestMM qw(test clean);
use Apache::TestRunPHP ();

# configure tests based on incoming arguments
Apache::TestMM::filter_args();

# generate the test harness (t/TEST)
Apache::TestRunPHP->generate_script();

WriteMakefile(
  NAME      => 'Power_PHP_Testing',
  VERSION   => 'apache-test-cli-with-simple-test',
);
