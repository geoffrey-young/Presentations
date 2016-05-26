use strict;
use warnings FATAL => 'all';

use Apache::Test;
use Apache::TestRequest;
use Apache::TestUtil;

use File::Spec;

plan tests => 8, have_lwp if have_apache(1);

# mod_include in 2.0 specifically unsets the Last-Modified header
# making it pointless to try and set (and test) it
plan tests => 8, todo => [8], have_lwp if have_apache(2);

{
  my $uri = '/xbithack/notexe.html';

  my $response = GET $uri;

  ok t_cmp($response->code,
           200,
           "$uri is ok");

  ok t_cmp($response->content,
           qr/fsize/,
           "$uri is unparsed");
}

{
  my $uri = '/xbithack/S_IXUSR.html';

  my $response = GET $uri;

  ok t_cmp($response->code,
           200,
           "$uri is ok");

  ok t_cmp($response->content,
           qr/64/,
           "$uri is was parsed");

  t_debug("$uri has no Last-Modified header");

  ok (! $response->header('Last-Modified'));
}

{
  my $uri = '/xbithack/S_IXGRP.html';

  my $response = GET $uri;

  ok t_cmp($response->code,
           200,
           "$uri is ok");

  ok t_cmp($response->content,
           qr/64/,
           "$uri is was parsed");

  t_debug("$uri has a Last-Modified header");

  ok ($response->header('Last-Modified'));
}
