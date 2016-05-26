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

if (delete_user($_POST['username']))
{
    echo '<p>User Deleted</p>';
    echo '<p><a href="/admin/">Admin Home</a></p>';
}
else
{
    echo '<p>Error</p>';
    echo '<p><a href="/admin/">Admin Home</a></p>';
}
?>
