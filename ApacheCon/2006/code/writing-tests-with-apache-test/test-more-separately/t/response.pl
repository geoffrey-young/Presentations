
# these two steps suppress the plan headers so
# we're just concerned with the actual test counts
use Test::More no_plan => 1;

Test::More->builder->no_header(1);

# now for the tests
# as with everything in TAP, the number of tests
# need to match the test plan, no matter where the
# actual plan happens

pass ('this was a passing test');
fail ('this one fails');
pass ('yet another pass');
