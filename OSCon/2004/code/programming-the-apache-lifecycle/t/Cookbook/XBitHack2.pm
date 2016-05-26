package Cookbook::XBitHack2;

use Apache::Const -compile => qw(OK DECLINED OPT_INCLUDES);

use Apache::RequestRec ();  # for $r->content_type && $r->handler
use Apache::Access;         # for $r->allow_options

use Fcntl qw(S_IXUSR);

use strict;

sub handler {

  my $r = shift;

  return Apache::DECLINED unless
    (-f $r->filename                  &&            # the file exists
     $r->content_type =~ m!text/html! &&            # and is HTML
     $r->allow_options & Apache::OPT_INCLUDES);     # and we have Options +Includes

  # Find out the user and group execution status.
  my $mode = (stat _)[2];

  # We have to be user executable specifically.
  return Apache::DECLINED unless ($mode & S_IXUSR);
   
  # Make sure mod_include picks it up.
  $r->handler('server-parsed');

  return Apache::OK;
}

1;
