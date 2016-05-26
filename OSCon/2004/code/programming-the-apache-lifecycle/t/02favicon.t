use strict;
use warnings FATAL => 'all';

use Apache::Test;
use Apache::TestRequest;
use Apache::TestUtil;

plan tests => 4, have_lwp;

{
  my $uri = '/favicon.ico';

  my $response = GET $uri;

  ok t_cmp($response->code,
           200,
           "$uri returned /images/favicon.ico");

  ok t_cmp($response->content,
           qr/just another favicon.ico/,
           "$uri returned proper content");
}

{
  my $uri = '/foo/bar/baz/biff/beer/favicon.ico';

  my $response = GET $uri;

  ok t_cmp($response->code,
           200,
           "$uri returned /images/favicon.ico");

  ok t_cmp($response->content,
           qr/just another favicon.ico/,
           "$uri returned proper content");
}
