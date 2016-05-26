use strict;
use warnings FATAL => 'all';

use Apache::Test;
use Apache::TestRequest;

plan tests => 1, (need_lwp && 
                  need_auth && 
                  need_module('mod_perl.c'));

my $uri = '/authen/index.html';

my $response = GET $uri;

ok $response->code == 401;
