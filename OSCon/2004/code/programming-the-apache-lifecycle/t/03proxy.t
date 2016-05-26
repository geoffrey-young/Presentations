use strict;
use warnings FATAL => 'all';

use Apache::Test;
use Apache::TestRequest;
use Apache::TestUtil;

$ENV{HTTP_PROXY} =  Apache::TestRequest::resolve_url('/');

Apache::TestRequest::user_agent(env_proxy => 1);

plan tests => 2, (have_lwp &&
                  have_module('proxy'));

{
  my $uri = 'http://www.apache.org/docs/index.html';

  my $response = GET $uri;

  ok t_cmp($response->code,
           200,
           "$uri found");

  ok t_cmp($response->content,
           qr/my localhost proxy worked/,
           "$uri returned proper content");
}
