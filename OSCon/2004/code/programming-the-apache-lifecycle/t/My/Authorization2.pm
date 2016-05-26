package My::Authorization2;

use Apache::Const -compile => qw(OK AUTH_REQUIRED);

use Apache::RequestRec ();  # for $r->user
use Apache::Access ();      # for $r->requires and $r->note_basic_auth_failure

use strict;

sub handler {

  my $r = shift;

  # Balk if we don't have a user to check.
  my $user = $r->user
    or $r->note_basic_auth_failure && return Apache::AUTH_REQUIRED;

  foreach my $requires (@{$r->requires}) {
    my ($directive, @list) = split " ", $requires->{requirement};

    # We're ok if only valid-user was required.
    return Apache::OK if lc($directive) eq 'valid-user';

    # Likewise if the user requirement was specified and
    # we match based on what we already know.
    return Apache::OK if lc($directive) eq 'user' && grep { $_ eq $user } @list;

    # now for group-level access, like
    # Require group DBA
    return Apache::OK if authorize_user($r->user);
  }

  # No criteria was met so the user didn't pass.
  $r->note_basic_auth_failure;
  return Apache::AUTH_REQUIRED;
}

sub authorize_user {
  # yes, 'geoff' is a DBA
  return shift eq 'geoff';
}

1;
