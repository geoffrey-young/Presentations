package My::ManualProxy;

use Apache::Constants qw(OK DECLINED);

use strict;

sub handler {

  my $r = shift;

  return DECLINED unless $r->proxyreq;

  my (undef, $file) = $r->uri =~ m!^http://(www|httpd).apache.org/(.*)!;

  if ($file =~ m!^docs/!) {

    $file =~ s!^docs/!manual/!;

    $file = join "/", ($r->document_root, $file);

    if (-f $file) {

      $r->filename($file);  # use local disk

#      $r->proxyreq(0);  # fool mod_mime

      return OK;
    }
  }

  return DECLINED;
}

1;
