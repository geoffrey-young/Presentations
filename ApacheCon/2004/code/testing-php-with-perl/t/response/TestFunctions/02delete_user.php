<?php
require 'test_more.inc';
require "{$_SERVER['DOCUMENT_ROOT']}/functions.inc";

plan(4);

{
    # no user
    $rc = delete_user('');
    ok (!$rc, 'no user fails');
}

{
    # non-existent user
    $rc = delete_user('user');
    ok (!$rc, 'cannot delete non-existent user');
}

{
    # created user
    $rc = add_user('user', 'password');
    ok ($rc, 'added user to delete');

    $rc = delete_user('user');
    ok ($rc, 'deleted user successfully');
}
?>
