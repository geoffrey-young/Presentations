use strict;
use warnings FATAL => 'all';

use Apache::Test;
use Apache::TestRequest;
use Apache::TestUtil;

plan tests => 1, have_lwp;

{
  my $response = GET '/level/clean.html';

  chomp(my $content = $response->content);

  ok t_cmp($content,
           q!<i><b>"This is a test"</b></i>!,
           'html is perly white');
}
