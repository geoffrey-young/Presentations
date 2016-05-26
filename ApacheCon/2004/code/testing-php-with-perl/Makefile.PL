# don't worry about this file - you should not
# need to edit it at all.

use 5.00503;

use ExtUtils::MakeMaker;

use lib qw(lib);

use Apache::TestMM qw(test clean);
use Apache::TestRunPHP ();

Apache::TestMM::filter_args();

Apache::TestRunPHP->generate_script();

WriteMakefile(
  NAME      => 'perl-php',
  VERSION   => 'test',
);
