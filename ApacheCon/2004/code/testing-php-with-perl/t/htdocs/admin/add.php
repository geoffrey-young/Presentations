<?php
include '../functions.inc';

$auth_user = '';
$auth_pass = '';
if (isset($_SERVER['PHP_AUTH_USER']) && isset($_SERVER['PHP_AUTH_PW']))
{
    $auth_user = $_SERVER['PHP_AUTH_USER'];
    $auth_pass = $_SERVER['PHP_AUTH_PW'];
}

if (!check_admin($auth_user, $auth_pass))
{
    echo '<p>Access Denied</p>';
    exit;
}

if (add_user($_POST['username'], $_POST['password']))
{
    echo '<p>User Added</p>';
    echo '<p><a href="/admin/">Admin Home</a></p>';
}
else
{
    echo '<p>Error</p>';
    echo '<p><a href="/admin/">Admin Home</a></p>';
}
?>
