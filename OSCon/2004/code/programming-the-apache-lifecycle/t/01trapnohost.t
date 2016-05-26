use strict;
use warnings FATAL => 'all';

use Apache::Test;
use Apache::TestRequest;
use Apache::TestUtil;

# for overriding.
use HTTP::Headers;
use URI::_generic;

plan tests => 4, have_lwp;

{
  no warnings qw(redefine);
  no strict qw(refs);

  # prevent the Host header from being automatically added
  my $init_header = *HTTP::Headers::init_header{CODE};
  local *HTTP::Headers::init_header = sub { return if $_[1] eq 'Host';
                                            $init_header->(@_);
                                          };

  my $response = GET '/index.html';

  ok t_cmp($response->code,
           400,
           'no host header returned Bad Request');

  ok t_cmp($response->content,
           qr/Oops/,
           'no host header returned custom error message');
}

{
  no warnings qw(redefine);
  no strict qw(refs);

  my $init_header = *HTTP::Headers::init_header{CODE};
  local *HTTP::Headers::init_header = sub { return if $_[1] eq 'Host';
                                            $init_header->(@_);
                                          };
  local *URI::_generic::path_query = sub { my $self = shift; $$self; };

  my $url = Apache::TestRequest::resolve_url('/index.html');

  my $response = GET $url;

  ok t_cmp($response->code,
           200,
           "absolute URI ($url) returned OK");
}

{
  my $response = GET '/index.html';

  ok t_cmp($response->code,
           200,
           'relative URI with Host header returned OK');
}
