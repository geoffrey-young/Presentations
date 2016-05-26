use strict;
use warnings FATAL => 'all';

use Apache::Test qw(-withtestmore);
use Apache::TestRequest;
use Apache::TestUtil qw(t_write_file);
use File::Spec;

plan tests => 13, (need_lwp &&
                   need_module('mod_auth_digest'));

my $url = '/digest/index.html';
my ($no_query_auth, $query_auth, $bad_query);

# write out the authentication file
my $file = File::Spec->catfile(Apache::Test::vars('serverroot'), 'realm1');
t_write_file($file, <DATA>);

{
  my $response = GET $url;

  is ($response->code,
      401,
      'no user to authenticate');
}

{
  # bad pass
  my $response = GET $url, username => 'user1', password => 'foo';

  is ($response->code,
      401,
      'user1:foo not found');
}

{
  # authenticated
  my $response = GET $url, username => 'user1', password => 'password1';

  is ($response->code,
      200,
      'user1:password1 found');

  # set up for later
  $no_query_auth = $response->request->headers->authorization;
}


# now that we know normal digest auth works, play with the query string

{
  # add a query string
  my $response = GET "$url?try=til%7Ede", username => 'user1', password => 'password1';

  is ($response->code,
      200,
      'user1:password1 with query string found');

  # set up for later
  $query_auth = $response->request->headers->authorization;
}

{
  # do the auth header ourselves
  my $response = GET "$url?try=til%7Ede", Authorization => $query_auth;
  is ($response->code,
      200,
      'manual Authorization header query string');
}

{
  # remove the query string from the uri - bang!
  (my $noquery = $query_auth) =~ s!\Q?try=til%7Ede!!;

  my $response = GET "$url?try=til%7Ede", Authorization => $noquery;
  is ($response->code,
      400,
      'manual Authorization with no query string in header');
}

{
  # same with changing the query string in the header
  ($bad_query = $query_auth) =~ s!try=til%7Ede!something=else!;

  my $response = GET "$url?try=til%7Ede", Authorization => $bad_query;
  is ($response->code,
      400,
      'manual Authorization header with mismatched query string');
}

{
  # another mismatch
  my $response = GET $url, Authorization => $query_auth;
  is ($response->code,
      400,
      'manual Authorization header with mismatched query string');
}

# finally, the MSIE tests

{
  # fake current MSIE behavior - this should work
  my $response = GET "$url?try=til%7Ede", Authorization => $no_query_auth, 
                                         'X-Browser'    => 'MSIE';
  is ($response->code,
      200,
      'manual Authorization with no query string in header + MSIE');
}

{
  # pretend MSIE fixed itself
  my $response = GET "$url?try=til%7Ede", Authorization => $query_auth, 
                                         'X-Browser'    => 'MSIE';
  is ($response->code,
      200,
      'manual Authorization header + MSIE');
}

{
  # this still bombs
  my $response = GET "$url?try=til%7Ede", Authorization => $bad_query, 
                                         'X-Browser'    => 'MSIE';
  is ($response->code,
      400,
      'manual Authorization header with mismatched query string + MSIE');
}

{
  # as does this
  my $response = GET $url, Authorization => $query_auth, 'X-Browser' => 'MSIE';
  is ($response->code,
      400,
      'manual Authorization header with mismatched query string + MSIE');
}

{
  # no hack required
  my $response = GET $url, username => 'user1', password => 'password1', 
                       'X-Browser' => 'MSIE';
  is ($response->code,
      200,
      'no query string + MSIE');
}

__DATA__
# user1/password1
user1:realm1:4b5df5ee44449d6b5fbf026a7756e6ee
