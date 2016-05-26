package Cookbook::Favicon2;

use Apache::Const -compile => qw(DECLINED);

use Apache::RequestRec ();

use strict;

sub handler {

  my $r = shift;

  $r->uri("/images/favicon.ico")
    if $r->uri =~ m!/favicon\.ico$!;

  return Apache::DECLINED;
}

1;
