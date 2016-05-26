<?php
require 'test_more.inc';
require "{$_SERVER['DOCUMENT_ROOT']}/functions.inc";

plan(6);

{
    # no user or password
    $rc = add_user('', '');
    ok (!$rc, 'no user/pass fails');
}

{
    # no user
    $rc = add_user('', 'password');
    ok (!$rc, 'password but no user fails');
}

{
    # no password
    $rc = add_user('user', '');
    ok (!$rc, 'user but no password fails');
}

{
    # some generic user/password
    $rc = add_user('user', 'password');
    ok ($rc, 'user/pass successfully added');

    # cleanup
    delete_user('user');
}

{
    # test key uniqueness
    $rc = add_user('user', 'password');
    ok ($rc, 'user/pass successfully added');

    $rc = add_user('user', 'password');
    ok (!$rc, 'user/pass successfully added');

    # cleanup
    delete_user('user');
}
?>
