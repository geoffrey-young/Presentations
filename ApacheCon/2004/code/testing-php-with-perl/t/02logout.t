use strict;
use warnings FATAL => 'all';

use Apache::Test qw(:withtestmore);
use Apache::TestRequest;

use Test::More;

plan tests => 4;


# share the session info between logical test units
my $cookies;

{
    # known user/pass is allowed

    my $uri = '/login.php';

    my $response = POST $uri, [ username => 'test', password => 'test' ];

    like ($response->content,
          qr!login successful!i,
          'login with known user/pass successful');

    $cookies = $response->header('Set-Cookie');
}

{
    # now, go back to index.php - we should be greeted with a logged in page

    my $uri = '/index.php';

    (my $session) = $cookies =~ m/(PHP.*);/;

    my $response = GET $uri, Cookie => $session;

    like ($response->content,
          qr!logged in.*test!i,
          'the user is definitey logged in'); 
}

{
    # logout

    my $uri = '/logout.php';

    (my $session) = $cookies =~ m/(PHP.*);/;

    my $response = GET $uri, Cookie => $session;

    like ($response->content,
          qr!logged out!i,
          'the user was logged out'); 
}

{
    # try the index page again

    my $uri = '/index.php';

    (my $session) = $cookies =~ m/(PHP.*);/;

    my $response = GET $uri, Cookie => $session;

    like ($response->content,
          qr!existing users!i,
          'the user must log in again'); 
}
