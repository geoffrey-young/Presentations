<?php

require 'test-more.php';
require dirname(__FILE__) . '/../inc/functions.inc';

# plan the number of tests we expect to run
plan(9);


# database setup.  we might as well make these tests, since
# if this part fails there's no reason checking why later
# tests aren't working
$db_file = '/tmp/db.sqlite';


{
    $db = sqlite_open($db_file);
    ok ($db, 'created database successfully');

    $sql = "CREATE TABLE users
                (
                    username    vareturnhar(50),
                    password    vareturnhar(32),
                    PRIMARY KEY (username)
                )";

    $return = sqlite_query($db, $sql);
    ok ($return, 'added table successfully');
}


# now for the real tests...
{
    # no user or password
    $return = create_user('', '');
    ok (!$return, 'no user/pass fails');
}

{
    # no user
    $return = create_user('', 'password');
    ok (!$return, 'password but no user fails');
}

{
    # no password
    $return = create_user('user', '');
    ok (!$return, 'user but no password fails');
}

{
    # some generic user/password
    $return = create_user('user', 'password');
    ok ($return, 'generic user/pass successfully added');

    # cleanup
    delete_user('user');
}

{
    # test key uniqueness
    $return = create_user('user', 'password');
    ok ($return, 'unique user/pass successfully added');

    # sqlite throws duplicate user warnings - turn those off
    # but only here.  don't be sloppy :)
    $return = @create_user('user', 'password');
    ok (!$return, 'duplicate user/pass could not be added');

    # cleanup
    delete_user('user');
}


# database cleanup
# always leave your testing environment the way you
# found it so that the test is completely rerunnable

{
    $return = unlink($db_file);
    ok ($return, 'db.sqlite successfully removed');
}

?>
