package My::Authenticate2;

use Apache::Const -compile => qw(OK DECLINED AUTH_REQUIRED);

use Apache::RequestRec ();    # for $r->user
use Apache::Access ();        # for $r->get_basic_auth_pw

use strict;

sub handler {

  my $r = shift;

  # Get the client-supplied credentials.
  my ($status, $password) = $r->get_basic_auth_pw;

  return $status unless $status == Apache::OK;

  # Let subrequests pass.
  return Apache::OK unless $r->is_initial_req;

  # Perform some custom user/password validation.
  return Apache::OK if authenticate_user($r->user, $password);

  # Whoops, bad credentials.
  $r->note_basic_auth_failure;
  return Apache::AUTH_REQUIRED;
}

sub authenticate_user {

  my ($user, $pass) = @_;

  return $user eq $pass;
}

1;
