package Cookbook::Favicon;

use Apache::Constants qw(DECLINED);

use strict;

sub handler {

  my $r = shift;

  $r->uri("/images/favicon.ico")
    if $r->uri =~ m!/favicon\.ico$!;

  return DECLINED;
}

1;
