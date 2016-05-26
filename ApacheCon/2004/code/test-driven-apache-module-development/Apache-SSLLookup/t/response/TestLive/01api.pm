package TestLive::01api;

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
    $r = Apache::SSLLookup->new($r);

    SKIP : {
      skip 'apache 2.0.51 required', 1
        unless have_min_apache_version('2.0.51');

      ok($r->is_https,
         'is_https() returned true');
    }

    ok ($r->ssl_lookup('https'),
        'HTTPS variable returned true');

    is ($r->ssl_lookup('ssl_client_verify'),
        'NONE',
        'SSL_CLIENT_VERIFY returned ssl.conf value');
  }

  return Apache::OK;
}

1;
__DATA__
<NoAutoConfig>
</NoAutoConfig>
