use strict;
use warnings FATAL => 'all';

use Apache::TestRequest;

use Test::More;

plan tests => 3;

my $uri = '/admin/';

{
    my $response = GET $uri;

    is ($response->code,
        401,
        "no valid password entry");
}

{
    my $response = GET $uri, username => 'geoff', password => 'foo';

    is ($response->code,
        401,
        "password mismatch");
}

{
    my $response = GET $uri, username => 'admin', password => 'adminpass';

    is ($response->code,
        200,
        "admin allowed to proceed");
}
