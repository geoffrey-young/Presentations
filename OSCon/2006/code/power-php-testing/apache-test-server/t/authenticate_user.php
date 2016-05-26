<?php

require 'test-more.php';
require dirname(__FILE__) . '/../inc/functions.inc';

# plan the number of tests we expect to run
plan(11);


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
    $return = authenticate_user('', '');
    ok (!$return, 'null user and password fails');
}

{
    # no user 
    $return = authenticate_user('', 'password');
    ok (!$return, 'null user fails');
}

{
    # non-existent user
    $return = authenticate_user('user', 'password');
    ok (!$return, 'non-existent user fails');
}


{
    # create a user
    $return = create_user('user', 'password');
    ok ($return, 'added user to authenticate against');

    # try to authenticate
    $return = authenticate_user('user', 'foo');
    ok (!$return, 'bad password fails');

    $return = authenticate_user('user', '');
    ok (!$return, 'null password fails');

    $return = authenticate_user('user', 'password');
    ok ($return, 'good password succeeds');

    # cleanup
    $return = delete_user('user');
    ok ($return, 'user deleted');
}


# database cleanup
# always leave your testing environment the way you
# found it so that the test is completely rerunnable

{
    $return = unlink($db_file);
    ok ($return, 'db.sqlite successfully removed');
}

?>
