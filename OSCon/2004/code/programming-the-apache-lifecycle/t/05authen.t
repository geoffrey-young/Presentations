use strict;
use warnings FATAL => 'all';

use Apache::Test;
use Apache::TestRequest;
use Apache::TestUtil qw(t_cmp t_write_file);

use File::Spec;

plan tests => 3, (have_lwp && have_auth);

my $serverroot = Apache::Test->vars('serverroot');

{
  my $uri = '/authen/index.html';

  my $response = GET $uri;

  ok t_cmp($response->code,
           401,
           "no valid password entry");
}


{
  my $uri = '/authen/index.html';

  my $response = GET $uri, username => 'geoff', password => 'foo';

  ok t_cmp($response->code,
           401,
           "password mismatch");
}

{
  my $uri = '/authen/index.html';

  my $response = GET $uri, username => 'geoff', password => 'geoff';

  ok t_cmp($response->code,
           200,
           "geoff:geoff allowed to proceed");
}
