package TestSSL::02new;

use strict;
use warnings FATAL => qw(all);

use Apache::Test qw(-withtestmore);

use Apache::Const -compile => qw(OK);

sub handler {

  my $r = shift;

  plan $r, tests => 4;

  { 
    use_ok('Apache::SSLLookup');
  }

  { 
    can_ok('Apache::SSLLookup', 'new');
  }

  {
    eval { $r = Apache::SSLLookup->new(bless {}, 'foo') };

    like ($@,
          qr/method `new' invoked by a `foo' object with no `r' key/,
          'new() requires an Apache::RequestRec object');
  }

  {
    $r = Apache::SSLLookup->new($r);

    isa_ok($r, 'Apache::SSLLookup');
  }

  return Apache::OK;
}

1;
