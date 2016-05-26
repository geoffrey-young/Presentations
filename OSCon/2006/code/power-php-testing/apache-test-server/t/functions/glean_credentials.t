use Apache::TestRequest qw(GET_BODY_ASSERT);

my $uri   = '/TestFunctions/glean_credentials.php';

my $query = 'username=testuser&password=testpass';

print GET_BODY_ASSERT "$uri?$query";
