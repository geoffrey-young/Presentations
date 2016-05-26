package My::ManualProxy2;

use Apache::Const -compile => qw(OK DECLINED);

use Apache::RequestRec ();
use Apache::RequestUtil ();

use strict;

sub handler {

  my $r = shift;

  return Apache::DECLINED unless $r->proxyreq;

  my (undef, $file) = $r->uri =~ m!^http://(www|httpd).apache.org/(.*)!;

  if ($file =~ m!^docs/!) {

    $file =~ s!^docs/!manual/!;

    $file = join "/", ($r->document_root, $file);

    if (-f $file) {

      $r->filename($file);  # use local disk

      #$r->proxyreq(0);  # fool mod_mime

      return Apache::OK;
    }
  }

  return Apache::DECLINED;
}

1;
