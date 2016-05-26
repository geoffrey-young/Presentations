use strict;
use warnings FATAL => 'all';

use Apache::Test;
use Apache::TestRequest;

plan tests => 20, (have_lwp &&
                  have_module('mod_php4'));

my $response = GET '/foo.php';
ok $response->code == 200;
ok $response->content !~ m/mod_perl/;
ok $response->content =~ m/echo/;

$response = GET '/php-script/foo.php';
ok $response->code == 200;
ok $response->content =~ m/mod_perl/;
ok $response->content !~ m/echo/;
ok $response->header('X-Powered-By') =~ m/mod_perl/;
ok $response->header('X-Powered-By') !~ m/PHP/;

$response = GET '/php-script/index.html';
ok $response->code == 200;
ok $response->header('X-Powered-By') =~ m/mod_perl/;
ok $response->header('X-Powered-By') !~ m/PHP/;

$response = GET '/php-app/foo.php';
ok $response->code == 200;
ok $response->content =~ m/mod_perl/;
ok $response->content !~ m/echo/;
ok $response->header('X-Powered-By') =~ m/mod_perl/;
ok $response->header('X-Powered-By') !~ m/PHP/;

$response = GET '/php-app/index.html';
ok $response->code == 200;
ok $response->content !~ m/mod_perl/;
ok ! $response->header('X-Powered-By');
ok ! $response->header('X-Powered-By');
