use strict;
use warnings FATAL => 'all';

use Apache::Test;
use Apache::TestRequest;
use Apache::TestUtil;

use File::Spec;

plan tests => 10, (have_lwp && have_auth);

{
  my $uri = '/authzvaliduser/index.html';

  {
    my $response = GET $uri;

    ok t_cmp($response->code,
             401,
             "no valid password entry at $uri");
  }

  {
    my $response = GET $uri, username => 'foo', password => 'bar';

    ok t_cmp($response->code,
             401,
             "password mismatch at $uri");
  }

  {
    my $response = GET $uri, username => 'foo', password => 'foo';

    ok t_cmp($response->code,
             200,
             "foo:foo allowed to proceed at $uri");
  }
}

{
  my $uri = '/authzuser/index.html';

  {
    my $response = GET $uri;

    ok t_cmp($response->code,
             401,
             "no valid password entry at $uri");
  }

  {
    my $response = GET $uri, username => 'foo', password => 'foo';

    ok t_cmp($response->code,
             401,
             "foo:foo invalid user at $uri");
  }

  {
    my $response = GET $uri, username => 'someuser', password => 'someuser';

    ok t_cmp($response->code,
             200,
             "foo:foo invalid user at $uri");
  }
}

{
  my $uri = '/authzgroup/index.html';

  {
    my $response = GET $uri;

    ok t_cmp($response->code,
             401,
             "no valid password entry at $uri");
  }

  {
    my $response = GET $uri, username => 'foo', password => 'foo';

    ok t_cmp($response->code,
             401,
             "foo:foo invalid user at $uri");
  }

  {
    my $response = GET $uri, username => 'someuser', password => 'someuser';

    ok t_cmp($response->code,
             401,
             "someuser:someuser invalid user at $uri");
  }

  {
    my $response = GET $uri, username => 'geoff', password => 'geoff';

    ok t_cmp($response->code,
             200,
             "geoff:geoff is a DBA at $uri");
  }
}
