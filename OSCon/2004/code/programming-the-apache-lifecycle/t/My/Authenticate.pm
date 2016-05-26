package My::Authenticate;

use Apache::Constants qw(OK DECLINED AUTH_REQUIRED);

use strict;

sub handler {

  my $r = shift;

  # Get the client-supplied credentials.
  my ($status, $password) = $r->get_basic_auth_pw;

  return $status unless $status == OK;

  # Let subrequests pass.
  return OK unless $r->is_initial_req;

  # Perform some custom user/password validation.
  return OK if authenticate_user($r->user, $password);

  # Whoops, bad credentials.
  $r->note_basic_auth_failure;
  return AUTH_REQUIRED;
}

sub authenticate_user {

  my ($user, $pass) = @_;

  return $user eq $pass;
}

1;
