package My::AuthenHandler;

use Apache2::Const -compile => qw(OK HTTP_UNAUTHORIZED);

use Apache2::RequestRec ();    # for $r->user
use Apache2::Access ();        # for $r->get_basic_auth_pw

use strict;

sub handler {

  my $r = shift;

  # Get the client-supplied credentials.
  my ($status, $password) = $r->get_basic_auth_pw;

  return $status unless $status == Apache2::Const::OK;

  # Perform some custom user/password validation.
  return Apache2::Const::OK if $r->user eq $password;

  # Whoops, bad credentials.
  $r->note_basic_auth_failure;
  return Apache2::Const::HTTP_UNAUTHORIZED;
}

1;
