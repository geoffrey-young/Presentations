use Test::More;

# how many tests do we expect?
my $tests = 3;

# plan the number of tests
plan tests => $tests;

# hack the test number into place
# this seems to work even if the callout dies
# before completing
Test::More->builder->current_test($tests);

# call out to some server in a completely different place
# maybe this is an httpd or smtp server, maybe it's a 
# php script...
print qx!perl t/response.pl!;

# simple, right?
