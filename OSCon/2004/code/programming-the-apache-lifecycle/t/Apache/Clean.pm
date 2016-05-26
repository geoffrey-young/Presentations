package Apache::Clean;

use Apache::Const -compile => qw(OK DECLINED);

use Apache::Filter ();      # $f
use Apache::RequestRec ();  # $r

use HTML::Clean ();

use strict;

sub handler {

  my $f   = shift;

  my $r   = $f->r;

  # we only process HTML documents
  unless ($r->content_type =~ m!text/html!i) {
    return Apache::DECLINED;
  }

  my $context;

  unless ($f->ctx) {
    # these are things we only want to do once no matter how
    # many times our filter is invoked per request

    # output filters that alter content are responsible for removing
    # the Content-Length header, but we only need to do this once.
    $r->headers_out->unset('Content-Length');
  }

  # retrieve the filter context, which was set up on the first invocation
  $context ||= $f->ctx;

  # now, filter the content
  while ($f->read(my $buffer, 1024)) {

    # prepend any tags leftover from the last buffer or invocation
    $buffer = $context->{extra} . $buffer if $context->{extra};

    # if our buffer ends in a split tag ('<strong' for example)
    # save processing the tag for later
    if (($context->{extra}) = $buffer =~ m/(<[^>]*)$/) {
      $buffer = substr($buffer, 0, - length($context->{extra}));
    }

    my $h = HTML::Clean->new(\$buffer);
    $h->level(9);
    $h->strip();
    $f->print(${$h->data});
  }

  if ($f->seen_eos) {
    # we've seen the end of the data stream

    # print any leftover data
    $f->print($context->{extra}) if $context->{extra};
  }
  else {
    # there's more data to come

    # store the filter context, including any leftover data
    # in the 'extra' key
    $f->ctx($context);
  }

  return Apache::OK;
}

1;
