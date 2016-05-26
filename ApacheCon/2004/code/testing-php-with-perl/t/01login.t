use strict;
use warnings FATAL => 'all';

use Apache::TestRequest;

use Test::More;

plan tests => 6;

my $uri = '/login.php';

{
    # login with no user/pass is denied

    my $response = GET $uri;

    like ($response->content,
          qr!invalid login!i,
          'could not login with no user/pass'); 
}

{
    # login with unknown user/pass is also denied

    my $response = POST $uri, [ username => 'foo', password => 'nada' ];

    like ($response->content,
          qr!invalid login!i,
          'could not login with bad user/pass'); 
}

{
    # known user/pass is allowed
    ok (create_user('mytest', 'mytest'), "created user 'mytest'");

    my $response = POST $uri, [ username => 'test', password => 'test' ];

    like ($response->content,
          qr!login successful!i,
          'login with known user/pass successful');

    # and that the response has the correct properties

    like ($response->header('Set-Cookie'),
          qr/PHPSESSID/,
          'a PHP session cookie was set');

    ok (delete_user('mytest'), "removed user 'mytest'");
}

sub create_user {
    # add a user known user to the database

    my ($user, $pass) = @_;

    return eval {
        require DBI;
        require File::Spec;
        require Digest::MD5;
                                                                                                                             
        my $db = File::Spec->catfile(Apache::Test::vars('serverroot'),
                                     qw(htdocs db.sqlite));
                                                                                                                             
        my $dbh = DBI->connect("dbi:SQLite2:dbname=$db", "", "",
                                  {RaiseError => 1, AutoCommit => 1});
                                                                                                                             
        my $password = Digest::MD5::md5_hex($pass);
                                                                                                                             
        $dbh->do("insert into users values ('$user', '$password')");

        1;
    };
}

sub delete_user {
                                                                                                                             
    my $user = shift;

    return eval {
        require DBI;
        require File::Spec;

        my $db = File::Spec->catfile(Apache::Test::vars('serverroot'),
                                     qw(htdocs db.sqlite));
                                                                                                                             
        my $dbh = DBI->connect("dbi:SQLite2:dbname=$db", "", "",
                                  {RaiseError => 1, AutoCommit => 1});
                                                                                                                             
        $dbh->do("delete from users where username = '$user'");

        1;
    };
}

