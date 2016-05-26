package My::AuthenHandler;

use Apache::Const -compile => qw(OK HTTP_UNAUTHORIZED);

use Apache::RequestRec ();    # for $r->user
use Apache::Access ();        # for $r->get_basic_auth_pw

use strict;

sub handler {

  my $r = shift;

  # Get the client-supplied credentials.
  my ($status, $password) = $r->get_basic_auth_pw;

  return $status unless $status == Apache::OK;

  # Perform some custom user/password validation.
  return Apache::OK if $r->user eq $password;

  # Whoops, bad credentials.
  $r->note_basic_auth_failure;
  return Apache::HTTP_UNAUTHORIZED;
}

1;
