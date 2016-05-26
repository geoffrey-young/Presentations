use strict;
use warnings FATAL => 'all';

use Apache::Test;
use Apache::TestRequest;
use Apache::TestUtil qw(t_cmp t_write_file);

use File::Spec;

plan tests => 2, (have_lwp && have_access && have_auth);

my $serverroot = Apache::Test->vars('serverroot');

{
  t_write_file(File::Spec->catfile($serverroot, 'htpasswd'),
               'geoff:KKGAqFmb2T66U');

  my $uri = '/access/index.html';

  my $response = GET $uri;

  ok t_cmp($response->code,
           401,
           "no valid password entry");
}

{
  t_write_file(File::Spec->catfile($serverroot, 'htpasswd'),
               'bug:qr34ts6W2sFgU');

  my $uri = '/access/index.html';

  my $response = GET $uri;

  ok t_cmp($response->code,
           200,
           "bug:squashing allowed to proceed");
}
