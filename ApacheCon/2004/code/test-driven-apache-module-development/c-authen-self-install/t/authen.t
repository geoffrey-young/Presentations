use strict;
use warnings FATAL => 'all';

use Apache::Test qw(:withtestmore);
use Apache::TestRequest;

use Test::More;

plan tests => 3, (need_lwp && need_auth);

{
  my $uri = '/authen/index.html';

  my $response = GET $uri;

  is ($response->code,
      401,
      "no valid password entry");
}

{
  my $uri = '/authen/index.html';

  my $response = GET $uri, username => 'geoff', password => 'foo';

  is ($response->code,
      401,
      "password mismatch");
}

{
  my $uri = '/authen/index.html';

  my $response = GET $uri, username => 'geoff', password => 'geoff';

  is ($response->code,
      200,
      "geoff:geoff allowed to proceed");
}
