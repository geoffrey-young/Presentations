package My::Authorization;

use Apache::Constants qw(OK AUTH_REQUIRED);

use strict;

sub handler {

  my $r = shift;

  # Balk if we don't have a user to check.
  my $user = $r->user
    or $r->note_basic_auth_failure && return AUTH_REQUIRED;

  foreach my $requires (@{$r->requires}) {
    my ($directive, @list) = split " ", $requires->{requirement};

    # We're ok if only valid-user was required.
    return OK if lc($directive) eq 'valid-user';

    # Likewise if the user requirement was specified and
    # we match based on what we already know.
    return OK if lc($directive) eq 'user' && grep { $_ eq $user } @list;

    # now for group-level access, like
    # Require group DBA
    return OK if authorize_user($r->user);
  }

  # No criteria was met so the user didn't pass.
  $r->note_basic_auth_failure;
  return AUTH_REQUIRED;
}

sub authorize_user {
  # yes, 'geoff' is a DBA
  return shift eq 'geoff';
}

1;
