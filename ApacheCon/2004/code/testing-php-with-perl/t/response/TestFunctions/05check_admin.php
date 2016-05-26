<?php
require 'test_more.inc';
require "{$_SERVER['DOCUMENT_ROOT']}/functions.inc";

plan(5);

{
    # no user or password
    $rc = check_admin('', '');
    ok (!$rc, 'no user/pass fails');
}

{
    # no user
    $rc = check_admin('', 'password');
    ok (!$rc, 'password but no user fails');
}

{
    # no password
    $rc = check_admin('user', '');
    ok (!$rc, 'user but no password fails');
}

{
    # non-admin user and password
    $rc = check_admin('user', 'password');
    ok (!$rc, 'non-admin user/pass fails');
}

{
    # the admin user can pass
    $rc = check_admin('admin', 'adminpass');
    ok ($rc, 'admin user/pass found');
}
?>
