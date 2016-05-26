use strict;
use warnings FATAL => 'all';

use Apache::Test;
use Apache::TestRequest;
use Apache::TestUtil;

plan tests => 3, (need_lwp  &&
                  need_auth &&
                  need_module('mod_perl.c'));

{
  my $uri = '/authen/index.html';

  my $response = GET $uri;

  ok $response->code == 401;
}


{
  my $uri = '/authen/index.html';

  my $response = GET $uri, username => 'geoff', password => 'foo';

  ok $response->code == 401;
}

{
  my $uri = '/authen/index.html';

  my $response = GET $uri, username => 'geoff', password => 'geoff';

  ok $response->code == 200;
}
