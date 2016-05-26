package Apache::Hijack;

use Apache::Filter ();
use Apache::RequestRec ();
use APR::Table ();

use Apache::Const -compile => qw(OK DECLINED);

use strict;

sub handler {

  my $f   = shift;
  my $r   = $f->r;

  return Apache::DECLINED
    unless $r->handler eq 'php-script' or 
           $r->handler eq 'application/x-httpd-php';

  $r->headers_out->unset('Content-Length');
  $r->headers_out->set('X-Powered-By' => 'mod_perl 2.0');

  while ($f->read(my $buffer, 1024)) {
    $buffer =~ s!(<body>)!$1<h1><center><code>got mod_perl?</code></center></h1>!i;
    $f->print($buffer);
  }

  return Apache::OK;
}
1;
