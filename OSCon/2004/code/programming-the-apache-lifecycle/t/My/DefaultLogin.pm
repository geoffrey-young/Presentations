package My::DefaultLogin;

use Apache::Constants qw(OK);

use MIME::Base64 ();
use Socket qw(sockaddr_in inet_ntoa);

use strict;

sub handler {

  my $r = shift;

  my $c = $r->connection;

  my $local_ip = inet_ntoa((sockaddr_in($c->local_addr))[1]);

  if ($c->remote_ip eq $local_ip) {

    my $user   = 'bug';
    my $passwd = 'squashing';

    # Join user and password and set the incoming header.
    my $credentials = MIME::Base64::encode(join(':', $user, $passwd));

    $r->headers_in->set(Authorization => "Basic $credentials");
  }

  return OK;
}

1;
