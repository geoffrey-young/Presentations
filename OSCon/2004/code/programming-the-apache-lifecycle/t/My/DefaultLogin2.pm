package My::DefaultLogin2;

use Apache::Const -compile => qw(OK);

use Apache::RequestRec ();    # for $r->connection
use Apache::Connection ();    # for $c->local_ip and $c->remote_ip

use APR::Table ();            # for headers_in->set

use MIME::Base64 ();

use strict;

sub handler {

  my $r = shift;

  my $c = $r->connection;

  if ($c->remote_ip eq $c->local_ip) {

    my $user   = 'bug';
    my $passwd = 'squashing';

    # Join user and password and set the incoming header.
    my $credentials = MIME::Base64::encode(join(':', $user, $passwd));

    $r->headers_in->set(Authorization => "Basic $credentials");
  }

  return Apache::OK;
}

1;
