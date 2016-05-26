use strict;
use warnings FATAL => 'all';

use Apache::Test qw(:withtestmore);
use Apache::TestRequest;
use Apache::TestUtil qw(t_write_file);
use File::Spec;

use Test::More;

plan tests => 3, need need_lwp,
                      need_module('mod_auth_digest');

my ($no_query_auth, $query_auth);

# write out the authentication file
my $file = File::Spec->catfile(Apache::Test::vars('serverroot'), 'realm1');
t_write_file($file, <DATA>);

my $url   = '/digest/index.html';
my $query = 'try=til%7Ede';

{
  my $response = GET $url;

  is ($response->code,
      401,
      'no user to authenticate');
}

{
  # authenticated
  my $response = GET $url,
                   username => 'user1', password => 'password1';

  is ($response->code,
      200,
      'user1:password1 found');

  # set up for later
  $no_query_auth = $response->request->headers->authorization;
}

{
  # fake current MSIE behavior - this should work as of 2.0.51
  my $response = GET "$url?$query",
                   Authorization => $no_query_auth, 
                   'X-Browser'   => 'MSIE';

  is ($response->code,
      200,
      'manual Authorization with no query string in header + MSIE');
}

__DATA__
# user1/password1
user1:realm1:4b5df5ee44449d6b5fbf026a7756e6ee
