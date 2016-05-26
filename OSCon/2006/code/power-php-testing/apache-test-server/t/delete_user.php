<?php

require 'test-more.php';
require dirname(__FILE__) . '/../inc/functions.inc';

# plan the number of tests we expect to run
plan(7);


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
    # no user
    $return = delete_user('');
    ok (!$return, 'no user fails');
}

{
    # non-existent user
    $return = delete_user('user');
    ok (!$return, 'cannot delete non-existent user');
}

{
    # created user
    $return = create_user('user', 'password');
    ok ($return, 'added user to delete');

    $return = delete_user('user');
    ok ($return, 'deleted user successfully');
}


# database cleanup
# always leave your testing environment the way you
# found it so that the test is completely rerunnable

{
    $return = unlink($db_file);
    ok ($return, 'db.sqlite successfully removed');
}

?>
