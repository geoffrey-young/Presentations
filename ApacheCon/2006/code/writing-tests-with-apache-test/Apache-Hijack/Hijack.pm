package Apache::Hijack;

use Apache2::Filter ();
use Apache2::RequestRec ();
use APR::Table ();

use Apache2::Const -compile => qw(OK DECLINED);

use strict;

sub handler {

  my $f   = shift;
  my $r   = $f->r;

  return Apache2::Const::DECLINED
    unless $r->handler eq 'php-script' or 
           $r->handler eq 'application/x-httpd-php';

  warn "not returning declined for ", $r->uri;
  my $context;

  unless ($f->ctx) {
    $r->headers_out->unset('Content-Length');
    $r->headers_out->set('X-Powered-By' => 'mod_perl 2.0');

    $context = { extra => undef };
  }

  $context ||= $f->ctx;

  while ($f->read(my $buffer, 1024)) {

    $buffer = $context->{extra} . $buffer if $context->{extra};

    if (($context->{extra}) = $buffer =~ m/(<[^>]*)$/) {
      $buffer = substr($buffer, 0, - length($context->{extra}));
    }

    $buffer =~ s!(<body>)!$1<h1><center><code>got mod_perl?</code></center></h1>!i;

    $f->print($buffer);
  }

  if ($f->seen_eos) {
    $f->print($context->{extra}) if $context->{extra};
  }
  else {
    $f->ctx($context);
  }

  return Apache2::Const::OK;
}

1;
