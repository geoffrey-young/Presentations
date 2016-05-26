use strict;
use warnings FATAL => 'all';

use Apache::Test qw(-withtestmore);
use Apache::TestRequest;

plan tests => 20, need_module('mod_example_ipc');

foreach my $counter (1 .. 20) {

  my $response = GET_BODY '/example_ipc';

  like ($response,
        qr!Counter:</td><td>$counter!,
        "counter incremented to $counter");
}
