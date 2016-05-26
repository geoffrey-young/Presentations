use strict;
use warnings FATAL => 'all';

use Apache::Test qw(-withtestmore);
use Apache::TestRequest;
use Apache::TestUtil qw(t_write_file);
use File::Spec;

plan tests => 2, need need_lwp,
                      need_module('mod_auth_digest');

# write out the authentication file
my $file = File::Spec->catfile(Apache::Test::vars('serverroot'), 'realm1');
t_write_file($file, <DATA>);

my $url   = '/digest/index.html';

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
}

__DATA__
# user1/password1
user1:realm1:4b5df5ee44449d6b5fbf026a7756e6ee
