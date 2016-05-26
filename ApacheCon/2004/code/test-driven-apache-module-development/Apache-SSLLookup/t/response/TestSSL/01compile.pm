package TestSSL::01compile;

use strict;
use warnings FATAL => qw(all);

use Apache::Test qw(-withtestmore);

use Apache::Const -compile => qw(OK);

sub handler {

  my $r = shift;

  plan $r, tests => 1;

  use_ok('Apache::SSLLookup');

  return Apache::OK;
}

1;
