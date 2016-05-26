use strict;
use warnings FATAL => 'all';

use Apache::Test qw(:withtestmore);
use Apache::TestRequest;

use Test::More;

plan tests => 3, (need_lwp &&
                  need_auth &&
                  need_module('mod_perl.c'));

my $uri = '/authen/index.html';

{
  my $response = GET $uri;

  is ($response->code,
      401,
      "no valid password entry");
}

{
  my $response = GET $uri, username => 'geoff', password => 'foo';

  is ($response->code,
      401,
      "password mismatch");
}

{
  my $response = GET $uri, username => 'geoff', password => 'geoff';

  is ($response->code,
      200,
      "geoff:geoff allowed to proceed");
}
