<?php
require 'test-more.php';
require "{$_SERVER['DOCUMENT_ROOT']}/functions.inc";

plan(5);

{
    # no user or password
    $rc = check_login('', '');
    ok (!$rc, 'no user/pass fails');
}

{
    # no user
    $rc = check_login('', 'password');
    ok (!$rc, 'password but no user fails');
}

{
    # no password
    $rc = check_login('user', '');
    ok (!$rc, 'user but no password fails');
}

{
    # user and password that don't exist
    $rc = check_login('user', 'password');
    ok (!$rc, 'non-existent user/pass fails');
}

{
    # add a known user/password pair
    add_user('user', 'password');

    $rc = check_login('user', 'password');
    ok ($rc, 'existing user/pass found');

    # cleanup
    delete_user('user');
}
?>
